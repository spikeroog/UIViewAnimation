//
//  FilterControlDateModel.m
//  Sales
//
//  Created by 元潇 on 2019/9/6.
//  Copyright © 2019年 南开承盛. All rights reserved.
//

#import "FilterControlDateModel.h"

@implementation FilterControlDateModel

- (instancetype)init {
    if (self = [super init]) {
        self.didStartSubject = [[RACSubject alloc] init];
        self.didEndSubject = [[RACSubject alloc] init];
    }
    return self;
}

@end
