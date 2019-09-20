//
//  AppDelegate+IQKeyboardManager.m
//  BaseObjSet
//
//  Created by 元潇 on 2018/12/18.
//  Copyright © 2018 元潇. All rights reserved.
//

#import "AppDelegate+IQKeyboardManager.h"

@implementation AppDelegate (IQKeyboardManager)

#pragma mark - 配置IQKeyboardManager
- (void)configIQKeyboardManager {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    // enable控制整个功能是否启用
    manager.enable = YES;
    // shouldResignOnTouchOutside控制点击背景是否收起键盘
    manager.shouldResignOnTouchOutside = YES;
    // shouldToolbarUsesTextFieldTintColor 控制键盘上的工具条文字颜色是否用户自定义
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    // enableAutoToolbar控制是否显示键盘上的工具条
    manager.enableAutoToolbar = NO;
}

@end
