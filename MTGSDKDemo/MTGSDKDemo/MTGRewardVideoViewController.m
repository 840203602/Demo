//  MTGRewardVideoViewController.m
//  MTGSDKDemo
//
//  Created by yujinping on 16/5/12.
//  Copyright © 2016年 Mobvista. All rights reserved.
//

#import "MTGRewardVideoViewController.h"
#import <MTGSDKReward/MTGRewardAdManager.h>
#import <MTGSDK/MTGSDK.h>


#define KRewardUnitID @"146892"
#define KRewardID @"8794"

@interface MTGRewardVideoViewController ()
<MTGRewardAdLoadDelegate,MTGRewardAdShowDelegate>

//Demo Reward Video View
@property (nonatomic, strong) UITextView *textView;

//Log Label
@property (nonatomic, strong) UILabel *logLabel;

@end

@implementation MTGRewardVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = customWhiteColor;
    
    [self createRewardVideoView];
    [self createDemoButtons];
    [self createLogLabel];
}





















#pragma mark - Reward Video Actions

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Init MTGRewardAdManager
- (IBAction)initAdManagerButtonAction:(id)sender
{
    [self log:@"MTGRewardAdManager init"];

    [MTGRewardAdManager sharedInstance];
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Load Video
- (IBAction)loadVideoButtonAction:(id)sender
{
    [self log:@"Reward video is loading"];
    
    [[MTGRewardAdManager sharedInstance] loadVideo:KRewardUnitID delegate:self];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Show Video
- (IBAction)showVideoButtonAction:(id)sender
{
    //Check isReady before you show a reward video
    if ([[MTGRewardAdManager sharedInstance] isVideoReadyToPlay:KRewardUnitID]) {
        [self log:@"Show reward video ad"];
        
        [[MTGRewardAdManager sharedInstance] showVideo:KRewardUnitID withRewardId:KRewardID userId:@"" delegate:self viewController:self];
    }
    else {
        //We will help you to load automatically when isReady is NO
        
        [self log:[NSString stringWithFormat:@"No ad to show"]];
    }
}

















#pragma mark - MTGRewardAdLoadDelegate Delegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)onAdLoadSuccess:(NSString *)unitId
{
    [self log:[NSString stringWithFormat:@"unitId = %@, load success, but video resouce not ready", unitId]];

}

//Load Reward Video Ad Success Delegate
- (void)onVideoAdLoadSuccess:(NSString *)unitId
{
    [self log:[NSString stringWithFormat:@"unitId = %@, load success, and video resource is ready to show", unitId]];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Load Reward Video Ad Failed Delegate
- (void)onVideoAdLoadFailed:(NSString *)unitId error:(NSError *)error
{
    //Here, suggest to call the load once
    
    [self log:[NSString stringWithFormat:@"unitId = %@, load failed, error: %@", unitId,  error]];
}





















#pragma mark - MTGRewardAdShowDelegate Delegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Show Reward Video Ad Success Delegate
- (void)onVideoAdShowSuccess:(NSString *)unitId
{
    [self log:[NSString stringWithFormat:@"unitId = %@, show success", unitId]];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Show Reward Video Ad Failed Delegate
- (void)onVideoAdShowFailed:(NSString *)unitId withError:(NSError *)error
{
    [self log:[NSString stringWithFormat:@"unitId = %@, show failed, error: %@", unitId, error]];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//About RewardInfo Delegate
- (void)onVideoAdDismissed:(NSString *)unitId withConverted:(BOOL)converted withRewardInfo:(MTGRewardAdInfo *)rewardInfo
{
    if (rewardInfo) {
        [self log:[NSString stringWithFormat:@"unitId = %@, reward : name = %@, amount = %ld", unitId, rewardInfo.rewardName, (long)rewardInfo.rewardAmount]];
    }
    else {
        [self log:[NSString stringWithFormat:@"unitId = %@, there is no reward to you", unitId]];
    }
}

- (void)onVideoAdDidClosed:(nullable NSString *)unitId{
    
    [self log:[NSString stringWithFormat:@"unitId = %@, the ad did closed", unitId]];
}

- (void)onVideoAdClicked:(nullable NSString *)unitId{
    [self log:[NSString stringWithFormat:@"unitId = %@, video ad clicked.", unitId]];
}

- (void) onVideoPlayCompleted:(nullable NSString *)unitId {
    [self log:[NSString stringWithFormat:@"unitId = %@, video play completed.", unitId]];
}

- (void) onVideoEndCardShowSuccess:(nullable NSString *)unitId {
    [self log:[NSString stringWithFormat:@"unitId = %@, endcard show success.", unitId]];
}






















#pragma mark - Create Views

- (void)createRewardVideoView
{
    self.textView = [[UITextView alloc] init];
    self.textView.frame = CGRectMake(0, 0, viewWidth, viewHeight - buttonHeight * 5);
    self.textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.text = @"Integration Guide:\n\n1、Called the load when initialize the appDelegate, later called show when you needed\n   [[MTGRewardAdManager sharedInstance] loadVideo:KRewardUnitID delegate:self];\n\n2、Called show when needed, Check isReady before you show a reward video.We will load automatically for you after show. So you don't need load again in your code.\n    if ([[MTGRewardAdManager sharedInstance] isVideoReadyToPlay:KRewardUnitID]) {\n       [[MTGRewardAdManager sharedInstance] showVideo:KRewardUnitID withRewardId:KRewardID delegate:self viewController:self];\n   }\n";
    self.textView.textColor = [UIColor lightGrayColor];
    self.textView.font = [UIFont systemFontOfSize:14];
    self.textView.editable = NO;
    [self.view addSubview:self.textView];
}

- (void)createDemoButtons
{
    //Create reward video ad demo buttons
    UIButton *initAdManagerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight*4, viewWidth, buttonHeight)];
    initAdManagerButton.backgroundColor = customGray1Color;
    [initAdManagerButton setTitle:@"Init AdManager" forState:UIControlStateNormal];
    initAdManagerButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [initAdManagerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [initAdManagerButton addTarget:self action:@selector(initAdManagerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:initAdManagerButton];
    
    UIButton *loadVideoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight*3, viewWidth, buttonHeight)];
    loadVideoButton.backgroundColor = customGray2Color;
    [loadVideoButton setTitle:@"Load Video" forState:UIControlStateNormal];
    loadVideoButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [loadVideoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loadVideoButton addTarget:self action:@selector(loadVideoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadVideoButton];
    
    UIButton *showVideoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight*2, viewWidth, buttonHeight)];
    showVideoButton.backgroundColor = customGray3Color;
    [showVideoButton setTitle:@"Show Video" forState:UIControlStateNormal];
    showVideoButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [showVideoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [showVideoButton addTarget:self action:@selector(showVideoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showVideoButton];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight, viewWidth, buttonHeight)];
    backButton.backgroundColor = ColorFromRGB(120, 227, 195);
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

























#pragma mark - Utility

- (void)log:(NSString *)logString
{
    NSLog(@"%@", logString);
    self.logLabel.textColor = customWhiteColor;
    self.logLabel.text = [NSString stringWithFormat:@"%@%@", logStringHeader, logString];
}










@end
