//
//  BGFMDBMaro.h
//  BaseObjSet
//
//  Created by 元潇 on 2018/12/20.
//  Copyright © 2018 元潇. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 默认数据库
 */
UIKIT_EXTERN NSString * const DB_NAMEKEY_WITH_DEFAULT;
/// 表(在默认数据库下的)
UIKIT_EXTERN NSString * const TABLE_NAMEKEY_WITH_DEFAULT; // 默认
UIKIT_EXTERN NSString * const TABLE_NAMEKEY_WITH_SEARCH; // 搜索历史

/** 测试数据库
 */
UIKIT_EXTERN NSString * const DB_NAMEKEY_WITH_TEST;
/// 表(在测试数据库下的)
UIKIT_EXTERN NSString * const TABLE_NAMEKEY_WITH_TEST;


@interface BGFMDBMaro : NSObject
@end

NS_ASSUME_NONNULL_END
