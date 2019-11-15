//
//  MTGAppWallViewController.m
//  MTGSDKDemo
//
//  Created by Jomy on 15/11/17.
//  Copyright © 2015年 Mobvista. All rights reserved.
//

#import "MTGAppWallViewController.h"
#import <MTGSDK/MTGSDK.h>
#import <MTGSDKAppWall/MTGWallAdManager.h>


#define KAppWallUnitID ([[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MTGTestMode"] boolValue])? @"1668":@"21317"//测试:线上

@interface MTGAppWallViewController ()

//Demo App Wall View
@property (nonatomic, strong) UIView *appWallView;

//Log Label
@property (nonatomic, strong) UILabel *logLabel;

//Ads Data Related
@property (nonatomic, strong) MTGWallAdManager *wallAdManager;

@end

@implementation MTGAppWallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createAppWallView];
    [self createDemoButtons];
    [self createLogLabel];
    
}















#pragma mark - App Wall Actions

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Init MTGWallAdManager
- (IBAction)initAdManagerButtonAction:(id)sender
{
    //clean old App Wall View
    [self createAppWallView];
    
#warning Enter your App Wall UnitID here
    _wallAdManager = [[MTGWallAdManager alloc] initWithUnitID:KAppWallUnitID presentingViewController:self];
    
    [self log:@"MTGWallAdManager init"];

}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Load App Wall Icon to view
- (IBAction)addWallIconButtonAction:(id)sender
{
    [self.wallAdManager loadWallIconToView:self.appWallView withDefaultIconImage:[UIImage imageNamed:@"star-lighted"]];
    
    [self log:@"Icon loaded, you can tap the icon to test"];
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Preload Ads
- (IBAction)preloadAdButtonAction:(id)sender
{
#warning Enter your App Wall UnitID here
    [[MTGSDK sharedInstance] preloadAppWallAdsWithUnitId:KAppWallUnitID];
    NSLog(@"-----%@", KAppWallUnitID);
    
    [self log:@"Preload App Wall Ads"];
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Custom App Wall Style
- (IBAction)changeStyleButtonAction:(id)sender
{
    [self.wallAdManager setAppWallTitle:@"YOYOYO" titleColor:customWhiteColor];
    [self.wallAdManager setAppWallNavBarTintColor:ColorFromRGB(121, 112, 206)];
    
    [self log:@"App wall's title and bar color changed"];
}

















#pragma mark - Create Views

- (void)createAppWallView
{
    if (self.appWallView) {
        [self.appWallView removeFromSuperview];
    }
    
    //this view is to hold app wall icon
    self.appWallView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.appWallView.backgroundColor = customGray2Color;
    self.appWallView.center = CGPointMake(viewWidth/2, (viewHeight - buttonHeight*5-40)/2);
    [self.view addSubview:self.appWallView];
}

- (void)createDemoButtons
{    
    //Create native ad demo buttons
    UIButton *initAdManagerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight*5, viewWidth, buttonHeight)];
    initAdManagerButton.backgroundColor = customGray1Color;
    [initAdManagerButton setTitle:@"Init AdManager" forState:UIControlStateNormal];
    initAdManagerButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [initAdManagerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [initAdManagerButton addTarget:self action:@selector(initAdManagerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:initAdManagerButton];
    
    UIButton *addWallIconButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight*4, viewWidth, buttonHeight)];
    addWallIconButton.backgroundColor = customGray2Color;
    [addWallIconButton setTitle:@"Add wall icon" forState:UIControlStateNormal];
    addWallIconButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [addWallIconButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addWallIconButton addTarget:self action:@selector(addWallIconButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addWallIconButton];
    
    UIButton *preloadAdButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight*3, viewWidth, buttonHeight)];
    preloadAdButton.backgroundColor = customGray3Color;
    [preloadAdButton setTitle:@"Preload Ads" forState:UIControlStateNormal];
    preloadAdButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [preloadAdButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [preloadAdButton addTarget:self action:@selector(preloadAdButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:preloadAdButton];
    
    UIButton *changeStyleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight*2, viewWidth, buttonHeight)];
    changeStyleButton.backgroundColor = customGray4Color;
    [changeStyleButton setTitle:@"Change Wall Style" forState:UIControlStateNormal];
    changeStyleButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [changeStyleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [changeStyleButton addTarget:self action:@selector(changeStyleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeStyleButton];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight-buttonHeight, viewWidth, buttonHeight)];
    backButton.backgroundColor = ColorFromRGB(253, 150, 180);
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
    [self.view addSubview:self.logLabel];
}












#pragma mark - Utility

- (void)log:(NSString *)logString
{
    NSLog(@"%@", logString);
    self.logLabel.textColor = customWhiteColor;
    self.logLabel.text = [NSString stringWithFormat:@"%@%@", logStringHeader, logString];
}

- (MTGWallAdManager *)wallAdManager
{
    //If the native ad manager is not existed, init it now.
    if (_wallAdManager == nil) {
        [self initAdManagerButtonAction:nil];
    }
    return _wallAdManager;
}













@end
