//
//  XYBaseGuideViewController.h
//  XYKit
//
//  Created by 元潇 on 2019/9/2.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^GuideFinishBlock) ();

typedef NS_ENUM(NSInteger, GuidePageType) {
    GuidePageTypePicture = 0,
    GuidePageTypeGif,
    GuidePageTypeVideo
};

@interface XYBaseGuideViewController : UIViewController

@property (nonatomic, copy) GuideFinishBlock guideBlock;

/**
 图片引导页
 
 @param imageNameArray 图片数组，gif传@[@"xx.gif", @"xxx.gif"]
 */
- (void)buildWithImageArray:(NSArray *)imageNameArray;

/**
 视频引导页
 
 @param videoName 视频名称
 @param videoSuffix 视频后缀
 */
- (void)buildWithVideoName:(NSString *)videoName videoSuffix:(NSString *)videoSuffix;

@end

NS_ASSUME_NONNULL_END
