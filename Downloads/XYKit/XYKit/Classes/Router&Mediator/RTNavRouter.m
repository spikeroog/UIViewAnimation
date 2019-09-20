//
//  RTNavRouter.m
//  XYKit
//
//  Created by 元潇 on 2019/8/22.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "RTNavRouter.h"
#import "AppDelegate.h"

@implementation RTNavRouter

#pragma mark - 导航栏颜色获取
+ (UIColor *)navBgColor {
    return [RTNavRouter currentNavC].rt_navigationController.navigationBar.barTintColor;
}

#pragma mark - 获取当前ViewController
// 获取当前ViewController
+ (RTContainerController *)currentVC {
    RTContainerController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    // app默认windowLevel是UIWindowLevelNormal，如果不是，找到它
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    id nextResponder = nil;
    UIViewController *appRootVC = window.rootViewController;
    // 通过present弹出VC，appRootVC.presentedViewController不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    } else {
        // 通过navigationcontroller弹出VC
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    // tabBarController
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        // 或者 UINavigationController * nav = tabbar.selectedViewController;
        result = nav.childViewControllers.lastObject;
    } else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        // navigationController
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    } else { // viewControler
        result = nextResponder;
    }
    if ([result isKindOfClass:[RTContainerController class]]) {
        return result.contentViewController;
    } else {
        return result;
    }
}

#pragma mark - 获取当前NavigationController，相当于rt_navigationController
// 获取当前NavigationController，相当于rt_navigationController
+ (RTRootNavigationController *)currentNavC {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        RTRootNavigationController *nav = ((UITabBarController *)rootViewController).selectedViewController;
        return nav;
    } else if ([rootViewController isKindOfClass:[RTRootNavigationController class]]) {
        RTRootNavigationController *nav = ((RTRootNavigationController *)rootViewController);
        return nav;
    }
    id nav = [RTNavRouter currentVC];
    if ([nav isKindOfClass:[RTRootNavigationController class]]) {
        return nav;
    } else {
        return nil;
    }
}

#pragma mark - 获取keyWindow
// 获取keyWindow
+ (UIWindow *)fetchKeyWindow {
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    if(!keyWindow){
        keyWindow = [UIApplication sharedApplication].windows.firstObject;
    }
    return keyWindow;
}

#pragma mark - 跳转到某个类

/**
 跳转到某个类
 跳转控制器建议传控制器对象，这样就不用再封装的方法里面设置控制器的属性
 @param viewController 控制器
 */
+ (void)pushViewController:(__kindof UIViewController *)viewController {
    // 防止因为点击多次而重复跳转同一个视图
    if ([[RTNavRouter currentVC] isMemberOfClass:[viewController class]]) {
        return;
    }
    [[RTNavRouter currentNavC] pushViewController:viewController animated:YES];
}

/**
 跳转到某个类
 跳转控制器建议传控制器对象，这样就不用再封装的方法里面设置控制器的属性
 @param viewController 控制器
 @param complete 完成回调
 */
+ (void)pushViewController:(__kindof UIViewController *)viewController
                  complete:(void(^ __nonnull)(void))complete {
    // 防止因为点击多次而重复跳转同一个视图
    if ([[RTNavRouter currentVC] isMemberOfClass:[viewController class]]) {
        return;
    }
    [[RTNavRouter currentNavC] pushViewController:viewController animated:YES complete:^(BOOL finished) {
        complete();
    }];
}

#pragma mark - 跳转到某个类(跳转的时候，如果这个类存在，就返回到这个类的位置)
+ (void)pushViewControllerNoRepeat:(__kindof UIViewController *)viewController {
    // 防止因为点击多次而重复跳转同一个视图
    if ([[RTNavRouter currentVC] isMemberOfClass:[viewController class]]) {
        return;
    }
    // 防止跳转界面时重复跳转，即界面a,b,c,d，我们希望界面d再跳转界面c的时候，不会重复跳转，而是返回到界面c
    NSArray *viewControllers = [RTNavRouter currentNavC].rt_viewControllers;
    for (UIViewController *controller in viewControllers) {
        if ([controller isKindOfClass:[viewController class]]) {
            [[RTNavRouter currentNavC] popToViewController:controller animated:YES];
            return;
        }
    }
    [[RTNavRouter currentNavC] pushViewController:viewController animated:YES];
}

#pragma mark - 删除层级中的某个控制器
/**
 删除层级中的某个控制器
 而删除或者返回某个控制器，建议传控制器名称，尽量不要直接传控制器，如：[vController new]，这样会额外开辟一份控制器的内存
 
 @param viewControllerName 控制器名称
 */
+ (void)deleteViewControllerWithName:(NSString *)viewControllerName {
    // 取得RTNavigationController下的RTContainerController数组
    NSMutableArray <__kindof RTContainerController *> *navArray = [[NSMutableArray alloc] initWithArray:[RTNavRouter currentNavC].viewControllers];
    // ios字典和数组forin遍历时不能执行removeobject操作，不然会crash掉，但是for循环可以。
    for (int i = 0; i < navArray.count; i++) {
        // RTContainerController.contentViewController 为实际的控制器对象
        if ([navArray[i].contentViewController.className isEqualToString:viewControllerName]) {
            [navArray removeObjectAtIndex:i];
            DLog(@"删除控制器%@成功", viewControllerName);
        }
    }
    [[RTNavRouter currentNavC] setViewControllers:navArray animated:YES];
}

#pragma mark - 返回上一级控制器
+ (void)popController {
    [[RTNavRouter currentNavC] popViewControllerAnimated:YES];
}

#pragma mark - 返回根目录控制器
+ (void)popToRootController {
    [[RTNavRouter currentNavC] popToRootViewControllerAnimated:YES];
}

+ (void)popToRootController:(void(^ __nonnull)())complete {
    [[RTNavRouter currentNavC] popToRootViewControllerAnimated:YES complete:^(BOOL finished) {
        complete();
    }];
}

#pragma mark - 返回到某个可能存在的控制器，带回调和不带回调，无法回滚到根目录控制器

/**
 返回到某个可能存在的控制器
 而删除或者返回某个控制器，建议传控制器名称，尽量不要直接传控制器，如：[vController new]，这样会额外开辟一份控制器的内存
 
 @param viewControllerName 控制器名称
 */
+ (void)popToMaybeExistControllerWithName:(NSString *)viewControllerName {
    for (UIViewController *controller in [RTNavRouter currentNavC].rt_viewControllers) {
        if ([controller.className isEqualToString:viewControllerName]) {
            // 包含该要查找的视图
            [[RTNavRouter currentNavC] popToViewController:controller animated:YES];
            return;
        }
    }
    DLog(@"控制器%@是TabBar包含Controller或不存在或已被删除，无法回退", viewControllerName);
}

/**
 返回到某个可能存在的控制器
 而删除或者返回某个控制器，建议传控制器名称，尽量不要直接传控制器，如：[vController new]，这样会额外开辟一份控制器的内存
 
 @param viewControllerName 控制器名称
 @param complete 完成回调
 */
+ (void)popToMaybeExistControllerWithName:(NSString *)viewControllerName
                                 complete:(void(^ __nonnull)())complete {
    for (UIViewController *controller in [RTNavRouter currentNavC].rt_viewControllers) {
        if ([controller.className isEqualToString:viewControllerName]) {
            // 包含该要查找的视图
            [[RTNavRouter currentNavC] popToViewController:controller animated:YES complete:^(BOOL finished) {
                complete();
            }];
            return;
        }
    }
    DLog(@"控制器%@是TabBar包含Controller或不存在或已被删除，无法回退", viewControllerName);
}

@end
