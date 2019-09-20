//
//  OBJBaseViewController.h
//  BaseObjSet
//
//  Created by 元潇 on 2018/11/20.
//  Copyright © 2018 元潇. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^RightItemsHandle) (NSInteger idx);

@interface OBJBaseViewController : UIViewController

/**导航栏背景颜色*/
@property (nonatomic, strong) UIColor *navBgColor;
/**导航栏按钮颜色*/
@property (nonatomic, strong) UIColor *navTitleColor;
/**导航栏标题颜色*/
@property (nonatomic, strong) UIColor *navButtonColor;

/**导航栏标题*/
@property (nonatomic, copy) NSString *navTitle;
/**导航栏标题图片*/
@property (nonatomic, strong) UIImage *titleViewImage;

/**左侧按钮文字*/
@property (nonatomic, copy) NSString *leftBarItemTitle;
/**左侧按钮图片*/
@property (nonatomic, copy) NSString *leftBarItemImage;

/**右侧按钮文字*/
@property (nonatomic, copy) NSString *rightBarItemTitle;
/**右侧按钮图片*/
@property (nonatomic, copy) NSString *rightBarItemImage;

/**多个右侧按钮点击回调*/
@property (nonatomic, copy) RightItemsHandle rightItemsHandle;

/**左侧按钮显示*/
- (void)leftBarItemShow;
/**左侧按钮隐藏*/
- (void)leftBarItemHidden;
/**单个右侧按钮显示*/
- (void)rightBarItemShow;
/**单个右侧按钮隐藏*/
- (void)rightBarItemHidden;
/**多个右侧按钮显示*/
- (void)rightBarItemsShowWithArray:(NSArray<NSNumber *> *)itemsArray;
/**多个右侧按钮隐藏*/
- (void)rightBarItemHiddenWithArray:(NSArray<NSNumber *> *)itemsArray;

/**
 点击右侧按钮数组回调
 
 @param complete 回调
 */
- (void)clickRigBarItemsHandle:(void(^)(NSInteger index))complete;

/**
 创建多个导航栏右侧按钮

 @param titleArr 标题
 @param imageArr 图片
 */
- (void)rigBarItemsWithTitleArr:(NSArray *)titleArr
                       imageArr:(NSArray *)imageArr;

/**左侧按钮点击方法*/
- (void)leftActionInController;
/**右侧按钮点击方法*/
- (void)rightActionInController;

/**隐藏导航条*/
- (void)hiddenNavigation;
/**显示导航条*/
- (void)showNavigation;

@end

NS_ASSUME_NONNULL_END
