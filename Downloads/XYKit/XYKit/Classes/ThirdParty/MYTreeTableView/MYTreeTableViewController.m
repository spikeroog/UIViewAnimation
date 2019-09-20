//
//  MYTreeTableViewController.m
//  BaseObjSet
//
//  Created by 元潇 on 2019/9/12.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "MYTreeTableViewController.h"
#import "MYTreeTableManager.h"
#import "MYTreeTableViewCell.h"
#import "MYTreeTableViewSearchBar.h"

@interface MYTreeTableViewController ()
<UITextFieldDelegate,
UITableViewDataSource,
UITableViewDelegate,
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate>

@property (nonatomic, strong) XYTextfield *textfield;
@property (nonatomic, strong) UITableView *infoTabView;
@property (nonatomic, strong) UIImageView *navView;
@property (nonatomic, strong) NSSet<MYTreeItem *> *items;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) MJRefreshManager *mjM;

@property (nonatomic, strong) UIRefreshControl *myRefreshControl;

@end

@implementation MYTreeTableViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initialization];
        [self setUpUI];

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initialization];
        [self setUpUI];
        
    }
    return self;
}

- (void)setUpUI {
    
    [self configNavView:@"asdasd" subtitle:@"aslkdsjalkdjsalkdjsalkdjaslkdjaskldjsalkdjaslkd"];
    
    self.textfield = [[XYTextfield alloc] init];
    self.textfield.delegate = self;
    self.textfield.placeholder = @"请输入关键字";
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    imageView.image = [UIImage imageNamed:@"search"];
    imageView.contentMode = UIViewContentModeLeft;
    self.textfield.rightView = imageView;
    self.textfield.rightViewMode = UITextFieldViewModeAlways;
    self.textfield.font = UIFontWithAutoSize(14);
//    self.textfield.borderStyle = UITextBorderStyleLine;
    self.textfield.layer.borderColor = UIColorWithRGB16Radix(0xE0E0E0).CGColor;
    self.textfield.layer.borderWidth = 1;
    self.textfield.layer.cornerRadius = 2;
    self.textfield.layer.masksToBounds = YES;
    [self addSubview:self.textfield];
    [self.textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).offset(10);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.offset(44);
    }];
    
    [self addSubview:self.infoTabView];
    [self.infoTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(60+25+44+20);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self.sureBtn.mas_top);
    }];
    
//    self.mjM = [[MJRefreshManager alloc] init];
//    self.mjM.pageNumber = 1;
//    WEAKSELF
//    [self.mjM initialMJHeaderWithTargetView:self.infoTabView pullDownCallBack:^{
//        weakSelf.mjM.pageNumber ++;
//        [weakSelf.infoTabView reloadData];
//    }];
//    [self.mjM initialMJFooterWithTargetView:self.infoTabView pullUpCallBack:^{
//        weakSelf.mjM.pageNumber = 1;
//        [weakSelf.infoTabView reloadData];
//    }];
//    self.myRefreshControl = [[UIRefreshControl alloc] init];
//    self.myRefreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
//    [self.myRefreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
//    [self.infoTabView addSubview:self.myRefreshControl];
    
    self.infoTabView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - 构建ui
- (void)configNavView:(nullable NSString *)title
             subtitle:(nullable NSString *)subtitle {
    self.navView = [[UIImageView alloc] init];
    self.navView.image = UIImageWithStr(@"ic_public_rulesBtn");
//    self.navView.contentMode = UIViewContentModeScaleAspectFill;
//    self.navView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.navView.userInteractionEnabled = YES;
    
    [self addSubview:self.navView];
    
    NSInteger navHeight;
    if (subtitle.length == 0 || subtitle == nil) {
        navHeight = 30+25;
    } else {
        navHeight = 60+25;
    }
    
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.height.offset(navHeight);
    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = title;
    titleLab.font = UIFontWithAutoSize(18);
    titleLab.textColor = [UIColor whiteColor];
    [self.navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView).offset(10);
        make.centerX.equalTo(self.navView);
        make.height.offset(30);
    }];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton addTarget:self action:@selector(closeBtnAct) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setImage:UIImageWithStr(@"closeup") forState:UIControlStateNormal];
    [self.navView addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(22);
        make.height.offset(22);
        make.right.equalTo(self.navView.mas_right).offset(-10);
        make.top.equalTo(self.navView).offset(10);
    }];
    
    if (subtitle.length > 0) {
        UILabel *detailLab = [[UILabel alloc] init];
        detailLab.text = subtitle;
        detailLab.font = UIFontWithAutoSize(14);
        detailLab.textColor = [UIColor whiteColor];
        detailLab.textAlignment = NSTextAlignmentCenter;
        detailLab.numberOfLines = 0;
        [self.navView addSubview:detailLab];
        [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.navView).offset(-10);
            make.left.equalTo(self.navView).offset(30);
            make.right.equalTo(self.navView).offset(-30);
        }];
    }
    
    // 底部确认按钮
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sureBtn addTarget:self action:@selector(sureBtnAct) forControlEvents:UIControlEventTouchUpInside];
    self.sureBtn.titleLabel.font = UIFontWithAutoSize(13);
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sureBtn setBackgroundColor:[UIColor blueColor]];
    self.sureBtn.layer.cornerRadius = 6;
    self.sureBtn.layer.masksToBounds = YES;
    
    [self addSubview:self.sureBtn];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(40);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.bottom.equalTo(self);
    }];
}

- (void)sureBtnAct { // 收起弹窗
    [[XYPopupView shareInstance] disMissView];
}

- (void)closeBtnAct { // 收起弹窗
    [[XYPopupView shareInstance] disMissView];
}

- (UITableView *)infoTabView {
    if (!_infoTabView) {
        _infoTabView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _infoTabView.backgroundColor = [UIColor whiteColor];
        _infoTabView.delegate = self;
        _infoTabView.dataSource = self;
        _infoTabView.emptyDataSetSource = self;;
        _infoTabView.emptyDataSetDelegate = self;
        _infoTabView.separatorStyle = UITableViewCellSeparatorStyleNone; // 去掉分割线
        _infoTabView.showsVerticalScrollIndicator = NO;
        _infoTabView.showsHorizontalScrollIndicator = NO;
        _infoTabView.estimatedRowHeight = 0;
        _infoTabView.estimatedSectionHeaderHeight = 0;
        _infoTabView.estimatedSectionFooterHeight = 0;
        
        [_infoTabView registerClass:[MYTreeTableViewCell class] forCellReuseIdentifier:@"MYTreeTableViewCell"];
    }
    return _infoTabView;
}


- (void)refreshData {
    
    if ([self.classDelegate respondsToSelector:@selector(refreshTableViewController:)]) {
        [self.classDelegate refreshTableViewController:self];
    }
    
    [self.infoTabView reloadData];
    [self.myRefreshControl endRefreshing];
}


#pragma mark - Set

- (void)setManager:(MYTreeTableManager *)manager {
    _manager = manager;
    
    // 遍历外部传来的所选择的 itemId
    for (NSString *itemId in self.checkItemIds) {
        MYTreeItem *item = [self.manager getItemById:itemId];
        if (item) {
            
            // 1. 勾选所选择的节点
            [self.manager checkItem:item isCheck:YES isChildItemCheck:!self.isSingleCheck];
            
            // 2. 展开所选择的节点
            if (self.isExpandCheckedNode) {
                
                NSMutableArray *expandParentItems = [NSMutableArray array];
                
                MYTreeItem *parentItem = item.parentItem;
                while (parentItem) {
                    [expandParentItems addObject:parentItem];
                    parentItem = parentItem.parentItem;
                }
                
                for (NSUInteger i = (expandParentItems.count - 1); i < expandParentItems.count; i--) {
                    [self.manager expandItem:expandParentItems[i] isExpand:YES];
                }
            }
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.infoTabView reloadData];
    });
}


#pragma mark - UITableViewDelegate and UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.manager.showItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MYTreeItem *item = self.manager.showItems[indexPath.row];
    
    MYTreeTableViewCell *cell = [MYTreeTableViewCell cellWithTableView:tableView andTreeItem:item];
    cell.isShowArrow      = self.isShowArrow;
    cell.isShowCheck      = self.isShowCheck;
    cell.isShowLevelColor = self.isShowLevelColor;
    
    if ((item.level < self.levelColorArray.count) && self.isShowLevelColor) {// 若干父级
        cell.backgroundColor = self.levelColorArray[item.level];
        if (self.fatherCantClick) {
            // 如果为父级，不显示勾选框，且点击只能展开、不会回调参数
            cell.isShowCheck = NO;
        }
    } else { // 最下层的子级
        cell.backgroundColor = self.normalBackgroundColor;
    }
    
    __weak typeof(self)wself = self;
    cell.checkButtonClickBlock = ^(MYTreeItem *item) {
        if (wself.isSingleCheck) {
            if (item.checkState != MYTreeItemChecked) {
                [wself.manager checkAllItem:NO];
            }
        }
        // 单选
        if (wself.isSingleCheck) {
            // 如果再次点击已经选中的 item 则取消选择
            if (wself.isCancelSingleCheck && (item.checkState == MYTreeItemChecked)) {
                
                [wself.manager checkItem:item isCheck:NO isChildItemCheck:NO];
                
                if ([wself.classDelegate respondsToSelector:@selector(tableViewController:checkItems:)]) {
                    [wself.classDelegate tableViewController:wself checkItems:@[]];
                }
            } else {
                
                [wself.manager checkItem:item isCheck:YES isChildItemCheck:NO];
                
                if ([wself.classDelegate respondsToSelector:@selector(tableViewController:checkItems:)]) {
                    [wself.classDelegate tableViewController:wself checkItems:@[item]];
                }
            }
        }
        // 多选
        else {
            [wself.manager checkItem:item isChildItemCheck:YES];
        }
        
        if ([wself.classDelegate respondsToSelector:@selector(tableViewController:didSelectCheckBoxRowAtIndexPath:)]) {
            [wself.classDelegate tableViewController:wself didSelectCheckBoxRowAtIndexPath:indexPath];
        }
        
        [wself.infoTabView reloadData];
    };
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.isShowSearchBar ? self.textfield : [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.isShowSearchBar ? self.textfield.bounds.size.height : 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MYTreeItem *item = self.manager.showItems[indexPath.row];
    
    [self tableView:tableView didSelectItems:@[item] isExpand:!item.isExpand];
    
    if ([self.classDelegate respondsToSelector:@selector(tableViewController:didSelectRowAtIndexPath:)]) {
        [self.classDelegate tableViewController:self didSelectRowAtIndexPath:indexPath];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [(MYTreeTableViewSearchBar *)self.infoTabView.tableHeaderView resignFirstResponder];
}


#pragma mark - MYSearchTextFieldDelegate

// 点击搜索框 - 用于埋点
- (void)treeTableViewSearchBarDidBeginEditing:(MYTreeTableViewSearchBar *)searchBar {
    if ([self.classDelegate respondsToSelector:@selector(searchBarDidBeginEditingInTableViewController:)]) {
        [self.classDelegate searchBarDidBeginEditingInTableViewController:self];
    }
}

// 实时查询搜索框中的文字
- (void)treeTableViewSearchBarDidEditing:(MYTreeTableViewSearchBar *)searchBar {
    [self.manager filterField:searchBar.text isChildItemCheck:!self.isSingleCheck];
    [self.infoTabView reloadData];
}

// 点击搜索键
- (void)treeTableViewSearchBarShouldReturn:(MYTreeTableViewSearchBar *)searchBar {
    [self.manager filterField:searchBar.text isChildItemCheck:!self.isSingleCheck];
    [self.infoTabView reloadData];
    [searchBar resignFirstResponder];
}


#pragma mark - Private Method

- (NSArray <NSIndexPath *>*)getUpdateIndexPathsWithCurrentIndexPath:(NSIndexPath *)indexPath andUpdateNum:(NSInteger)updateNum {
    
    NSMutableArray *tmpIndexPaths = [NSMutableArray arrayWithCapacity:updateNum];
    for (int i = 0; i < updateNum; i++) {
        NSIndexPath *tmp = [NSIndexPath indexPathForRow:(indexPath.row + 1 + i) inSection:indexPath.section];
        [tmpIndexPaths addObject:tmp];
    }
    return tmpIndexPaths;
}

- (UIColor *)getColorWithRed:(NSInteger)redNum green:(NSInteger)greenNum blue:(NSInteger)blueNum {
    return [UIColor colorWithRed:redNum/255.0 green:greenNum/255.0 blue:blueNum/255.0 alpha:1.0];
}

- (void)tableView:(UITableView *)tableView didSelectItems:(NSArray <MYTreeItem *>*)items isExpand:(BOOL)isExpand {
    
    NSMutableArray *updateIndexPaths = [NSMutableArray array];
    NSMutableArray *editIndexPaths   = [NSMutableArray array];
    
    for (MYTreeItem *item in items) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.manager.showItems indexOfObject:item] inSection:0];
        [updateIndexPaths addObject:indexPath];
        
        NSInteger updateNum = [self.manager expandItem:item];
        NSArray *tmp = [self getUpdateIndexPathsWithCurrentIndexPath:indexPath andUpdateNum:updateNum];
        [editIndexPaths addObjectsFromArray:tmp];
    }
    
    if (self.isShowExpandedAnimation) {
        if (isExpand) {
            [tableView insertRowsAtIndexPaths:editIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        } else {
            [tableView deleteRowsAtIndexPaths:editIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    } else {
        [tableView reloadData];
    }
    
    for (NSIndexPath *indexPath in updateIndexPaths) {
        MYTreeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell updateItem];
    }
}

- (void)initialization {
    
    self.isShowExpandedAnimation  = YES;
    self.isShowArrowIfNoChildNode = NO;
    self.isShowArrow              = YES;
    self.isShowCheck              = YES;
    self.isSingleCheck            = NO;
    self.isCancelSingleCheck      = NO;
    self.isExpandCheckedNode      = YES;
    self.isShowLevelColor         = YES;
    self.isShowSearchBar          = YES;
    self.isSearchRealTime         = YES;
    self.fatherCantClick          = NO;
    
    self.normalBackgroundColor = [UIColor whiteColor];
    self.levelColorArray = @[[self getColorWithRed:230 green:230 blue:230],
                             [self getColorWithRed:238 green:238 blue:238]];
}


#pragma mark - Public Method

// 全部勾选/全部取消勾选
- (void)checkAllItem:(BOOL)isCheck {
    [self.manager checkAllItem:isCheck];
    [self.infoTabView reloadData];
}

// 全部展开/全部折叠
- (void)expandAllItem:(BOOL)isExpand {
    [self expandItemWithLevel:(isExpand ? NSIntegerMax : 0)];
}

// 展开/折叠到多少层级
- (void)expandItemWithLevel:(NSInteger)expandLevel {
    
    __weak typeof(self)wself = self;
    
    [self.manager expandItemWithLevel:expandLevel completed:^(NSArray *noExpandArray) {
        
        [wself tableView:wself.infoTabView didSelectItems:noExpandArray isExpand:NO];
        
    } andCompleted:^(NSArray *expandArray) {
        
        [wself tableView:wself.infoTabView didSelectItems:expandArray isExpand:YES];
        
    }];
}

- (void)prepareCommit {
    if ([self.classDelegate respondsToSelector:@selector(tableViewController:checkItems:)]) {
        [self.classDelegate tableViewController:self checkItems:self.manager.allCheckItem];
    }
}

- (NSArray *)getShowItems {
    return self.manager.showItems;
}

- (NSArray *)getAllItems {
    return self.manager.allItems;
}

- (NSArray *)getCheckItems {
    return self.manager.allCheckItem;
}

#pragma mark - emptyDataSet
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return UIImageWithStr(@"ic_message_emptyData");
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSDictionary *attributes = @{
                                 NSFontAttributeName:UIFontWithAutoSize(17),
                                 NSForegroundColorAttributeName:UIColorWithRGB16Radix(0x000000)
                                 };
    return [[NSAttributedString alloc] initWithString:@"" attributes:attributes];
}

// Y轴于屏幕中心的值，加上这个值self.emetyDataVerticalOffset后为最终的显示效果
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -10;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    // click empty view
}

// 如果不实现此方法的话,无数据时下拉刷新不可用
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

@end
