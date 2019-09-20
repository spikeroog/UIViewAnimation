//
//  TabBarPageBaseViewController.m
//  XYKit
//
//  Created by 元潇 on 2019/9/4.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "TabBarPageBaseViewController.h"
#import "SGPagingView.h"

@interface TabBarPageBaseViewController ()
<SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentCollectionView *pageContentCollectionView;

@property (nonatomic, strong) NSArray<__kindof UIViewController *> *datas;
@property (nonatomic, strong) NSArray<NSString *> *titles;

@property (nonatomic, strong) UIImageView *headView; // 自定义样式

@end

@implementation TabBarPageBaseViewController

- (void)configHeaderView {
    
    self.headView = [[UIImageView alloc] init];
    self.headView.backgroundColor = [RTNavRouter navBgColor];
    [self.view addSubview:self.headView];
    [self.view sendSubviewToBack:self.headView];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView).offset(kAutoCs(0));
        make.left.equalTo(self.headView).offset(kAutoCs(0));
        make.width.offset(kScreenWidth);
        make.height.offset(kAutoCs(50));
    }];
}

/**
 构建标签栏
 
 @param datas 标签控制器
 @param titles 标签title
 
 */
- (void)configDefaultTabPageBar:(NSArray<__kindof UIViewController *>*)datas
                         titles:(NSArray<NSString *>*)titles {
    
    [self configHeaderView];
    
    _datas = datas;
    _titles = titles;
    
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    // 如果需要未选中为细字体，选中为粗字体，直接设置两种字体一种为粗，一种为细即可
    configure.titleFont = UIFontWithAutoSize(17);
    configure.titleSelectedFont = UIBoldFontWithAutoSize(17);
    configure.titleColor = UIColorWithRGB16Radix(0x6A7C94);
    configure.titleSelectedColor = UIColorWithRGB16Radix(0x4BA5FB);
    
    // 是否居左布局 默认YES，如果需要居左布局，设置为NO
    configure.equivalence = YES;
    
    configure.indicatorColor = UIColorWithRGB16Radix(0x4BA5FB);
    configure.indicatorStyle = SGIndicatorStyleDynamic;
    // 如果是固定样式，就不用设置
    configure.titleAdditionalWidth = kAutoCs(35);
    // 不显示分割线
    configure.showBottomSeparator = NO;
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(kAutoCs(15), kAutoCs(25), self.view.frame.size.width-kAutoCs(15*2), kAutoCs(50)) delegate:self titleNames:_titles configure:configure];
    self.pageTitleView.backgroundColor = UIColorWithRGB16Radix(0xffffff);
    
    self.pageTitleView.layer.cornerRadius = kAutoCs(10);
    self.pageTitleView.layer.masksToBounds = YES;
    
    [self.view addSubview:_pageTitleView];
    
    CGFloat collectionViewHeight = self.view.frame.size.height - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentCollectionView = [[SGPageContentCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), self.view.frame.size.width, collectionViewHeight) parentVC:self childVCs:_datas];
    _pageContentCollectionView.delegatePageContentCollectionView = self;
    [self.view addSubview:_pageContentCollectionView];
}

- (void)configSingleCenterTabPageBar:(NSArray<__kindof UIViewController *>*)datas
                              titles:(NSArray<NSString *>*)titles {
    _datas = datas;
    _titles = titles;
    
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    // 设置缩放效果，titleTextZoomRatio为0.9，则选中字体是未选中的1.9倍
    // 这里我们只要设置未选中的大小就好了，不能设置选中字体
    configure.titleFont = UIFontWithAutoSize(16);
    configure.titleColor = UIColorWithRGB16Radix(0x6A7C94);
    configure.titleSelectedColor = UIColorWithRGB16Radix(0x4BA5FB);
    
    configure.titleTextZoom = YES;
    configure.titleTextZoomRatio = 0.2;
    configure.titleGradientEffect = YES;
    
    // 是否居左布局 默认YES，如果需要居左布局，设置为NO
    configure.equivalence = YES;
    
    configure.indicatorColor = UIColorWithRGB16Radix(0x4BA5FB);
    configure.indicatorStyle = SGIndicatorStyleDynamic;
    // 如果是固定样式，就不用设置
    //    configure.titleAdditionalWidth = kAutoCs(35);
    // 不显示分割线
    configure.showBottomSeparator = NO;
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(kAutoCs(125), 0, self.view.frame.size.width-kAutoCs(125*2), kAutoCs(50)) delegate:self titleNames:_titles configure:configure];
    self.pageTitleView.backgroundColor = UIColorWithRGB16Radix(0xffffff);
    
    [self.view addSubview:_pageTitleView];
    
    CGFloat collectionViewHeight = self.view.frame.size.height - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentCollectionView = [[SGPageContentCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), self.view.frame.size.width, collectionViewHeight) parentVC:self childVCs:_datas];
    _pageContentCollectionView.delegatePageContentCollectionView = self;
    [self.view addSubview:_pageContentCollectionView];
}

- (void)configBigTitleTabPageBar:(NSArray<__kindof UIViewController *>*)datas
                          titles:(NSArray<NSString *>*)titles {
    _datas = datas;
    _titles = titles;
    
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    // 如果需要未选中为细字体，选中为粗字体，直接设置两种字体一种为粗，一种为细即可
    configure.titleFont = UIBoldFontWithAutoSize(18);
    configure.titleSelectedFont = UIBoldFontWithAutoSize(30);
    configure.titleColor = UIColorWithRGB16Radix(0x6A7C94);
    configure.titleSelectedColor = UIColorWithRGB16Radix(0x24252C);
    // 显示底部线
    configure.showBottomSeparator = YES;
    // 是否渐变
    configure.titleGradientEffect = YES;
    // 是否居左布局 默认YES，如果需要居左布局，设置为NO
    configure.equivalence = YES;
    
    configure.indicatorColor = UIColorWithRGB16Radix(0x4BA5FB);
    configure.indicatorStyle = SGIndicatorStyleDynamic;
    // 如果是固定样式，就不用设置
    //    configure.titleAdditionalWidth = kAutoCs(35);
    // 不显示分割线
    configure.showBottomSeparator = YES;
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(kAutoCs(15), 0, self.view.frame.size.width-kAutoCs(150), kAutoCs(50)) delegate:self titleNames:_titles configure:configure];
    self.pageTitleView.backgroundColor = UIColorWithNull;
    
    [self.view addSubview:_pageTitleView];
    
    CGFloat collectionViewHeight = self.view.frame.size.height - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentCollectionView = [[SGPageContentCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), self.view.frame.size.width, collectionViewHeight) parentVC:self childVCs:_datas];
    _pageContentCollectionView.delegatePageContentCollectionView = self;
    [self.view addSubview:_pageContentCollectionView];
}


#pragma mark - delegate
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentCollectionView setPageContentCollectionViewCurrentIndex:selectedIndex];
}

- (void)pageContentCollectionView:(SGPageContentCollectionView *)pageContentCollectionView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

@end
