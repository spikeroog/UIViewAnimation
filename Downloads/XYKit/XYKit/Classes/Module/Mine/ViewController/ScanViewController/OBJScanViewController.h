//
//  OBJScanViewController.h
//  BaseObjSet
//
//  Created by 元潇 on 2018/12/11.
//  Copyright © 2018 元潇. All rights reserved.
//

#import "OBJBaseViewController.h"

typedef void(^ScanUrlBlockHandle)(NSString *scan_url);

NS_ASSUME_NONNULL_BEGIN

@interface OBJScanViewController : OBJBaseViewController
@property (nonatomic, copy) ScanUrlBlockHandle scanUrlBlockHandle;

@end

NS_ASSUME_NONNULL_END
