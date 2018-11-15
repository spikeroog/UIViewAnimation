# 系统级视图动画的实现
包含了视图从坐标a移动到坐标b，并且移动的同时变大或者变小，视图出现时，高效的背景高斯模糊，以及视图消失同时，背景透明度逐渐为0的效果。
## 何时需要用到视图动画
视图动画在APP中是很常见的，一个流畅且自然的视图弹出收起动画，可以给用户提供轻松的视觉体验。一般情况下，APP中的动画都是固定某种形式，以便养成用户视觉习惯，建议不要东边一种动画，西边一种动画，这样给用户的体验很不好。
## CGAffineTransform
* 使用`CGAffineTransform`，利用`UIView`的`transform`属性实现动画。
```Objc
// 平移:设置平移量
CGAffineTransformMakeTranslation(CGFloat tx, CGFloat ty)
```
```Objc
// 缩放:设置缩放比例
CGAffineTransformMakeScale(CGFloat sx, CGFloat sy)
```
```Objc
// 旋转:设置旋转角度
CGAffineTransformMakeRotation(CGFloat angle)
```
以上3个都是针对视图的原定最初位置的中心点为起始参照进行相应操作的，在操作结束之后可对设置量进行还原：<br>
```Objc
// 还原之前的动画
UIView.transform ＝ CGAffineTransformIdentity;
```
## Core Animation
`Core Animation`是一组非常强大的动画处理API,使用它能做出很多优雅的动画效果。能用的动画类有4个子类：`CABasicAnimation`、`CAKeyframeAnimation`、`CATransition`、`CAAnimationGroup`。
```
通过调用CALayer的addAnimation:forKey:增加动画到层(CALayer)中,这样就能触发动画.
```
```
通过调用removeAnimationForKey:可以停止层中的动画.
```
```
Core Animation的动画执行过程都是在后台操作的,不会阻塞主线程.
```
* `CAKeyframeAnimation`的三大属性：
  * `values` : NSArray对象，里面的元素称为”关键帧”(keyframe)。动画对象会在指定的时间(duration)内，依次显示values数组中的每一个关键帧。
  * `path`: 可以设置一个`CGPathRef` \ `CGMutablePathRef`，让层跟着路径移动。path只对CALayer的`anchorPoint`和`position`起作用。如果你设置了path，那么values将被忽略。
  * `keyTimes`: 可以为对应的关键帧指定对应的时间点，其取值范围为[0,1]，keyTimes中的每一个时间值都对应values中的每一帧。当keyTimes没有设置的时候，各个关键帧的时间是平分的。

## Spring Animation
系统级动画体验, 以下是`Spring Animation`动画的API：
```Objc
+ (void)animateWithDuration:(NSTimeInterval)duration
                      delay:(NSTimeInterval)delay
     usingSpringWithDamping:(CGFloat)dampingRatio
      initialSpringVelocity:(CGFloat)velocity
                    options:(UIViewAnimationOptions)options
                 animations:(void (^)(void))animations
                 completion:(void (^)(BOOL finished))completion;
```
* `usingSpringWithDamping`的范围为0.0f到1.0f，数值越小「弹簧」的振动效果越明显。
* `initialSpringVelocity`则表示初始的速度，数值越大一开始移动越快。

## 总结
我们需要将`Spring Animation`和`Core Animation`或`CGAffineTransform`任意一种配合使用，以达到流畅动画的实现，附上代码:
#### 弹出：<br>
```Objc
    [popInputView addScaleAnimationWithDuration:0.35f];
    [UIView animateWithDuration:0.35f delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:0.8f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        // 在动画过程中禁止遮罩视图响应用户手势
        popInputView.maskView.userInteractionEnabled = NO;
    } completion:^(BOOL finished) {
        // 在动画结束后允许遮罩视图响应用户手势
        popInputView.maskView.userInteractionEnabled = YES;
    }];
```
```Objc
#pragma mark - 加载动画
- (void)addScaleAnimationWithDuration:(NSTimeInterval)duration {
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.values = @[@0.5f, @1.15, @0.9f, @1.0];
    scaleAnimation.duration = duration;
    // 重复次数 默认为1
    scaleAnimation.repeatCount = 1;
    // 设置是否原路返回默认为NO
    scaleAnimation.autoreverses = NO;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:scaleAnimation forKey:nil];
}
```
#### 收起：<br>
```Objc
    [self removeScaleAnimationWithDuration:0.20f];
    [UIView animateWithDuration:0.35f delay:0.0f usingSpringWithDamping:0.7 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //在动画过程中禁止遮罩视图响应用户手势
        _maskView.userInteractionEnabled = NO;
        _maskView.alpha = 0.01;
    } completion:^(BOOL finished) {
        [_maskView removeFromSuperview];
        [self removeFromSuperview];
    }];
 ```
 ```Objc
 #pragma mark - 移除动画
 - (void)removeScaleAnimationWithDuration:(NSTimeInterval)duration {
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.values = @[@1.0, @1.3, @0.01];
    scaleAnimation.duration = duration;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:scaleAnimation forKey:nil];
}
```
## 异步屏幕截图并将图片高斯模糊
使用到了第三方库`GPUImage`，这个库实现的高斯模糊处理时间最短.
```Objc
/**
异步截图并将图片高斯模糊
 */
- (void)blurImageHandle
{
   
//    dispatch_queue_t queue = dispatch_queue_create("ck", DISPATCH_QUEUE_SERIAL);  // 异步串行队列
    dispatch_queue_t queue = dispatch_queue_create("ck", DISPATCH_QUEUE_CONCURRENT);  // 异步并发队列
    dispatch_async(queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *screenImage = [self makeImageWithDrawImageSize:CGSizeMake(kScreenWidth, kScreenHeight)];
            self.backImageView.image = [self applyGaussianBlur:screenImage];
        });
    });
}
```
```Objc
/**
 图片进行高斯模糊
 @param image <#image description#>
 @return <#return value description#>
 */
- (UIImage *)applyGaussianBlur:(UIImage *)image
{
    GPUImageGaussianBlurFilter *filter = [[GPUImageGaussianBlurFilter alloc] init];
//    filter.texelSpacingMultiplier = 10;
    filter.blurRadiusInPixels = 5;
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *pic = [[GPUImagePicture alloc] initWithImage:image];
    [pic addTarget:filter];
    [pic processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}
```
```Objc
/**
 获取屏幕截图
 @param size <#size description#>
 @return <#return value description#>
 */
- (UIImage *)makeImageWithDrawImageSize:(CGSize)size
{
    CGSize imageSize = CGSizeZero;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        imageSize = screenSize;
    } else {
        imageSize = CGSizeMake(screenSize.height, screenSize.width);
    }
    
    UIGraphicsBeginImageContextWithOptions(imageSize, false, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context) {
        for (UIWindow *window in [UIApplication sharedApplication].windows) {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, window.center.x, window.center.y);
            CGContextConcatCTM(context, window.transform);
            CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
            
            if (orientation == UIInterfaceOrientationLandscapeLeft) {
                CGContextRotateCTM(context, M_PI_4);
                CGContextTranslateCTM(context, 0, -imageSize.width);
            } else if (orientation == UIInterfaceOrientationLandscapeRight) {
                CGContextRotateCTM(context, - M_PI_2);
                CGContextTranslateCTM(context, -imageSize.height, 0);
            } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
                CGContextRotateCTM(context, M_PI);
                CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
            }
            
            if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
                [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
            } else {
                [window.layer renderInContext:context];
            }
            
            CGContextRestoreGState(context);
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
```
