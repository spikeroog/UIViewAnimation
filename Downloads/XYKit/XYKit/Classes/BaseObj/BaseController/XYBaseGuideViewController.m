//
//  XYBaseGuideViewController.m
//  XYKit
//
//  Created by 元潇 on 2019/9/2.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "XYBaseGuideViewController.h"
#define TAG 1000

@interface XYBaseGuideViewController ()
<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *imageArray;
/** 是否支持滑动进入APP，默认为NO **/
@property (nonatomic, assign) BOOL isSlideThroughApp;
/** pageControl **/
@property (nonatomic, strong) UIPageControl *imagePageControl;
/** 右上角的跳过按钮 **/
@property (nonatomic, strong) UIButton *skipButton;
/** 下方的开始体验按钮 **/
@property (nonatomic, strong) UIButton *startButton;
/** gif **/
@property (strong, nonatomic) FLAnimatedImage *animatedImage;
@property (strong, nonatomic) FLAnimatedImageView *animatedImageView;
/** 当前图片的下标 **/
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) GuidePageType guideType;

@end

@implementation XYBaseGuideViewController

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 0;
}

/**
 图片引导页
 
 @param imageNameArray 图片数组，gif传@[@"xx.gif", @"xxx.gif"]
 */
- (void)buildWithImageArray:(NSArray *)imageNameArray {
    
    // 默认最后一张引导页不能右滑进入app
    self.isSlideThroughApp = NO;
    
    if ([kStringSafe(imageNameArray[0]) containsString:@".gif"]) { // gif图片
        self.guideType = GuidePageTypeGif;
    } else {
        self.guideType = GuidePageTypePicture;
    }
    
    self.imageArray = imageNameArray;
    
    // 设置引导视图的scrollview
    UIScrollView *guidePageView = [[UIScrollView alloc] initWithFrame:kScreenRect];
    [guidePageView setBackgroundColor:[UIColor lightGrayColor]];
    [guidePageView setContentSize:CGSizeMake(kScreenWidth * imageNameArray.count, kScreenHeight)];
    [guidePageView setBounces:self.isSlideThroughApp];
    [guidePageView setPagingEnabled:YES];
    [guidePageView setShowsHorizontalScrollIndicator:NO];
    [guidePageView setDelegate:self];
    [self.view addSubview:guidePageView];
    
    // 设置引导页上的跳过按钮
    [self.view addSubview:self.skipButton];
    
    // 添加在引导视图上的多张引导图片
    for (int i = 0; i < imageNameArray.count; i++) {
        
        FLAnimatedImageView *animatedImageView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenHeight)];
        
        // 设置tag
        animatedImageView.tag = TAG + i;
        
        if ([kStringSafe(imageNameArray[i]) containsString:@".gif"]) { // gif图片
            
            NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:imageNameArray[i] ofType:nil]];
            
            FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:url]];
            
            if (i == 0) { // 如果是第一张引导页默认显示gif
                
                animatedImageView.animatedImage = animatedImage;
                
            } else { // 不是第一张引导页就显示gif第一帧的静态图片
                
                // 默认是不播放动画的，赋值为gif第一帧的图片，FLAnimatedImage自带属性，不需要UI重新给图
                animatedImageView.image = animatedImage.posterImage;
                
            }
            
            [guidePageView addSubview:animatedImageView];
            
        } else { // 普通图片
            animatedImageView.image = UIImageWithStr(imageNameArray[i]);
            [guidePageView addSubview:animatedImageView];
        }
        
        // 设置在最后一张图片上显示进入体验按钮
        if (i == imageNameArray.count-1) {
            [animatedImageView setUserInteractionEnabled:YES];
            [animatedImageView addSubview:self.startButton];
        }
        // 设置引导页上的页面控制器pageControl
        [self.view addSubview:self.imagePageControl];
    }
}

/**
 视频引导页
 
 @param videoName 视频名称
 @param videoSuffix 视频后缀
 */
- (void)buildWithVideoName:(NSString *)videoName videoSuffix:(NSString *)videoSuffix {
    self.guideType = GuidePageTypeVideo;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 四舍五入,保证pageControl状态跟随手指滑动及时刷新
    [self.imagePageControl setCurrentPage:(int)((scrollView.contentOffset.x / scrollView.frame.size.width) + 0.5f)];
    
    if ((int)(scrollView.contentOffset.x) % (int)kScreenWidth == 0) {
        if (scrollView.contentOffset.x >= kScreenWidth*(self.imageArray.count-1)) {
            if (self.startButton.hidden == YES) {
                self.startButton.hidden = NO;
            }
        } else if (scrollView.contentOffset.x < kScreenWidth*(self.imageArray.count-1)) {
            if (self.startButton.hidden == NO) {
                self.startButton.hidden = YES;
            }
        }
    } else {
        if (self.startButton.hidden == NO && scrollView.contentOffset.x < kScreenWidth*(self.imageArray.count-1)) {
            self.startButton.hidden = YES;
        }
    }
    
    if (self.isSlideThroughApp) {
        if (scrollView.contentOffset.x > kScreenWidth+1) {
            // 只让执行一次
            self.isSlideThroughApp = !self.isSlideThroughApp;
            [self finishGuide];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 不是动态图片引导页就return
    if (self.guideType == GuidePageTypePicture || self.guideType == GuidePageTypeVideo) {
        return ;
    }
    
    NSInteger page = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);
    
    if (page != self.page) { // 如果没有彻底离开当前界面，就不重新播放gif
        // 设置当前页的动画
        FLAnimatedImageView *imageView = [self.view viewWithTag:TAG+page];
        
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:self.imageArray[page] ofType:nil]];
        FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:url]];
        imageView.animatedImage = animatedImage;
        
        // 重置其他页的动画
        for (int i = 0; i < self.imageArray.count; i++) {
            if (i != page) {
                FLAnimatedImageView *imageView = [self.view viewWithTag:TAG+i];
                NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:self.imageArray[i] ofType:nil]];
                FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:url]];
                imageView.image = animatedImage.posterImage;
            }
        }
    }
    
    self.page = page;
}

#pragma mark - 按钮点击
- (void)skipButtonClick {
    [self finishGuide];
}

- (void)startButtonClick {
    [self finishGuide];
}

- (void)moviewButtonClick {
    [self finishGuide];
}

#pragma mark - 结束
- (void)finishGuide {
    [kUserDefaults setBool:YES forKey:GuidancePage];
    [kUserDefaults synchronize];
    // 显示电池栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    // 回调
    !self.guideBlock ? : self.guideBlock();
}

#pragma mark - NSObject
- (UIButton *)skipButton {
    if (!_skipButton) {
        _skipButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth*0.75f, kScreenWidth*0.1f, kAutoCs(70), kAutoCs(30))];
        [_skipButton setTitle:@"跳过" forState:UIControlStateNormal];
        [_skipButton.titleLabel setFont:UIFontWithAutoSize(14)];
        [_skipButton setBackgroundColor:[UIColor grayColor]];
        [_skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_skipButton.layer setCornerRadius:(_skipButton.frame.size.height * 0.5f)];
        [_skipButton addTarget:self action:@selector(skipButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipButton;
}

- (UIButton *)startButton {
    if (!_startButton) {
        _startButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth*0.3f, kScreenHeight*0.8f, kScreenWidth*0.4f, kScreenHeight*0.08f)];
        [_startButton setTitle:@"开始体验" forState:UIControlStateNormal];
        [_startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_startButton.titleLabel setFont:UIFontWithAutoSize(20)];
        [_startButton setBackgroundColor:[UIColor grayColor]];
        [_startButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_startButton addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startButton;
}

- (UIPageControl *)imagePageControl {
    if (!_imagePageControl) {
        _imagePageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(kScreenWidth*0.0f, kScreenHeight*0.9f, kScreenWidth*1.0f, kScreenHeight*0.1f)];
        _imagePageControl.currentPage = 0;
        _imagePageControl.numberOfPages = self.imageArray.count;
        _imagePageControl.pageIndicatorTintColor = [UIColor grayColor];
        _imagePageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    }
    return _imagePageControl;
}

/**
 高效的gif
 Usage:
 NSURL *imgUrl = [NSURL URLWithString:wholeGM.rewardGif];
 self.animatedImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:imgUrl]];
 /// 动画播放一次
 self.animatedImage.loopCount = 1;
 /// 动画播放完成回调
 ThisWeak(weakSelf);
 self.animatedImageView.loopCompletionBlock = ^(NSUInteger loopCountRemaining) {
 if (loopCountRemaining == 0) {
 
 }
 };
 
 @return animatedImageView
 */
- (FLAnimatedImageView *)animatedImageView {
    if (!_animatedImageView) {
        _animatedImageView = [[FLAnimatedImageView alloc] init];
    }
    return _animatedImageView;
}

@end
