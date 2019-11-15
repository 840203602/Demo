//
//  MTGInterActiveViewController.m
//  MTGSDKSample
//
//  Created by CharkZhang on 2018/5/17.
//  Copyright © 2018年 Mintegral. All rights reserved.
//

#import "MTGInterActiveViewController.h"

#import <MTGSDKInterActive/MTGInterActiveManager.h>

#define KInterActiveUnitID @"146897"


@interface MTGInterActiveViewController ()<MTGInterActiveDelegate>

//Demo InstersActive View
@property (nonatomic, strong) UITextView *textView;

//Log Label
@property (nonatomic, strong) UILabel *logLabel;

@property (nonatomic, strong) UIView *entryView;


@property (nonatomic, strong) MTGInterActiveManager *instersActiveAdManager;

@end

@implementation MTGInterActiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createDemoButtons];
    [self createLogLabel];
}


- (void)createDemoButtons
{
    //Create InstersActive ad demo buttons
    UIButton *initAdManagerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight*5, viewWidth, buttonHeight)];
    initAdManagerButton.backgroundColor = customGray1Color;
    [initAdManagerButton setTitle:@"Init AdManager" forState:UIControlStateNormal];
    initAdManagerButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [initAdManagerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [initAdManagerButton addTarget:self action:@selector(initAdManagerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:initAdManagerButton];
    
    UIButton *loadInstersActiveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight*4, viewWidth, buttonHeight)];
    loadInstersActiveButton.backgroundColor = customGray2Color;
    [loadInstersActiveButton setTitle:@"Load Ad" forState:UIControlStateNormal];
    loadInstersActiveButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [loadInstersActiveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loadInstersActiveButton addTarget:self action:@selector(loadInstersActiveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadInstersActiveButton];

    UIButton *showInstersActiveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight*3, viewWidth, buttonHeight)];
    showInstersActiveButton.backgroundColor = customGray3Color;
    [showInstersActiveButton setTitle:@"Show Ad" forState:UIControlStateNormal];
    showInstersActiveButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [showInstersActiveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [showInstersActiveButton addTarget:self action:@selector(showInstersActiveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showInstersActiveButton];
    
    UIButton *showWithoutLoadButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight * 2, viewWidth, buttonHeight)];
    showWithoutLoadButton.backgroundColor = customGray4Color;
    [showWithoutLoadButton setTitle:@"show without load" forState:UIControlStateNormal];
    showWithoutLoadButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [showWithoutLoadButton addTarget:self action:@selector(showInstersActiveWithoutLoadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showWithoutLoadButton];

    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight, viewWidth, buttonHeight)];
    backButton.backgroundColor = ColorFromRGB(127, 141, 226);
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    self.entryView = [[UIView alloc] initWithFrame:CGRectMake((viewWidth-60)/2.0, (viewHeight - buttonHeight*5-40-60)/2.0, 60, 60)];
    [self.view addSubview:self.entryView];
    self.entryView.backgroundColor = [UIColor lightGrayColor];

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


- (IBAction)initAdManagerButtonAction:(id)sender
{
    if (!_instersActiveAdManager) {
        _instersActiveAdManager = [[MTGInterActiveManager alloc] initWithUnitID:KInterActiveUnitID withViewController:self ];
        _instersActiveAdManager.delegate = self;
        [self log:@"MTGInterActiveManager init"];
    }
}

- (IBAction)loadInstersActiveButtonAction:(id)sender
{
    if (!_instersActiveAdManager) {
        _instersActiveAdManager = [[MTGInterActiveManager alloc] initWithUnitID:KInterActiveUnitID withViewController:self ];
        _instersActiveAdManager.delegate = self;
    }
    [_instersActiveAdManager loadAd];
}

- (void)loadRemoteIconButtonAction
{
    if (!_instersActiveAdManager) {
        _instersActiveAdManager = [[MTGInterActiveManager alloc] initWithUnitID:KInterActiveUnitID withViewController:self ];
        _instersActiveAdManager.delegate = self;
    }
    [_instersActiveAdManager loadRemoteIconToView:self.entryView withDefaultIconImage:[UIImage imageNamed:@"star-lighted"]];
}

- (IBAction)showInstersActiveButtonAction:(id)sender
{
    if (!_instersActiveAdManager) {
        _instersActiveAdManager = [[MTGInterActiveManager alloc] initWithUnitID:KInterActiveUnitID withViewController:self ];
        _instersActiveAdManager.delegate = self;
    }

    [_instersActiveAdManager showAd];
}

- (IBAction)showInstersActiveWithoutLoadButtonAction:(id)sender
{
    if (!_instersActiveAdManager) {
        _instersActiveAdManager = [[MTGInterActiveManager alloc] initWithUnitID:KInterActiveUnitID withViewController:self ];
        _instersActiveAdManager.delegate = self;
    }
    MTGInterActiveStatus status = [_instersActiveAdManager readyStatus];
    if (status == MTGInterActiveStatusMaterialLoading || status == MTGInterActiveStatusMaterialCompleted) {

        [_instersActiveAdManager showAd];
    }
}

#pragma mark - Utility

- (void)log:(NSString *)logString
{
    NSLog(@"%@", logString);
    self.logLabel.textColor = [UIColor whiteColor];
    self.logLabel.text = [NSString stringWithFormat:@"%@%@", logStringHeader, logString];
}


#pragma mark - instersActive Delegate Methods

- (void) onInterActiveLoadSuccess:(MTGInterActiveResourceType)resourceType adManager:(MTGInterActiveManager *_Nonnull)adManager{

    [self log:[NSString stringWithFormat:@"rType:%d %@",(int)resourceType,NSStringFromSelector(_cmd)]];
    
    //you can load entrance icon here, or set it when got "onInterActiveMaterialloadSuccess: adManager:"
//    [self loadRemoteIconButtonAction];
}

- (void) onInterActiveMaterialloadSuccess:(MTGInterActiveResourceType)resourceType adManager:(MTGInterActiveManager *_Nonnull)adManager{
    [self log:[NSString stringWithFormat:@"rType:%d %@",(int)resourceType,NSStringFromSelector(_cmd)]];
    //you can load entrance icon here, or set it when got "onInterActiveLoadSuccess: adManager:"
    [self loadRemoteIconButtonAction];
}

- (void) onInterActiveLoadFailed:(nonnull NSError *)error adManager:(MTGInterActiveManager *_Nonnull)adManager{
    [self log:error.description];
}

- (void) onInterActiveShowSuccess:(MTGInterActiveManager *_Nonnull)adManager{
    [self log:NSStringFromSelector(_cmd)];
}

- (void) onInterActiveShowFailed:(nonnull NSError *)error adManager:(MTGInterActiveManager *_Nonnull)adManager{
    [self log:NSStringFromSelector(_cmd)];
}

- (void) onInterActiveAdClick:(MTGInterActiveManager *_Nonnull)adManager{
    [self log:NSStringFromSelector(_cmd)];
}

- (void) onInterActiveAdDismissed:(MTGInterActiveManager *_Nonnull)adManager{
    [self log:NSStringFromSelector(_cmd)];
    
    //We recommend to load ad again after closing Interactive ads.
    [_instersActiveAdManager loadAd];
}

- (void)onInterActiveAdManager:(MTGInterActiveManager *_Nonnull)adManager playingComplete:(BOOL)completeOrNot {
    // playable finished playing or not.
    [self log:[NSString stringWithFormat:@"finished playing : %@", @(completeOrNot)]];
}


@end
