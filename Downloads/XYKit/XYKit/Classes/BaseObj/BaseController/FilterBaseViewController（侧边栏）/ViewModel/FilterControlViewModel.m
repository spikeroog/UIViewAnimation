//
//  FilterControlViewModel.m
//  Sales
//
//  Created by 元潇 on 2019/9/6.
//  Copyright © 2019年 南开承盛. All rights reserved.
//

#import "FilterControlViewModel.h"
#import "FilterControlDateCell.h"
#import "FilterControlTextFieldCell.h"
#import "FilterControlTextTagCell.h"

@interface FilterControlViewModel ()
// 点击重置按钮
@property (nonatomic, readwrite, strong) RACSubject *didResetSubject;
// 点击完成按钮
@property (nonatomic, readwrite, strong) RACSubject *didCompleteSubject;
// 请求网络成功
@property (nonatomic, readwrite, strong) RACSubject *requestSuccessSubject;
// 请求网络失败
@property (nonatomic, readwrite, strong) RACSubject *requestFailSubject;
@end


@implementation FilterControlViewModel

- (instancetype)initWithRequstUrl:(NSString *)requstUrl
                         parmters:(NSArray *)parmters  {
    if (self = [super init]) {
        self.requstUrl = requstUrl;
        self.requestParams = parmters;
        self.didResetSubject = [[RACSubject alloc] init];
        self.didCompleteSubject = [[RACSubject alloc] init];
        self.requestSuccessSubject = [[RACSubject alloc] init];
        self.requestFailSubject = [[RACSubject alloc] init];
        
        [self reloadData];
    }
    return self;
}

- (__kindof UITableViewCell *)constructCellWithStyle:(FilterControlStyle)style
                                             targetV:(__kindof UITableView *)targetV
                                                 idx:(NSInteger)idx {

    if (style == FilterControlStyleDateSingle) {// 单选日期
        
    } else if (style == FilterControlStyleDateMultiple) {// 双选日期
        FilterControlDateCell *cell = [targetV dequeueReusableCellWithIdentifier:NSStringFromClass([FilterControlDateCell class])];
        @weakify(self)
        [cell.model.didStartSubject subscribeNext:^(id  _Nullable x) {
            @strongify(self)
            self.requestModel.startDate = x;
        }];
        [cell.model.didEndSubject subscribeNext:^(id  _Nullable x) {
            @strongify(self)
            self.requestModel.endDate = x;
        }];
        return cell;
    } else if (style == FilterControlStyleTextField) {// 输入框
        FilterControlTextFieldCell *cell = [targetV dequeueReusableCellWithIdentifier:NSStringFromClass([FilterControlTextFieldCell class])];
        cell.textV.placeholder = [NSString stringWithFormat:@"请输入%@",self.callBackModels[idx].title];
        @weakify(self)
        [[cell.textV rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
            @strongify(self)
            self.requestModel.name = x;
        }];
        return cell;
    } else if (style == FilterControlStyleTagSingle) {// 标签单选样式
        FilterControlTextTagCell *cell = [targetV dequeueReusableCellWithIdentifier:NSStringFromClass([FilterControlTextTagCell class])];
        NSMutableArray *nameArr = [[NSMutableArray alloc] init];
        [self.callBackModels[1].dataList enumerateObjectsUsingBlock:^(FilterCallBackDataListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [nameArr addObject:obj.name];
        }];
        [cell setTags:nameArr];
        @weakify(self)
        [cell.clickTagSubject subscribeNext:^(id  _Nullable x) {
            @strongify(self)
            self.requestModel.selectTags = x;
        }];
        return cell;
    } else if (style == FilterControlStyleTagMultiple) {// 标签多选样式
        
    } else if (style == FilterControlStyleDropDownSingle) {// 下拉框单选
        
    } else if (style == FilterControlStyleDropDownMultiple) {// 下拉框多选
        
    } else if (style == FilterControlStyleTreeSingleDefault) {// 树形单选 (默认不选父类)
        
    } else if (style == FilterControlStyleTreeSingle) {// 树形单选可选父类
        
    } else if (style == FilterControlStyleTreeMultiple) {// 树形,多选,可选父类
        
    }
    
    return [targetV dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
}

#pragma mark - 请求网络
- (void)reloadData {
    if (self.requstUrl.length == 0) return;
    
    [PPNetworkHelper POST:self.requstUrl parameters:self.requestParams success:^(id responseObject) {
        
        self.callBackModels = [FilterCallBackModel mj_objectArrayWithKeyValuesArray:responseObject[@"content"]];
        [self.requestSuccessSubject sendNext:self.callBackModels];
        
    } failure:^(NSError *error) {
        [self.requestFailSubject sendNext:error.localizedDescription];
    }];
}

- (CGFloat)obtainCellHeight:(NSInteger)section {
    switch (section) {
        case 0:
            return kAutoCs(63);

            break;
        case 1:
            return kAutoCs(34);
            
            break;
            
        default:
            return kAutoCs(1);

            break;
    }

}
- (CGFloat)obtainHeaderHeight {
    return kAutoCs(50);
}
- (CGFloat)obtainFooterHeight {
    return kAutoCs(18);
}



- (FilterRequestModel *)requestModel {
    if (!_requestModel) {
        _requestModel = [[FilterRequestModel alloc] init];
    }
    return _requestModel;
}


@end
