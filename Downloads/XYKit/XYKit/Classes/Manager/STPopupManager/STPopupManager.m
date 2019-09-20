//
//  STPopupManager.m
//  XYKit
//
//  Created by 元潇 on 2019/8/28.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "STPopupManager.h"
#import "STPopup.h"

@implementation STPopupManager

/**
 将UIViewController转换为window弹出
 
 @param convertVC 需要转换的VC
 @param portraitSize 竖屏windowVC的大小
 @param landscapeSize 横屏windowVC的大小
 @param targetVC 显示视图的VC
 */
+ (void)convertControllerAsWindow:(__kindof UIViewController *)convertVC
                     portraitSize:(CGSize)portraitSize
                    landscapeSize:(CGSize)landscapeSize
                         targetVC:(__kindof UIViewController *)targetVC {
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:convertVC];
    convertVC.navigationController.navigationBarHidden = YES;
    convertVC.contentSizeInPopup = portraitSize;
    convertVC.landscapeContentSizeInPopup = portraitSize;
    popupController.containerView.layer.cornerRadius = 4;
    popupController.transitionStyle = STPopupTransitionStyleFade;
    [popupController presentInViewController:targetVC];
}

@end
