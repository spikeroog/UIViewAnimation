//
//  OBJMineViewController.m
//  BaseObjSet
//
//  Created by 元潇 on 2018/11/28.
//  Copyright © 2018 元潇. All rights reserved.
//

#import "OBJMineViewController.h"
#import "XYHomeDetailsViewController.h"
#import "XYHomeNextVC.h"
#import "XYHomeNextVC1.h"
#import "XYHomeNextVC2.h"

#define kMaxImageCount 5 // 最多选5张

@interface OBJMineViewController ()
@property (nonatomic, strong) NSMutableArray *datas;
@end


@implementation OBJMineViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"我的";
    
    [self rigBarItemsWithTitleArr:@[@"扫一扫", @"弹窗", @"图片"] imageArr:@[]];

    _WeakSelf
    self.rightItemsHandle = ^(NSInteger idx) {
        if (idx == 0) {
            [weakSelf gotoScan];
        } else if (idx == 1) {
            [weakSelf popWindow];
        } else if (idx == 2)  {
            [weakSelf gotoPhoto];
        }
    };
    
    [self configDefaultTabPageBar:@[[XYHomeNextVC new],
                             [XYHomeNextVC1 new],
                             [XYHomeNextVC new],
                             [XYHomeNextVC2 new]]
                    titles:@[@"我的", @"云村", @"发现", @"视频"]];
    
    [self setUpUI];
}

- (void)setUpUI {
    
    [self configCategoryView];


}

- (void)configCategoryView {
    

}

- (void)popWindow {
    XYObserverView *view = [[XYObserverView alloc] init];
    view.backgroundColor = Green;
    view.frame = CGRectMake(0, 0, 300, 300);
    UITextField *tf = [[UITextField alloc] init];
    tf.backgroundColor = [UIColor whiteColor];
    //    tf.frame = CGRectMake(0, 0, view.width, 40);
    [view addSubview:tf];
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view);
        make.left.equalTo(view);
        make.width.offset(view.width);
        make.height.offset(40);
    }];
    [[XYPopupView shareInstance] popupView:view animationType:PopUpViewAnimationTypeCenter clickDismiss:YES];
}

- (void)gotoScan {
    [XYKitMediator fetchScanCodeHaventCamera:^{
        
    } haventPicture:^{
        
    } urlBlock:^(NSString * _Nonnull result) {
        
    }];
}


- (void)gotoPhoto {
    _WeakSelf
    NSInteger lessNum = 0;
    if (self.datas.count < kMaxImageCount) { // 最多选5张
        lessNum = kMaxImageCount - self.datas.count;
    }
    
    [[TZImagePickerControllerManager shareInstance] imagePickerallowPickingMuitlple:NO allowTakePhoto:NO allowTakeVideo:YES sortAscending:NO allowPickingPhoto:NO allowPickingVideo:YES allowPickingOriginalPhoto:NO showSheet:YES maxCount:lessNum showCornermark:YES allowCrop:NO needCircleCrop:NO maxImageSize:10 maxVideoSize:50 pictureCallBack:^(NSArray<UIImage *> * _Nonnull imageArray) {
        _StrongSelf
        [strongSelf.datas addObjectsFromArray:imageArray];
        
    } videoCallBack:^(NSString * _Nonnull outputPath, UIImage * _Nonnull coverImage) {
        
    } gifCallBack:^(UIImage * _Nonnull animatedImage) {
        
    }];

}


@end
