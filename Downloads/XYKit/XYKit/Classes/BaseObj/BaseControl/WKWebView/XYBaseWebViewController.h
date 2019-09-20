//
//  XYBaseWebViewController.h
//  XYKit
//
//  Created by 元潇 on 2019/9/16.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "OBJBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYBaseWebViewController : OBJBaseViewController

/**
 加载js网页
 
 @param urlString @""
 */
- (void)localHtmlWithUrl:(NSString *)urlString;

/**
 加载本地js文件
 
 @param localFile @"JStoOC.html"
 */
- (void)localHtmlWithLocalFile:(NSString *)localFile;

@end

NS_ASSUME_NONNULL_END
