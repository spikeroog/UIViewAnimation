//
//  MJRefreshManager.h
//  BaseObjSet
//
//  Created by 元潇 on 2018/11/28.
//  Copyright © 2018 元潇. All rights reserved.
//  自定义GIF的MJ上拉下拉的封装
//  当我们想要实现各个界面互不影响，由于单例只会初始化一次会有多个界面互相影响的问题，不能使用单例，只能将工具类声明成类的属性，再单独调用，如:@property (nonatomic, strong) MJRefreshManager *mjRefreshManager;

#import <Foundation/Foundation.h>
#import "MJRefreshManager.h"

typedef void(^PullUpRefresh)(void); // 上拉
typedef void(^PullDownRefresh)(void); // 下拉

NS_ASSUME_NONNULL_BEGIN

@interface MJRefreshManager : NSObject

@property (nonatomic, assign) NSInteger pageNumber;

/**
 为tableView或者collectionView添加下拉刷新
 参数传nil就是默认

 @param targetView 传入的tableView或者collectionView
 @param isGif 是否是gif
 @param pullDownCallBack 下拉刷新回调
 */
- (void)initialMJHeaderWithTargetView:(nullable __kindof UIScrollView *)targetView
                                isGif:(BOOL)isGif
                     pullDownCallBack:(PullDownRefresh)pullDownCallBack;

/**
 为tableView或者collectionView添加上拉加载
 参数传nil就是默认

 @param targetView 传入的tableView或者collectionView
 @param isGif 是否是gif
 @param pullUpCallBack 上拉加载回调
 */
- (void)initialMJFooterWithTargetView:(nullable __kindof UIScrollView *)targetView
                                isGif:(BOOL)isGif
                       pullUpCallBack:(PullUpRefresh)pullUpCallBack;
@end

NS_ASSUME_NONNULL_END
