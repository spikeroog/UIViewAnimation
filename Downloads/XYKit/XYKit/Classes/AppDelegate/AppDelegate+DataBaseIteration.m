//
//  AppDelegate+DataBaseIteration.m
//  BaseObjSet
//
//  Created by 元潇 on 2018/12/20.
//  Copyright © 2018 元潇. All rights reserved.
//

#import "AppDelegate+DataBaseIteration.h"
/** 在这里包含用到的所有的表Model **/
#import "BGFMDBTestModel.h" // 在defaultDB里面

@implementation AppDelegate (DataBaseIteration)

/**
 数据库版本迭代
 */
- (void)dataBaseIteration {
    dispatch_queue_t queue = dispatch_queue_create("dataBaseIteration", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        BOOL type = [BGFMDBManager tableIterationWithTableName:TABLE_NAMEKEY_WITH_DEFAULT dataBaseName:DB_NAMEKEY_WITH_DEFAULT tableModel:[BGFMDBTestModel new]];
        if (type == YES) { // 处理成功
            
        } else { // 处理失败
            
        }
    });
}

@end
