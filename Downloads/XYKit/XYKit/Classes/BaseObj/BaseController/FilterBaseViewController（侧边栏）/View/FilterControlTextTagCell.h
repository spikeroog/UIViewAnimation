//
//  FilterControlTextTagCell.h
//  Sales
//
//  Created by 元潇 on 2019/9/9.
//  Copyright © 2019年 南开承盛. All rights reserved.
//

#import "FilterBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface FilterControlTextTagCell : FilterBaseCell
@property (nonatomic, strong) TTGTextTagCollectionView *tagView;
- (void)setTags:(NSArray<NSString *> *)tags;
// 点击tag
@property (nonatomic, strong) RACSubject *clickTagSubject;

@end

NS_ASSUME_NONNULL_END
