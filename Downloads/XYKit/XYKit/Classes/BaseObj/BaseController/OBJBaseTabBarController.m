//
//  OBJBaseTabBarController.m
//  BaseObjSet
//
//  Created by 元潇 on 2018/11/20.
//  Copyright © 2018 元潇. All rights reserved.
//

#import "OBJBaseTabBarController.h"
#import "OBJHomeViewController.h"
#import "OBJMineViewController.h"

@interface OBJBaseTabBarController ()
<UITabBarControllerDelegate>

@end

@implementation OBJBaseTabBarController

- (id)init {
    self = [super init];
    if (self) {
        [self initial];
    }
    return self;
}

- (void)initial {
    [self setViewControllersWithArray:@[[self fetchHomeViewController],
                                        [self fetchMineViewController]
                                        ]];
}

- (void)setViewControllersWithArray:(NSArray *)arrayViewControllers {
    
    if ([arrayViewControllers count] == 0)  return;
    
    [self setViewControllers:arrayViewControllers];
    self.delegate = self;
    
    // 设置Tabbar字体颜色
    // 字体颜色 选中
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorWithRGB16Radix(0x24252C)} forState:UIControlStateSelected];
    // 字体颜色 未选中
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorWithRGB16Radix(0x999999)} forState:UIControlStateNormal];
    
    // 设置tabBar的背景颜色
    [[UITabBar appearance] setBarTintColor:UIColorWithRGB16Radix(0xeeeeee)];
    
    if (kSystemVersion >= 8.0) {
        [UITabBar appearance].translucent = NO;
    }
    
    // 设置tabbar 线条颜色
    UIColor *tabBarTopLinecolor = UIColorWithImage(UIImageWithStr(@"ic_tabBar_topLine"));
//    UIColor *tabBarTopLinecolor = [UIColor blackColor];
    CGRect rect = CGRectMake(0, 0, kScreenWidth, 3.5f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, tabBarTopLinecolor.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [[UITabBar appearance]  setShadowImage:img];
    [[UITabBar appearance]  setBackgroundImage:[[UIImage alloc] init]];
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}

#pragma mark - NSObject
/**
 首页
 
 @return 首页
 */
- (RTContainerNavigationController *)fetchHomeViewController {
    OBJHomeViewController *homeVC = [[OBJHomeViewController alloc] init];
    RTContainerNavigationController *nav = [[RTContainerNavigationController alloc] initWithRootViewController:homeVC];
    
    UIImage *normal = [UIImage imageNamed:@"tabBar_essence_icon"];
    UIImage *selected = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    
    normal = [normal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selected = [selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"首页"
                                                       image:normal
                                               selectedImage:selected];
    [self setAnimationWithTabbar:item];
    
    // 只显示图片不显示文字
    //    item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    nav.tabBarItem = item;
    return nav;
}

/**
 我的
 
 @return 我的
 */
- (RTContainerNavigationController *)fetchMineViewController {
    OBJMineViewController *mineVC = [[OBJMineViewController alloc] init];
    RTContainerNavigationController *nav = [[RTContainerNavigationController alloc] initWithRootViewController:mineVC];
    
    UIImage *normal = [UIImage imageNamed:@"tabBar_me_icon"];
    UIImage *selected = [UIImage imageNamed:@"tabBar_me_click_icon"];
    
    normal = [normal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selected = [selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"我的"
                                                       image:normal
                                               selectedImage:selected];
    [self setAnimationWithTabbar:item];
    
    // 只显示图片不显示文字
    //    item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    nav.tabBarItem = item;
    return nav;
}


- (void)setAnimationWithTabbar:(UITabBarItem *)item {
    int count = arc4random() % 3;
    if (count == 0) {
        // 创建动画
        TLBounceAnimation *anm = [TLBounceAnimation new];
        // 设置动画属性（重点）
        item.animation = anm;
    } else if (count == 1) {
        // 创建动画
        TLFumeAnimation *anm = [TLFumeAnimation new];
        // 设置动画属性（重点）
        item.animation = anm;
    } else if (count == 2) {
        // 创建动画
        TLRotationAnimation *anm = [TLRotationAnimation new];
        // 设置动画属性（重点）
        item.animation = anm;
    }
}


//- (BOOL)prefersStatusBarHidden {
//    return self.selectedViewController.prefersStatusBarHidden;
//}
//
//- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
//    return self.selectedViewController.preferredStatusBarUpdateAnimation;
//}
//
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return self.selectedViewController.preferredStatusBarStyle;
//}

@end
