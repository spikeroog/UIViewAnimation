//
//  HeaderMarco.h
//  BaseObjSet
//
//  Created by 元潇 on 2018/11/20.
//  Copyright © 2018 元潇. All rights reserved.
//

#ifndef HeaderMarco_h
#define HeaderMarco_h

/** 系统库
 */
//#import <objc/runtime.h>

/** 第三方库
 */
#import "ReactiveObjC.h" // rac
// YYkit
#import "YYCategories.h"
#import "YYText.h"
#import "Masonry.h" // 视图约束配置
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h> // 空视图展示
#import "XHPKit.h" // x宝/x信 goumai
#import "MJExtension.h" // 解析网络数据
#import "RTRootNavigationController.h" // 自定义导航栏
#import "MJRefresh.h" // 上拉加载下拉刷新
#import "FLEX.h" // 调试器
#import "SGPagingView.h" // 多段控制器
#import "TZImagePickerController.h" // 跳转相册
#import "SGQRCode.h" // 扫描二维码/二维码
#import "FLAnimatedImage.h" // 加载动态图片
#import "SDCycleScrollView.h" // 轮播图
#import "IQKeyboardManager.h" // 键盘弹起自适应
#import "XHLaunchAd.h" // 启动页广告
#import "PPNetworkHelper.h" // 网络请求
#import "MTTCircularSlider.h" // 自定义‘方向盘’形slider视图，3张图片实现
// ---- 百度地图 ----
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BMKLocationKit/BMKLocationComponent.h>//百度定位
// ---- 图片浏览器 视频播放器 ----
#import <YBImageBrowser/YBImageBrowser.h> // 浏览图片
#import <YBImageBrowser/YBIBVideoData.h> // 浏览视频
// 动态监听/动态修复闪退
#import "JJException.h"
#import "TLAnimationTabBar.h" // 自定义tabBar动画
#import "BRPickerView.h" // 地址/时间选择器
#import "XWCountryCodeController.h" // 国家选择器
#import "NNValidationView.h" // 图片验证码
#import "BRPickerView.h" // 城市/日期选择器
#import "LCActionSheet.h" // 自定义alert
#import "YUFoldingTableView.h" // 可折叠cell
#import "RJBadgeKit.h" // UIView显示红点，可自定义图片
#import "UIViewController+CWLateralSlide.h" // 侧边栏筛选菜单
#import "STPopupManager.h" // 将UIViewController当做window来用，frame自定义
#import "TTGTextTagCollectionView.h" // 标签CollectionView 自适应高度

/** 自定义基类
 */
#import "OBJBaseViewController.h"
#import "OBJBaseNavigationController.h"
#import "OBJBaseTabBarController.h"
#import "OBJConvertWindowViewController.h"
#import "TabBarPageBaseViewController.h"
#import "XYBaseGuideViewController.h"
#import "XYBaseWebViewController.h"
#import "XYEmptyTableView.h"
#import "XYEmptyCollectionView.h"

#import "XYTextfield.h"
#import "OBJBaseLabel.h"
#import "OBJBaseImageView.h"
#import "OBJBaseButton.h"
#import "OBJSlider.h"
#import "XYObserverView.h" // 动态监听键盘高度的view，如果view上有输入框，则动态改变view位置
#import "FilterBaseCell.h" // 侧边栏基类cell
#import "MYTreeTableViewController.h" // 树状列表，高度自定义

/** 自定义管理类
 */
#import "XYPopupView.h" // 视图弹出动画
#import "XYKitRouter.h"
#import "UtilityTools.h" // 公共方法
#import "XHPKitManager.h" // x宝/x信 manager
#import "RTNavRouter.h" // 路由
#import "XYKitMediator.h" // 跳转相关
#import "AdapterManager.h" // 控制台打印dealloc信息
#import "MJRefreshManager.h" // MJ菊花封装
#import "TZImagePickerControllerManager.h" // 跳转到TZ相册
#import "XYPermissionManager.h" // 权限判断
#import "XHLaunchAdManager.h" // 启动页广告
#import "UMengUShareManager.h" // 友盟登录分享
#import "NetWorkStatusManager.h" // 实时监听网络状态

// 数据库相关 ----
#import "BGFMDB.h"
#import "BGFMDBManager.h"
#import "BGFMDBMaro.h"
#import "BGFMDBTestModel.h"


/** 类别Category
 */
#import "MBProgressHUD+XYKit.h"
#import "NSMutableAttributedString+AutoSize.h"
#import "UIImageView+WebCache.h"
#import "UIImage+GIF.h"
#import "UIButton+EnlargeEdge.h"
#import "UIViewController+HHTransition.h"
#import "NSString+Extension.h"
#import "NSObject+KVO.h"
#import "NSObject+Extension.h"
#import "NSObject+Runtime.h"
#import "UIImage+Extension.h"
#import "UIButton+Extension.h"
#import "UILabel+Extension.h"
#import "CALayer+XibColor.h"
#import "UITextView+Extension.h"
#import "UIColor+Extension.h"

#endif /* HeaderMarco_h */
