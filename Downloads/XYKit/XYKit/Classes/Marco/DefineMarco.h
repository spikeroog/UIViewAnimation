//
//  DefineMarco.h
//  BaseObjSet
//
//  Created by 元潇 on 2018/11/20.
//  Copyright © 2018 元潇. All rights reserved.
//  建议常量不要写成宏定义，用 FOUNDATION_EXTERN static const 修饰
//  宏定义不要过多，会影响编译速度

#ifndef DefineMarco_h
#define DefineMarco_h

/** ---- AppStore ----
 */
// appstoreId
#define kAppStoreId @""
// appstore跳转链接（app内部调用跳转，该链接生成的二维码无法正常跳转）
#define kAppStoreUrl [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8", kAppStoreId]
// appstore评分跳转链接（app内部调用跳转）
#define kAppStoreGradeUrl [NSString stringWithFormat:@"https://itunes.apple.com/us/app/itunes-u/id%@?action=write-review&mt=8", kAppStoreId]

/** ---- 屏幕适配刘海屏 ----
 */
// 导航栏高度
#define kNavBarHeight ([UtilityTools iPhoneNotchScreen]?88:64)
// 电池栏高度
#define kStatusBarHeight ([UtilityTools iPhoneNotchScreen]?44:20)
// 标签栏高度
#define kTabBarHeight ([UtilityTools iPhoneNotchScreen]?83:49)
// 刘海屏底部栏的高度
#define kBottomBarHeight ([UtilityTools iPhoneNotchScreen]?34:0)

/** ---- 颜色 ----
 */
// hex颜色
#define UIColorWithRGB16Radix(rgbValue) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0])
// hex颜色及透明度
#define UIColorWithRGB16RadixA(rgbValue, a) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a])
// rgb颜色及透明度
#define UIColorWithRGB(r,g,b) (UIColorWithRGBA(r,g,b,1.0f))
// rgb颜色
#define UIColorWithRGBA(r,g,b,a) ([UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a])
// 根据名字设置颜色
#define UIColorWithName(name) ([UIColor name##Color])
// 透明颜色
#define UIColorWithNull ([UIColor clearColor])
// 随机颜色
#define UIColorWithRandom ([UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0])
// 图片生成颜色
#define UIColorWithImage(image) ([UIColor colorWithPatternImage:image])
// 自定义透明度颜色（不会作用在自视图上,即：父视图设置了透明度，字视图不会受到i影响）
#define UIColorWithOpacity(color, alpha) [color colorWithAlphaComponent:alpha]

/** ---- 字体 ----
 */
// 根据名字设置字体
#define UIFontWithNameAndSize(fontName,fontSize) ([UIFont fontWithName:fontName size:fontSize])
// 正常的字体
#define UIFontWithSize(size) ([UIFont systemFontOfSize:size])
// 屏幕适配的字体
#define UIFontWithAutoSize(size) ([UIFont systemFontOfSize:kAutoCs(size)])
// 加粗字体
#define UIBoldFontWithSize(size) ([UIFont boldSystemFontOfSize:size])
// 加粗屏幕适配的字体
#define UIBoldFontWithAutoSize(size) ([UIFont boldSystemFontOfSize:kAutoCs(size)])
// 斜体
#define UIItalicFontWithSize(size) ([UIFont italicSystemFontOfSize:size])

/** ---- 屏幕适配 ----
 */
#define kAutoCs(number) (number) * ([UIScreen mainScreen].bounds.size.width) / 375.0f

/** ---- Weakself Strongself ----
 */
#define _WeakSelf __weak __typeof__(self) weakSelf = self;
#define _StrongSelf __strong __typeof__(weakSelf) strongSelf = weakSelf;

/** ---- 图片 ----
 */
// 本地图片

#define UIImageWithStr(string) [UIImage imageNamed:(string)]
// 网络图片
#define UIImageWithUrl(url) [NSURL URLWithString:url]

/** ---- 判断机型 ----
 */
// 判断ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

// 判断iPhone5 5s
#define kiPhone5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhone6 6s 7 8
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhone6p 6sp 7p 8p
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneX iPhoneXS
#define kiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXS MAX
#define kiPhoneXSMAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXR
#define kiPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

// 判断12.9 ipadPro
#define kIpadPro129 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(2048, 2732), [[UIScreen mainScreen] currentMode].size) && isPad : NO)
// 判断11 ipadPro
#define kIpadPro11 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1668, 2388), [[UIScreen mainScreen] currentMode].size) && isPad : NO)
// 判断10.5 ipadPro
#define kIpadPro105 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1668, 2224), [[UIScreen mainScreen] currentMode].size) && isPad : NO)
// 判断9.7 ipad
#define kIpad97 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1536, 2048), [[UIScreen mainScreen] currentMode].size) && isPad : NO)

/** ---- GCD ----
 */
// GCD - 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
// GCD - 在Main线程上运行
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
// GCD - 开启异步线程
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);

/** ---- 沙盒 ----
 */
// 获取沙盒 Home目录
#define kPathHome NSHomeDirectory()
// 获取沙盒 Library
#define kPathLibrary [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]
// 获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
// 获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
// 获取 Temp
#define kPathTemp NSTemporaryDirectory()

/** ---- 屏幕相关 ----
 */
// 屏幕大小
#ifndef kScreenRect
#define kScreenRect [UIScreen mainScreen].bounds
#endif

// 屏幕分辨率
#ifndef kScreenResolutio
#define kScreenResolutio (SCREEN_WIDTH * SCREEN_HEIGHT * ([UIScreen mainScreen].scale))
#endif

// 宽
#ifndef kScreenWidth
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#endif

// 高
#ifndef kScreenHeight
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#endif

/** Application
 */
#define kApplication ([UIApplication sharedApplication])

/** AppDelegate
 */
#define kAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

/** UserDefaults
 */
#define kUserDefaults [NSUserDefaults standardUserDefaults]

/** NotificationCenter
 */
#define kNotificationCenter [NSNotificationCenter defaultCenter]

/** KeyWindow
 */
#define kKeyWindow [UIApplication sharedApplication].keyWindow

/** App名称
 */
#define kAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

/** 版本号
 */
/*
 Version:发布版本号，可以通过App Store、itunes或其它软件看到，是给用户看的，如当前上架版本为1.1.0  之后你更新的时候可以改为1.1.1
 Build: 内部标示，团队开发中内部使用的，只有开发者可以看到，用以记录开发版本的，每次更新的时候都需要比上一次高 如：当前版本是1.1  下一次就要大于1.1 比如 1.2，1.3 ....）
 还有就是build的为了方便开发者多次提交binary, 比如被苹果reject后，第一次提交version和build都是1.0，假如审核没过，那么修改代码后新的构建的version还是1.0，build改为1.0.1就ok了
 */
// 手机 iOS系统 版本号
#ifndef kSystemVersion
#define kSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#endif
// 获取 APP Version 版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
// 获取 APP Build 版本号
#define kBuildVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

/** 判断字符串、数组、字典、对象为空
 */
// 字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO)
// 数组是否为空
#define kArrayIsEmpty(array) ((array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0) ? YES : NO)
// 字典是否为空
#define kDictIsEmpty(dic) ((dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0) ? YES : NO)
// 对象是否为空
#define kObjectIsEmpty(_object) ((_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0)) ? YES : NO)

/** 安全的字符串、数组、字典，如果为null就自动转成@"", @{}, @[]，不会闪退
 */
// 安全的字符串
#define kStringSafe(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? @"" : str)
// 安全的数组
#define kArraySafe(array) ((array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0) ? @[] : array)
// 安全的字典
#define kDictionarySafe(dic) ((dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0) ? @{} : dic)

/** 获取当前方法名称
 */
#define kMethodName  __PRETTY_FUNCTION__

/** 获取当前语言名称
 */
#define kLanguageName ([[NSLocale preferredLanguages] firstObject])


/** 一些方便工程的配置信息
 */
// DeBug下打印，Release下不打印
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

// 消除警告⚠️
#define kMJPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

/** 其他实用宏
 */
// 角度转弧度
#define kDEGREES_TO_RADIANS(d) (d * M_PI / 180)


#endif /* DefineMarco_h */
