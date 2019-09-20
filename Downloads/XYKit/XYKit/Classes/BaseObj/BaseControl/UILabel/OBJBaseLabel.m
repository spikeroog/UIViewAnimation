//
//  OBJBaseLabel.m
//  BaseObjSet
//
//  Created by 元潇 on 2018/11/21.
//  Copyright © 2018 元潇. All rights reserved.
//  ifdef如果存在 ifndef如果不存在

#import "OBJBaseLabel.h"
#import "NSMutableAttributedString+AutoSize.h"

@implementation OBJBaseLabel

/**
 普通label
 
 @param text 文字
 @param textColor 文字颜色
 @param textAligment 对齐方式
 @param font 字体
 @return 返回label对象
 */
+ (nonnull instancetype)labelWithText:(nullable NSString *)text
                             textColor:(UIColor *)textColor
                          textAligment:(NSTextAlignment)textAligment
                                  font:(nullable UIFont *)font {
    OBJBaseLabel *label = [[OBJBaseLabel alloc] init];
    if (text) label.text = text;
    label.textColor = textColor;
    label.textAlignment = textAligment;
    if (font) label.font = font;
    return label;
}

/**
包含不同大小字体的label

@param attributedTextArr 文字数组
@param textColorArray 文字颜色数组
@param fontArray 字体数组
@param textAligment 对齐方式
@return 返回label对象
*/
+ (nonnull instancetype)attributedLabelWithArr:(nullable NSArray <NSString *>*)attributedTextArr
                                textColorArray:(nullable NSArray <UIColor *>*)textColorArray
                                     fontArray:(nullable NSArray <UIFont *>*)fontArray
                                  textAligment:(NSTextAlignment)textAligment {
    OBJBaseLabel *label = [[OBJBaseLabel alloc] init];
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] init];
    if (attributedTextArr && textColorArray && fontArray) {
         [attributedTextArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         [attstr appendString:attributedTextArr[idx] withColor:textColorArray[idx] font:fontArray[idx]];
         }];
    }
    label.attributedText = attstr;
    label.textAlignment = textAligment;
    return label;
}

@end
