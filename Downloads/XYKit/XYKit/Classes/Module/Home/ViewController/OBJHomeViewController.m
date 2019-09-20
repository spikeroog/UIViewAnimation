//
//  OBJHomeViewController.m
//  BaseObjSet
//
//  Created by 元潇 on 2018/11/28.
//  Copyright © 2018 元潇. All rights reserved.
//

#import "OBJHomeViewController.h"
#import "XYEmptyCollectionView.h"
#import "XYHomeDetailsViewController.h"
#import "XYHomeNextVC.h"
#import "XYHomeNextVC1.h"
#import "XYHomeNextVC2.h"
#import "XYHomeNextVC3.h"
#import "XYtestView.h"


#define HeaderMaskViewHeight kAutoCs(100)

static NSString * const kCollectionViewCellId = @"kCollectionViewCellId";

@interface OBJHomeViewController ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) XYEmptyCollectionView *collectionV;
@property (nonatomic, strong) MJRefreshManager *mjRefreshManager;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) XYHomeDetailsViewController *detailVC;

@end

@implementation OBJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleViewImage = UIImageWithStr(@"MainTitle");
//    self.navTitle = @"首页";

    [self rigBarItemsWithTitleArr:@[] imageArr:@[@"Image_headerView_settings", @"icon_nav_dycard"]];
    
    _WeakSelf
    [self clickRigBarItemsHandle:^(NSInteger index) {
        if (index == 0) {
            [weakSelf gotoNext];
            DLog(@"0");
        } else if (index == 1) {
            [weakSelf popWindow];
        } else {
            DLog(@"2");
        }
    }];

    
    // 注册手势驱动
    [self cw_registerShowIntractiveWithEdgeGesture:YES transitionDirectionAutoBlock:^(CWDrawerTransitionDirection direction) {
        if (direction == CWDrawerTransitionFromLeft) { // 左侧滑出
            [weakSelf defaultAnimationFromLeft];
        } else if (direction == CWDrawerTransitionFromRight) { // 右侧滑出
            [weakSelf scaleYAnimationFromRight];
        }
    }];
    
    
    // 注意，要先设置MJRefresh（setMJRefresh）再构建collectionView（setUpUI），这样的话MJRefresh就会出现在背景imgView上面了，不这么写的话，MJRefresh会被imgView挡住哦
    [self setMJRefresh];
    [self setUpUI];
    [self setUpConstraints];
//    [self reloadHttpData];
}
- (void)rightActionInController {
    
}

- (void)leftActionInController {
    
}

// 仿QQ从左侧划出
- (void)defaultAnimationFromLeft {
    // 强引用leftVC，不用每次创建新的,也可以每次在这里创建leftVC，抽屉收起的时候会释放掉
    [self cw_showDefaultDrawerViewController:self.detailVC];
    // 或者这样调用
    //    [self cw_showDrawerViewController:vc animationType:CWDrawerAnimationTypeDefault configuration:nil];
}

// 仿QQ从右侧划出
- (void)scaleYAnimationFromRight {
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration defaultConfiguration];
    conf.direction = CWDrawerTransitionFromRight; // 从右边滑出
    conf.finishPercent = 0.2f;
    conf.showAnimDuration = 0.2f;
    conf.HiddenAnimDuration = 0.2f;
    conf.maskAlpha = 0.1f;
    
    [self cw_showDrawerViewController:self.detailVC animationType:CWDrawerAnimationTypeDefault configuration:conf];
}

- (void)setUpUI {
    [self.view addSubview:self.collectionV];
   
}

- (void)setUpConstraints {
    
    [self.collectionV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setMJRefresh {
    _WeakSelf
    // 下拉刷新
    [self.mjRefreshManager initialMJHeaderWithTargetView:self.collectionV isGif:YES pullDownCallBack:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.page = 1;
            [weakSelf.datas removeAllObjects];
            [weakSelf reloadHttpData];
        });
      
    }];
    // 上拉加载
    [self.mjRefreshManager initialMJFooterWithTargetView:self.collectionV isGif:YES pullUpCallBack:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.page++;
            [weakSelf reloadHttpData];
        });
    }];
}


- (void)reloadHttpData {
    // test
    [self.datas addObjectsFromArray:@[@"", @"", @"", @"", @"",@""]];
    [self.collectionV reloadData];
    [self.collectionV.mj_header endRefreshing];
    [self.collectionV.mj_footer endRefreshing];
}

- (void)popWindow {
    XYtestView *view = [[[NSBundle mainBundle] loadNibNamed:@"XYtestView" owner:nil options:nil]firstObject];
    [[XYPopupView shareInstance] popupView:view animationType:PopUpViewAnimationTypeBottom clickDismiss:NO];
}

- (void)gotoNext {
    [RTNavRouter pushViewController:[XYHomeNextVC new]];
}

#pragma mark - UICollectionView

// 返回头部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
    
    } else if (kind == UICollectionElementKindSectionFooter) {
        
    }
    return reusableView;
}


// 每个分区下的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

// 默认返回1
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.datas.count;
}

// 填充单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellId forIndexPath:indexPath];
    cell.backgroundColor = UIColorWithRandom;
    return cell;
}

// 点击单元格
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = UIColorWithRandom;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kScreenWidth/2, kAutoCs(100));
}


//设置每个item水平间距（行）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//设置每个item垂直间距（列）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - NSObject

- (XYEmptyCollectionView *)collectionV {
    if (!_collectionV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionV = [[XYEmptyCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _WeakSelf
        // 空视图点击
        _collectionV.collectionViewEmptyViewClickBlock = ^{
            weakSelf.page = 1;
            [weakSelf.datas removeAllObjects];
            [weakSelf reloadHttpData];
        };
        // 取消水平，垂直方向的滑动条
        _collectionV.showsHorizontalScrollIndicator = NO;
        _collectionV.showsVerticalScrollIndicator = NO;
        _collectionV.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionV.backgroundColor = UIColorWithRGB16Radix(0xffffff);
        // 设置代理,和tableview一样有两个代理,三个代理方法
        _collectionV.dataSource = self;
        _collectionV.delegate = self;
        [_collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewCellId];
    }
    return _collectionV;
}

- (MJRefreshManager *)mjRefreshManager {
    if (!_mjRefreshManager) {
        _mjRefreshManager = [[MJRefreshManager alloc] init];
    }
    return _mjRefreshManager;
}

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [[NSMutableArray alloc] init];
    }
    return _datas;
}

- (XYHomeDetailsViewController *)detailVC {
    if (!_detailVC) {
        _detailVC = [[XYHomeDetailsViewController alloc] init];
    }
    return _detailVC;
}

@end
