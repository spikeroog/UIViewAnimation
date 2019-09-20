//
//  NSLayoutConstraint+AutoLayout.h
//  MZFBaseFramework
//
//  Created by 元潇 on 2018/12/5.
//  Copyright © 2018 元潇. All rights reserved.
//  Xib约束自适配

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSLayoutConstraint (AutoLayout)
@property (nonatomic) IBInspectable BOOL widthScreen;

@end

NS_ASSUME_NONNULL_END
