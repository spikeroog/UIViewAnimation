//
//  FilterControlDateCell.m
//  Sales
//
//  Created by 元潇 on 2019/9/6.
//  Copyright © 2019年 南开承盛. All rights reserved.
//

#import "FilterControlDateCell.h"

@implementation FilterControlDateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.model = [[FilterControlDateModel alloc] init];
        self.backgroundColor = UIColorf5f5f5;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startBtn setTitle:@"起始日期" forState:UIControlStateNormal];
    startBtn.titleLabel.font = UIFontWithAutoSize(14);
    startBtn.backgroundColor = [UIColor whiteColor];
    [startBtn setTitleColor:[UIColor textfieldPlaceholderColor] forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startAct:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:startBtn];
    
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(kAutoCs(6));
        make.width.offset(kAutoCs(110));
        make.height.offset(kAutoCs(32));
    }];
    
    UIButton *endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [endBtn setTitle:@"截止日期" forState:UIControlStateNormal];
    endBtn.titleLabel.font = UIFontWithAutoSize(14);
    endBtn.backgroundColor = [UIColor whiteColor];
    [endBtn setTitleColor:[UIColor textfieldPlaceholderColor] forState:UIControlStateNormal];
    [endBtn addTarget:self action:@selector(endAct:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:endBtn];
    
    [endBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-kAutoCs(6));
        make.width.offset(kAutoCs(110));
        make.height.offset(kAutoCs(32));
    }];
}

- (void)startAct:(UIButton *)sender {
    _WeakSelf
    [BRDatePickerView showDatePickerWithTitle:@"起始日期" dateType:BRDatePickerModeYM defaultSelValue:nil resultBlock:^(NSString *selectValue) {
        [sender setTitle:selectValue forState:UIControlStateNormal];
        [sender setTitleColor:UIColor333333 forState:UIControlStateNormal];
        [weakSelf.model.didStartSubject sendNext:selectValue];
    }];
}

- (void)endAct:(UIButton *)sender {
    _WeakSelf
    [BRDatePickerView showDatePickerWithTitle:@"截止日期" dateType:BRDatePickerModeYM defaultSelValue:nil resultBlock:^(NSString *selectValue) {
        [sender setTitle:selectValue forState:UIControlStateNormal];
        [sender setTitleColor:UIColor333333 forState:UIControlStateNormal];
        [weakSelf.model.didEndSubject sendNext:selectValue];
    }];
}

@end
