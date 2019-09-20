//
//  FilterBaseViewController.m
//  Sales
//
//  Created by 元潇 on 2019/9/5.
//  Copyright © 2019年 南开承盛. All rights reserved.
//

#import "FilterBaseViewController.h"
#import "FilterControlDateCell.h"
#import "FilterControlTextFieldCell.h"
#import "FilterControlTextTagCell.h"

#define kFilterWidth kAutoCs(281.5)

@interface FilterBaseViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UIView *navView;
@property (nonatomic, strong) XYEmptyTableView *infoTabView;
@property (nonatomic, strong) UIButton *resetBtn;
@property (nonatomic, strong) UIButton *completeBtn;

@property (nonatomic, strong) FilterControlViewModel *viewModel;
@end

@implementation FilterBaseViewController

- (instancetype)initWithViewModel:(FilterControlViewModel *)viewModel {
    if (self == [super init]) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"筛选";
    self.view.backgroundColor = [UIColor whiteColor];
    [self configNavView];
    [self configTableView];
    [self configBottomView];
    
    [self racObserver];
}

- (void)racObserver {
    @weakify(self)
    // 重置按钮
    [self.viewModel.didResetSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        // 清空需要返回的数据源
        self.viewModel.requestModel = [FilterRequestModel new];
        [self.viewModel.callBackModels enumerateObjectsUsingBlock:^(FilterCallBackModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 清空cell的缓存状态
            [[self.viewModel constructCellWithStyle:[obj.type integerValue] targetV:self.infoTabView idx:idx] removeFromSuperview];
            [self.infoTabView reloadSection:idx withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
    }];
    // 请求网络成功
    [self.viewModel.requestSuccessSubject subscribeNext:^(id  _Nullable x) {
        [self.infoTabView reloadData];
    }];
    // 请求网络失败
    [self.viewModel.requestFailSubject subscribeNext:^(id  _Nullable x) {
        [MBProgressHUD showTextHUD:x];
    }];
}

- (void)resetBtnAct {
    [self.viewModel.didResetSubject sendNext:nil];

}

- (void)completeBtnAct {
    [self.viewModel.didCompleteSubject sendNext:self.viewModel.requestModel];
}

#pragma mark - NSObject
- (UITableView *)infoTabView {
    if (!_infoTabView) {
        _infoTabView = [[XYEmptyTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _infoTabView.delegate = self;
        _infoTabView.dataSource = self;
        _infoTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _infoTabView.showsVerticalScrollIndicator = NO;
        _infoTabView.showsHorizontalScrollIndicator = NO;
        //cell使用Self-Sizing
        _infoTabView.rowHeight = UITableViewAutomaticDimension;
        _infoTabView.estimatedRowHeight = kAutoCs(36);
        //cell不使用Self-Sizing
//        _infoTabView.estimatedRowHeight = 0;
        //头部尾部不使用Self-Sizing
        _infoTabView.estimatedSectionHeaderHeight = 0;
        _infoTabView.estimatedSectionFooterHeight = 0;
        
        _infoTabView.backgroundColor = [UIColor whiteColor];
        // header
        [_infoTabView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
        [_infoTabView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"footer"];

        // default
        [_infoTabView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        // custom
        [_infoTabView registerClass:[FilterControlDateCell class] forCellReuseIdentifier:NSStringFromClass([FilterControlDateCell class])];
        [_infoTabView registerClass:[FilterControlTextFieldCell class] forCellReuseIdentifier:NSStringFromClass([FilterControlTextFieldCell class])];
        [_infoTabView registerClass:[FilterControlTextTagCell class] forCellReuseIdentifier:NSStringFromClass([FilterControlTextTagCell class])];
  
    }
    return _infoTabView;
}

- (FilterControlViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FilterControlViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark - tabView

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerV = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    [headerV removeAllSubviews];
    headerV.backgroundColor = UIColorWithNull;
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = UIColorWithNull;
    label.text = self.viewModel.callBackModels[section].title;
    label.font = UIFontWithAutoSize(15);
    label.textColor = UIColor666666;
    [headerV addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerV);
        make.left.equalTo(headerV);
    }];
    return headerV;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UITableViewHeaderFooterView *footerV = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
    [footerV removeAllSubviews];
    footerV.backgroundColor = UIColorWithNull;
    // 添加下分割线
    UIView *tv = [[UIView alloc] init];
    tv.backgroundColor = UIColorWithRGB16Radix(0xeeeeee);
    [footerV addSubview:tv];
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(footerV);
        make.width.equalTo(footerV);
        make.height.offset(0.5f);
        make.centerX.equalTo(footerV);
    }];
    return footerV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.viewModel obtainHeaderHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self.viewModel obtainFooterHeight];
}

#pragma mark - 自动布局UITableViewAutomaticDimension兼容iOS11以下，修复ios11以下的闪退问题
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAutoCs(36);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [self.viewModel obtainCellHeight:indexPath.section];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.callBackModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel constructCellWithStyle:[self.viewModel.callBackModels[indexPath.section].type integerValue] targetV:tableView idx:indexPath.section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - 构建ui
- (void)configNavView {
    self.navView = [[UIView alloc] init];
    self.navView.backgroundColor = UIColorTheme;
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.offset(kNavBarHeight);
    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"筛选";
    titleLab.font = UIFontWithAutoSize(14);
    titleLab.textColor = [UIColor whiteColor];
    [self.navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.navView);
        make.left.equalTo(self.navView).offset(kAutoCs(15));
        make.height.offset(44);
    }];
}

- (void)configTableView {
    [self.view addSubview:self.infoTabView];
    [self.infoTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kNavBarHeight);
        make.left.equalTo(self.view).offset(kAutoCs(15));
        make.width.offset(kFilterWidth-kAutoCs(30));
        make.bottom.equalTo(self.view).offset(-kBottomBarHeight-kAutoCs(45));
    }];
}

- (void)configBottomView {
    self.resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [self.resetBtn setBackgroundColor:UIColorWithRGB16Radix(0xebebeb)];
    [self.resetBtn setTitleColor:UIColorWithRGB16Radix(0x999999) forState:UIControlStateNormal];
    self.resetBtn.titleLabel.font = UIFontWithAutoSize(17);
    [self.resetBtn addTarget:self action:@selector(resetBtnAct) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.resetBtn];
    [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-kBottomBarHeight);
        make.left.equalTo(self.view);
        make.width.offset(kFilterWidth/2);
        make.height.offset(kAutoCs(45));
    }];
    
    self.completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.completeBtn setBackgroundColor:UIColorTheme];
    [self.completeBtn setTitleColor:UIColorWithRGB16Radix(0xffffff) forState:UIControlStateNormal];
    self.completeBtn.titleLabel.font = UIFontWithAutoSize(17);
    [self.completeBtn addTarget:self action:@selector(completeBtnAct) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.completeBtn];
    [self.completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-kBottomBarHeight);
        make.right.equalTo(self.infoTabView.mas_right).offset(kAutoCs(15));
        make.width.offset(kFilterWidth/2);
        make.height.offset(kAutoCs(45));
    }];
}



@end
