//
//  UIButton+Extension.m
//  BaseObjSet
//
//  Created by 元潇 on 2018/12/3.
//  Copyright © 2018 元潇. All rights reserved.
//  走位走位看不见，难受难受手里干。

#import "UIButton+Extension.h"
#import <objc/runtime.h>

#define kLikenBtnTimer 1 // 点赞按钮最后回调间隔

#define kDelayBtnTimer 2 // 延时按钮间隔

static OBJ_ButtonEventsBlock _obj_buttonEventsBlock;
static OBJ_Delay_ButtonFinalEventsBlock _obj_delay_buttonfinalEventsBlock;
static OBJ_Delay_ButtonCourseEventsBlock _obj_delay_buttonCourseEventsBlock;
static OBJ_Delay_ButtonNormalEventsBlock _obj_delay_buttonNormalEventsBlock;

@interface UIButton ()
@end

@implementation UIButton (Extension)

#pragma mark - 普通Button点击方法封装
- (void)obj_addTapEventHandle:(OBJ_ButtonEventsBlock)obj_buttonEventsBlock {
    if (obj_buttonEventsBlock) _obj_buttonEventsBlock = obj_buttonEventsBlock;
    SEL sel = @selector(obj_tapEvent:);
    [self addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
}

- (void)obj_tapEvent:(__kindof UIButton *)sender {
    !_obj_buttonEventsBlock ? : _obj_buttonEventsBlock();
}

#pragma mark - N秒内只能响应一次点击的Button点击方法封装
- (void)obj_addDelayButtonEventHandle:(OBJ_Delay_ButtonNormalEventsBlock)obj_delay_buttonNormalEventsBlock {
    if (obj_delay_buttonNormalEventsBlock) _obj_delay_buttonNormalEventsBlock = obj_delay_buttonNormalEventsBlock;
    SEL sel = @selector(obj_delayBtnHandle:);
    [self addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
}

- (void)obj_delayBtnHandle:(__kindof UIButton *)sender {
    self.enabled = NO;
    !_obj_delay_buttonNormalEventsBlock ? : _obj_delay_buttonNormalEventsBlock();
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDelayBtnTimer * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.enabled = YES;
    });
}

#pragma mark - 点赞按钮实现封装（一般用来处理点赞按钮一类的需求，防止连续请求导致的服务器高并发）
/**
 点赞按钮实现封装（一般用来处理点赞按钮一类的需求，防止连续请求导致的服务器高并发）
 
 @param courseEventsBlock N秒内连续点击时 回调的方法（用以本地改变状态）
 @param finalEventsBlock N秒结束后按钮没有再次点击 回调的方法（请求服务端）
 */
- (void)obj_addLikeBtnCourseTapEventHandle:(OBJ_Delay_ButtonCourseEventsBlock)courseEventsBlock
                          finalEventsBlock:(OBJ_Delay_ButtonFinalEventsBlock)finalEventsBlock {
    if (courseEventsBlock) _obj_delay_buttonCourseEventsBlock = courseEventsBlock;
    if (finalEventsBlock) _obj_delay_buttonfinalEventsBlock = finalEventsBlock;
    SEL sel = @selector(obj_likeBtnTapCourse:);
    [self addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
}

- (void)obj_likeBtnTapCourse:(__kindof UIButton *)sender {
    // 连续点击过程中会调用的方法
    !_obj_delay_buttonCourseEventsBlock ? : _obj_delay_buttonCourseEventsBlock();
    SEL sel = @selector(obj_likeBtnTapFinalEvent:);
    // 这里是关键，点击按钮后先取消之前的操作，再进行需要进行的操作
    [self.class cancelPreviousPerformRequestsWithTarget:self selector:sel object:sender];
    // 最后一次点击完毕以后的N秒后会执行的方法
    [self performSelector:sel withObject:sender afterDelay:kLikenBtnTimer];
}

- (void)obj_likeBtnTapFinalEvent:(__kindof UIButton *)sender {
    !_obj_delay_buttonfinalEventsBlock ? : _obj_delay_buttonfinalEventsBlock();
}

#pragma mark - runtime setup get_method and set_method
- (void)setObj_buttonEventsBlock:(OBJ_ButtonEventsBlock)obj_buttonEventsBlock {
    objc_setAssociatedObject(self, &_obj_buttonEventsBlock, obj_buttonEventsBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (OBJ_ButtonEventsBlock)obj_buttonEventsBlock {
    return (OBJ_ButtonEventsBlock)objc_getAssociatedObject(self, &_obj_buttonEventsBlock);
}

- (void)setObj_delay_buttonCourseEventsBlock:(OBJ_Delay_ButtonCourseEventsBlock)obj_delay_buttonCourseEventsBlock {
    objc_setAssociatedObject(self, &_obj_delay_buttonCourseEventsBlock, obj_delay_buttonCourseEventsBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);

}

- (OBJ_Delay_ButtonCourseEventsBlock)obj_delay_buttonCourseEventsBlock {
    return (OBJ_Delay_ButtonCourseEventsBlock)objc_getAssociatedObject(self, &_obj_delay_buttonCourseEventsBlock);

}

- (void)setObj_delay_buttonfinalEventsBlock:(OBJ_Delay_ButtonFinalEventsBlock)obj_delay_buttonfinalEventsBlock {
    objc_setAssociatedObject(self, &_obj_delay_buttonfinalEventsBlock, obj_delay_buttonfinalEventsBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);

}

- (OBJ_Delay_ButtonFinalEventsBlock)obj_delay_buttonfinalEventsBlock {
    return (OBJ_Delay_ButtonFinalEventsBlock)objc_getAssociatedObject(self, &_obj_delay_buttonfinalEventsBlock);

}

- (void)setObj_delay_buttonNormalEventsBlock:(OBJ_Delay_ButtonNormalEventsBlock)obj_delay_buttonNormalEventsBlock {
    objc_setAssociatedObject(self, &_obj_delay_buttonNormalEventsBlock, obj_delay_buttonNormalEventsBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);

}

- (OBJ_Delay_ButtonNormalEventsBlock)obj_delay_buttonNormalEventsBlock {
    return (OBJ_Delay_ButtonNormalEventsBlock)objc_getAssociatedObject(self, &_obj_delay_buttonNormalEventsBlock);
}

@end
