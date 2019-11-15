//
//  MTGBidInsterstialVideoViewController.m
//  MTGSDKDemo
//
//  Created by Harry on 2019/5/30.
//  Copyright © 2019 Mobvista. All rights reserved.
//

#import "MTGBidInsterstialVideoViewController.h"
#import "MTGInsterstialVideoViewController.h"
#import <MTGSDKInterstitialVideo/MTGBidInterstitialVideoAdManager.h>
#import <MTGSDKBidding/MTGBiddingRequest.h>




#define KInterstitialVideoUnitID @"146894"


@interface MTGBidInsterstialVideoViewController ()<MTGBidInterstitialVideoDelegate>

//Demo InsterstialVideo View
@property (nonatomic, strong) UITextView *textView;

//Log Label
@property (nonatomic, strong) UILabel *logLabel;


@property (nonatomic,strong)  MTGBidInterstitialVideoAdManager *ivAdManager;

@property (nonatomic, copy) NSString *bidToken;

@end

@implementation MTGBidInsterstialVideoViewController

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
    UIButton *bidButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight*5, viewWidth, buttonHeight)];
    bidButton.backgroundColor = customGray1Color;
    [bidButton setTitle:@"Request Bid Token" forState:UIControlStateNormal];
    bidButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [bidButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bidButton addTarget:self action:@selector(bidButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bidButton];
    
    UIButton *initAdManagerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight*4, viewWidth, buttonHeight)];
    initAdManagerButton.backgroundColor = customGray2Color;
    [initAdManagerButton setTitle:@"Init IV AdManager" forState:UIControlStateNormal];
    initAdManagerButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [initAdManagerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [initAdManagerButton addTarget:self action:@selector(initAdManagerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:initAdManagerButton];
    
    UIButton *loadInsterstialButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight*3, viewWidth, buttonHeight)];
    loadInsterstialButton.backgroundColor = customGray3Color;
    [loadInsterstialButton setTitle:@"Load IV" forState:UIControlStateNormal];
    loadInsterstialButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [loadInsterstialButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loadInsterstialButton addTarget:self action:@selector(loadInsterstialButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadInsterstialButton];
    
    UIButton *showInsterstialButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight*2, viewWidth, buttonHeight)];
    showInsterstialButton.backgroundColor = customGray4Color;
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
    self.logLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, viewHeight - buttonHeight*5-40, viewWidth, 40)];
    self.logLabel.backgroundColor = ColorFromRGBALPHA(0, 0, 0, 0.5);
    self.logLabel.font = [UIFont systemFontOfSize:12];
    self.logLabel.textColor = [UIColor whiteColor];
    self.logLabel.text = logStringHeader;
    self.logLabel.adjustsFontSizeToFitWidth = YES;
    self.logLabel.minimumScaleFactor = 0.8;
    [self.view addSubview:self.logLabel];
}

- (void)bidButtonAction:(UIButton *)btn {
    
    // new bid request method
    MTGBiddingRequestParameter *requestParameter = [[MTGBiddingRequestParameter alloc]initWithUnitId:KInterstitialVideoUnitID basePrice:@(0.1)];
     [MTGBiddingRequest getBidWithRequestParameter:requestParameter completionHandler:^(MTGBiddingResponse * _Nonnull bidResponse) {
         if (bidResponse.success) {
             self.bidToken = bidResponse.bidToken;
             [self log:@"request token success"];
             [bidResponse notifyWin];
         }else{
             NSString *errorMsg = bidResponse.error.description;
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request Bid Failed" message:errorMsg delegate:nil cancelButtonTitle:@"Got" otherButtonTitles:nil];
             [alert show];
             [self log:@"request token failed"];
         }
     }];
    
    /*
     old bid request method
    [MTGBiddingRequest getBidWithUnitId:KInterstitialVideoUnitID basePrice:@(0.1) completionHandler:^(MTGBiddingResponse * _Nonnull bidResponse) {
        
        if (bidResponse.success) {
            self.bidToken = bidResponse.bidToken;
            [self log:@"request bid token success"];
            [bidResponse notifyWin];
        }else{
            NSString *errorMsg = bidResponse.error.description;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request Token Failed" message:errorMsg delegate:nil cancelButtonTitle:@"Got" otherButtonTitles:nil];
            [alert show];
            [self log:@"request bid token failed"];
        }
    }];
     */
}


- (IBAction)initAdManagerButtonAction:(id)sender
{
    if (!_ivAdManager) {
        _ivAdManager = [[MTGBidInterstitialVideoAdManager alloc] initWithUnitID:KInterstitialVideoUnitID delegate:self];
        _ivAdManager.delegate = self;
        [self log:@"MTGBidInterstitialVideoAdManager init"];
        
    }
}

- (IBAction)loadInsterstialButtonAction:(id)sender
{
    if (!_ivAdManager) {
        _ivAdManager = [[MTGBidInterstitialVideoAdManager alloc] initWithUnitID:KInterstitialVideoUnitID delegate:self];
        _ivAdManager.delegate = self;
        
    }
    [_ivAdManager loadAdWithBidToken:self.bidToken];
}

- (IBAction)showInsterstialButtonAction:(id)sender
{
    if (!_ivAdManager) {
        _ivAdManager = [[MTGBidInterstitialVideoAdManager alloc] initWithUnitID:KInterstitialVideoUnitID delegate:self];
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

- (void) onInterstitialAdLoadSuccess:(MTGBidInterstitialVideoAdManager *_Nonnull)adManager{
    [self log:NSStringFromSelector(_cmd)];
}

- (void) onInterstitialVideoLoadSuccess:(MTGBidInterstitialVideoAdManager *_Nonnull)adManager{
    [self log:NSStringFromSelector(_cmd)];
    
}

- (void) onInterstitialVideoLoadFail:(nonnull NSError *)error adManager:(MTGBidInterstitialVideoAdManager *_Nonnull)adManager;{
    [self log:[NSStringFromSelector(_cmd) stringByAppendingString:error.description]];
    
}

- (void) onInterstitialVideoShowSuccess:(MTGBidInterstitialVideoAdManager *_Nonnull)adManager{
    [self log:NSStringFromSelector(_cmd)];
    
}

- (void) onInterstitialVideoShowFail:(nonnull NSError *)error adManager:(MTGBidInterstitialVideoAdManager *_Nonnull)adManager{
    [self log:[NSStringFromSelector(_cmd) stringByAppendingString:error.description]];
    
}

- (void) onInterstitialVideoAdClick:(MTGBidInterstitialVideoAdManager *_Nonnull)adManager{
    [self log:NSStringFromSelector(_cmd)];
    
}

- (void)onInterstitialVideoAdDismissedWithConverted:(BOOL)converted adManager:(MTGBidInterstitialVideoAdManager *_Nonnull)adManager{
    [self log:NSStringFromSelector(_cmd)];
    
}

- (void) onInterstitialVideoAdDidClosed:(MTGBidInterstitialVideoAdManager *_Nonnull)adManager{
    
    [self log:NSStringFromSelector(_cmd)];
}

- (void) onInterstitialVideoPlayCompleted:(MTGBidInterstitialVideoAdManager *_Nonnull)adManager {
    [self log:NSStringFromSelector(_cmd)];
}

- (void) onInterstitialVideoEndCardShowSuccess:(MTGBidInterstitialVideoAdManager *_Nonnull)adManager {
    [self log:NSStringFromSelector(_cmd)];
}



@end

