//
//  XYKitRouter.m
//  BaseObjSet
//
//  Created by 元潇 on 2019/8/21.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "XYKitRouter.h"

@implementation XYKitRouter

#pragma mark - 导航栏颜色获取
+ (UIColor *)navBgColor {
    return [XYKitRouter currentNavC].navigationController.navigationBar.barTintColor;
}


#pragma mark - 获取当前Window试图
// 获取当前屏幕显示的导航栏
+ (UINavigationController *)currentNavC {
    UIViewController *viewVC = (UIViewController* )[self currentWindowVC];
    UINavigationController  *naVC;
    if ([viewVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabbar = (UITabBarController *)viewVC;
        naVC = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        if (naVC.presentedViewController) {
            while (naVC.presentedViewController) {
                naVC = (UINavigationController *)naVC.presentedViewController;
            }
        }
    } else if ([viewVC isKindOfClass:[UINavigationController class]]) {
        naVC  = (UINavigationController *)viewVC;
        if (naVC.presentedViewController) {
            while (naVC.presentedViewController) {
                naVC = (UINavigationController *)naVC.presentedViewController;
            }
        }
    } else if ([viewVC isKindOfClass:[UIViewController class]]) {
        if (viewVC.navigationController) {
            return viewVC.navigationController;
        }
        return  (UINavigationController *)viewVC;
    }
    return naVC;
}

+ (UIViewController*)currentWindowVC {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    // app默认windowLevel是UIWindowLevelNormal，如果不是，找到它
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    id nextResponder = nil;
    UIViewController *appRootVC = window.rootViewController;
    // 1、通过present弹出VC，appRootVC.presentedViewController不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    } else {
        // 2、通过navigationcontroller弹出VC
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    return nextResponder;
}

// 获取当前屏幕最上层的ViewController
+ (UIViewController *)currentVC {
    UIViewController *viewC = [[UIViewController alloc] init];
    UINavigationController *nav = (UINavigationController *)[[self class] currentNavC];
    if ([nav isKindOfClass:[UINavigationController class]]) {
        viewC = nav.viewControllers.lastObject;
        if (viewC.childViewControllers.count > 0) {
            viewC = [[self class] subUIVCWithVC:viewC];
        }
    } else {
        viewC = (UIViewController *)nav;
    }
    return viewC;
}

+ (UIViewController *)subUIVCWithVC:(UIViewController *)vc {
    UIViewController *viewC = [[UIViewController alloc] init];
    viewC = vc.childViewControllers.lastObject;
    if (viewC.childViewControllers > 0) {
        [[self class] subUIVCWithVC:viewC];
    } else {
        return viewC;
    }
    return viewC;
}

// 获取keyWindow
+ (UIWindow *)keyWindow {
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    if(!keyWindow){
        keyWindow = [UIApplication sharedApplication].windows.firstObject;
    }
    return keyWindow;
}

@end
