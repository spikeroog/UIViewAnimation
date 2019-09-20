//
//  XYKitMediator.h
//  XYKit
//
//  Created by 元潇 on 2019/8/22.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYKitMediator : NSObject

+ (instancetype)shareInstanced;

#pragma mark - 跳转扫一扫界面，获取扫一扫url
+ (void)fetchScanCodeHaventCamera:(void(^)())haventCamera
                  haventPicture:(void(^)())haventPicture
                       urlBlock:(void(^)(NSString *result))urlBlock;
@end

NS_ASSUME_NONNULL_END
