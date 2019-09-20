//
//  OBJHomeViewController.h
//  BaseObjSet
//
//  Created by 元潇 on 2018/11/28.
//  Copyright © 2018 元潇. All rights reserved.
//  V/VC只关心数据的绑定（RAC或者KVO），以达到Model的变化直接就影响View的效果（其实是ViewModel中对Model进行了改变，V/VC和ViewModel中的数据绑定后起到改变V的效果），Model只能和ViewModel耦合，View和ViewController中不应该出现Model

#import "OBJBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OBJHomeViewController : OBJConvertWindowViewController

@end

NS_ASSUME_NONNULL_END
