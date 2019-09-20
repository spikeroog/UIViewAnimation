//
//  UIView+XYPop.m
//  XYKit
//
//  Created by 元潇 on 2019/8/29.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "UIView+XYPop.h"

// 扩展属性 对应的地址值, 保证 set/get 方法内使用的 地址完全一样。
static const void *xy_popStyleKey = &xy_popStyleKey;

@implementation UIView (XYPop)

- (void)setXy_popStyle:(XYViewPopStyle)xy_popStyle {
    objc_setAssociatedObject(self, &xy_popStyleKey, @(xy_popStyle), OBJC_ASSOCIATION_ASSIGN);

}

- (XYViewPopStyle)xy_popStyle {
    return [objc_getAssociatedObject(self, &xy_popStyleKey) integerValue];
}


@end
