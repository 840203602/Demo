//
//  MTGInsterstialViewController.m
//  MTGSDKSample
//
//  Created by yujinping on 16/11/7.
//  Copyright © 2016年 Mobvista. All rights reserved.
//

#import "MTGInsterstialViewController.h"
#import <MTGSDKInterstitial/MTGInterstitialAdManager.h>

#define KInterstitialUnitID @"146896"

@interface MTGInsterstialViewController ()<MTGInterstitialAdLoadDelegate,MTGInterstitialAdShowDelegate>

//Demo Insterstial View
@property (nonatomic, strong) UITextView *textView;

//Log Label
@property (nonatomic, strong) UILabel *logLabel;


@property (nonatomic, strong) MTGInterstitialAdManager *interstitialAdManager;

@end

@implementation MTGInsterstialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = customWhiteColor;
    
    [self createInsterstialView];
    [self createDemoButtons];
    [self createLogLabel];
}


- (void)createInsterstialView
{
    
}


- (void)createDemoButtons
{
    //Create Insterstial ad demo buttons
    UIButton *initAdManagerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight*4, viewWidth, buttonHeight)];
    initAdManagerButton.backgroundColor = customGray1Color;
    [initAdManagerButton setTitle:@"Init AdManager" forState:UIControlStateNormal];
    initAdManagerButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [initAdManagerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [initAdManagerButton addTarget:self action:@selector(initAdManagerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:initAdManagerButton];
    
    UIButton *loadInsterstialButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight*3, viewWidth, buttonHeight)];
    loadInsterstialButton.backgroundColor = customGray2Color;
    [loadInsterstialButton setTitle:@"Load Insterstial" forState:UIControlStateNormal];
    loadInsterstialButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [loadInsterstialButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loadInsterstialButton addTarget:self action:@selector(loadInsterstialButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadInsterstialButton];
    
    UIButton *showInsterstialButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight*2, viewWidth, buttonHeight)];
    showInsterstialButton.backgroundColor = customGray3Color;
    [showInsterstialButton setTitle:@"Show Insterstial" forState:UIControlStateNormal];
    showInsterstialButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [showInsterstialButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [showInsterstialButton addTarget:self action:@selector(showInsterstialButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showInsterstialButton];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight, viewWidth, buttonHeight)];
    backButton.backgroundColor = ColorFromRGB(98, 172, 227);
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
    self.logLabel.textColor = customWhiteColor;
    self.logLabel.text = logStringHeader;
    self.logLabel.adjustsFontSizeToFitWidth = YES;
    self.logLabel.minimumScaleFactor = 0.8;
    [self.view addSubview:self.logLabel];
}


- (IBAction)initAdManagerButtonAction:(id)sender
{
    if (!_interstitialAdManager) {
        _interstitialAdManager = [[MTGInterstitialAdManager alloc] initWithUnitID:KInterstitialUnitID adCategory:0];
        
        [self log:@"MTGInterstitialAdManager init"];

    }
}

- (IBAction)loadInsterstialButtonAction:(id)sender
{
    if (!_interstitialAdManager) {
        _interstitialAdManager = [[MTGInterstitialAdManager alloc] initWithUnitID:KInterstitialUnitID adCategory:0];
    }
        [_interstitialAdManager loadWithDelegate:self];
}

- (IBAction)showInsterstialButtonAction:(id)sender
{
    if (!_interstitialAdManager) {
        _interstitialAdManager = [[MTGInterstitialAdManager alloc] initWithUnitID:KInterstitialUnitID adCategory:0];
    }

    [_interstitialAdManager showWithDelegate:self presentingViewController:self];
}


#pragma mark - Utility

- (void)log:(NSString *)logString
{
    NSLog(@"%@", logString);
    self.logLabel.textColor = customWhiteColor;
    self.logLabel.text = [NSString stringWithFormat:@"%@%@", logStringHeader, logString];
}


#pragma mark - Interstitial Delegate Methods
- (void) onInterstitialLoadSuccess:(MTGInterstitialAdManager *)adManager{

    [self log:NSStringFromSelector(_cmd)];
}

- (void) onInterstitialLoadFail:(nonnull NSError *)error adManager:(MTGInterstitialAdManager * _Nonnull)adManager{
    
    [self log:NSStringFromSelector(_cmd)];
}

- (void) onInterstitialShowSuccess:(MTGInterstitialAdManager *)adManager{
    
    [self log:NSStringFromSelector(_cmd)];
}

- (void) onInterstitialShowFail:(nonnull NSError *)error adManager:(MTGInterstitialAdManager * _Nonnull)adManager{
    
    [self log:NSStringFromSelector(_cmd)];
}

- (void) onInterstitialClosed:(MTGInterstitialAdManager *)adManager{
    
    [self log:NSStringFromSelector(_cmd)];
}

- (void) onInterstitialAdClick:(MTGInterstitialAdManager *)adManager{
    
    [self log:NSStringFromSelector(_cmd)];
}


@end
