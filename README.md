# 各种视图动画的实现
包含了视图从坐标a移动到坐标b，并且移动的同时变大或者变小，视图出现时，高效的背景高斯模糊，以及视图消失同时，背景透明度逐渐为0的效果。
## 何时需要用到视图动画
视图动画在APP中是很常见的，一个流畅且自然的视图弹出收起动画，可以给用户提供轻松的视觉体验。一般情况下，APP中的动画都是固定某种形式，以便养成用户视觉习惯，建议不要东边一种动画，西边一种动画，这样给用户的体验很不好。
## 如何实现
* `移动`使用到了`CGAffineTransform`，使用`UIView`的`transform`属性实现动画。
```ObJc
// 平移:设置平移量
CGAffineTransformMakeTranslation(CGFloat tx, CGFloat ty)
```
```ObJc
// 缩放:设置缩放比例
CGAffineTransformMakeScale(CGFloat sx, CGFloat sy)
```
```ObJc
// 旋转:设置旋转角度
CGAffineTransformMakeRotation(CGFloat angle)
```
以上3个都是针对视图的原定最初位置的中心点为起始参照进行相应操作的，在操作结束之后可对设置量进行还原：<br>
```ObJc
// 还原之前的动画
view.transform ＝ CGAffineTransformIdentity;
```
