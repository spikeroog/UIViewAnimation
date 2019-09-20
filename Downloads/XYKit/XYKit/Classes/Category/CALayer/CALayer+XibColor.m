//
//  CALayer+XibColor.m
//  BaseObjSet
//
//  Created by 元潇 on 2019/8/19.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "CALayer+XibColor.h"

@implementation CALayer (XibColor)

- (void)setBorderColorFromUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}
@end
