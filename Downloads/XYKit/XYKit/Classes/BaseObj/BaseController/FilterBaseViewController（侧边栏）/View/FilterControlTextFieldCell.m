//
//  FilterControlTextFieldCell.m
//  Sales
//
//  Created by 元潇 on 2019/9/6.
//  Copyright © 2019年 南开承盛. All rights reserved.
//

#import "FilterControlTextFieldCell.h"

@implementation FilterControlTextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    _textV = [[UITextView alloc] init];
    _textV.placeholder = @"请输入";
    _textV.placeholderColor = [UIColor textfieldPlaceholderColor];
    _textV.backgroundColor = UIColorf5f5f5;
    _textV.textColor = UIColor333333;
    _textV.font = UIFontWithAutoSize(14);
    [self addSubview:_textV];
    [_textV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self);
        make.width.equalTo(self);
        make.height.offset(kAutoCs(36));
    }];
    
}


@end
