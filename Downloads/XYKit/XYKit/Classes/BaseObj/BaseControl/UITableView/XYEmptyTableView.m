//
//  XYEmptyTableView.m
//  BaseObjSet
//
//  Created by 元潇 on 2019/8/13.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "XYEmptyTableView.h"

@interface XYEmptyTableView ()
<DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate>

@end

@implementation XYEmptyTableView

- (instancetype)init {
    if (self = [super init]) {
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                        style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
    }
    return self;
}

#pragma mark - DZNEmptyDataSetSource DZNEmptyDataSetDelegate

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return UIImageWithStr(@"home_yanzhi_nodata");
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
    return 0;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    // click empty view
    !self.tableViewEmptyViewClickBlock ? : self.tableViewEmptyViewClickBlock();
}

// 如果不实现此方法的话,无数据时下拉刷新不可用
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

// 点击无数据视图的时候 开始刷新数据
//- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
//    [scrollView.mj_header beginRefreshing];
//}

@end
