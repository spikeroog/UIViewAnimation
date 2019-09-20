//
//  OBJBaseButton.h
//  BaseObjSet
//
//  Created by 元潇 on 2018/12/3.
//  Copyright © 2018 元潇. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OBJBaseButton : UIButton

/**
 普通button
 
 @param title 内容
 @param titleColor 内容颜色
 @param cornerRadius 圆角
 @param isNetWorkImage 是否是网络图片
 @param imageUrlOrName 网络图片的url或者本地图片的name
 @param imageInsert 图片间距 默认传UIEdgeInsetZero
 @param titleInsert 文字间距 默认传UIEdgeInsetZero
 @param placeholderImage 默认图片
 @return 返回的button对象
 */
+ (nonnull UIButton *)buttonWithTitle:(nullable NSString *)title
                           titleColor:(UIColor *)titleColor
                         cornerRadius:(CGFloat)cornerRadius
                        isNetWorkImage:(BOOL)isNetWorkImage
                       imageUrlOrName:(nullable NSString *)imageUrlOrName
                          imageInsert:(UIEdgeInsets)imageInsert
                          titleInsert:(UIEdgeInsets)titleInsert
                     placeholderImage:(nullable UIImage *)placeholderImage;


@end

NS_ASSUME_NONNULL_END
