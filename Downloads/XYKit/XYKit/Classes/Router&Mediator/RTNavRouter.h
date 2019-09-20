//
//  RTNavRouter.h
//  XYKit
//
//  Created by 元潇 on 2019/8/22.
//  Copyright © 2019年 元潇. All rights reserved.
//  block不能传nil或者null，不然会闪退，闪退地址为0x10，void*占8字节，int占4字节；局部block在栈中，声明成属性的block在堆中。

#import <Foundation/Foundation.h>
#import "RTRootNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RTNavRouter : NSObject

#pragma mark - 导航栏颜色获取
+ (UIColor *)navBgColor;

#pragma mark - 获取当前ViewController
+ (RTContainerController *)currentVC;

#pragma mark - 获取当前NavigationController
+ (RTRootNavigationController *)currentNavC;

#pragma mark - 获取keyWindow
+ (UIWindow *)fetchKeyWindow;

#pragma mark - 跳转到某个类
+ (void)pushViewController:(__kindof UIViewController *)viewController;

+ (void)pushViewController:(__kindof UIViewController *)viewController
                  complete:(void(^ __nonnull)(void))complete;

#pragma mark - 跳转到某个类(多次点击不会重复跳转，但这个类只会存在一个)
+ (void)pushViewControllerNoRepeat:(__kindof UIViewController *)viewController;

#pragma mark - 删除层级中的某个控制器
+ (void)deleteViewControllerWithName:(NSString *)viewControllerName;

#pragma mark - 返回上一级控制器
+ (void)popController;

#pragma mark - 返回根目录控制器
+ (void)popToRootController;
+ (void)popToRootController:(void(^ __nonnull)())complete;

#pragma mark - 返回到某个可能存在的控制器，无法回滚到根目录控制器
+ (void)popToMaybeExistControllerWithName:(NSString *)viewControllerName;
+ (void)popToMaybeExistControllerWithName:(NSString *)viewControllerName
                                 complete:(void(^ __nonnull)())complete;
@end

NS_ASSUME_NONNULL_END
