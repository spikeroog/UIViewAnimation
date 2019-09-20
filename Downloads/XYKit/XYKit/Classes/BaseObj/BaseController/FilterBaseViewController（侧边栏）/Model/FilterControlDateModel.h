//
//  FilterControlDateModel.h
//  Sales
//
//  Created by 元潇 on 2019/9/6.
//  Copyright © 2019年 南开承盛. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FilterControlDateModel : NSObject
// 点击开始日期
@property (nonatomic, strong) RACSubject *didStartSubject;
// 点击结束日期
@property (nonatomic, strong) RACSubject *didEndSubject;

@end

NS_ASSUME_NONNULL_END
