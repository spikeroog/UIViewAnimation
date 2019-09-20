//
//  XYHomeNextVC1.m
//  XYKit
//
//  Created by 元潇 on 2019/8/27.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "XYHomeNextVC1.h"
#import "XYHomeNextVC2.h"
#import "XYHomeNextVC.h"

@interface XYHomeNextVC1 ()

@end

@implementation XYHomeNextVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.className;
    self.rightBarItemTitle = @"forward";
    
    [self configSingleCenterTabPageBar:@[[XYHomeNextVC new],
                             [XYHomeNextVC new]]
                    titles:@[@"广场", @"动态"]];
    
}

- (void)rightActionInController {
    [[RTNavRouter currentNavC] pushViewController:[XYHomeNextVC2 new] animated:YES complete:^(BOOL finished) {
        [RTNavRouter deleteViewControllerWithName:self.className];
        [MBProgressHUD showTextHUD:[NSString stringWithFormat:@"删除%@成功", self.className]];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
