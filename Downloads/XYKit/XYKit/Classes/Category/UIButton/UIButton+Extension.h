//
//  UIButton+Extension.h
//  BaseObjSet
//
//  Created by 元潇 on 2018/12/3.
//  Copyright © 2018 元潇. All rights reserved.
//  按钮动态添加方法，按钮动态添加方法并实现N秒执行一次点击方法（防止按钮重复点击）

#import <UIKit/UIKit.h>

/** 普通按钮 **/
typedef void(^OBJ_ButtonEventsBlock) (void);
/** 点赞按钮 **/
typedef void(^OBJ_Delay_ButtonCourseEventsBlock) (void); // 连续点击过程中调用的方法
typedef void(^OBJ_Delay_ButtonFinalEventsBlock) (void); // 连续点击后N秒执行的最终方法
/** N秒内只能响应一次点击的按钮 **/
typedef void(^OBJ_Delay_ButtonNormalEventsBlock) (void);

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Extension)

#pragma mark - 普通Button点击方法封装
- (void)obj_addTapEventHandle:(OBJ_ButtonEventsBlock)obj_buttonEventsBlock;

#pragma mark - N秒内只能响应一次点击的Button点击方法封装
- (void)obj_addDelayButtonEventHandle:(OBJ_Delay_ButtonNormalEventsBlock)obj_delay_buttonNormalEventsBlock;

#pragma mark - 点赞按钮实现封装（一般用来处理点赞按钮一类的需求，防止连续请求导致的服务器高并发）
/**
 点赞按钮实现封装（一般用来处理点赞按钮一类的需求，防止连续请求导致的服务器高并发）

 @param courseEventsBlock N秒内连续点击时 回调的方法（用以本地改变状态）
 @param finalEventsBlock N秒结束后按钮没有再次点击 回调的方法（请求服务端）
 */
- (void)obj_addLikeBtnCourseTapEventHandle:(OBJ_Delay_ButtonCourseEventsBlock)courseEventsBlock
                          finalEventsBlock:(OBJ_Delay_ButtonFinalEventsBlock)finalEventsBlock;
@end

NS_ASSUME_NONNULL_END
