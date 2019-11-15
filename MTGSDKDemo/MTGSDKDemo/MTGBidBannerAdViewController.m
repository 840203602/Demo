//
//  MTGBannerAdViewController.m
//  MTGSDKSample
//
//  Created by Lee on 2019/10/17.
//  Copyright © 2019 Mintegral. All rights reserved.
//

#import "MTGBidBannerAdViewController.h"
#import <MTGSDKBanner/MTGBannerAdView.h>
#import <MTGSDKBanner/MTGBannerAdViewDelegate.h>
#import <MTGSDKBidding/MTGBiddingRequest.h>
#import <MTGSDKBidding/MTGBiddingBannerRequestParameter.h>

#define kLogLabelHeight   40
#define SCREEN_HEIGHT CGRectGetHeight([[UIScreen mainScreen] bounds])
#define SCREEN_WIDTH  CGRectGetWidth([[UIScreen mainScreen] bounds])
#define kBannerUnitID  @"146898"

@interface MTGBidBannerAdViewController ()
<MTGBannerAdViewDelegate>

@property(nonatomic,strong) UILabel *bidLogLabel;
@property(nonatomic,strong) UIButton *bidLoadButton;
@property(nonatomic,strong) UIButton *bidBackButton;
@property(nonatomic,strong) UIButton *bidButton;
@property(nonatomic,strong) MTGBannerAdView *bidBannerView;
@property(nonatomic,copy) NSString *bidToken;
//@property (nonatomic, strong) UITextView *bidTextView;

@end

@implementation MTGBidBannerAdViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self addBannerAdView];
    
    [self addBackButton];
    [self addBidLoadButton];
    [self addBidButton];
    [self addBidLogLabel];

}

#pragma mark --
#pragma mark -- MTGBannerAdViewDelegate
- (void)adViewLoadSuccess:(MTGBannerAdView *)adView {
    
    _bidBannerView.hidden = NO;
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
    self.bidLogLabel.text = [NSString stringWithFormat:@"%@%@",logStringHeader,logString];
}

- (void)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadButtonAction:(UIButton *)sender {
    [self log:@"star load ad"];
    [_bidBannerView loadBannerAdWithBidToken:self.bidToken];
}

- (void)requestBidTokenAction:(UIButton *)sender {
    [self log:@"start request bid token"];
    MTGBiddingBannerRequestParameter *requstParamter = [[MTGBiddingBannerRequestParameter alloc]initWithUnitId:kBannerUnitID basePrice:@(0.1) bannerSizeType:MTGStandardBannerType320x50];
    [MTGBiddingRequest getBidWithRequestParameter:requstParamter completionHandler:^(MTGBiddingResponse * _Nonnull bidResponse) {
        if (bidResponse.success) {
            self.bidToken = bidResponse.bidToken;
            [self log:@"request token success"];
            [bidResponse notifyWin];
        }else{
            NSString *errorMsg = bidResponse.error.description;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bid Failed" message:errorMsg delegate:nil cancelButtonTitle:@"Got" otherButtonTitles:nil];
            [alert show];
            [self log:@"token failed"];
        }
    }];
}
#pragma mark --
#pragma mark -- setter
- (void)addBannerAdView {

    /*
     _bannerAdView = [[MTGBannerAdView alloc]initBannerAdViewWithAdSize:CGSizeMake(320, 50) unitId:kBannerUnitID rootViewController:self];
     */
    _bidBannerView = [[MTGBannerAdView alloc]initBannerAdViewWithBannerSizeType:MTGStandardBannerType320x50 unitId:kBannerUnitID rootViewController:self];
    _bidBannerView.delegate = self;
    _bidBannerView.autoRefreshTime = 0;
    _bidBannerView.hidden = YES;

    [self.view addSubview:_bidBannerView];

    _bidBannerView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *centerConstraint = [NSLayoutConstraint constraintWithItem:_bidBannerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0];
    [self.view addConstraint:centerConstraint];
    
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:_bidBannerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:320];
    [self.view addConstraint:widthConstraint];

    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_bidBannerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.f constant:90];
    [self.view addConstraint:topConstraint];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_bidBannerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:50];
    [self.view addConstraint:heightConstraint];
}

- (void)addBackButton{
    [self.view addSubview:self._bidBackButton];
    _bidBackButton.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_bidBackButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
    [self.view addConstraint:leftConstraint];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:_bidBackButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.f constant:0];
    [self.view addConstraint:rightConstraint];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_bidBackButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:buttonHeight];
    [self.view addConstraint:heightConstraint];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_bidBackButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
    [self.view addConstraint:bottomConstraint];
}

-(void)addBidLoadButton {
    [self.view addSubview:self.bidLoadButton];
    _bidLoadButton.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_bidLoadButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
    [self.view addConstraint:leftConstraint];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:_bidLoadButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.f constant:0];
    [self.view addConstraint:rightConstraint];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_bidLoadButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:buttonHeight];
    [self.view addConstraint:heightConstraint];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_bidLoadButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.f constant:-buttonHeight];
    [self.view addConstraint:bottomConstraint];
}

-(void)addBidLogLabel{
    [self.view addSubview:self.bidLogLabel];
    _bidLogLabel.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_bidLogLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
    [self.view addConstraint:leftConstraint];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:_bidLogLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.f constant:0];
    [self.view addConstraint:rightConstraint];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_bidLogLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:kLogLabelHeight];
    [self.view addConstraint:heightConstraint];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_bidLogLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.f constant:-buttonHeight * 3.0];
    [self.view addConstraint:bottomConstraint];
}

- (void)addBidButton {
    [self.view addSubview:self.bidButton];
    _bidButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_bidButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
    [self.view addConstraint:leftConstraint];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:_bidButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.f constant:0];
    [self.view addConstraint:rightConstraint];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_bidButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:buttonHeight];
    [self.view addConstraint:heightConstraint];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_bidButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.f constant:-buttonHeight * 2.0];
    [self.view addConstraint:bottomConstraint];
}

- (UILabel *)bidLogLabel {
    if (!_bidLogLabel) {
        _bidLogLabel = [[UILabel alloc]init];
        self.bidLogLabel.backgroundColor = ColorFromRGBALPHA(0, 0, 0, 0.5);
        self.bidLogLabel.font = [UIFont systemFontOfSize:12];
        self.bidLogLabel.textColor = customWhiteColor;
        self.bidLogLabel.text = logStringHeader;
        self.bidLogLabel.adjustsFontSizeToFitWidth = YES;
        self.bidLogLabel.minimumScaleFactor = 0.8;
        
    }
    return _bidLogLabel;
}

- (UIButton *)bidButton {
    if (!_bidButton) {
        _bidButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bidButton.backgroundColor = customGray1Color;
        [_bidButton setTitle:@"Request Bid Token" forState:UIControlStateNormal];
        [_bidButton setTitle:@"Request Bid Token" forState:UIControlStateHighlighted];
        _bidButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [_bidButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_bidButton addTarget:self action:@selector(requestBidTokenAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bidButton;
}

- (UIButton *)bidLoadButton {

    if (!_bidLoadButton) {
        _bidLoadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bidLoadButton.backgroundColor = customGray3Color;
        [_bidLoadButton setTitle:@"Load Banner Ad" forState:UIControlStateNormal];
        [_bidLoadButton setTitle:@"Load Banner Ad" forState:UIControlStateHighlighted];
        _bidLoadButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [_bidLoadButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_bidLoadButton addTarget:self action:@selector(loadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bidLoadButton;
}

- (UIButton *)_bidBackButton {
    if (!_bidBackButton) {
        _bidBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bidBackButton.backgroundColor = ColorFromRGB(0,206,209);
        [_bidBackButton setTitle:@"Back" forState:UIControlStateNormal];
        [_bidBackButton setTitle:@"Back" forState:UIControlStateHighlighted];
        _bidBackButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [_bidBackButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bidBackButton;
}
@end
