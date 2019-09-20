//
//  XYPermissionManager.m
//  XYKit
//
//  Created by 元潇 on 2019/9/2.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "XYPermissionManager.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <EventKit/EventKit.h>
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <HealthKit/HealthKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <UserNotifications/UserNotifications.h> // 通知

/** 一些方便工程的配置信息
 */
// DeBug下打印，Release下不打印
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#define IOS_10_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)

@interface XYPermissionManager()
<CLLocationManagerDelegate,CBCentralManagerDelegate>

@property (nonatomic,copy) callBack block;

/** 定位 **/
@property (strong, nonatomic) CLLocationManager *locationManager;

/** 蓝牙 **/
@property (strong, nonatomic) CBCentralManager *centralManager;

/** 健康 **/
@property (nonatomic, strong) HKHealthStore *healthStore;

/** 是否显示alert弹窗 **/
@property (nonatomic, assign) BOOL showAlert;

@end

@implementation XYPermissionManager

static XYPermissionManager *_instance;

/**
 单例
 
 @return self
 */
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    }) ;
    return _instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [XYPermissionManager shareInstance] ;
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [XYPermissionManager shareInstance] ;
}

/**
 获取权限
 
 @param type 类型
 @param showAlert 是否显示 没有权限时，跳转设置的alert
 @param block 回调
 */
- (void)permissonType:(PermissionType)type
            showAlert:(BOOL)showAlert
           withHandle:(callBack)block {
    
    self.block = block;
    self.showAlert = showAlert;
    
    switch (type) {
        case PermissionTypePhoto:
        {
            [self permissionTypePhotoAction];
        }
            break;
        case PermissionTypeCamera:
        {
            [self permissionTypeCameraAction];
        }
            break;
        case PermissionTypeMic:
        {
            [self permissionTypeMicAction];
        }
            break;
        case PermissionTypeLocationWhen:
        {
            [self permissionTypeLocationWhenAction];
        }
            break;
        case PermissionTypeCalendar:
        {
            [self permissionTypeCalendarAction];
        }
            break;
        case PermissionTypeContacts:
        {
            [self permissionTypeContactsAction];
        }
            break;
        case PermissionTypeBlue:
        {
            [self permissionTypeBlueAction];
        }
            break;
        case PermissionTypeRemaine:
        {
            [self permissionTypeRemainerAction];
        }
            break;
        case PermissionTypeHealth:
        {
            [self permissionTypeHealthAction];
        }
            break;
        case PermissionTypeMediaLibrary:
        {
            [self permissionTypeMediaLibraryAction];
        }
            break;
        case PermissionTypeNotification:
        {
            [self permissionTypeNotification];
        }
            break;
        default:
            break;
    }
}

/*
 *相册权限
 */
- (void)permissionTypePhotoAction {
    PHAuthorizationStatus photoStatus = [PHPhotoLibrary authorizationStatus];
    __block XYPermissionManager *weakSelf = self;
    if (photoStatus == PHAuthorizationStatusNotDetermined) {
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                weakSelf.block(YES, @(photoStatus));
            } else {
                weakSelf.block(NO, @(photoStatus));
            }
        }];
    } else if (photoStatus == PHAuthorizationStatusAuthorized) {
        self.block(YES, @(photoStatus));
    } else if (photoStatus == PHAuthorizationStatusRestricted||photoStatus == PHAuthorizationStatusDenied){
        self.block(NO, @(photoStatus));
        [self pushSetting:@"相册权限"];
        
    } else {
        self.block(NO, @(photoStatus));
    }
}

/*
 *相机权限
 */
- (void)permissionTypeCameraAction {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    __block XYPermissionManager *weakSelf = self;
    if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            weakSelf.block(granted, @(authStatus));
        }];
    }  else if (authStatus == AVAuthorizationStatusAuthorized) {
        self.block(YES, @(authStatus));
    } else if(authStatus == AVAuthorizationStatusRestricted||authStatus == AVAuthorizationStatusDenied) {
        self.block(NO, @(authStatus));
        [self pushSetting:@"相机权限"];
        
    } else {
        self.block(NO, @(authStatus));
    }
}

/*
 *麦克风权限
 */
- (void)permissionTypeMicAction {
    AVAudioSessionRecordPermission micPermisson = [[AVAudioSession sharedInstance] recordPermission];
    __block XYPermissionManager *weakSelf = self;
    if (micPermisson == AVAudioSessionRecordPermissionUndetermined) {
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
            weakSelf.block(granted, @(micPermisson));
        }];
    } else if (micPermisson == AVAudioSessionRecordPermissionGranted) {
        self.block(YES, @(micPermisson));
    } else {
        self.block(NO, @(micPermisson));
        [self pushSetting:@"麦克风权限"];
    }
}


/*
 *获取地理位置When
 */
- (void)permissionTypeLocationWhenAction {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined) {
        
        if (!self.locationManager) {
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
        }
        [self.locationManager requestWhenInUseAuthorization];
        
    } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        self.block (YES, @(status));
    } else {
        self.block(NO, @(status));
        [self pushSetting:@"使用期间访问地理位置权限"];
    }
}

/*
 *日历
 */
- (void)permissionTypeCalendarAction {
    EKEntityType type  = EKEntityTypeEvent;
    __block XYPermissionManager *weakSelf = self;
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:type];
    if (status == EKAuthorizationStatusNotDetermined) {
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        [eventStore requestAccessToEntityType:type completion:^(BOOL granted, NSError * _Nullable error) {
            weakSelf.block(granted,@(status));
        }];
    } else if (status == EKAuthorizationStatusAuthorized) {
        self.block(YES,@(status));
    } else {
        [self pushSetting:@"日历权限"];
        self.block(NO,@(status));
    }
}


/*
 *联系人
 */
- (void)permissionTypeContactsAction {
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    __block XYPermissionManager *weakSelf = self;
    if (status == CNAuthorizationStatusNotDetermined) {
        CNContactStore *store = [[CNContactStore alloc] init];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                weakSelf.block(granted,[weakSelf openContact]);
            }
            weakSelf.block(granted,@(status));
        }];
    } else if (status == CNAuthorizationStatusAuthorized) {;
        self.block(YES,[self openContact]);
    } else {
        self.block(NO,@(status));
        [self pushSetting:@"联系人权限"];
    }
}


/*
 *蓝牙
 */
- (void)permissionTypeBlueAction {
    if (!self.centralManager) {
        self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
    }
}

/*
 * 提醒
 */
- (void)permissionTypeRemainerAction {
    EKEntityType type  = EKEntityTypeReminder;
    __block XYPermissionManager *weakSelf = self;
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:type];
    if (status == EKAuthorizationStatusNotDetermined) {
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        [eventStore requestAccessToEntityType:type completion:^(BOOL granted, NSError * _Nullable error) {
            weakSelf.block(granted,@(status));
        }];
    } else if (status == EKAuthorizationStatusAuthorized) {
        self.block(YES,@(status));
    } else {
        [self pushSetting:@"日历权限"];
        self.block(NO,@(status));
    }
}

/*
 * 健康
 */
- (void)permissionTypeHealthAction {
    // 查看healthKit在设备上是否可用，ipad不支持HealthKit
    if (![HKHealthStore isHealthDataAvailable]) {
        DLog(@"设备不支持healthKit");
        self.block(NO, nil);
        return;
    }
    
    if (!self.healthStore) {
        self.healthStore = [HKHealthStore new];
    }
    
    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    __block XYPermissionManager *weakSelf = self;
    NSSet *readDataTypes =  [NSSet setWithObjects:stepType, nil];
    [self.healthStore requestAuthorizationToShareTypes:nil readTypes:readDataTypes completion:^(BOOL success, NSError * _Nullable error) {
        
        if (success) {
            [weakSelf readStepCount];
        } else {
            weakSelf.block(NO, nil);
        }
    }];
}

/*
 * 多媒体
 */
- (void)permissionTypeMediaLibraryAction {
    __block XYPermissionManager *weakSelf = self;
    [MPMediaLibrary requestAuthorization:^(MPMediaLibraryAuthorizationStatus status){
        switch (status) {
            case MPMediaLibraryAuthorizationStatusNotDetermined: {
                weakSelf.block(NO, @(status));
                break;
            }
            case MPMediaLibraryAuthorizationStatusRestricted: {
                weakSelf.block(NO, @(status));
                break;
            }
            case MPMediaLibraryAuthorizationStatusDenied: {
                weakSelf.block(NO, @(status));
                break;
            }
            case MPMediaLibraryAuthorizationStatusAuthorized: {
                // authorized
                weakSelf.block(YES, @(status));
                break;
            }
            default: {
                break;
            }
        }
        
    }];
}

- (void)permissionTypeNotification {
    __block XYPermissionManager *weakSelf = self;
    UIUserNotificationSettings *status = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay completionHandler:^(BOOL granted, NSError * _Nullable error) {
            // 注册之后的回调
            BOOL is = !error && granted ? YES : NO;
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.block(is, status);
                is ? : [weakSelf pushSetting:@"推送权限"];
            });
        }];
    } else {
        // Fallback on earlier versions
        if (status.types == YES) {
            UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound  categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
            self.block(status.types, status);
        } else {
            [self pushSetting:@"推送权限"];
            self.block(status.types, status);
        }
    }
}

/*
 * 查询步数数据
 */
- (void)readStepCount {
    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    
    __block XYPermissionManager *weakSelf = self;
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:stepType predicate:[XYPermissionManager predicateForSamplesToday] limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if (error) {
            
            weakSelf.block(NO, error);
        } else {
            NSInteger totleSteps = 0;
            for(HKQuantitySample *quantitySample in results) {
                HKQuantity *quantity = quantitySample.quantity;
                HKUnit *heightUnit = [HKUnit countUnit];
                double usersHeight = [quantity doubleValueForUnit:heightUnit];
                totleSteps += usersHeight;
            }
            DLog(@"当天行走步数 = %ld",(long)totleSteps);
            weakSelf.block(YES,@(totleSteps));
        }
    }];
    
    [self.healthStore executeQuery:query];
    
}

/*!
 *  @brief  当天时间段(可以获取某一段时间)
 *
 *  @return 时间段
 */
+ (NSPredicate *)predicateForSamplesToday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond: 0];
    
    NSDate *startDate = [calendar dateFromComponents:components];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone];
    return predicate;
}

// 有通讯录权限-- 获取通讯录
- (NSArray*)openContact {
    // 获取指定的字段
    NSArray *keysToFetch = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    NSMutableArray *arr = [NSMutableArray new];
    [contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        // 拼接姓名
        NSString *nameStr = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
        NSArray *phoneNumbers = contact.phoneNumbers;
        for (CNLabeledValue *labelValue in phoneNumbers) {
            CNPhoneNumber *phoneNumber = labelValue.value;
            NSString * string = phoneNumber.stringValue ;
            // 去掉电话中的特殊字符
            string = [string stringByReplacingOccurrencesOfString:@"+86" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
            DLog(@"姓名=%@, 电话号码是=%@", nameStr, string);
            [arr addObject:@{@"name":nameStr,@"phone":string}];
        }
    }];
    return [NSArray arrayWithArray:arr];
    
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    self.block(YES, error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    self.block(YES, newLocation);
    [self stopLocationService];
}

- (void)stopLocationService {
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
    self.locationManager = nil;
}

#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    // 蓝牙第一次以及之后每次蓝牙状态改变都会调用这个函数
    if (central.state==CBCentralManagerStatePoweredOn) {
        DLog(@"蓝牙设备开着");
        self.block(YES, nil);
    } else {
        DLog(@"蓝牙设备关着");
        self.block(NO, nil);
    }
}


/*
 *跳转设置
 */
- (void)pushSetting:(NSString*)urlStr {
    
    if (!self.showAlert) {
        return;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@%@",urlStr,self.tip] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url= [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if (IOS_10_OR_LATER) {
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url options:@{}completionHandler:^(BOOL success) {
                }];
            }
        } else {
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }];
    [alert addAction:okAction];
    [[XYPermissionManager getCurrentVC] presentViewController:alert animated:YES completion:nil];
}

// 获取当前VC
+ (UIViewController *)getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]) {
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    
    return currentVC;
}

#pragma mark - NSObject
- (NSString *)tip {
    if (!_tip) {
        _tip = @"尚未开启,是否前往设置";
    }
    return _tip;
}

@end
