//
//  XYBaseLoadingVC.m
//  XYKit
//
//  Created by 元潇 on 2019/9/19.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "XYBaseLoadingVC.h"

@interface XYBaseLoadingVC ()

@end

@implementation XYBaseLoadingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showLoadingHud];
}

#pragma mark - 设置View请求网络过程中的动画
- (void)showLoadingHud {
    
    [MBProgressHUD showGifHUD:MBProgressHUDGIfTypeImages message:@"" text:@""];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD removeLoadingHudOnKeyWindow:NO];
    });
}

@end
