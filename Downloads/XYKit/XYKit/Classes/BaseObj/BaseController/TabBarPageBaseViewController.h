//
//  TabBarPageBaseViewController.h
//  XYKit
//
//  Created by 元潇 on 2019/9/4.
//  Copyright © 2019年 元潇. All rights reserved.
//  如果需要别的样式，自行往下添加，不建议属性一一传值，新的样式的标签栏在这个类里多写一个方法实现就好了，一个项目撑死了4，5种，不可能再多了，所有没有封装的必要

#import "OBJBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TabBarPageBaseViewController : OBJBaseViewController
/**
 构建标签栏
 
 @param datas 标签控制器
 @param titles 标签title
 
 */
- (void)configDefaultTabPageBar:(NSArray<__kindof UIViewController *>*)datas
                         titles:(NSArray<NSString *>*)titles;

- (void)configSingleCenterTabPageBar:(NSArray<__kindof UIViewController *>*)datas
                              titles:(NSArray<NSString *>*)titles;

- (void)configBigTitleTabPageBar:(NSArray<__kindof UIViewController *>*)datas
                          titles:(NSArray<NSString *>*)titles;
@end

NS_ASSUME_NONNULL_END
