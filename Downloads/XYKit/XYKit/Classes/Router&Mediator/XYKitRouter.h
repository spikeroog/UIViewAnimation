//
//  XYKitRouter.h
//  BaseObjSet
//
//  Created by 元潇 on 2019/8/21.
//  Copyright © 2019年 元潇. All rights reserved.
//  系统导航栏相关

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYKitRouter : NSObject

#pragma mark - 导航栏颜色获取
+ (UIColor *)navBgColor;

#pragma mark - 系统windows
// 获取当前界面的系统导航栏
+ (UINavigationController *)currentNavC;
// 获取当前界面的系统ViewController
+ (UIViewController *)currentVC;
// 获取keyWindow
+ (UIWindow *)keyWindow;

@end

NS_ASSUME_NONNULL_END
