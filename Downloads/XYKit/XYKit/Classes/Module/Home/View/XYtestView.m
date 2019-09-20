//
//  XYtestView.m
//  XYKit
//
//  Created by 元潇 on 2019/8/29.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "XYtestView.h"

@implementation XYtestView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)btnAct:(id)sender {
    [[XYPopupView shareInstance] disMissView];
}

@end
