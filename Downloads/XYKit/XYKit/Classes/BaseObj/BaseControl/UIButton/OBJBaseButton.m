//
//  OBJBaseButton.m
//  BaseObjSet
//
//  Created by 元潇 on 2018/12/3.
//  Copyright © 2018 元潇. All rights reserved.
//

#import "OBJBaseButton.h"

@implementation OBJBaseButton

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
                     placeholderImage:(nullable UIImage *)placeholderImage {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title) [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    // 取消button点击后的高亮效果
    button.adjustsImageWhenHighlighted = NO;
    // 高效设置圆角
    [UtilityTools advancedEfficientDrawBead:button drawTopLeft:YES drawTopRight:YES drawBottomLeft:YES drawBottomRight:YES cornerRadius:cornerRadius];
    if (isNetWorkImage) {
        
        if (imageUrlOrName) [button setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrlOrName]]] forState:UIControlStateNormal];
    } else {
        if (imageUrlOrName) [button setImage:UIImageWithStr(imageUrlOrName) forState:UIControlStateNormal];
    }
    [button setImageEdgeInsets:imageInsert];
    [button setTitleEdgeInsets:titleInsert];
    return button;
}

@end
