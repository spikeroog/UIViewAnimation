//
//  FilterCallBackModel.h
//  Sales
//
//  Created by 元潇 on 2019/9/9.
//  Copyright © 2019年 南开承盛. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FilterCallBackDataListModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger ids;
@property (nonatomic, assign) BOOL checked;
@end


@interface FilterCallBackModel : NSObject
@property (nonatomic, copy) NSString *ids;
/* 表格控件样式
 1:单选日期，2:双选日期，3:输入框，4:按钮单选，5:按钮多选，6:下拉框单选 , 7:下拉多选 , 8:树形单选 (默认不选父类), 9:树形单选可选父类 10:树形,多选,可选父类
 */
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, copy) NSString *attachId;
@property (nonatomic, copy) NSString *attachName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *href;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSArray <FilterCallBackDataListModel *>*dataList; // 标签
@property (nonatomic, strong) NSArray *allData;
@property (nonatomic, copy) NSString *chooseId;
@property (nonatomic, copy) NSString *chooseName;
@property (nonatomic, copy) NSString *singleCheckedId;
@end

NS_ASSUME_NONNULL_END
