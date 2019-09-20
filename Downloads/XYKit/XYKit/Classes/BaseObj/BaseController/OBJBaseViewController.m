//
//  OBJBaseViewController.m
//  BaseObjSet
//
//  Created by 元潇 on 2018/11/20.
//  Copyright © 2018 元潇. All rights reserved.
//

#import "OBJBaseViewController.h"

@interface OBJBaseViewController ()
<RTNavigationItemCustomizable>
/**左侧按钮Item*/
@property (nonatomic, strong) UIBarButtonItem *leftBarItem;
/**右侧按钮Item*/
@property (nonatomic, strong) UIBarButtonItem *rightBarItem;
@end

@implementation OBJBaseViewController

@synthesize
navBgColor = _navBgColor,
navTitleColor = _navTitleColor,
navButtonColor = _navButtonColor,
navTitle = _navTitle;

#pragma mark - Controller lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 隐藏导航栏 UIScrollView下移问题 适配ios11
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // 不是根控制器左侧默认显示图片
    NSInteger count = [RTNavRouter currentNavC].childViewControllers.count;
    if (count > 1) {
        // 设置默认左侧按钮图片
        self.leftBarItemImage = @"nav_icon_back";
        self.rt_disableInteractivePop = NO;
    } else {
        self.rt_disableInteractivePop = YES;
    }

    self.navBgColor = UIColorWithRGB16Radix(0x24252C);
    self.navTitleColor = UIColorWithRGB16Radix(0xffffff);
    self.navButtonColor = UIColorWithRGB16Radix(0xffffff);
    self.view.backgroundColor = UIColorWithRGB16Radix(0xF5F5F5);
    
    // 去掉导航栏下方的线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

    // 取消导航栏半透明
    self.navigationController.navigationBar.translucent = NO;
    // 修改导航栏背景颜色
    self.navigationController.navigationBar.barTintColor = self.navBgColor;
    // 修改导航栏字体颜色
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    // 修改导航栏按钮颜色
    self.navigationController.navigationBar.tintColor = self.navButtonColor;

    // 设置导航栏标题样式
    NSMutableDictionary *titleTextAttributes = [NSMutableDictionary dictionary];
    // 颜色
    titleTextAttributes[NSForegroundColorAttributeName] = self.navTitleColor;
    // 字体大小
    titleTextAttributes[NSFontAttributeName] = UIFontWithAutoSize(18.0f);
    [self.navigationController.navigationBar setTitleTextAttributes:titleTextAttributes];
}

#pragma mark - 导航栏左右侧按钮点击事件，子类重写的话就不会再调用了
/**
 左侧按钮点击事件
 */
- (void)leftActionInController {
    [RTNavRouter popController];
}

/**
 右侧按钮点击事件
 */
- (void)rightActionInController {
    
}

#pragma mark - 导航栏颜色
/**修改导航栏背景颜色  如果是标签栏界面，想要改变导航栏颜色，需要设置每一个子控制器的导航栏颜色*/
- (void)setNavBgColor:(UIColor *)navBgColor {
    UIColor *col = !navBgColor ? UIColorWithRGB16Radix(0xffffff):navBgColor;
    _navBgColor = col;
    self.navigationController.navigationBar.barTintColor = _navBgColor;
    
    self.rt_navigationController.navigationBar.barTintColor = _navBgColor;
}

- (UIColor *)navBgColor {
    UIColor *col = !_navBgColor ? UIColorWithRGB16Radix(0xffffff):_navBgColor;
    return col;
}

/**修改导航栏标题颜色*/
- (void)setNavTitleColor:(UIColor *)navTitleColor {
    UIColor *col = !navTitleColor ? UIColorWithRGB16Radix(0xffffff):navTitleColor;
    _navTitleColor = col;
    NSMutableDictionary *titleTextAttributes = [NSMutableDictionary dictionary];
    titleTextAttributes[NSForegroundColorAttributeName] = _navTitleColor;
    titleTextAttributes[NSFontAttributeName] = UIFontWithAutoSize(18.0f);
    [self.navigationController.navigationBar setTitleTextAttributes:titleTextAttributes];
}

- (UIColor *)navTitleColor {
    UIColor *col = !_navTitleColor ? UIColorWithRGB16Radix(0xffffff):_navTitleColor;
    return col;
}

/**修改导航栏按钮背景颜色*/
- (void)setNavButtonColor:(UIColor *)navButtonColor {
    UIColor *col = !navButtonColor ? UIColorWithRGB16Radix(0xffffff):navButtonColor;
    _navButtonColor = col;
    self.navigationController.navigationBar.tintColor = _navButtonColor;
}

- (UIColor *)navButtonColor {
    UIColor *col = !_navButtonColor ? UIColorWithRGB16Radix(0xffffff):_navButtonColor;
    return col;
}

#pragma mark - 导航栏标题
/**
 设置标题
 
 @param title 文字
 */
- (void)setTitle:(NSString *)title {
    _navTitle = title;
    self.navigationItem.title = _navTitle;
}

- (void)setNavTitle:(NSString *)navTitle {
    _navTitle = navTitle;
    self.navigationItem.title = _navTitle;
}

- (NSString *)navTitle {
    return _navTitle;
}

#pragma mark - 导航栏标题处图片
/**
 设置标题处图片

 @param titleViewImage 图片名
 */
- (void)setTitleViewImage:(UIImage *)titleViewImage {
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:titleViewImage];
}

#pragma mark - 导航栏左侧按钮
/**
 导航栏左侧按钮

 @return 导航栏左侧按钮
 */
- (UIBarButtonItem *)leftBarItem {
    if (!_leftBarItem) {
        _leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:@selector(leftActionInController)];
        [_leftBarItem setTintColor:[UIColor whiteColor]];
        [_leftBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIFontWithAutoSize(16),NSFontAttributeName,nil] forState:UIControlStateNormal];
        [_leftBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIFontWithAutoSize(16),NSFontAttributeName,nil] forState:UIControlStateHighlighted];
        self.navigationItem.leftBarButtonItem = _leftBarItem;
    }
    return _leftBarItem;
}

/**
 左侧按钮设置文字
 
 @param leftBarItemTitle 文字
 */
- (void)setLeftBarItemTitle:(NSString *)leftBarItemTitle {
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:leftBarItemTitle style:UIBarButtonItemStyleDone target:self action:@selector(leftActionInController)];
    [leftBarItem setTintColor:[UIColor whiteColor]];
    [leftBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIFontWithAutoSize(16),NSFontAttributeName,nil] forState:UIControlStateNormal];
    [leftBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIFontWithAutoSize(16),NSFontAttributeName,nil] forState:UIControlStateHighlighted];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

/**
 左侧按钮设置图片
 
 @param leftBarItemImage 图片url
 */
- (void)setLeftBarItemImage:(NSString *)leftBarItemImage {
    // 左侧设置或返回
    UIImage *leftBarButtonImage = [UIImageWithStr(leftBarItemImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(leftActionInController)];
}

#pragma mark - 导航栏右侧按钮
/**
 导航栏右侧按钮
 
 @return 导航栏右侧按钮
 */
- (UIBarButtonItem *)rightBarItem {
    if (!_rightBarItem) {
        _rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:@selector(rightActionInController)];
        [_rightBarItem setTintColor:[UIColor whiteColor]];
        [_rightBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIFontWithAutoSize(16),NSFontAttributeName,nil] forState:UIControlStateNormal];
        [_rightBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIFontWithAutoSize(16),NSFontAttributeName,nil] forState:UIControlStateHighlighted];
        self.navigationItem.rightBarButtonItem = _rightBarItem;
    }
    return _rightBarItem;
}

/**
 右侧按钮设置文字
 
 @param rightBarItemTitle 文字
 */
- (void)setRightBarItemTitle:(NSString *)rightBarItemTitle {
    UIBarButtonItem *rightBarBtnItem = [[UIBarButtonItem alloc] initWithTitle:rightBarItemTitle style:UIBarButtonItemStyleDone target:self action:@selector(rightActionInController)];
    [rightBarBtnItem setTintColor:[UIColor whiteColor]];
    [rightBarBtnItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIFontWithAutoSize(16),NSFontAttributeName,nil] forState:UIControlStateNormal];
    [rightBarBtnItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIFontWithAutoSize(16),NSFontAttributeName,nil] forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem = rightBarBtnItem;
}

/**
 右侧按钮设置图片
 
 @param rightBarItemImage 图片url
 */
- (void)setRightBarItemImage:(NSString *)rightBarItemImage {
    UIImage *rightBarButtonImage = [UIImageWithStr(rightBarItemImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:rightBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(rightActionInController)];
}

/**
 创建多个导航栏右侧按钮
 如果需要动态改变数组里面某个按钮的标题或者背景图片，重写一行rigBarItemsWithTitleArr代码即可，回调会走最新的那行代码下
 
 @param titleArr 标题
 @param imageArr 图片
 */
- (void)rigBarItemsWithTitleArr:(NSArray *)titleArr
                       imageArr:(NSArray *)imageArr {
    
    NSInteger count;
    titleArr.count >= imageArr.count ? (count = titleArr.count) : (count = imageArr.count);
    
    NSMutableArray<UIBarButtonItem *> *muarr = [[NSMutableArray alloc] init];
    
    for (int i = 0 ; i < count; i++) {
        
        UIBarButtonItem *rigItem = [[UIBarButtonItem alloc] init];
        if ([titleArr objectOrNilAtIndex:i] != nil && [imageArr objectOrNilAtIndex:i] != nil) { // 有文字和图片，使用自定义样式
            
            UIButton *rigBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [rigBtn addTarget:self action:@selector(rigBtnsAct:) forControlEvents:UIControlEventTouchUpInside];
            
            if ([imageArr objectOrNilAtIndex:i] != nil) {
                if ([titleArr objectOrNilAtIndex:i] != nil) {
                    [rigBtn setTitle:[NSString stringWithFormat:@" %@",titleArr[i]] forState:UIControlStateNormal];
                }
            } else {
                if ([titleArr objectOrNilAtIndex:i] != nil) {
                    [rigBtn setTitle:[NSString stringWithFormat:@"%@",titleArr[i]] forState:UIControlStateNormal];
                }
            }
            
            if ([imageArr objectOrNilAtIndex:i] != nil) {
                [rigBtn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
            }
            
            rigBtn.tag = i+100;
            [rigBtn sizeToFit];
            
            rigItem = [[UIBarButtonItem alloc] initWithCustomView:rigBtn];
            
        } else if ([titleArr objectOrNilAtIndex:i] != nil && [imageArr objectOrNilAtIndex:i] == nil) { // 只有文字，使用系统title样式
            
            rigItem = [[UIBarButtonItem alloc] initWithTitle:titleArr[i] style:UIBarButtonItemStyleDone target:self action:@selector(rigBtnsAct:)];
            [rigItem setTintColor:[UIColor whiteColor]];
            [rigItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIFontWithAutoSize(16),NSFontAttributeName,nil] forState:UIControlStateNormal];
            [rigItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIFontWithAutoSize(16),NSFontAttributeName,nil] forState:UIControlStateHighlighted];
            rigItem.tag = i+100;

        } else if ([imageArr objectOrNilAtIndex:i] != nil && [titleArr objectOrNilAtIndex:i] == nil) { // 只有图片，使用系统image样式
            
            UIImage *rightBarButtonImage = [UIImageWithStr(imageArr[i]) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            rigItem = [[UIBarButtonItem alloc] initWithImage:rightBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(rigBtnsAct:)];
            rigItem.tag = i+100;

        }
        
        [muarr addObject:rigItem];
    }
    
    self.navigationItem.rightBarButtonItems = muarr;
}


/**
 点击右侧按钮数组回调

 @param complete 回调
 */
- (void)clickRigBarItemsHandle:(void(^)(NSInteger))complete {
    self.rightItemsHandle = complete;
}

- (void)rigBtnsAct:(UIButton *)sender {
    NSInteger idx = sender.tag - 100;
    !self.rightItemsHandle ? : self.rightItemsHandle(idx);
}

- (void)leftBarItemShow {
    self.leftBarItem.enabled = YES;
    self.leftBarItem.customView.hidden = NO;
}

- (void)leftBarItemHidden {
    self.leftBarItem.enabled = NO;
    self.leftBarItem.customView.hidden = YES;
}

- (void)rightBarItemShow {
    self.rightBarItem.enabled = YES;
    self.rightBarItem.customView.hidden = NO;
}

- (void)rightBarItemHidden {
    self.rightBarItem.enabled = NO;
    self.rightBarItem.customView.hidden = YES;
}

// [self rightBarItemsShowWithArray:@[@1,@2]];
- (void)rightBarItemsShowWithArray:(NSArray<NSNumber *> *)itemsArray {
    [itemsArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger index = [obj integerValue];
        self.navigationItem.rightBarButtonItems[index].enabled = YES;
        self.navigationItem.rightBarButtonItems[index].customView.hidden = NO;
    }];
}

// [self rightBarItemHiddenWithArray:@[@1,@2]];
- (void)rightBarItemHiddenWithArray:(NSArray<NSNumber *> *)itemsArray {
    [itemsArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger index = [obj integerValue];
        self.navigationItem.rightBarButtonItems[index].enabled = NO;
        self.navigationItem.rightBarButtonItems[index].customView.hidden = YES;
    }];
}

#pragma mark - 隐藏/显示导航栏
/**
 隐藏导航栏
 */
- (void)hiddenNavigation {
    self.navigationController.navigationBarHidden = YES;
}

/**
 显示导航栏
 */
- (void)showNavigation {
    self.navigationController.navigationBarHidden = NO;
}


@end
