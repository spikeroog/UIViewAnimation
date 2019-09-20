//
//  UIImage+Extension.h
//  BaseObjSet
//
//  Created by 元潇 on 2018/12/18.
//  Copyright © 2018 元潇. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)

#pragma mark - 圆角

/**
通过CPU重新绘制一份带圆角的视图来实现圆角效果，会大大增加CPU的负担，而且相当于多了一份视图拷贝会增加内存开销。但是就显示性能而言，由于没有触发离屏渲染，所以能保持较高帧率。下例是绘制一个圆形图片，绘制其它UIView并无本质区别。重新绘制的过程可以交由后台线程来处理。
 在需要圆角时调用如下
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     UIImage *img = [[UIImage imageNamed:@"image.png"] drawCircleImage];
     dispatch_async(dispatch_get_main_queue(), ^{
         view.image = img;
     });
 });

 @return 圆角图片
 */
- (UIImage *)drawCircleImage;

#pragma mark - 全屏截图
+ (UIImage *)yx_shotScreen;

#pragma mark - 截取view生成一张图片
+ (UIImage *)yx_shotWithView:(UIView *)view;

#pragma mark - 截取view中某个区域生成一张图片
+ (UIImage *)yx_shotWithView:(UIView *)view scope:(CGRect)scope;

#pragma mark - 图片根据某个值压缩，如: 传1024 ~> 1M
+ (NSData *)yx_resetSizeOfImageData:(UIImage *)source_image
                         maxSize:(NSInteger)maxSize;

#pragma mark - 按尺寸裁剪图片
+ (UIImage *)yx_imageCompressForSize:(UIImage *)sourceImage
                       targetSize:(CGSize)size;

#pragma mark - 高效的，图片进行高斯模糊
+ (UIImage *)yx_applyGaussianBlur:(UIImage *)image;

#pragma mark - 对图片进行滤镜处理
+ (UIImage *)yx_filterWithOriginalImage:(UIImage *)image filterName:(NSString *)name;

#pragma mark - 调整图片饱和度, 亮度, 对比度
+ (UIImage *)yx_colorControlsWithOriginalImage:(UIImage *)image
                                 saturation:(CGFloat)saturation
                                 brightness:(CGFloat)brightness
                                   contrast:(CGFloat)contrast;

#pragma mark - 异步获取本地动态图片
+ (UIImage *)yx_localGifWithName:(NSString *)gifName;

#pragma mark - 图片还原默认角度
+ (UIImage *)yx_fixOrientation:(UIImage *)aImage;

#pragma mark - 颜色转图片
+ (UIImage *)yx_createImageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
