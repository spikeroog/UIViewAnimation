//
//  UITextView+Extension.m
//  BaseObjSet
//
//  Created by 元潇 on 2019/8/19.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "UITextView+Extension.h"
#import <objc/message.h>

@interface UITextView()

/** <#注释#> */
@property(nonatomic, strong) UILabel *placeholderLabel;
@end

@implementation UITextView (Extension)

- (void)setPlaceholder:(NSString *)placeholder {
    self.placeholderLabel.text = placeholder;
}

- (NSString *)placeholder {
    return self.placeholderLabel.text;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    self.placeholderLabel.textColor = placeholderColor;
}

- (UIColor *)placeholderColor {
    return self.placeholderLabel.textColor;
}

- (void)setPlaceholderLabel:(UILabel *)placeholderLabel {
    objc_setAssociatedObject(self, "xy_placeholderLabelKey", placeholderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)placeholderLabel {
    UILabel * label = objc_getAssociatedObject(self, "xy_placeholderLabelKey");
    if (!label) {
        if (self.font == nil) { // 防止没大小时显示异常 系统默认设置14
            self.font = [UIFont systemFontOfSize:14];
        }
        label = [[UILabel alloc] initWithFrame:self.bounds];
        label.numberOfLines = 0;
        label.font = self.font;
        label.textColor = [UIColor lightGrayColor];
        [label sizeToFit];
        [self setValue:label forKey:@"_placeholderLabel"];
        [self addSubview:label];
        [self sendSubviewToBack:label];
        objc_setAssociatedObject(self, "xy_placeholderLabelKey", label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return label;
}

@end
