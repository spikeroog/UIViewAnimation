//
//  FilterControlViewModel.h
//  Sales
//
//  Created by 元潇 on 2019/9/6.
//  Copyright © 2019年 南开承盛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FilterRequestModel.h"
#import "FilterCallBackModel.h"



/* 表格控件样式
1:单选日期，2:双选日期，3:输入框，4:按钮单选，5:按钮多选，6:下拉框单选 , 7:下拉多选 , 8:树形单选 (默认不选父类), 9:树形单选可选父类 10:树形,多选,可选父类
 */

typedef NS_ENUM(NSInteger, FilterControlStyle) {
    FilterControlStyleDateSingle = 1, // 单选日期
    FilterControlStyleDateMultiple, // 双选日期
    FilterControlStyleTextField, // 输入框
    FilterControlStyleTagSingle, // 标签单选样式
    FilterControlStyleTagMultiple, // 标签多选样式
    FilterControlStyleDropDownSingle, // 下拉框单选
    FilterControlStyleDropDownMultiple, // 下拉框多选
    FilterControlStyleTreeSingleDefault, // 树形单选 (默认不选父类)
    FilterControlStyleTreeSingle, // 树形单选可选父类
    FilterControlStyleTreeMultiple // 树形,多选,可选父类
};

NS_ASSUME_NONNULL_BEGIN

@interface FilterControlViewModel : NSObject

- (instancetype)initWithRequstUrl:(NSString *)requstUrl
                         parmters:(NSArray *)parmters;

// 获取的网络数据model
@property (nonatomic, strong) NSArray <FilterCallBackModel *>*callBackModels;
// view最终返回数据model
@property (nonatomic, strong) FilterRequestModel *requestModel;

// 是否需要请求网络数据
@property (nonatomic, copy) NSString *requstUrl;
// 请求网络数据的参数数组
@property (nonatomic, strong) NSArray *requestParams;

// 请求网络成功
@property (nonatomic, readonly, strong) RACSubject *requestSuccessSubject;
// 请求网络失败
@property (nonatomic, readonly, strong) RACSubject *requestFailSubject;
// 点击重置按钮
@property (nonatomic, readonly, strong) RACSubject *didResetSubject;
// 点击完成按钮
@property (nonatomic, readonly, strong) RACSubject *didCompleteSubject;

- (__kindof UITableViewCell *)constructCellWithStyle:(FilterControlStyle)style
                                             targetV:(__kindof UITableView *)targetV
                                                 idx:(NSInteger)idx;
- (CGFloat)obtainHeaderHeight;
- (CGFloat)obtainFooterHeight;
- (CGFloat)obtainCellHeight:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
