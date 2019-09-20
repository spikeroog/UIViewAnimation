//
//  XYHomeNextVC2.m
//  XYKit
//
//  Created by 元潇 on 2019/8/27.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "XYHomeNextVC2.h"
#import "XYHomeNextVC1.h"
#import "XYHomeNextVC3.h"

@interface XYHomeNextVC2 ()

@end

@implementation XYHomeNextVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.className;
    self.rightBarItemTitle = @"forward";
    self.view.backgroundColor = UIColorWithRGB16Radix(0xf5f5f5);
    
    [self configBigTitleTabPageBar:@[[XYHomeNextVC3 new],
                                     [XYHomeNextVC3 new],
                                     [XYHomeNextVC3 new]] titles:@[@"推荐",
                                                                   @"现场",
                                                                   @"游戏"]];
}

- (void)rightActionInController {
    [RTNavRouter pushViewController:[XYHomeNextVC3 new]];

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
