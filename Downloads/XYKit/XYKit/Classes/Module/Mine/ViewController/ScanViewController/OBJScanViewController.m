//
//  OBJScanViewController.m
//  BaseObjSet
//
//  Created by 元潇 on 2018/12/11.
//  Copyright © 2018 元潇. All rights reserved.
//

#import "OBJScanViewController.h"
#import "SGQRCode.h"
// 识别二维码后跳转网页的ViewController
#import "OBJScanSuccessViewController.h"

@interface OBJScanViewController () {
    SGQRCodeObtain *obtain;
}
@property (nonatomic, strong) SGQRCodeScanView *scanView;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, assign) BOOL stop;

@end

@implementation OBJScanViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_stop) {
        [obtain startRunningWithBefore:nil completion:nil];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanView addTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scanView removeTimer];
}

- (void)dealloc {
    NSLog(@"WBQRCodeVC - dealloc");
    [self removeScanningView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"识别二维码";
    self.leftBarItemTitle = @"返回";
    self.rightBarItemTitle = @"相册";
    // Do any additional setup after loading the view from its nib.
    obtain = [SGQRCodeObtain QRCodeObtain];
    
    [self setupQRCodeScan];
    [self.view addSubview:self.scanView];
    [self.view addSubview:self.promptLabel];
}

- (void)rightActionInController {
    _WeakSelf
//    [obtain establishAuthorizationQRCodeObtainAlbumWithController:nil];
//    if (obtain.isPHAuthorization == YES) {
//        [self.scanView removeTimer];
//    }
//    [obtain setBlockWithQRCodeObtainAlbumDidCancelImagePickerController:^(SGQRCodeObtain *obtain) {
//        [weakSelf.view addSubview:weakSelf.scanView];
//    }];
//    [obtain setBlockWithQRCodeObtainAlbumResult:^(SGQRCodeObtain *obtain, NSString *result) {
//        if (result == nil) {
//            NSLog(@"暂未识别出二维码");
//        } else {
//            if ([result hasPrefix:@"http"]) {
//                !weakSelf.scanUrlBlockHandle ? : weakSelf.scanUrlBlockHandle(result);
//                //                ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
//                //                jumpVC.comeFromVC = ScanSuccessJumpComeFromWB;
//                //                jumpVC.jump_URL = result;
//                //                [weakSelf.navigationController pushViewController:jumpVC animated:YES];
//                //
//            } else {
//                !weakSelf.scanUrlBlockHandle ? : weakSelf.scanUrlBlockHandle(result);
//                //                ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
//                //                jumpVC.comeFromVC = ScanSuccessJumpComeFromWB;
//                //                jumpVC.jump_bar_code = result;
//                //                [weakSelf.navigationController pushViewController:jumpVC animated:YES];
//            }
//        }
//    }];
    [[TZImagePickerControllerManager shareInstance] imagePickerallowPickingMuitlple:NO allowTakePhoto:YES allowTakeVideo:NO sortAscending:NO allowPickingPhoto:YES allowPickingVideo:NO allowPickingOriginalPhoto:NO showSheet:NO maxCount:1 showCornermark:NO allowCrop:NO needCircleCrop:NO maxImageSize:10 maxVideoSize:50 pictureCallBack:^(NSArray<UIImage *> * _Nonnull imageArray) {
        _StrongSelf
        [strongSelf scanPictureQRCode:[imageArray firstObject] have:^(NSString *resultStr) {
            !strongSelf.scanUrlBlockHandle ? : strongSelf.scanUrlBlockHandle(resultStr);
        } havent:^{
            [MBProgressHUD showTextHUD:@"扫描失败"];
        }];
    } videoCallBack:^(NSString * _Nonnull outputPath, UIImage * _Nonnull coverImage) {
        
    } gifCallBack:^(UIImage * _Nonnull animatedImage) {
        
    }];
}

- (void)scanPictureQRCode:(UIImage *)image have:(void(^)(NSString *resultStr))have havent:(void(^)())havent {
    // 创建 CIDetector，并设定识别类型：CIDetectorTypeQRCode
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    // 获取识别结果
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    if (features.count == 0) {
//        [[RTNavRouter currentVC] dismissViewControllerAnimated:YES completion:nil];
        havent();
        return;
    } else {
        NSString *detectorString = @"";
        for (int index = 0; index < [features count]; index ++) {
            CIQRCodeFeature *feature = [features objectAtIndex:index];
            NSString *resultStr = feature.messageString;
            detectorString = resultStr;
        }
//        [[RTNavRouter currentVC] dismissViewControllerAnimated:YES completion:nil];
        have(detectorString);
    }
}

- (void)setupQRCodeScan {
    __weak typeof(self) weakSelf = self;
    
    SGQRCodeObtainConfigure *configure = [SGQRCodeObtainConfigure QRCodeObtainConfigure];
    configure.openLog = YES;
    configure.rectOfInterest = CGRectMake(0.05, 0.2, 0.7, 0.6);
    // 这里只是提供了几种作为参考（共：13）；需什么类型添加什么类型即可
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    configure.metadataObjectTypes = arr;
    
    [obtain establishQRCodeObtainScanWithController:self configure:configure];
    [obtain startRunningWithBefore:^{

    } completion:^{
        [MBProgressHUD removeLoadingHudOnKeyWindow:YES];
    }];
    [obtain setBlockWithQRCodeObtainScanResult:^(SGQRCodeObtain *obtain, NSString *result) {
        if (result) {
            [obtain stopRunning];
            weakSelf.stop = YES;
            [obtain playSoundName:@"SGQRCode.bundle/sound.caf"];
            
            !weakSelf.scanUrlBlockHandle ? : weakSelf.scanUrlBlockHandle(result);
            //            ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
            //            jumpVC.comeFromVC = ScanSuccessJumpComeFromWB;
            //            jumpVC.jump_URL = result;
            //            [weakSelf.navigationController pushViewController:jumpVC animated:YES];
        }
    }];
}

- (SGQRCodeScanView *)scanView {
    if (!_scanView) {
        _scanView = [[SGQRCodeScanView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight)];
        // 静态库加载 bundle 里面的资源使用 SGQRCode.bundle/QRCodeScanLineGrid
        // 动态库加载直接使用 QRCodeScanLineGrid
        _scanView.scanImageName = @"SGQRCode.bundle/QRCodeScanLineGrid";
        _scanView.scanAnimationStyle = ScanAnimationStyleGrid;
        _scanView.cornerLocation = CornerLoactionOutside;
        _scanView.cornerColor = [UIColor orangeColor];
    }
    return _scanView;
}
- (void)removeScanningView {
    [self.scanView removeTimer];
    [self.scanView removeFromSuperview];
    self.scanView = nil;
}

- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.backgroundColor = [UIColor clearColor];
        CGFloat promptLabelX = 0;
        CGFloat promptLabelY = 0.73 * self.view.frame.size.height;
        CGFloat promptLabelW = self.view.frame.size.width;
        CGFloat promptLabelH = 25;
        _promptLabel.frame = CGRectMake(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        _promptLabel.font = [UIFont boldSystemFontOfSize:13.0];
        _promptLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        _promptLabel.text = @"将二维码/条码放入框内, 即可自动扫描";
    }
    return _promptLabel;
}

@end
