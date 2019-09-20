//
//  XYKitMediator.m
//  XYKit
//
//  Created by 元潇 on 2019/8/22.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "XYKitMediator.h"
#import "OBJScanViewController.h"

@implementation XYKitMediator

#pragma mark - shareInstanced
+ (instancetype)shareInstanced {
    static XYKitMediator *mediator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[XYKitMediator alloc] init];
    });
    return mediator;
}

#pragma mark - 跳转扫一扫界面，获取扫一扫url
/**
 获取扫一扫url
 
 @param haventCamera 是否有相机权限
 @param haventPicture 是否有相册权限
 @param urlBlock 返回的url
 */
+ (void)fetchScanCodeHaventCamera:(void(^)())haventCamera
                  haventPicture:(void(^)())haventPicture
                       urlBlock:(void(^)(NSString *result))urlBlock {
    OBJScanViewController *scanVC = [[OBJScanViewController alloc] init];
    scanVC.scanUrlBlockHandle = ^(NSString * _Nonnull scan_url) {
        [[RTNavRouter currentNavC] popViewControllerAnimated:YES];
        urlBlock(scan_url);
    };
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (status) {
            case AVAuthorizationStatusNotDetermined: {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [RTNavRouter pushViewController:scanVC];
                        });
                        DLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
                    } else {
                        haventCamera();
                        DLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                    }
                }];
                break;
            }
            case AVAuthorizationStatusAuthorized: {
                [RTNavRouter pushViewController:scanVC];
                break;
            }
            case AVAuthorizationStatusDenied: {
                
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"请去-> [设置 - 隐私 - 相机 - %@] 打开访问开关", kAppName] preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertC addAction:alertA];
                [[RTNavRouter currentVC] presentViewController:alertC animated:YES completion:nil];
                break;
            }
            case AVAuthorizationStatusRestricted: {
                DLog(@"因为系统原因, 无法访问相册");
                haventPicture();
                break;
            }
                
            default:
                break;
        }
        return ;
    }
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:alertA];
    [[RTNavRouter currentVC] presentViewController:alertC animated:YES completion:nil];
}
@end
