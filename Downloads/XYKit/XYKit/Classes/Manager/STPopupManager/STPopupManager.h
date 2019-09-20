//
//  STPopupManager.h
//  XYKit
//
//  Created by 元潇 on 2019/8/28.
//  Copyright © 2019年 元潇. All rights reserved.
//  注意事项：如果跳转的vc没有设置contentSizeInPopup和landscapeContentSizeInPopup会闪退；如果跳转的vc是xib文件，需要事先在xib中UserDefine..中加入contentSizeInPopup和landscapeContentSizeInPopup的value
//  好处：自定义弹窗如果有输入框，IQKeyBoard就能生效了，且hud也不会被蒙版遮挡住了。。有的视图非常复杂，如树状视图（里面包含了tableView，甚至tableVIew里面嵌套了CollectionView），构建如果用UIview，将会变得难以维护，需要使用VC，但是设计图显示需要用UIview的显示逻辑显示，则可以使用该方法将VC表达为UIview的显示逻辑

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STPopupManager : NSObject

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
                         targetVC:(__kindof UIViewController *)targetVC;

@end

NS_ASSUME_NONNULL_END
