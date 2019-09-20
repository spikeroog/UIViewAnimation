//
//  AppDelegate+FLEX.m
//  BaseObjSet
//
//  Created by 元潇 on 2018/12/18.
//  Copyright © 2018 元潇. All rights reserved.
//

#import "AppDelegate+FLEX.h"

@implementation AppDelegate (FLEX)

#pragma mark - FLEX

- (void)showFLEX {
#if defined(DEBUG) || defined(_DEBUG)
    // 显示flex
    [[FLEXManager sharedManager] showExplorer];
#endif
}

@end
