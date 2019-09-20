//
//  TZImagePickerControllerManager.m
//  BaseObjSet
//
//  Created by 元潇 on 2018/12/4.
//  Copyright © 2018 元潇. All rights reserved.
//

#import "TZImagePickerControllerManager.h"
#import "TZImagePickerController.h"
#import "TZLocationManager.h"
#import "FLAnimatedImage.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>
#import <AssetsLibrary/AssetsLibrary.h>

// 视频最大拍摄时间(s)
#define kVideoMaxTime 10

@interface TZImagePickerControllerManager ()
<TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate> {
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    CGFloat _itemWH;
    CGFloat _margin;
    BOOL _isOriginalPhoto;
}
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) TZImagePickerController *tz_ImagePickerVc;
@property (strong, nonatomic) CLLocation *location;
@property (nonatomic, copy) TZPictureCallBackBlock pictureCallBackBlock;
@property (nonatomic, copy) TZVideoCallBackBlock videoCallBackBlock;
@property (nonatomic, copy) TZGifCallBackBlock gifCallBackBlock;

@property (nonatomic, assign) NSInteger maxImageSize;
@property (nonatomic, assign) NSInteger maxVideoSize;
@end

@implementation TZImagePickerControllerManager

+ (instancetype)shareInstance {
    static TZImagePickerControllerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TZImagePickerControllerManager alloc] init];
    });
    return manager;
}

#pragma mark - NSObject

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

- (UIImagePickerController *)imagePickerVc {
    if (!_imagePickerVc) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // 视频最大拍摄时间
        _imagePickerVc.videoMaximumDuration = kVideoMaxTime;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.translucent = NO;
        _imagePickerVc.navigationBar.barTintColor = [RTNavRouter navBgColor];
        _imagePickerVc.navigationBar.tintColor = [UIColor whiteColor];

        _imagePickerVc.allowsEditing = YES;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (@available(iOS 9, *)) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        
    }
    return _imagePickerVc;
}

#pragma mark - 跳转TZImagePickerController
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
                            gifCallBack:(TZGifCallBackBlock)gifCallBack {
    
    self.pictureCallBackBlock = pictureCallBack;
    self.videoCallBackBlock = videoCallBack;
    self.gifCallBackBlock = gifCallBack;
    self.maxImageSize = maxImageSize;
    self.maxVideoSize = maxVideoSize;
    
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    _isOriginalPhoto = allowPickingOriginalPhoto;
    // 参数介绍： MaxImagesCount：最多选择多少张图片  columnNumber：最少选择几张
    TZImagePickerController *imagePickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:maxCount columnNumber:1 delegate:self pushPhotoPickerVc:YES];
    imagePickerController.allowPickingMultipleVideo = allowPickingMuitlple;
    imagePickerController.allowTakePicture = allowTakePhoto;
    imagePickerController.allowTakeVideo = allowTakeVideo;
    imagePickerController.sortAscendingByModificationDate = sortAscending;
    imagePickerController.allowPickingImage = allowPickingPhoto;
    imagePickerController.allowPickingVideo = allowPickingVideo;
    imagePickerController.allowPickingOriginalPhoto = allowPickingOriginalPhoto;
    imagePickerController.allowCrop = allowCrop;
    imagePickerController.needCircleCrop = needCircleCrop;
    imagePickerController.showSelectedIndex = showCornermark;
    
    imagePickerController.navigationBar.translucent = NO;
    
    imagePickerController.navigationBar.barTintColor = [RTNavRouter navBgColor];
    imagePickerController.navigationBar.tintColor = [UIColor whiteColor];

    
    self.tz_ImagePickerVc = imagePickerController;
    
    if (showSheet) {
        NSString *takePhotoTitle = @"拍照";
        if (imagePickerController.allowTakeVideo && imagePickerController.allowTakePicture) {
            takePhotoTitle = @"相机";
        } else if (imagePickerController.allowTakeVideo) {
            takePhotoTitle = @"拍摄";
        }
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:takePhotoTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self takePhoto:imagePickerController];
        }];
        [alertVc addAction:takePhotoAction];
        UIAlertAction *imagePickerAction = [UIAlertAction actionWithTitle:@"去相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self pushTZImagePickerController:imagePickerController];
        }];
        [alertVc addAction:imagePickerAction];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertVc addAction:cancelAction];
        [[RTNavRouter currentVC] presentViewController:alertVc animated:YES completion:nil];
    } else {
        [self pushTZImagePickerController:imagePickerController];
    }
}

#pragma mark - TZImagePickerController Delegate

- (void)pushTZImagePickerController:(TZImagePickerController *)imagePickerVc {
    // imagePickerVc.navigationBar.translucent = NO;
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    if (imagePickerVc.maxImagesCount > 1) {
        // 1.设置目前已经选中的图片数组
        imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    }
    
    imagePickerVc.videoMaximumDuration = kVideoMaxTime; // 视频最大拍摄时间
    [imagePickerVc setUiImagePickerControllerSettingBlock:^(UIImagePickerController *imagePickerController) {
        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }];
    
    // imagePickerVc.photoWidth = 1000;
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    // imagePickerVc.navigationBar.translucent = NO;
    
    // 自定义imagePickerVc导航栏背景颜色 标题颜色等
    imagePickerVc.navigationBar.translucent = NO;
    
    imagePickerVc.navigationBar.barTintColor = [RTNavRouter navBgColor];
    imagePickerVc.navigationBar.tintColor = [UIColor whiteColor];
    
    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }];
    /*
     [imagePickerVc setAssetCellDidSetModelBlock:^(TZAssetCell *cell, UIImageView *imageView, UIImageView *selectImageView, UILabel *indexLabel, UIView *bottomView, UILabel *timeLength, UIImageView *videoImgView) {
     cell.contentView.clipsToBounds = YES;
     cell.contentView.layer.cornerRadius = cell.contentView.tz_width * 0.5;
     }];
     */
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图

    // 4. 照片排列按修改时间升序
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
    
    /// 5. Single selection mode, valid when maxImagesCount = 1
    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;
    // 设置竖屏下的裁剪尺寸
    CGFloat left = 0;
    CGFloat top = [RTNavRouter fetchKeyWindow].centerY-kScreenWidth/2;
    imagePickerVc.cropRect = CGRectMake(left, top, kScreenWidth, kScreenWidth);
    // 设置横屏下的裁剪尺寸
    // imagePickerVc.cropRectLandscape = CGRectMake(left, top, kScreenWidth, kScreenWidth);
    /*
     [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
     cropView.layer.borderColor = [UIColor redColor].CGColor;
     cropView.layer.borderWidth = 2.0;
     }];*/
    
    //imagePickerVc.allowPreview = NO;
    // 自定义导航栏上的返回按钮
    /*
     [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton){
     [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
     [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 20)];
     }];
     imagePickerVc.delegate = self;
     */
    
    // Deprecated, Use statusBarStyle
    // imagePickerVc.isStatusBarDefault = NO;
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;

    // 自定义gif播放方案
    [[TZImagePickerConfig sharedInstance] setGifImagePlayBlock:^(TZPhotoPreviewView *view, UIImageView *imageView, NSData *gifData, NSDictionary *info) {
        FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:gifData];
        FLAnimatedImageView *animatedImageView;
        for (UIView *subview in imageView.subviews) {
            if ([subview isKindOfClass:[FLAnimatedImageView class]]) {
                animatedImageView = (FLAnimatedImageView *)subview;
                animatedImageView.frame = imageView.bounds;
                animatedImageView.animatedImage = nil;
            }
        }
        if (!animatedImageView) {
            animatedImageView = [[FLAnimatedImageView alloc] initWithFrame:imageView.bounds];
            animatedImageView.runLoopMode = NSDefaultRunLoopMode;
            [imageView addSubview:animatedImageView];
        }
        animatedImageView.animatedImage = animatedImage;
    }];
    
    // 设置首选语言 / Set preferred language
    // imagePickerVc.preferredLanguage = @"zh-Hans";
    
    // 设置languageBundle以使用其它语言 / Set languageBundle to use other language
    // imagePickerVc.languageBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"tz-ru" ofType:@"lproj"]];
    
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    imagePickerVc.allowPickingOriginalPhoto = _isOriginalPhoto;

    [[RTNavRouter currentVC] presentViewController:imagePickerVc animated:YES completion:nil];
}

/// User click cancel button
/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // DLog(@"cancel");
}

// The picker should dismiss itself; when it dismissed these handle will be called.
// You can also set autoDismiss to NO, then the picker don't dismiss itself.
// If isOriginalPhoto is YES, user picked the original photo.
// You can get original photo with asset, by the method [[TZImageManager manager] getOriginalPhotoWithAsset:completion:].
// The UIImage Object in photos default width is 828px, you can set it by photoWidth property.
// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 你也可以设置autoDismiss属性为NO，选择器就不会自己dismis了
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
    
    // 1.打印图片名字
//    [self printAssetsName:assets];
    // 2.图片位置信息
    for (PHAsset *phAsset in assets) {
        DLog(@"location:%@",phAsset.location);
    }
    
    NSMutableArray *muPhotos = [photos mutableCopy];
    
    [photos enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.maxImageSize > 0) {
            if ([UtilityTools fetchImageSize:obj] > self.maxImageSize) {
                [muPhotos removeObjectAtIndex:idx];
                [MBProgressHUD showTextHUD:[NSString stringWithFormat:@"请选择小于等于%ldM的图片文件", (long)self.maxImageSize]];
            }
        }
    }];
    if (muPhotos.count > 0) {
        !self.pictureCallBackBlock ? : self.pictureCallBackBlock(muPhotos);
    }
    
    /*
     // 3. 获取原图的示例，这样一次性获取很可能会导致内存飙升，建议获取1-2张，消费和释放掉，再获取剩下的
     __block NSMutableArray *originalPhotos = [NSMutableArray array];
     __block NSInteger finishCount = 0;
     for (NSInteger i = 0; i < assets.count; i++) {
     [originalPhotos addObject:@1];
     }
     for (NSInteger i = 0; i < assets.count; i++) {
     PHAsset *asset = assets[i];
     PHImageRequestID requestId = [[TZImageManager manager] getOriginalPhotoWithAsset:asset completion:^(UIImage *photo, NSDictionary *info) {
     finishCount += 1;
     [originalPhotos replaceObjectAtIndex:i withObject:photo];
     if (finishCount >= assets.count) {
     DLog(@"All finished.");
     }
     }];
     DLog(@"requestId: %d", requestId);
     }
     */
}

// If user picking a video and allowPickingMultipleVideo is NO, this callback will be called.
// If allowPickingMultipleVideo is YES, will call imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
// 如果用户选择了一个视频且allowPickingMultipleVideo是NO，下面的代理方法会被执行
// 如果allowPickingMultipleVideo是YES，将会调用imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    
    PHAssetResource *resource = [[PHAssetResource assetResourcesForAsset:asset] firstObject];
    long long size = [[resource valueForKey:@"fileSize"] longLongValue];
    if (self.maxVideoSize > 0) {
        if ((CGFloat)size/(1024*1024) > self.maxVideoSize) {
            [MBProgressHUD showTextHUD:[NSString stringWithFormat:@"请选择小于等于%ldM的视频文件", (long)self.maxVideoSize]];
            return;
        }
    }
    
    // 选择视频后，有个导出的过程，视频越大越费时
    [MBProgressHUD showLoadingHUD:@"导出视频中.."];
    
    // open this code to send video / 打开这段代码发送视频
    _WeakSelf
    [[TZImageManager manager] getVideoOutputPathWithAsset:asset presetName:AVAssetExportPreset640x480 success:^(NSString *outputPath) {
        
            [MBProgressHUD removeLoadingHudOnKeyWindow:YES];
        
        !weakSelf.videoCallBackBlock ? : weakSelf.videoCallBackBlock(outputPath, coverImage);
        
        DLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
        // Export completed, send video here, send by outputPath or NSData
        // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
    } failure:^(NSString *errorMessage, NSError *error) {
        DLog(@"视频导出失败:%@,error:%@",errorMessage, error);
    }];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
}

// If user picking a gif image and allowPickingMultipleVideo is NO, this callback will be called.
// If allowPickingMultipleVideo is YES, will call imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
// 如果用户选择了一个gif图片且allowPickingMultipleVideo是NO，下面的代理方法会被执行
// 如果allowPickingMultipleVideo是YES，将会调用imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(PHAsset *)asset {
    
    !self.gifCallBackBlock ? :self.gifCallBackBlock(animatedImage);
    
    _selectedPhotos = [NSMutableArray arrayWithArray:@[animatedImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
}

// Decide album show or not't
// 决定相册显示与否
- (BOOL)isAlbumCanSelect:(NSString *)albumName result:(PHFetchResult *)result {
    /*
     if ([albumName isEqualToString:@"个人收藏"]) {
     return NO;
     }
     if ([albumName isEqualToString:@"视频"]) {
     return NO;
     }*/
    return YES;
}

// Decide asset show or not't
// 决定asset显示与否
- (BOOL)isAssetCanSelect:(PHAsset *)asset {
    /*
     switch (asset.mediaType) {
     case PHAssetMediaTypeVideo: {
     // 视频时长
     // NSTimeInterval duration = phAsset.duration;
     return NO;
     } break;
     case PHAssetMediaTypeImage: {
     // 图片尺寸
     if (phAsset.pixelWidth > 3000 || phAsset.pixelHeight > 3000) {
     // return NO;
     }
     return YES;
     } break;
     case PHAssetMediaTypeAudio:
     return NO;
     break;
     case PHAssetMediaTypeUnknown:
     return NO;
     break;
     default: break;
     }
     */
    return YES;
}


#pragma mark - UIImagePickerController Delegate
- (void)takePhoto:(TZImagePickerController *)tzImagePickerController {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        // 无相机权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        _WeakSelf
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf takePhoto:tzImagePickerController];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        _WeakSelf
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [weakSelf takePhoto:tzImagePickerController];
        }];
    } else {
        [self pushImagePickerController:tzImagePickerController];
    }
}

// 调用相机
- (void)pushImagePickerController:(TZImagePickerController *)tzImagePickerController {
    // 提前定位
    __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = [locations firstObject];
    } failureBlock:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = nil;
    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        if (tzImagePickerController.allowTakeVideo) {
            [mediaTypes addObject:(NSString *)kUTTypeMovie];
        }
        if (tzImagePickerController.allowTakePicture) {
            [mediaTypes addObject:(NSString *)kUTTypeImage];
        }
        if (mediaTypes.count) {
            self.imagePickerVc.mediaTypes = mediaTypes;
        }
        DLog(@"%d", self.imagePickerVc.allowsEditing);
        [[RTNavRouter currentVC] presentViewController:self.imagePickerVc animated:YES completion:nil];
    } else {
        DLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];

    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    tzImagePickerVc.sortAscendingByModificationDate = self.tz_ImagePickerVc.sortAscendingByModificationDate;
    [tzImagePickerVc showProgressHUD];
    if ([type isEqualToString:@"public.image"]) {
        /*
         UIImagePickerControllerOriginalImage 原图
         UIImagePickerControllerEditedImage 裁剪的图片
         */
        __block UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        _WeakSelf
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(PHAsset *asset, NSError *error){
            [tzImagePickerVc hideProgressHUD];
            if (error) {
                DLog(@"图片保存失败 %@",error);
            } else {
                
//                !weakSelf.pictureCallBackBlock ? : weakSelf.pictureCallBackBlock(@[image]);
//
                TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
//                if (self.tz_ImagePickerVc.allowCrop) { // 允许裁剪,去裁剪
//                    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
//                        [self refreshCollectionViewWithAddedAsset:asset image:cropImage];
//                    }];
//                    imagePicker.allowPickingImage = YES;
//                    imagePicker.needCircleCrop = self.tz_ImagePickerVc.needCircleCrop;
//                    imagePicker.circleCropRadius = 100;
//                    [[RTNavRouter currentVC] presentViewController:imagePicker animated:YES completion:nil];
//                } else {
                    image = [weakSelf fixOrientation:image];
                    if ([UtilityTools fetchImageSize:image] > self.maxImageSize) {
                        [MBProgressHUD showTextHUD:[NSString stringWithFormat:@"请选择小于等于%ldM的图片文件", (long)self.maxImageSize]];
                        return ;
                    }
                    !weakSelf.pictureCallBackBlock ? : weakSelf.pictureCallBackBlock(@[image]);
                    
                    [weakSelf refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
//                }
            }
        }];
    } else if ([type isEqualToString:@"public.movie"]) {
        NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        if (videoUrl) {
            _WeakSelf
            [[TZImageManager manager] saveVideoWithUrl:videoUrl location:self.location completion:^(PHAsset *asset, NSError *error) {
                [tzImagePickerVc hideProgressHUD];
                if (!error) {
                    TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                    [[TZImageManager manager] getPhotoWithAsset:assetModel.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
                        if (!isDegraded && photo) {
                            !weakSelf.videoCallBackBlock ? :                             weakSelf.videoCallBackBlock([videoUrl absoluteString], photo);
                            [weakSelf refreshCollectionViewWithAddedAsset:assetModel.asset image:photo];
                        }
                    }];
                }
            }];
        }
    }
}

- (void)refreshCollectionViewWithAddedAsset:(PHAsset *)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    [_selectedPhotos addObject:image];
    
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = asset;
        DLog(@"location:%@",phAsset.location);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

#pragma clang diagnostic pop

#pragma mark - 逆时针90（N度）度图片还原默认角度（系统相机拍的照片会转90度）
/**
 90度图片还原

 @param aImage 图片
 @return 图片
 */
- (UIImage *)fixOrientation:(UIImage *)aImage {
    // No-op if the orientation is already correct
    if (aImage.imageOrientation ==UIImageOrientationUp)
        return aImage;
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform =CGAffineTransformIdentity;
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width,0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width,0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height,0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx =CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                            CGImageGetBitsPerComponent(aImage.CGImage),0,
                                            CGImageGetColorSpace(aImage.CGImage),
                                            CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx,CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
        default:
            CGContextDrawImage(ctx,CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg =CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
