//
//  BGFMDBTestModel.m
//  BaseObjSet
//
//  Created by 元潇 on 2018/12/20.
//  Copyright © 2018 元潇. All rights reserved.
//

#import "BGFMDBTestModel.h"

@implementation BGFMDBTestModel

/**
 如果需要指定“唯一约束”字段,就实现该函数,这里指定 name 为“唯一约束”.
 */
//+(NSArray *)bg_uniqueKeys{
//    return @[@"name"];
//}

/**
 设置不需要存储的属性.
 */
//+(NSArray *)bg_ignoreKeys{
//   return @[@"eye",@"sex",@"num"];
//}

/**
 自定义“联合主键” ,这里指定 name和age 为“联合主键”.
 */
//+(NSArray *)bg_unionPrimaryKeys{
//    return @[@"name",@"age"];
//}

@end

@implementation Man

@end

@implementation User
//+(NSArray *)bg_ignoreKeys{
//   return @[@"attri",@"userNumer",@"student",@"userP"];
//}
@end

@implementation Student

@end

@implementation Human

@end

@implementation testT

@end

@implementation T1

@end

@implementation T2

@end

@implementation T3

@end
