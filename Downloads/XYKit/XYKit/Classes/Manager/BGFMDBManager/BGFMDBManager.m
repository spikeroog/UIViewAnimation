//
//  BGFMDBManager.m
//  BaseObjSet
//
//  Created by 元潇 on 2018/12/20.
//  Copyright © 2018 元潇. All rights reserved.
//

#import "BGFMDBManager.h"
#import "BGFMDB.h"

#define DataBaseVersion 1
#define kDataBaseVersionKey @"DataBaseVersionKey"

@implementation BGFMDBManager

#pragma mark - deprecated（弃用）
+ (instancetype)shareInstanced NS_UNAVAILABLE {
    static BGFMDBManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

#pragma mark - 数据库所有表的版本迭代 unrealized（未实现）
+ (void)dataBaseIterationWithDataBaseName:(NSString *)dataBaseName {
    // 暂未实现
}

#pragma mark - 数据库表版本迭代
/**
 数据库表版本迭代

 @param tableName 表名称
 @param dataBaseName 数据库名称
 @param tableModel 表字段Model
 @return 迭代结果
 */
+ (BOOL)tableIterationWithTableName:(NSString *)tableName
                       dataBaseName:(NSString *)dataBaseName
                         tableModel:(__kindof NSObject *)tableModel {
    
    bg_setSqliteName(dataBaseName);
    
    NSInteger localVersion = [BGFMDBManager getDataBaseVersion];
    if (DataBaseVersion > localVersion) {
        
        [BGFMDBManager setDataBaseVersion:DataBaseVersion];
        
        // [tableModel.class new] 添加一条无用数据，即可改变表的数据结构
        return [BGFMDBManager insertDataWithDataBaseName:dataBaseName tableName:tableName tableModel:[tableModel.class new]];
    
    } else {
        return NO;
    }
}

#pragma mark - 获取数据库版本

/**
 获取数据库版本

 @return 版本
 */
+ (NSInteger)getDataBaseVersion {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults integerForKey:kDataBaseVersionKey];
}

/**
 设置数据库版本

 @param version 版本
 */
+ (void)setDataBaseVersion:(NSInteger)version {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:version forKey:kDataBaseVersionKey];
    [defaults synchronize];
}

#pragma mark - 增
/**
 创建表 ||
 插入数据 ||
 自动化更新表结构（根据传入的model改变，即：model中有的字段会加入表中，没有的字段会从表中删除）
 
 @param dataBaseName 数据库名称
 @param tableName 表名称
 @param tableModel 表字段Model
 @return 成功与否
 */
+ (BOOL)insertDataWithDataBaseName:(NSString *)dataBaseName
                         tableName:(NSString *)tableName
                        tableModel:(__kindof NSObject *)tableModel {
    /**
     配置自定义数据库名称
     */
    bg_setSqliteName(dataBaseName);
    tableModel.bg_tableName = tableName;
    return [tableModel bg_save];
}

#pragma mark - 删
/**
 删除数据库
 
 @param dataBaseName 数据库
 @return 成功与否
 */
+ (BOOL)deleteDataBaseWithName:(NSString *)dataBaseName {
    // 删除数据库
    return bg_deleteSqlite(dataBaseName);
}

/**
 删除数据库中的某张表
 
 @param tableName 表名称
 @param dataBaseName 数据库名称
 @param tableModel 表字段Model
 @return 成功与否
 */
+ (BOOL)deleteTableWithName:(NSString *)tableName
               dataBaseName:(NSString *)dataBaseName
                 tableModel:(__kindof NSObject *)tableModel {
    /**
     配置自定义数据库名称
     */
    bg_setSqliteName(dataBaseName);
    return [tableModel.class bg_drop:tableName];
}

/**
 删除数据库中的某张表中的所有数据
 
 @param tableName 表名称
 @param dataBaseName 数据库名称
 @param tableModel 表字段Model
 @return 成功与否
 */
+ (BOOL)deleteTableTotalDataWithName:(NSString *)tableName
                        dataBaseName:(NSString *)dataBaseName
                          tableModel:(__kindof NSObject *)tableModel {
    /**
     配置自定义数据库名称
     */
    bg_setSqliteName(dataBaseName);
    return [tableModel.class bg_clear:tableName];
}

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
                    tableModel:(__kindof NSObject *)tableModel {
    /**
     配置自定义数据库名称
     */
    bg_setSqliteName(dataBaseName);
    NSString* where = [NSString stringWithFormat:@"where %@=%@", bg_sqlKey(fieldKey), bg_sqlValue(fieldValue)];
    return [tableModel.class bg_delete:tableName where:where];
}


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
                     tableModel:(__kindof NSObject *)tableModel {
    /**
     配置自定义数据库名称
     */
    bg_setSqliteName(dataBaseName);
    tableModel.bg_tableName = tableName;
    
    /* 失效的api
    NSString *where = [NSString stringWithFormat:@"where %@=%@", bg_sqlKey(fieldKey), bg_sqlValue(fieldValue)];
    return [tableModel bg_updateWhere:where];
     */
    
    NSString *where = [NSString stringWithFormat:@"update %@ set %@=%@", tableName,  bg_sqlKey(fieldKey), bg_sqlValue(fieldValue)];
    // 更新或删除等操作时,后两个参数不必传入
    return bg_executeSql(where, nil, nil);
}


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
                              tableModel:(__kindof NSObject *)tableModel {
    /**
     配置自定义数据库名称
     */
    bg_setSqliteName(dataBaseName);
    NSString *where = [NSString stringWithFormat:@"where %@=%@", bg_sqlKey(fieldKey), bg_sqlValue(fieldValue)];
    return [tableModel.class bg_find:tableName where:where];
}

/**
 获取表里全部数据
 
 @param dataBaseName 数据库名称
 @param tableName 表名
 @param tableModel 表字段Model
 @return 表里所有数据数据
 */
+ (NSArray *)fetchWholeDataWithDataBaseName:(NSString *)dataBaseName
                                  tableName:(NSString *)tableName
                                 tableModel:(__kindof NSObject *)tableModel {
    /**
     配置自定义数据库名称
     */
    bg_setSqliteName(dataBaseName);
    return [tableModel.class bg_findAll:tableName];
}

@end
