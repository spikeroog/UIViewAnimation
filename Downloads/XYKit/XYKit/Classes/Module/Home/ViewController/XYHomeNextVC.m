//
//  XYHomeNextVC.m
//  XYKit
//
//  Created by 元潇 on 2019/8/27.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "XYHomeNextVC.h"
#import "XYHomeNextVC1.h"

@interface XYHomeNextVC ()

@end

@implementation XYHomeNextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.className;
    self.rightBarItemTitle = @"forward";

}

- (void)rightActionInController {
    [RTNavRouter pushViewController:[XYHomeNextVC1 new]];
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
