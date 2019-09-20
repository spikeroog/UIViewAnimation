//
//  XYEmptyCollectionView.h
//  BaseObjSet
//
//  Created by 元潇 on 2019/8/13.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

typedef void(^CollectionViewEmptyViewClickBlock) ();

NS_ASSUME_NONNULL_BEGIN

@interface XYEmptyCollectionView : UICollectionView
@property (nonatomic, copy) CollectionViewEmptyViewClickBlock collectionViewEmptyViewClickBlock;

@end

NS_ASSUME_NONNULL_END
