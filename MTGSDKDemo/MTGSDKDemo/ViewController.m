//
//  ViewController.m
//  MTGSDKDemo
//
//  Created by Jomy on 15/11/17.
//  Copyright © 2015年 Mobvista. All rights reserved.
//

#import "ViewController.h"
#import "MTGAppWallViewController.h"
#import "MTGRewardVideoViewController.h"
#import "MTGOfferWallViewController.h"
#import "MTGInsterstialViewController.h"
#import "MTGInsterstialVideoViewController.h"
#import "MTGInterActiveViewController.h"
#import "BiddingViewController.h"
#import "MTGBannerAdViewController.h"
#define MTGButtonNum 7

@interface ViewController ()

@end

@implementation ViewController

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
    UIButton *bannerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight/MTGButtonNum*butonIndex, viewWidth, viewHeight/MTGButtonNum)];
    bannerButton.backgroundColor = ColorFromRGB(0,206,209);
    [bannerButton setTitle:@"Banner Ad" forState:UIControlStateNormal];
    bannerButton.titleLabel.font = [UIFont boldSystemFontOfSize:35];
    [bannerButton addTarget:self action:@selector(bannerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bannerButton];

    butonIndex++;
    UIButton *insterstialButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight/MTGButtonNum*butonIndex, viewWidth, viewHeight/MTGButtonNum)];
    insterstialButton.backgroundColor = ColorFromRGB(98, 172, 227);
    [insterstialButton setTitle:@"Insterstial Ad" forState:UIControlStateNormal];
    insterstialButton.titleLabel.font = [UIFont boldSystemFontOfSize:35];
    [insterstialButton addTarget:self action:@selector(insterstialButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:insterstialButton];
    
    butonIndex++;
    UIButton *insterstialVideoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight/MTGButtonNum*butonIndex, viewWidth, viewHeight/MTGButtonNum)];
    insterstialVideoButton.backgroundColor = ColorFromRGB(146, 174, 254);
    [insterstialVideoButton setTitle:@"Interstial Video Ad" forState:UIControlStateNormal];
    insterstialVideoButton.titleLabel.font = [UIFont boldSystemFontOfSize:35];
    [insterstialVideoButton addTarget:self action:@selector(insterstialVideoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:insterstialVideoButton];
    
    butonIndex++;
    UIButton *insterActiveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight/MTGButtonNum*butonIndex, viewWidth, viewHeight/MTGButtonNum)];
    insterActiveButton.backgroundColor = ColorFromRGB(127, 141, 226);
    [insterActiveButton setTitle:@"Interactive Ad" forState:UIControlStateNormal];
    insterActiveButton.titleLabel.font = [UIFont boldSystemFontOfSize:35];
    [insterActiveButton addTarget:self action:@selector(insterActiveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:insterActiveButton];
    
    butonIndex++;
    UIButton *biddingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight/MTGButtonNum*butonIndex, viewWidth, viewHeight/MTGButtonNum)];
    biddingButton.backgroundColor = ColorFromRGB(253, 150, 180);
    [biddingButton setTitle:@"Header Bidding" forState:UIControlStateNormal];
    biddingButton.titleLabel.font = [UIFont boldSystemFontOfSize:35];
    [biddingButton addTarget:self action:@selector(biddingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:biddingButton];

}










#pragma mark - Button Actions

- (IBAction)nativeButtonAction:(id)sender
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MTGNativeVideo" bundle:nil];
    UIViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"MTGNativeVideoViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)rewardVideoButtonAction:(id)sender
{
    [self.navigationController pushViewController:[[MTGRewardVideoViewController alloc] init] animated:YES];
}

- (IBAction)insterstialVideoButtonAction:(id)sender{
    [self.navigationController pushViewController:[[MTGInsterstialVideoViewController alloc] init] animated:YES];
}
- (IBAction)insterstialButtonAction:(id)sender
{
    [self.navigationController pushViewController:[[MTGInsterstialViewController alloc] init] animated:YES];
}


- (IBAction)insterActiveButtonAction:(id)sender{
    [self.navigationController pushViewController:[[MTGInterActiveViewController alloc] init] animated:YES];
}

- (void)biddingButtonAction:(id)sender {
    BiddingViewController *vc = [[BiddingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)bannerButtonAction:(id)sender {
    MTGBannerAdViewController *vc = [[MTGBannerAdViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}








@end
