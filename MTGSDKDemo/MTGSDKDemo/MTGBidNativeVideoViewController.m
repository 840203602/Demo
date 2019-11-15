//
//  MTGBidNativeVideoViewController.m
//  MTGSDKDemo
//
//  Created by Harry on 2019/5/30.
//  Copyright © 2019 Mobvista. All rights reserved.
//

#import "MTGBidNativeVideoViewController.h"
#import "MTGNativeVideoViewController.h"
#import <MTGSDK/MTGSDK.h>
#import <MTGSDK/MTGBidNativeAdManager.h>
#import <MTGSDKBidding/MTGBiddingRequest.h>
#import "MTGNativeAdsViewCell.h"
#import "MTGNativeVideoCell.h"

#import <MTGSDKBidding/MTGBiddingRequestParameter.h>

#define KNativeUnitID @"146891"
#define KPlacementID @""




@interface MTGBidNativeVideoViewController ()<MTGBidNativeAdManagerDelegate,UITableViewDataSource,UITableViewDelegate,MTGMediaViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *logLabel;
@property (weak, nonatomic) IBOutlet UIButton *registerviewBtn;


@property (nonatomic, strong) MTGBidNativeAdManager *nativeVideoAdManager;
@property (nonatomic, strong) NSMutableArray *adsArray;

@property (nonatomic, copy) NSString *bidToken;



@end

@implementation MTGBidNativeVideoViewController{
    BOOL registerView ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_tableView registerNib:[UINib nibWithNibName:@"MTGNativeAdsViewCell" bundle:nil] forCellReuseIdentifier:@"MTGNativeAdsViewCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"MTGNativeVideoCell" bundle:nil] forCellReuseIdentifier:@"MTGNativeVideoCell"];
    [self.registerviewBtn setTitle:@"UnRegisterview" forState:UIControlStateNormal];
    [self.registerviewBtn setTitle:@"Registerview" forState:UIControlStateSelected];
    registerView = YES;
    
}


- (IBAction)backBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)registerviewBtnAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    if (!button.selected) {
        registerView = YES;
        [self log:@"adCallButton or CellContentViews registered, now you can click  adCallButton to test"];
    }else{
        registerView = NO;
        [self log:@"View unregistered"];
    }
    [self.tableView reloadData];
    
    
}

- (IBAction)loadAdsBtnAction:(id)sender {
    [self.nativeVideoAdManager loadWithBidToken:self.bidToken];
    [self log:@"Start to load ads"];
    
}

- (IBAction)initMangerBtnAction:(id)sender {
    
    [self log:@"MTGBidNativeAdManager init"];
    
    [self nativeVideoAdManager];
    
}

- (IBAction)bidBtnAction:(id)sender {
    
    //new bid request method
    MTGBiddingRequestParameter *requestParameter = [[MTGBiddingRequestParameter alloc]initWithUnitId:KNativeUnitID basePrice:@(0.1)];
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
    [MTGBiddingRequest getBidWithUnitId:KNativeUnitID basePrice:@(0.1) completionHandler:^(MTGBiddingResponse * _Nonnull bidResponse) {
        
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
   */
}

- (void)log:(NSString *)logString
{
    NSLog(@"%@", logString);
    self.logLabel.textColor = customWhiteColor;
    self.logLabel.text = [NSString stringWithFormat:@"%@%@", logStringHeader, logString];
}


- (MTGBidNativeAdManager *)nativeVideoAdManager
{
    //If the native ad manager is not existed, init it now.
    if (_nativeVideoAdManager == nil) {
        _nativeVideoAdManager = [[MTGBidNativeAdManager alloc] initWithUnitID:KNativeUnitID presentingViewController:self];
        _nativeVideoAdManager.showLoadingView = YES;
        _nativeVideoAdManager.delegate = self;
    }
    return _nativeVideoAdManager;
}

- (NSMutableArray *)adsArray
{
    if (_adsArray == nil) {
        _adsArray = [NSMutableArray array];
    }
    return _adsArray;
}

#pragma mark AdManger delegate
- (void)nativeAdsLoaded:(NSArray *)nativeAds bidNativeManager:(nonnull MTGBidNativeAdManager *)nativeManager
{
    
    if (nativeAds.count > 0) {
        [self log:[NSString stringWithFormat:@"unitid = %@,%lu ads loaded", nativeManager.currentUnitId,(unsigned long)[nativeAds count]]];
        
        [self.adsArray addObjectsFromArray:nativeAds];
        [self.tableView reloadData];
        
    }
    else {
        [self log:@"no ads"];
    }
}

- (void)nativeAdsFailedToLoadWithError:(NSError *)error bidNativeManager:(nonnull MTGBidNativeAdManager *)nativeManager
{
    [self log:[NSString stringWithFormat:@"unitid = %@,Failed to load ads, error:%@",nativeManager.currentUnitId, error.domain]];
}



#pragma mark MediaView delegate
- (void)MTGMediaViewWillEnterFullscreen:(MTGMediaView *)mediaView{
    [self log:@"MTGMedia View Will Enter Full Screen"];
}


- (void)MTGMediaViewDidExitFullscreen:(MTGMediaView *)mediaView{
    [self log:@"MTGMedia View Did Exit Full Screen"];
}

- (void)MTGMediaViewVideoDidStart:(MTGMediaView *)mediaView {
    [self log:@"MTGMedia View Video Did Start To Play"];
}


#pragma mark MediaView and AdManger Click delegate

- (void)nativeAdDidClick:(MTGCampaign *)nativeAd bidNativeManager:(nonnull MTGBidNativeAdManager *)nativeManager
{
    [self log:@"Registerview Ad is clicked"];
}
- (void)nativeAdDidClick:(MTGCampaign *)nativeAd mediaView:(nonnull MTGMediaView *)mediaView
{
    [self log:@"MTGMediaView Ad is clicked"];
}

- (void)nativeAdClickUrlWillStartToJump:(NSURL *)clickUrl bidNativeManager:(nonnull MTGBidNativeAdManager *)nativeManager
{
    [self log:[NSString stringWithFormat:@"Registerview click url:%@", clickUrl.absoluteString]];
}
- (void)nativeAdClickUrlWillStartToJump:(NSURL *)clickUrl mediaView:(nonnull MTGMediaView *)mediaView
{
    [self log:[NSString stringWithFormat:@"MTGMediaView click url:%@", clickUrl.absoluteString]];
}

- (void)nativeAdClickUrlDidJumpToUrl:(NSURL *)jumpUrl bidNativeManager:(nonnull MTGBidNativeAdManager *)nativeManager
{
    [self log:[NSString stringWithFormat:@"Registerview jump to url:%@", jumpUrl.absoluteString]];
}
- (void)nativeAdClickUrlDidJumpToUrl:(NSURL *)jumpUrl mediaView:(nonnull MTGMediaView *)mediaView
{
    [self log:[NSString stringWithFormat:@"MTGMediaView jump to url:%@", jumpUrl.absoluteString]];
}

- (void)nativeAdClickUrlDidEndJump:(NSURL *)finalUrl error:(NSError *)error bidNativeManager:(nonnull MTGBidNativeAdManager *)nativeManager
{
    [self log:[NSString stringWithFormat:@"Registerview final url:%@ error:%@", finalUrl.absoluteString, error?error.domain:@"none"]];
}
- (void)nativeAdClickUrlDidEndJump:(NSURL *)finalUrl error:(NSError *)error mediaView:(nonnull MTGMediaView *)mediaView
{
    [self log:[NSString stringWithFormat:@"MTGMediaView final url:%@ error:%@", finalUrl.absoluteString, error?error.domain:@"none"]];
}


#pragma mark tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.adsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell;
    
    if (indexPath.row+1> self.adsArray.count) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MTGNativeIconCell"];
    }
    MTGCampaign *campaign = self.adsArray[indexPath.row];
    if (indexPath.row % 3 == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MTGNativeAdsViewCell"];
        if (cell) {
            MTGNativeAdsViewCell *mediaViewCell = (MTGNativeAdsViewCell *)cell;
            [mediaViewCell updateCellWithCampaign:campaign unitId:KNativeUnitID];
            if (registerView) {
                [self.nativeVideoAdManager registerViewForInteraction:mediaViewCell.contentView withCampaign:campaign];
            }else{
                [self.nativeVideoAdManager unregisterView:mediaViewCell.contentView];
            }
        }
    }else if (indexPath.row % 3 == 1) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"MTGNativeVideoCell"];
        if (cell) {
            MTGNativeVideoCell *nativeVideoCell = (MTGNativeVideoCell *)cell;
            [nativeVideoCell updateCellWithCampaign:campaign unitId:KNativeUnitID];
            nativeVideoCell.MTGMediaView.delegate = self;
            
            if (registerView) {
                [self.nativeVideoAdManager registerViewForInteraction:nativeVideoCell.adCallButton withCampaign:campaign];
            }else{
                [self.nativeVideoAdManager unregisterView:nativeVideoCell.adCallButton];
            }
        }
    }else{
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MTGNativeIconCell"];
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 80-0.5f, self.view.bounds.size.width, 0.5)];
            lineView.backgroundColor = [UIColor grayColor];
            [cell.contentView addSubview:lineView];
        }
        [campaign loadIconUrlAsyncWithBlock:^(UIImage *image) {
            cell.imageView.image = image;
            cell.imageView.frame = CGRectMake(10, 10, 60, 60);
            cell.textLabel.text = campaign.appName;
            cell.detailTextLabel.numberOfLines = 2;
            cell.detailTextLabel.text = campaign.appDesc;
            
        }];
        if (registerView) {
            [self.nativeVideoAdManager registerViewForInteraction:cell.contentView withCampaign:campaign];
        }else{
            [self.nativeVideoAdManager unregisterView:cell.contentView];
        }
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row % 3 == 0) {
        return 60.0f+[[UIScreen mainScreen] bounds].size.width*(627.0f/1200.0f);
    }else if(indexPath.row % 3 == 1){
        return 130.0f+[[UIScreen mainScreen] bounds].size.width*(9.0f/16.0f);
    }else{
        return 80;
    }
}
@end

