//
//  BGFMDBManager.h
//  BaseObjSet
//
//  Created by 元潇 on 2018/12/20.
//  Copyright © 2018 元潇. All rights reserved.
//  封装数据库增删改查操作，可以将这种用Model驱动的方式理解为一个Model相当于一张表
/*
 Usage:
 1.
bg_primaryKey @"bg_id" -> 默认自增键(主键)
bg_createTimeKey @"bg_createTime" -> 默认创建时间
bg_updateTimeKey @"bg_updateTime" -> 默认更新时间
 2.
方法中传的tableModel是NSObject的实例对象
 
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BGFMDBManager : NSObject

#pragma mark - deprecated（弃用）
+ (instancetype)shareInstanced NS_UNAVAILABLE;

#pragma mark - 数据库所有表的版本迭代 unrealized（未实现）
+ (void)dataBaseIterationWithDataBaseName:(NSString *)dataBaseName;

#pragma mark - 数据库表迭代
/**
 数据库表版本迭代
 
 @param tableName 表名称
 @param dataBaseName 数据库名称
 @param tableModel 表字段Model
 @return 迭代结果
 */
+ (BOOL)tableIterationWithTableName:(NSString *)tableName
                       dataBaseName:(NSString *)dataBaseName
                         tableModel:(__kindof NSObject *)tableModel;

#pragma mark - 增
/**
 创建表 || 插入数据

 @param dataBaseName 数据库名称
 @param tableName 表名称
 @param tableModel 表字段Model
 @return 成功与否
 */
+ (BOOL)insertDataWithDataBaseName:(NSString *)dataBaseName
                         tableName:(NSString *)tableName
                        tableModel:(__kindof NSObject *)tableModel;

#pragma mark - 删
/**
 删除数据库
 
 @param dataBaseName 数据库
 @return 成功与否
 */
+ (BOOL)deleteDataBaseWithName:(NSString *)dataBaseName;

/**
 删除数据库中的某张表
 
 @param tableName 表名称
 @param dataBaseName 数据库名称
 @param tableModel 表字段Model
 @return 成功与否
 */
+ (BOOL)deleteTableWithName:(NSString *)tableName
               dataBaseName:(NSString *)dataBaseName
                 tableModel:(__kindof NSObject *)tableModel;

/**
 删除数据库中的某张表中的所有数据
 
 @param tableName 表名称
 @param dataBaseName 数据库名称
 @param tableModel 表字段Model
 @return 成功与否
 */
+ (BOOL)deleteTableTotalDataWithName:(NSString *)tableName
                        dataBaseName:(NSString *)dataBaseName
                          tableModel:(__kindof NSObject *)tableModel;

/**
 根据key/value删除某条(份)数据
 数据库表中含有该key/value的数据都会被删除
 
 @param fieldKey 字段Key
 @param fieldValue 字段Value
 @param dataBaseName 数据库名称
 @param tableName 表名
 @param tableModel 表字段Model
 @return 成功与否
 */
+ (BOOL)deleteDataWithFieldKey:(NSString *)fieldKey
                    fieldValue:(id)fieldValue
                  dataBaseName:(NSString *)dataBaseName
                     tableName:(NSString *)tableName
                    tableModel:(__kindof NSObject *)tableModel;


#pragma mark - 更新
/**
 更新表里的某条(份)数据

 @param fieldKey 字段Key
 @param fieldValue 字段Value
 @param dataBaseName 数据库名称
 @param tableName 表名
 @param tableModel 表字段Model
 @return 成功与否
 */
+ (BOOL)updateFieldWithFieldKey:(NSString *)fieldKey
                 fieldValue:(id)fieldValue
               dataBaseName:(NSString *)dataBaseName
                  tableName:(NSString *)tableName
                 tableModel:(__kindof NSObject *)tableModel;

#pragma mark - 查
/**
 根据key/value查询某条(份)数据

 @param fieldKey 字段Key
 @param fieldValue 字段Value
 @param dataBaseName 数据库名称
 @param tableName 表名
 @param tableModel 表字段Model
 @return 数据
 */
+ (NSArray *)fetchSingleDataWithFieldKey:(NSString *)fieldKey
                        fieldValue:(id)fieldValue
                      dataBaseName:(NSString *)dataBaseName
                         tableName:(NSString *)tableName
                        tableModel:(__kindof NSObject *)tableModel;

/**
 获取表里全部数据

 @param dataBaseName 数据库名称
 @param tableName 表名
 @param tableModel 表字段Model
 @return 表里所有数据数据
 */
+ (NSArray *)fetchWholeDataWithDataBaseName:(NSString *)dataBaseName
                                  tableName:(NSString *)tableName
                                 tableModel:(__kindof NSObject *)tableModel;


@end

NS_ASSUME_NONNULL_END
