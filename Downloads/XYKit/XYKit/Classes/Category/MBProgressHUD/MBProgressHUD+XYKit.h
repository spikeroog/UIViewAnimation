//
//  MBProgressHUD+XYKit.h
//  BaseObjSet
//
//  Created by 元潇 on 2019/8/21.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MBProgressHudGifType) {
    MBProgressHUDGIfTypeUrl = 0, // 网络gif地址
    MBProgressHUDGIfTypeFile, // 本地gif文件名
    MBProgressHUDGIfTypeImages // 图片数组
};

@interface MBProgressHUD (XYKit)
<MBProgressHUDDelegate>

@property (nonatomic, assign) BOOL isKeyWindow;

/**
 移除loading hud

 @param isKeyWindow 是否是在keyWindow上，YES为keywindow，NO为当前显示的VC
 */
+ (void)removeLoadingHudOnKeyWindow:(BOOL)isKeyWindow;
/**
 无提示，简单hud
 */
+ (void)showSimpleHUD;

/**
 文本hud
 
 @param text 文本
 */
+ (void)showTextHUD:(NSString *)text;

/**
 文本hud显示在可以window上
 
 @param text 文本
 */
+ (void)showTextHUDInKeyWindow:(NSString *)text;

/**
 带指示器的hud
 
 @param loadText 文本
 */
+ (void)showLoadingHUD:(NSString *)loadText;

/**
 显示成功hud，带图标
 
 @param text 文本
 */
+ (void)showSuccessHUD:(NSString *)text;

/**
 显示失败hud，带图标
 
 @param text 文本
 */
+ (void)showErrorHUD:(NSString *)text;

/**
 显示gif hud

 @param type 显示类型
 @param message 目标字符串，url链接或者本地gif名称
 @param text 提示文本
 */
+ (void)showGifHUD:(MBProgressHudGifType)type
           message:(NSString *)message
              text:(nullable NSString *)text;
/**
 显示环形下载hud
 
 @param title 标题，如：Downloading
 @param isShowCancelBtn 是否显示取消按钮
 @param complete 回调
 */
+ (void)showRingHUD:(NSString *)title isShowCancelBtn:(BOOL)isShowCancelBtn complete:(void(^)(void))complete;

/**
 显示横条样式下载hud
 
 @param title 标题，如：Downloading
 @param isShowCancelBtn 是否显示取消按钮
 @param complete 回调
 */
+ (void)showPieHUD:(NSString *)title isShowCancelBtn:(BOOL)isShowCancelBtn complete:(void(^)(void))complete;

@end

NS_ASSUME_NONNULL_END
