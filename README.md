# 各种视图动画的实现
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
`CAKeyframeAnimation`的三大属性：
```
***`values`***:NSArray对象，里面的元素称为”关键帧”(`keyframe`)。动画对象会在指定的时间(`duration`)内，依次显示`values`数组中的每一个关键帧
```
```
***`path`***:可以设置一个`CGPathRef\CGMutablePathRef`,让层跟着路径移动。`path`只对`CALayer`的`anchorPoint`和`position`起作用。如果你设置了`path`，那么`values`将被忽略
```
```
***`keyTimes`***:可以为对应的关键帧指定对应的时间点,其取值范围为[0,1],`keyTimes`中的每一个时间值都对应`values`中的每一帧.当`keyTimes`没有设置的时候,各个关键帧的时间是平分的
```

* 使用Core Animation动画`CAKeyframeAnimation`，利用UIView的layer层实现动画，附上代码:
```Objc
// `@"transform.translation"`,`@"transform.scale"`,`@"transform.rotation"`
CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
// 设置关键帧，可实现先大后小的变化
scaleAnimation.values = @[@0.5, @1.15, @0.9, @1.0];
scaleAnimation.duration = duration;
// 重复次数 默认为1
scaleAnimation.repeatCount = 1;
// 设置是否原路返回默认为NO
scaleAnimation.autoreverses = NO;
scaleAnimation.removedOnCompletion = NO;
scaleAnimation.fillMode = kCAFillModeForwards;
[UIView.layer addAnimation:scaleAnimation forKey:nil];
```
