//
//  MTGBannerAdViewController.m
//  MTGSDKSample
//
//  Created by Lee on 2019/7/9.
//  Copyright © 2019 Mintegral. All rights reserved.
//

#import "MTGBannerAdViewController.h"
#import <MTGSDKBanner/MTGBannerAdView.h>
#import <MTGSDKBanner/MTGBannerAdViewDelegate.h>

#define kLogLabelHeight   40
#define SCREEN_HEIGHT CGRectGetHeight([[UIScreen mainScreen] bounds])
#define SCREEN_WIDTH  CGRectGetWidth([[UIScreen mainScreen] bounds])
#define kBannerUnitID  @"146898"

@interface MTGBannerAdViewController ()
<MTGBannerAdViewDelegate>

@property(nonatomic,strong) UILabel *logLabel;
@property(nonatomic,strong) UIButton *loadButton;
@property(nonatomic,strong) UIButton *backButton;
@property(nonatomic,strong) MTGBannerAdView *bannerAdView;

@property (nonatomic, strong) UITextView *textView;

@end

@implementation MTGBannerAdViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self addBannerAdView];
    
    [self addBackButton];
    [self addLoadButton];
    [self addLogLabel];

}

#pragma mark --
#pragma mark -- MTGBannerAdViewDelegate
- (void)adViewLoadSuccess:(MTGBannerAdView *)adView {
    
    _bannerAdView.hidden = NO;
    [self log:[NSString stringWithFormat:@"%@",NSStringFromSelector(_cmd)]];
}

- (void)adViewLoadFailedWithError:(NSError *)error adView:(MTGBannerAdView *)adView {
    [self log:[NSString stringWithFormat:@"Load Error:%@",error.debugDescription]];
}

- (void)adViewWillLogImpression:(MTGBannerAdView *)adView {
    [self log:[NSString stringWithFormat:@"%@",NSStringFromSelector(_cmd)]];
}

- (void)adViewDidClicked:(MTGBannerAdView *)adView {
    [self log:[NSString stringWithFormat:@"%@",NSStringFromSelector(_cmd)]];

}

- (void)adViewWillLeaveApplication:(MTGBannerAdView *)adView {
    [self log:[NSString stringWithFormat:@"%@",NSStringFromSelector(_cmd)]];

}

- (void)adViewWillOpenFullScreen:(MTGBannerAdView *)adView {
    [self log:[NSString stringWithFormat:@"%@",NSStringFromSelector(_cmd)]];

}

- (void)adViewCloseFullScreen:(MTGBannerAdView *)adView {
    [self log:[NSString stringWithFormat:@"%@",NSStringFromSelector(_cmd)]];
}

- (void)log:(NSString *)logString {
    self.logLabel.text = [NSString stringWithFormat:@"%@%@",logStringHeader,logString];
}

- (void)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadButtonAction:(UIButton *)sender {
    [self log:@"start load banner ad"];
    [_bannerAdView loadBannerAd];
}

#pragma mark --
#pragma mark -- setter
- (void)addBannerAdView {

    /*
     _bannerAdView = [[MTGBannerAdView alloc]initBannerAdViewWithAdSize:CGSizeMake(320, 50) unitId:kBannerUnitID rootViewController:self];
     */
    _bannerAdView = [[MTGBannerAdView alloc]initBannerAdViewWithBannerSizeType:MTGStandardBannerType320x50 unitId:kBannerUnitID rootViewController:self];
    _bannerAdView.delegate = self;
    _bannerAdView.autoRefreshTime = 0;
    _bannerAdView.hidden = YES;

    [self.view addSubview:_bannerAdView];

    _bannerAdView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *centerConstraint = [NSLayoutConstraint constraintWithItem:_bannerAdView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0];
    [self.view addConstraint:centerConstraint];
    
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:_bannerAdView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:320];
    [self.view addConstraint:widthConstraint];

    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_bannerAdView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.f constant:90];
    [self.view addConstraint:topConstraint];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_bannerAdView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:50];
    [self.view addConstraint:heightConstraint];
}

- (void)addBackButton{
    [self.view addSubview:self.backButton];
    _backButton.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_backButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
    [self.view addConstraint:leftConstraint];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:_backButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.f constant:0];
    [self.view addConstraint:rightConstraint];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_backButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:buttonHeight];
    [self.view addConstraint:heightConstraint];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_backButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
    [self.view addConstraint:bottomConstraint];
}

-(void)addLoadButton{
    [self.view addSubview:self.loadButton];
    _loadButton.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_loadButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
    [self.view addConstraint:leftConstraint];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:_loadButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.f constant:0];
    [self.view addConstraint:rightConstraint];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_loadButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:buttonHeight];
    [self.view addConstraint:heightConstraint];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_loadButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.f constant:-buttonHeight];
    [self.view addConstraint:bottomConstraint];
}

-(void)addLogLabel{
    [self.view addSubview:self.logLabel];
    _logLabel.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_logLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
    [self.view addConstraint:leftConstraint];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:_logLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.f constant:0];
    [self.view addConstraint:rightConstraint];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_logLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:kLogLabelHeight];
    [self.view addConstraint:heightConstraint];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_logLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.f constant:-buttonHeight * 2.0];
    [self.view addConstraint:bottomConstraint];
}



- (UILabel *)logLabel {
    if (!_logLabel) {
        _logLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - buttonHeight -buttonHeight - kLogLabelHeight, SCREEN_WIDTH, kLogLabelHeight)];
        self.logLabel.backgroundColor = ColorFromRGBALPHA(0, 0, 0, 0.5);
        self.logLabel.font = [UIFont systemFontOfSize:12];
        self.logLabel.textColor = customWhiteColor;
        self.logLabel.text = logStringHeader;
        self.logLabel.adjustsFontSizeToFitWidth = YES;
        self.logLabel.minimumScaleFactor = 0.8;
        
    }
    return _logLabel;
}

- (UIButton *)loadButton {

    if (!_loadButton) {
        _loadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loadButton.backgroundColor = customGray1Color;
        [_loadButton setTitle:@"Load Banner Ad" forState:UIControlStateNormal];
        [_loadButton setTitle:@"Load Banner Ad" forState:UIControlStateHighlighted];
        _loadButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [_loadButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_loadButton addTarget:self action:@selector(loadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loadButton;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.backgroundColor = ColorFromRGB(0,206,209);
        [_backButton setTitle:@"Back" forState:UIControlStateNormal];
        [_backButton setTitle:@"Back" forState:UIControlStateHighlighted];
        _backButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}
@end
