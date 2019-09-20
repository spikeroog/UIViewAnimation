//
//  FilterCallBackModel.m
//  Sales
//
//  Created by 元潇 on 2019/9/9.
//  Copyright © 2019年 南开承盛. All rights reserved.
//

#import "FilterCallBackModel.h"

@implementation FilterCallBackDataListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ids":@"id"
             };
}

@end


@implementation FilterCallBackModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ids":@"id"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"dataList":@"FilterCallBackDataListModel"
             };
}

@end
