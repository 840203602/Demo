//
//  MTGMainViewController.m
//  MTGSDKDemo
//
//  Created by apple on 2018/5/4.
//  Copyright © 2018年 Mobvista. All rights reserved.
//

#import "MTGMainViewController.h"
#import "MTGGDPRViewController.h"
#import "ViewController.h"
#import "MTGSDK/MTGSDK.h"

#define MTGButtonNum 2
#define allButtonHeight (viewHeight)

@interface MTGMainViewController ()

@end

@implementation MTGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = customWhiteColor;
    
    [self createDemoButtons];
}





- (void)createDemoButtons
{
    //Create ad demo buttons
    
    int butonIndex = 0;
    CGFloat buttonHeightFloat = allButtonHeight/MTGButtonNum;
    CGFloat butonY = (buttonHeightFloat*butonIndex);
    
    UIButton *userPrivateYESButton = [[UIButton alloc] initWithFrame:CGRectMake(0, butonY, viewWidth, buttonHeightFloat)];
    userPrivateYESButton.backgroundColor = ColorFromRGB(71, 216, 203);
    [userPrivateYESButton setTitle:@"Init SDK&Enter Demo" forState:UIControlStateNormal];
    userPrivateYESButton.titleLabel.font = [UIFont boldSystemFontOfSize:35];
    [userPrivateYESButton addTarget:self action:@selector(enterDemoButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:userPrivateYESButton];
    
    butonIndex++;
    butonY = (buttonHeightFloat*butonIndex);
    UIButton *userPrivateNOButton = [[UIButton alloc] initWithFrame:CGRectMake(0, butonY, viewWidth, buttonHeightFloat)];
    userPrivateNOButton.backgroundColor = ColorFromRGB(121, 112, 206);
    [userPrivateNOButton setTitle:@"EU-GDPR Init SDK" forState:UIControlStateNormal];
    userPrivateNOButton.titleLabel.font = [UIFont boldSystemFontOfSize:35];
    [userPrivateNOButton addTarget:self action:@selector(GDPRInitSDKButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:userPrivateNOButton];
    
    
    
}



- (IBAction)GDPRInitSDKButtonAction:(id)sender
{
    [self.navigationController pushViewController:[[MTGGDPRViewController alloc] init] animated:YES];
}

- (IBAction)enterDemoButton:(id)sender
{
    [[MTGSDK sharedInstance] setAppID:@"118692" ApiKey:@"7c22942b749fe6a6e361b675e96b3ee9"];
    [self.navigationController pushViewController:[[ViewController alloc] init] animated:YES];
    
}

@end
