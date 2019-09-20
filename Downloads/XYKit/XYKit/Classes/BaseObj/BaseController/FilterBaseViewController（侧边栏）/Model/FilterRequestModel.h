//
//  FilterRequestModel.h
//  Sales
//
//  Created by 元潇 on 2019/9/6.
//  Copyright © 2019年 南开承盛. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kCustomerManagementUrl [NSString stringWithFormat:@"%@%@", MAIN_URL, @"app/customer/list/filter/data"]


@interface FilterRequestModel : NSObject
// 开始日期、结束日期
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *endDate;
// 姓名
@property (nonatomic, copy) NSString *name;
// 选中的便签
@property (nonatomic, copy) NSArray <NSString *>*selectTags;

@end

NS_ASSUME_NONNULL_END
