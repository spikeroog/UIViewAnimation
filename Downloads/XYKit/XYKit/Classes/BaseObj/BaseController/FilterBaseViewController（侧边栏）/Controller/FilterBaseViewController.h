//
//  FilterBaseViewController.h
//  Sales
//
//  Created by 元潇 on 2019/9/5.
//  Copyright © 2019年 南开承盛. All rights reserved.
//

#import "OBJBaseViewController.h"
#import "FilterControlViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FilterBaseViewController : OBJBaseViewController

- (instancetype)initWithViewModel:(FilterControlViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
