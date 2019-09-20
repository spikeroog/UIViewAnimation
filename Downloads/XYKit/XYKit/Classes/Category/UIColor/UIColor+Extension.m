//
//  UIColor+Extension.m
//  BaseObjSet
//
//  Created by 元潇 on 2019/8/19.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

/**
 获取textfield默认的placeholderColor
 
 @return placeholderColor
 */
+ (UIColor *)textfieldPlaceholderColor {
    UIColor *color = [[UIColor alloc] init];
    UITextField *textField = [[UITextField alloc] init];
    textField.placeholder = @" ";
    color = [textField valueForKeyPath:@"_placeholderLabel.textColor"];
    return color;
}

@end
