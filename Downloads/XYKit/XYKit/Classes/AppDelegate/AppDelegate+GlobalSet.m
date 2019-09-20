//
//  AppDelegate+GlobalSet.m
//  BaseObjSet
//
//  Created by 元潇 on 2018/11/20.
//  Copyright © 2018 元潇. All rights reserved.
//

#import "AppDelegate+GlobalSet.h"

@implementation AppDelegate (GlobalSet)

- (void)configGlobalset {
    
#pragma mark - 防止多个button同时点击
    // 避免在一个界面上同时点击多个UIButton导致同时响应多个方法
    [[UIButton appearance] setExclusiveTouch:YES];
    
#pragma mark - scrollView适配iOS11
    
    if (@available(iOS 11.0, *)) {
        // 防止iOS11后所有的ScrollView，TableView，CollectionView下移64
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        // ios11 tableView 禁止使用自适应cell header footer大小
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
    }
    
    // 设置网络请求超时时间
    [PPNetworkHelper setRequestTimeoutInterval:15];

#pragma mark - 设置状态栏颜色
    BOOL isStatusBarBlack = NO;
    /*
    UIStatusBarStyleDefault 状态栏为黑色，系统默认为黑色
    UIStatusBarStyleLightContent 状态栏为白色
    （需要到info.plist中添加`View controller-based status bar appearance`设置为`NO`）才能生效
     */
    if (isStatusBarBlack) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    } else {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
}

@end
