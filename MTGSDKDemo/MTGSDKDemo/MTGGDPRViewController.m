//
//  MTGGDPRViewController.m
//  MTGSDKDemo
//
//  Created by apple on 2018/5/3.
//  Copyright © 2018年 Mobvista. All rights reserved.
//

#import "MTGGDPRViewController.h"
#import <MTGSDK/MTGSDK.h>
#import "ViewController.h"
#define MTGButtonNum 7
#define logLabelHeight 70
#define allButtonHeight (viewHeight - logLabelHeight)

@interface MTGGDPRViewController (){
    BOOL _authorizationUserPrivate;
    BOOL _initialized;
}
//Demo View
@property (nonatomic, strong) UITextView *textView;

//Log Label
@property (nonatomic, strong) UILabel *logLabel;


@end

@implementation MTGGDPRViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = customWhiteColor;
    
    [self createDemoButtons];
    [self createLogLabel];
}





- (void)createDemoButtons
{
    //Create ad demo buttons

    int butonIndex = 0;
    CGFloat buttonHeightFloat = allButtonHeight/MTGButtonNum;
    CGFloat butonY = logLabelHeight+(buttonHeightFloat*butonIndex);
    CGFloat fontSize = 30;
    
    UIButton *userPrivateYESButton = [[UIButton alloc] initWithFrame:CGRectMake(0, butonY, viewWidth, buttonHeightFloat)];
    userPrivateYESButton.backgroundColor = ColorFromRGB(71, 216, 203);
    [userPrivateYESButton setTitle:@"Set ConsentStatus to YES" forState:UIControlStateNormal];
    userPrivateYESButton.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    [userPrivateYESButton addTarget:self action:@selector(setUserPrivateYESButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:userPrivateYESButton];
    
    butonIndex++;
    butonY = logLabelHeight+(buttonHeightFloat*butonIndex);
    UIButton *userPrivateNOButton = [[UIButton alloc] initWithFrame:CGRectMake(0, butonY, viewWidth, buttonHeightFloat)];
    userPrivateNOButton.backgroundColor = ColorFromRGB(121, 112, 206);
    [userPrivateNOButton setTitle:@"Set ConsentStatus to  NO" forState:UIControlStateNormal];
    userPrivateNOButton.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    [userPrivateNOButton addTarget:self action:@selector(setUserPrivateNOButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:userPrivateNOButton];
    
    
    
    butonIndex++;
    butonY = logLabelHeight+(buttonHeightFloat*butonIndex);
    UIButton *showUserPrivateInfoTipsButton = [[UIButton alloc] initWithFrame:CGRectMake(0, butonY, viewWidth, buttonHeightFloat)];
    showUserPrivateInfoTipsButton.backgroundColor = ColorFromRGB(182, 112, 205);
    [showUserPrivateInfoTipsButton setTitle:@"Show ConsentStatus Tips" forState:UIControlStateNormal];
    showUserPrivateInfoTipsButton.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    [showUserPrivateInfoTipsButton addTarget:self action:@selector(showUserPrivateInfoTipsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showUserPrivateInfoTipsButton];
    
    butonIndex++;
    butonY = logLabelHeight+(buttonHeightFloat*butonIndex);
    UIButton *getUserPrivateInfoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, butonY, viewWidth, buttonHeightFloat)];
    getUserPrivateInfoButton.backgroundColor = ColorFromRGB(108, 169, 224);
    [getUserPrivateInfoButton setTitle:@"Get ConsentStatus" forState:UIControlStateNormal];
    getUserPrivateInfoButton.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    [getUserPrivateInfoButton addTarget:self action:@selector(getUserPrivateInfoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getUserPrivateInfoButton];
    
    butonIndex++;
    butonY = logLabelHeight+(buttonHeightFloat*butonIndex);
    UIButton *eUGDPRInitSDKButton = [[UIButton alloc] initWithFrame:CGRectMake(0, butonY, viewWidth, buttonHeightFloat)];
    eUGDPRInitSDKButton.backgroundColor = ColorFromRGB(121, 112, 206);
    [eUGDPRInitSDKButton setTitle:@"EU-GDPR Init SDK" forState:UIControlStateNormal];
    eUGDPRInitSDKButton.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    [eUGDPRInitSDKButton addTarget:self action:@selector(EUGDPRInitSDKButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eUGDPRInitSDKButton];
    
    butonIndex++;
    butonY = logLabelHeight+(buttonHeightFloat*butonIndex);
    UIButton *enterDemoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, butonY, viewWidth, buttonHeightFloat)];
    enterDemoButton.backgroundColor = ColorFromRGB(182, 112, 235);
    [enterDemoButton setTitle:@"Enter Demo" forState:UIControlStateNormal];
    enterDemoButton.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    [enterDemoButton addTarget:self action:@selector(enterDemoButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enterDemoButton];
    
    
    butonIndex++;
    butonY = logLabelHeight+(buttonHeightFloat*butonIndex);
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, butonY, viewWidth, buttonHeightFloat)];
    backButton.backgroundColor = customGray3Color;
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
   

}


- (void)createLogLabel
{
    //Create log label to help you understand the demo
    self.logLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewWidth, logLabelHeight)];
    self.logLabel.backgroundColor = customGray10Color;
    self.logLabel.font = [UIFont systemFontOfSize:12];
    self.logLabel.textColor = customWhiteColor;
    self.logLabel.text = logStringHeader;
    self.logLabel.adjustsFontSizeToFitWidth = YES;
    self.logLabel.minimumScaleFactor = 0.8;
    [self.view addSubview:self.logLabel];
}



- (IBAction)setUserPrivateYESButtonAction:(id)sender
{
    [[MTGSDK sharedInstance] setConsentStatus:YES];
    _authorizationUserPrivate = YES;
    [self log:@"set ConsentStatus to YES"];
}

- (IBAction)setUserPrivateNOButtonAction:(id)sender
{
    [[MTGSDK sharedInstance] setConsentStatus:NO];
    _authorizationUserPrivate = YES;
    [self log:@"set ConsentStatus to NO"];

}
- (IBAction)showUserPrivateInfoTipsButtonAction:(id)sender{
    [[MTGSDK sharedInstance] showConsentInfoTips:^(BOOL consentStatus, NSError * _Nullable error) {
        if (error == nil) {
            BOOL status = consentStatus;
            NSString * info = [NSString stringWithFormat: @"consentStatus = %d", status];
            [self log:info];
            _authorizationUserPrivate = YES;
        }else{
            [self log:error.localizedDescription];
        }
    }];
}

- (IBAction)getUserPrivateInfoButtonAction:(id)sender{
    
    BOOL status = [[MTGSDK sharedInstance] consentStatus];
    NSString * info = [NSString stringWithFormat: @"consentStatus = %d", status];
    [self log:info];
}


- (IBAction)EUGDPRInitSDKButtonAction:(id)sender
{
    
    if (_authorizationUserPrivate) {
        [[MTGSDK sharedInstance] setAppID:@"92763" ApiKey:@"936dcbdd57fe235fd7cf61c2e93da3c4"];
        _initialized= YES;
        [self log:@"EU-GDPR Init Finish"];

    }else{
        [self log:@"Need to be setUserPrivateInfo/showUserPrivateTips"];
    }
}

- (IBAction)enterDemoButton:(id)sender
{
    if (_initialized) {
        [self.navigationController pushViewController:[[ViewController alloc] init] animated:YES];
    }else{
        [self log:@"Need to be initialized"];
    }
    
}

#pragma mark - Utility

- (void)log:(NSString *)logString
{
    NSLog(@"%@", logString);
    self.logLabel.textColor = customWhiteColor;
    self.logLabel.text = [NSString stringWithFormat:@"%@%@", logStringHeader, logString];
}



@end
