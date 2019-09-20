//
//  OBJBaseNavigationController.m
//  BaseObjSet
//
//  Created by 元潇 on 2018/11/20.
//  Copyright © 2018 元潇. All rights reserved.
//

#import "OBJBaseNavigationController.h"

@interface OBJBaseNavigationController ()
<UINavigationControllerDelegate,
UIGestureRecognizerDelegate>

@end

@implementation OBJBaseNavigationController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // 添加导航栏右滑返回手势
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = self;
}

/**
 如果当前显示的是第一个子控制器，禁止掉[返回手势]
 ❎未解决后果：第一个界面响应右滑卡顿，甚至视图错乱
 
 @param gestureRecognizer 手势
 @return 是否应该响应手势
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 如果当前显示的是第一个子控制器,就应该禁止掉[返回手势]
    if (self.childViewControllers.count == 1) {
        return NO;
    } else {
        return self.childViewControllers.count > 1;
    }
}

#pragma mark - 重写push/pop方法
/**
 重写push方法，子页面隐藏tabBar
 
 @param viewController viewController description
 @param animated animated description
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 子界面隐藏tabBar
    if (self.viewControllers.count > 0) {
        [viewController setHidesBottomBarWhenPushed:YES];
    }
    [super pushViewController:viewController animated:animated];
}

/**
 重写pop方法
 
 @param animated animated description
 @return return value description
 */
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    // 判断即将到栈底
    if (self.viewControllers.count == 0) {
        
    } else {
        
    }
    //  pop出栈
    return [super popViewControllerAnimated:animated];
}


@end
