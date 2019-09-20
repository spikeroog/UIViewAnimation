//
//  FilterControlTextTagCell.m
//  Sales
//
//  Created by 元潇 on 2019/9/9.
//  Copyright © 2019年 南开承盛. All rights reserved.
//

#import "FilterControlTextTagCell.h"

#define kTagWidth kAutoCs(281.5)-kAutoCs(30)

@interface FilterControlTextTagCell ()
<TTGTextTagCollectionViewDelegate>

/**实现单选，上一次选中的 tag index*/
@property (assign, nonatomic) NSInteger lastSelectedIndex;

@end

@implementation FilterControlTextTagCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.clickTagSubject = [[RACSubject alloc] init];
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    _tagView = [[TTGTextTagCollectionView alloc] init];
    // Alignment
    _tagView.alignment = TTGTagCollectionAlignmentFillByExpandingWidth;
    
    // Use manual calculate height
    _tagView.manualCalculateHeight = YES;
    _tagView.delegate = self;
    // 单选1，多选0
//    _tagView.selectionLimit = 1;
    // 不允许点击tabView
//    _tagView.enableTagSelection = NO;
    TTGTextTagConfig *config = _tagView.defaultConfig;
    config.selectedBackgroundColor = UIColorTheme;
    config.backgroundColor = UIColorf5f5f5;
    config.textColor = UIColor333333;
    config.selectedTextColor = UIColor333333;
    config.textFont = UIFontWithAutoSize(14);
    config.borderWidth = 0;
    config.selectedBorderWidth = 0;
    config.cornerRadius = 7;
    
    [self addSubview:_tagView];
    
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
        make.centerY.equalTo(self);
        make.bottom.equalTo(self);
    }];
}

- (void)setTags:(NSArray<NSString *> *)tags {
    [_tagView removeAllTags];
    [_tagView addTags:tags];
    
    // Use manual height, update preferredMaxLayoutWidth
    _tagView.preferredMaxLayoutWidth = kTagWidth;
    // 默认选中
//    [_tagView setTagAtIndex:0 selected:YES];
}

/**实现单选*/
- (void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView
                    didTapTag:(NSString *)tagText
                      atIndex:(NSUInteger)index
                     selected:(BOOL)selected
                    tagConfig:(TTGTextTagConfig *)config {
    
    /**实现单选*/
    // 上一次选中 有值，并且跟本次选中的 index 不同
    if (self.lastSelectedIndex != -1 && self.lastSelectedIndex != index) {
        // 取消上一次选中
        [textTagCollectionView setTagAtIndex:self.lastSelectedIndex selected:NO];
    }
    self.lastSelectedIndex = index;
    
    // 获取选中的tag名字
    [self.clickTagSubject sendNext:self.tagView.allSelectedTags];
}


@end
