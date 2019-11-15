//
//  MTGOfferWallViewController.m
//  MTGSDKSample
//
//  Created by yujinping on 16/11/7.
//  Copyright © 2016年 Mobvista. All rights reserved.
//

#import "MTGOfferWallViewController.h"
#import <MTGSDKOfferWall/MTGOfferWallAdManager.h>


#define KOfferWallUnitID ([[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MTGTestMode"] boolValue])? @"1624":@"21320"//测试:线上

@interface MTGOfferWallViewController ()<MTGOfferWallAdLoadDelegate,MTGOfferWallAdShowDelegate,MTGOfferWallQueryRewardsDelegate>

//Demo Offer Wall View
@property (nonatomic, strong) UITextView *textView;

//Log Label
@property (nonatomic, strong) UILabel *logLabel;

@property (nonatomic, strong)MTGOfferWallAdManager *offerWallAdManager;

@end

@implementation MTGOfferWallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = customWhiteColor;
    
    [self createOfferWallView];
    [self createDemoButtons];
    [self createLogLabel];
}


- (void)createOfferWallView
{
    
}


- (void)createDemoButtons
{
    //Create offer wall ad demo buttons
    UIButton *initAdManagerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight*5, viewWidth, buttonHeight)];
    initAdManagerButton.backgroundColor = customGray1Color;
    [initAdManagerButton setTitle:@"Init AdManager" forState:UIControlStateNormal];
    initAdManagerButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [initAdManagerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [initAdManagerButton addTarget:self action:@selector(initAdManagerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:initAdManagerButton];
    
    UIButton *loadOfferWallButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight*4, viewWidth, buttonHeight)];
    loadOfferWallButton.backgroundColor = customGray2Color;
    [loadOfferWallButton setTitle:@"Load Offer Wall" forState:UIControlStateNormal];
    loadOfferWallButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [loadOfferWallButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loadOfferWallButton addTarget:self action:@selector(loadOfferWallButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadOfferWallButton];
    
    UIButton *showOfferWallButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight*3, viewWidth, buttonHeight)];
    showOfferWallButton.backgroundColor = customGray3Color;
    [showOfferWallButton setTitle:@"Show Offer Wall" forState:UIControlStateNormal];
    showOfferWallButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [showOfferWallButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [showOfferWallButton addTarget:self action:@selector(showOfferWallButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showOfferWallButton];

    UIButton *queryRewardButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight*2, viewWidth, buttonHeight)];
    queryRewardButton.backgroundColor = customGray4Color;
    [queryRewardButton setTitle:@"Query Reward" forState:UIControlStateNormal];
    queryRewardButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [queryRewardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [queryRewardButton addTarget:self action:@selector(queryRewardButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:queryRewardButton];

    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight, viewWidth, buttonHeight)];
    backButton.backgroundColor = ColorFromRGB(94, 222, 211);
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}


- (void)createLogLabel
{
    //Create log label to help you understand the demo
    self.logLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, viewHeight - buttonHeight*5-40, viewWidth, 40)];
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
    if (!_offerWallAdManager) {
        _offerWallAdManager = [[MTGOfferWallAdManager alloc]initWithUnitID:KOfferWallUnitID userID:@"123456" adCategory:0];

        [_offerWallAdManager setAlertTipsWhenVideoClosed:@"停止播放不会增加积分哦" leftButtonTitle:@"关闭" rightButtonTitle:@"继续播放"];
        
        [self log:@"MTGOfferWallAdManager init"];

    }
}

- (IBAction)loadOfferWallButtonAction:(id)sender
{
    if (!_offerWallAdManager) {
        [self initAdManagerButtonAction:nil];
    }
    [_offerWallAdManager loadWithDelegate:self];
}

- (IBAction)showOfferWallButtonAction:(id)sender
{
    if (!_offerWallAdManager) {
        [self initAdManagerButtonAction:nil];
    }
    [_offerWallAdManager showWithDelegate:self presentingViewController:self];
}

- (IBAction)queryRewardButtonAction:(id)sender
{
    if (!_offerWallAdManager) {
        [self initAdManagerButtonAction:nil];
    }
    [_offerWallAdManager queryRewardsWithDelegate:self];
}

#pragma mark - Utility

- (void)log:(NSString *)logString
{
    NSLog(@"%@", logString);
    self.logLabel.textColor = customWhiteColor;
    self.logLabel.text = [NSString stringWithFormat:@"%@%@", logStringHeader, logString];
}


#pragma mark loadDelegate

- (void) onOfferwallLoadSuccess:(MTGOfferWallAdManager *)adManager{
    
    [self log:NSStringFromSelector(_cmd)];
}

- (void) onOfferwallLoadFail:(nonnull NSError *)error adManager:(MTGOfferWallAdManager * _Nonnull)adManager{

    [self log:NSStringFromSelector(_cmd)];
}

#pragma mark showDelegate
- (void) offerwallShowSuccess:(MTGOfferWallAdManager *)adManager{

    [self log:NSStringFromSelector(_cmd)];
}

- (void) offerwallShowFail:(nonnull NSError *)error adManager:(MTGOfferWallAdManager * _Nonnull)adManager{

    [self log:NSStringFromSelector(_cmd)];
}

- (void) onOfferwallClosed:(MTGOfferWallAdManager *)adManager{

    [self log:NSStringFromSelector(_cmd)];
}

- (void) onOfferwallCreditsEarnedImmediately:(nullable NSArray *)rewards adManager:(MTGOfferWallAdManager * _Nonnull)adManager{
    
    NSString *hasReward = @"No Rewards";
    
    if (rewards.count) {
        hasReward = @"Get New Rewards";
    }
    NSString *logStr = [NSString stringWithFormat:@"%@  %@",NSStringFromSelector(_cmd),hasReward];
    [self log:logStr];

}


-(void)onOfferwallCreditsEarned:(NSArray *)rewards adManager:(MTGOfferWallAdManager * _Nonnull)adManager{
    
    NSString *hasReward = @"No Rewards";

    if (rewards.count) {
        hasReward = @"Get New Rewards";
    }
    NSString *logStr = [NSString stringWithFormat:@"%@  %@",NSStringFromSelector(_cmd),hasReward];
    [self log:logStr];
}

- (void) onOfferwallAdClick:(MTGOfferWallAdManager *)adManager{

   [self log:NSStringFromSelector(_cmd)];
}

@end
