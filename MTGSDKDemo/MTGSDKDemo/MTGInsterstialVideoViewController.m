//
//  MTGInsterstialVideoViewController.m
//  MTGSDKSample
//
//  Created by CharkZhang on 2018/4/8.
//  Copyright © 2018年 Mobvista. All rights reserved.
//

#import "MTGInsterstialVideoViewController.h"
#import <MTGSDKInterstitialVideo/MTGInterstitialVideoAdManager.h>




#define KInterstitialVideoUnitID @"146894"


@interface MTGInsterstialVideoViewController ()<MTGInterstitialVideoDelegate>

//Demo InsterstialVideo View
@property (nonatomic, strong) UITextView *textView;

//Log Label
@property (nonatomic, strong) UILabel *logLabel;


@property (nonatomic,strong)  MTGInterstitialVideoAdManager *ivAdManager;

@end

@implementation MTGInsterstialVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createInsterstialView];
    [self createDemoButtons];
    [self createLogLabel];
}


- (void)createInsterstialView
{
    
}

- (void)createDemoButtons
{
    //Create InsterstialVideo ad demo buttons
    UIButton *initAdManagerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight*4, viewWidth, buttonHeight)];
    initAdManagerButton.backgroundColor = customGray1Color;
    [initAdManagerButton setTitle:@"Init IV AdManager" forState:UIControlStateNormal];
    initAdManagerButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [initAdManagerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [initAdManagerButton addTarget:self action:@selector(initAdManagerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:initAdManagerButton];
    
    UIButton *loadInsterstialButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight*3, viewWidth, buttonHeight)];
    loadInsterstialButton.backgroundColor = customGray2Color;
    [loadInsterstialButton setTitle:@"Load IV" forState:UIControlStateNormal];
    loadInsterstialButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [loadInsterstialButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loadInsterstialButton addTarget:self action:@selector(loadInsterstialButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadInsterstialButton];
    
    UIButton *showInsterstialButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight*2, viewWidth, buttonHeight)];
    showInsterstialButton.backgroundColor = customGray3Color;
    [showInsterstialButton setTitle:@"Show IV" forState:UIControlStateNormal];
    showInsterstialButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [showInsterstialButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [showInsterstialButton addTarget:self action:@selector(showInsterstialButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showInsterstialButton];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight, viewWidth, buttonHeight)];
    backButton.backgroundColor = ColorFromRGB(146, 174, 254);
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}


- (void)createLogLabel
{
    //Create log label to help you understand the demo
    self.logLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, viewHeight - buttonHeight*4-40, viewWidth, 40)];
    self.logLabel.backgroundColor = ColorFromRGBALPHA(0, 0, 0, 0.5);
    self.logLabel.font = [UIFont systemFontOfSize:12];
    self.logLabel.textColor = [UIColor whiteColor];
    self.logLabel.text = logStringHeader;
    self.logLabel.adjustsFontSizeToFitWidth = YES;
    self.logLabel.minimumScaleFactor = 0.8;
    [self.view addSubview:self.logLabel];
}


- (IBAction)initAdManagerButtonAction:(id)sender
{
    if (!_ivAdManager) {
        _ivAdManager = [[MTGInterstitialVideoAdManager alloc] initWithUnitID:KInterstitialVideoUnitID delegate:self];
        _ivAdManager.delegate = self;
        [self log:@"MTGInterstitialVideoAdManager init"];

    }
}

- (IBAction)loadInsterstialButtonAction:(id)sender
{
    if (!_ivAdManager) {
        _ivAdManager = [[MTGInterstitialVideoAdManager alloc] initWithUnitID:KInterstitialVideoUnitID delegate:self];
        _ivAdManager.delegate = self;
        
    }
        [_ivAdManager loadAd];
}

- (IBAction)showInsterstialButtonAction:(id)sender
{
    if (!_ivAdManager) {
        _ivAdManager = [[MTGInterstitialVideoAdManager alloc] initWithUnitID:KInterstitialVideoUnitID delegate:self];
        _ivAdManager.delegate = self;
        
    }

    if ([_ivAdManager isVideoReadyToPlay:KInterstitialVideoUnitID]) {
        [self log:@"Show interstitial video ad"];
        [_ivAdManager showFromViewController:self];
    }
    else {
        [self log:[NSString stringWithFormat:@"No ad to show"]];
    }
}


#pragma mark - Utility

- (void)log:(NSString *)logString
{
    NSLog(@"%@", logString);
    self.logLabel.textColor = [UIColor whiteColor];
    self.logLabel.text = [NSString stringWithFormat:@"%@%@", logStringHeader, logString];
}


#pragma mark - Interstitial Delegate Methods

- (void) onInterstitialAdLoadSuccess:(MTGInterstitialVideoAdManager *_Nonnull)adManager{
    [self log:NSStringFromSelector(_cmd)];    
}

- (void) onInterstitialVideoLoadSuccess:(MTGInterstitialVideoAdManager *_Nonnull)adManager{
    [self log:NSStringFromSelector(_cmd)];

}

- (void) onInterstitialVideoLoadFail:(nonnull NSError *)error adManager:(MTGInterstitialVideoAdManager *_Nonnull)adManager;{
    [self log:[NSStringFromSelector(_cmd) stringByAppendingString:error.description]];

}

- (void) onInterstitialVideoShowSuccess:(MTGInterstitialVideoAdManager *_Nonnull)adManager{
    [self log:NSStringFromSelector(_cmd)];

}

- (void) onInterstitialVideoShowFail:(nonnull NSError *)error adManager:(MTGInterstitialVideoAdManager *_Nonnull)adManager{
    [self log:[NSStringFromSelector(_cmd) stringByAppendingString:error.description]];

}

- (void) onInterstitialVideoAdClick:(MTGInterstitialVideoAdManager *_Nonnull)adManager{
    [self log:NSStringFromSelector(_cmd)];

}

- (void)onInterstitialVideoAdDismissedWithConverted:(BOOL)converted adManager:(MTGInterstitialVideoAdManager *_Nonnull)adManager{
    [self log:NSStringFromSelector(_cmd)];

}

- (void) onInterstitialVideoAdDidClosed:(MTGInterstitialVideoAdManager *_Nonnull)adManager{

    [self log:NSStringFromSelector(_cmd)];
}

- (void) onInterstitialVideoPlayCompleted:(MTGInterstitialVideoAdManager *_Nonnull)adManager {
    [self log:NSStringFromSelector(_cmd)];
}

- (void) onInterstitialVideoEndCardShowSuccess:(MTGInterstitialVideoAdManager *_Nonnull)adManager {
    [self log:NSStringFromSelector(_cmd)];
}



@end
