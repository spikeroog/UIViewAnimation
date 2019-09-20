//
//  OBJBaseImageView.h
//  BaseObjSet
//
//  Created by 元潇 on 2018/11/21.
//  Copyright © 2018 元潇. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OBJBaseImageView : UIImageView

/**
 网络图片
 iOS9以后UIImageView设置圆角不会触发离屏渲染

 @param imageUrl 网络图片url
 @param cornerRadius 圆角
 @param alpha 透明度
 @param placeholderImage 默认图片
 @return imageView对象
 */
- (nonnull instancetype)imageViewWithImageUrl:(nullable NSString *)imageUrl
                                 cornerRadius:(CGFloat)cornerRadius
                                        alpha:(CGFloat)alpha
                             placeholderImage:(nullable UIImage *)placeholderImage;

/**
 本地图片
 iOS9以后UIImageView设置圆角不会触发离屏渲染

 @param imageName 本地图片
 @param cornerRadius 圆角
 @param alpha 透明度
 @return imageView对象
 */
- (nonnull instancetype)imageViewWithImageName:(nullable NSString *)imageName
                                  cornerRadius:(CGFloat)cornerRadius
                                         alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
