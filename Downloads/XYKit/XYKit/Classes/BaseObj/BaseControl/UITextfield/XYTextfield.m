//
//  XYTextfield.m
//  BaseObjSet
//
//  Created by 元潇 on 2019/8/13.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "XYTextfield.h"

#define SPACE 10

@implementation XYTextfield

// 显示时 居左居右居上居下间距
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(SPACE, 0, bounds.size.width-SPACE*2, bounds.size.height);
}

// 编辑时 居左居右居上居下间距
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectMake(SPACE, 0, bounds.size.width-SPACE*2, bounds.size.height);
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect textRect = [super leftViewRectForBounds:bounds];
    textRect.origin.x += SPACE;
    return textRect;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    CGRect textRect = [super rightViewRectForBounds:bounds];
    textRect.origin.x -= SPACE;
    return textRect;
}

@end
