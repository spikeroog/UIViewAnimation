//
//  OBJBaseLabel.h
//  BaseObjSet
//
//  Created by 元潇 on 2018/11/21.
//  Copyright © 2018 元潇. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OBJBaseLabel : UILabel

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
                                  font:(nullable UIFont *)font;

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
                    textAligment:(NSTextAlignment)textAligment;


@end

NS_ASSUME_NONNULL_END
