//
//  TZImagePickerControllerManager.h
//  BaseObjSet
//
//  Created by 元潇 on 2018/12/4.
//  Copyright © 2018 元潇. All rights reserved.
//  跳转相册或者相机
//  需要在info.plist中添加开启权限字段，不然会crash
/*
 <key>NSCameraUsageDescription</key>
 <string>访问相机以拍照</string>
 <key>NSLocationWhenInUseUsageDescription</key>
 <string>允许定位以把位置保存到照片中</string>
 <key>NSMicrophoneUsageDescription</key>
 <string>访问麦克风以录像</string>
 <key>NSPhotoLibraryUsageDescription</key>
 <string>访问相册以选择照片</string>
 */
// 使用注意事项：视频一次只能选一个，且选了视频就无法再选图片，多选的时候无法裁剪图片，只有单选的时候才能裁剪

#import <Foundation/Foundation.h>

@class TZImagePickerController;

NS_ASSUME_NONNULL_BEGIN

typedef void(^TZPictureCallBackBlock) (NSArray <UIImage *>*imageArray);
/** outputPath视频绝对路径 coverImage第一帧图片 **/
typedef void(^TZVideoCallBackBlock) (NSString *outputPath, UIImage *coverImage);
typedef void(^TZGifCallBackBlock) (UIImage *animatedImage);

@interface TZImagePickerControllerManager : NSObject

/**
 单例instancetyoe

 @return 单例对象
 */
+ (instancetype)shareInstance;

/**
 跳转TZImagePickerController
 
 @param allowPickingMuitlple 允许多选
 @param allowTakePhoto 允许拍照
 @param allowTakeVideo 允许拍视频
 @param sortAscending 照片排列按修改时间升序，默认是YES。如果设置为NO,最新的照片会显示在最前面，内部的拍照按钮会排在第一个
 @param allowPickingPhoto 允许选择照片
 @param allowPickingVideo 允许选择视频
 @param allowPickingOriginalPhoto 允许选择原图
 @param showSheet 显示一个sheet,把拍照/拍视频按钮放在外面
 @param maxCount 照片最大可选张数，设置为1即为单选模式
 @param showCornermark 多选时，显示选中图片的数字（第几个）
 @param allowCrop 单选模式下允许裁剪
 @param needCircleCrop 使用圆形裁剪框
 @param pictureCallBack 图片回调
 @param maxImageSize 最大图片大小
 @param maxVideoSize 最大视频大小
 @param videoCallBack 视频回调
 @param gifCallBack gif图片回调
 */
- (void)imagePickerallowPickingMuitlple:(BOOL)allowPickingMuitlple
                         allowTakePhoto:(BOOL)allowTakePhoto
                         allowTakeVideo:(BOOL)allowTakeVideo
                          sortAscending:(BOOL)sortAscending
                      allowPickingPhoto:(BOOL)allowPickingPhoto
                      allowPickingVideo:(BOOL)allowPickingVideo
              allowPickingOriginalPhoto:(BOOL)allowPickingOriginalPhoto
                              showSheet:(BOOL)showSheet
                               maxCount:(NSInteger)maxCount
                         showCornermark:(BOOL)showCornermark
                              allowCrop:(BOOL)allowCrop
                         needCircleCrop:(BOOL)needCircleCrop
                           maxImageSize:(CGFloat)maxImageSize
                           maxVideoSize:(CGFloat)maxVideoSize
                        pictureCallBack:(TZPictureCallBackBlock)pictureCallBack
                          videoCallBack:(TZVideoCallBackBlock)videoCallBack
                            gifCallBack:(TZGifCallBackBlock)gifCallBack;

@end

NS_ASSUME_NONNULL_END
