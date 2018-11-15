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
Core Animation是一组非常强大的动画处理API,使用它能做出很多优雅的动画效果。能用的动画类有4个子类：`CABasicAnimation`、`CAKeyframeAnimation`、`CATransition`、`CAAnimationGroup`。

* 使用Core Animation动画`CAKeyframeAnimation`，利用UIView的Layer`@"transform.translation"`,`@"transform.scale"`,`@"transform.rotation"`实现动画，附上代码:
```Objc
CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
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
