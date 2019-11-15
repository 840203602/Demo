//
//  BiddingViewController.m
//  MTGSDKDemo
//
//  Created by Harry on 2019/5/30.
//  Copyright © 2019 Mobvista. All rights reserved.
//

#import "BiddingViewController.h"
#import "MTGBidNativeVideoViewController.h"
#import "MTGBidRewardVideoViewController.h"
#import "MTGBidInsterstialVideoViewController.h"
#import "MTGBidBannerAdViewController.h"
#define MTGButtonNum 5

@interface BiddingViewController ()

@end

@implementation BiddingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  添加 设备旋转 通知
     *
     *  当监听到 UIDeviceOrientationDidChangeNotification 通知时，调用handleDeviceOrientationDidChange:方法
     *  @param handleDeviceOrientationDidChange: handleDeviceOrientationDidChange: description
     *
     *  @return return value description
     */
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDeviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    //Create demo buttons
    [self createButton];
    
    
}


-(void)dealloc{
    
    /**
     *  结束 设备旋转通知
     *
     *  @return return value description
     */
    [[UIDevice currentDevice]endGeneratingDeviceOrientationNotifications];
    
}

- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation
{
    [self createButton];
    
}


-(void)createButton{
    for (UIView *subView in self.view.subviews) {
        [subView removeFromSuperview];
    }
    int butonIndex = 0;
    UIButton *nativeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight/MTGButtonNum*butonIndex, viewWidth, viewHeight/MTGButtonNum)];
    nativeButton.backgroundColor = ColorFromRGB(255, 204, 99);
    [nativeButton setTitle:@"Native Ad" forState:UIControlStateNormal];
    nativeButton.titleLabel.font = [UIFont boldSystemFontOfSize:35];
    [nativeButton addTarget:self action:@selector(nativeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nativeButton];
    
    
    
    butonIndex++;
    UIButton *rewardVideoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight/MTGButtonNum*butonIndex, viewWidth, viewHeight/MTGButtonNum)];
    rewardVideoButton.backgroundColor = ColorFromRGB(120, 227, 195);
    [rewardVideoButton setTitle:@"Reward Video" forState:UIControlStateNormal];
    rewardVideoButton.titleLabel.font = [UIFont boldSystemFontOfSize:35];
    [rewardVideoButton addTarget:self action:@selector(rewardVideoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rewardVideoButton];
    
 
    butonIndex++;
    UIButton *insterstialVideoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight/MTGButtonNum*butonIndex, viewWidth, viewHeight/MTGButtonNum)];
    insterstialVideoButton.backgroundColor = ColorFromRGB(146, 174, 254);
    [insterstialVideoButton setTitle:@"Interstial Video Ad" forState:UIControlStateNormal];
    insterstialVideoButton.titleLabel.font = [UIFont boldSystemFontOfSize:35];
    [insterstialVideoButton addTarget:self action:@selector(insterstialVideoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:insterstialVideoButton];
    
    butonIndex++;
    UIButton *bidBannerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight/MTGButtonNum*butonIndex, viewWidth, viewHeight/MTGButtonNum)];
    bidBannerButton.backgroundColor = ColorFromRGB(0,206,209);
    [bidBannerButton setTitle:@"Banner Ad" forState:UIControlStateNormal];
    bidBannerButton.titleLabel.font = [UIFont boldSystemFontOfSize:35];
    [bidBannerButton addTarget:self action:@selector(bannerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bidBannerButton];
    
    butonIndex++;
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight/MTGButtonNum*butonIndex, viewWidth, viewHeight/MTGButtonNum)];
    backButton.backgroundColor = ColorFromRGB(253, 150, 180);
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:35];
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
}


#pragma mark - Button Actions

- (IBAction)nativeButtonAction:(id)sender
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MTGNativeVideo" bundle:nil];
    UIViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"MTGBidNativeVideoViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)rewardVideoButtonAction:(id)sender
{
    [self.navigationController pushViewController:[[MTGBidRewardVideoViewController alloc] init] animated:YES];
}

- (IBAction)insterstialVideoButtonAction:(id)sender{
    [self.navigationController pushViewController:[[MTGBidInsterstialVideoViewController alloc] init] animated:YES];
}

- (void)bannerButtonAction:(UIButton *)sender {
    [self.navigationController pushViewController:[[MTGBidBannerAdViewController alloc] init] animated:YES];
}
- (void)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
