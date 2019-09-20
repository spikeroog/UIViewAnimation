//
//  UITextView+Extension.h
//  BaseObjSet
//
//  Created by 元潇 on 2019/8/19.
//  Copyright © 2019年 元潇. All rights reserved.
//  通过Runtime为UITextView添加占位文字placeholder(支持Xib) eg: 在xib的User Defined Runtime Attributes的keyPath中设置 placeholderColor (Color)还有 placeholder (String) 还有TextView下对应输入一样的placeholderColor和placeholder 即可生效

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (Extension)
/** <#注释#> */
@property(nonatomic, strong)IBInspectable NSString *placeholder;

/** <#注释#> */
@property(nonatomic, strong)IBInspectable UIColor *placeholderColor;

@end

NS_ASSUME_NONNULL_END
