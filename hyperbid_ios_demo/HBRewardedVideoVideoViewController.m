//
//  HBRewardedVideoVideoViewController.m
//  HyperBidSDKDemo
//
//  Created by Leo on 05/07/2018.
//  Copyright © 2018 Leo. All rights reserved.
//

#import "HBRewardedVideoVideoViewController.h"
#import <HyperBidSDK/HBAPI.h>
#import "MTAutolayoutCategories.h"
#import <HyperBidSDK/HBAdManager.h>
#import <HyperBidRewardedVideo/HBRewardedVideoDelegate.h>
#import <HyperBidRewardedVideo/HBAdManager+RewardedVideo.h>
#import "HyperBidAdManager.h"

@interface HBRewardedVideoVideoViewController ()<HBRewardedVideoDelegate>
@property(nonatomic, readonly) NSString *name;
@property(nonatomic, readonly) NSDictionary *placementIDs;
@property(nonatomic, readonly) UIActivityIndicatorView *loadingView;
@property(nonatomic, readonly) UIButton *reloadADButton;
@property(nonatomic, readonly) UIButton *clearAdButton;
@property(nonatomic, readonly) UIButton *showAdButton;
@property(nonatomic, readonly) UILabel *failureTipsLabel;
@property(nonatomic, readonly) UIButton *removeAdButton;
@property(nonatomic, readonly) BOOL reload;
@end

NSString *const kTapjoyPlacementName = @"Tapjoy";
NSString *const kChartboostPlacementName = @"Chartboost";
NSString *const kIronsourcePlacementName = @"Ironsource";
NSString *const kVunglePlacementName = @"Vungle";
NSString *const kAdcolonyPlacementName = @"Adcolony";
NSString *const kUnityAdsPlacementName = @"Unity Ads";
NSString *const kTTPlacementName = @"TT";
NSString *const kOnewayPlacementName = @"Oneway";
NSString *const kBaiduPlacement = @"Baidu";
NSString *const kNendPlacement = @"Nend";
NSString *const kMaioPlacement = @"Maio";
NSString *const kKSPlacement = @"KS";
NSString *const kMyOfferPlacement = @"MyOffer";
NSString *const kADXPlacement = @"ADX";
NSString *const kOguryPlacement = @"Ogury";
NSString *const kHeliumPlacement = @"Helium";
NSString *const kKidozPlacement = @"Kidoz";
NSString *const kMyTargetPlacement = @"MyTarget";

static NSString *const kPlacement0ID = @"b5ad9ba61dcb39";
static NSString *const kInmobiPlacementID = @"b5b44a03522f92";
static NSString *const kMintegralPlacementID = @"b5b44a07fc3bf6";
static NSString *const kMintegralHeaderBiddingPlacementID = @"b5d13341598199";
static NSString *const kFacebookPlacementID = @"b5b44a02112383";
static NSString *const kFacebookHeaderBiddingPlacementID = @"b5d133438158c6";
static NSString *const kAdMobPlacementID = @"b5b44a02bf08c0";
static NSString *const kApplovinPlacementID = @"b5b44a0646e64b";
static NSString *const kMopubPlacementID = @"b5b44a088ba48d";
static NSString *const kMopubVideoPlacementID = @"b5b44a088ba48d";
static NSString *const kGDTPlacementID = @"b5c0f7cd196a4c";
static NSString *const kTapjoyRVPlacementID = @"b5b44a0ac855ff";//to be modified
static NSString *const kChartboostRVPlacementID = @"b5b44a09a5c912";//to be modified
static NSString *const kIronsourceRVPlacementID = @"b5b44a0bf09475";//to be modified
static NSString *const kVungleRVPlacementID = @"b5b44a0d05d707";//to be modified
static NSString *const kAdcolonyRVPlacementID = @"b5b44a0de295ad";//to be modified
static NSString *const kUnityAdsPlacementID = @"b5b44a0c7b9b64";//to be modified
static NSString *const kAllPlacementID = @"b5b44a0f115321";
static NSString *const kTTPlacementID = @"b5b72b21184aa8";
static NSString *const kAppnextPlacementID = @"b5bc7fb4fd15e6";
static NSString *const kBaiduPlacementID = @"b5c04dd81c1af3";
static NSString *const kNendPlacementID = @"b5cb96d6f68fdb";
static NSString *const kMaioPlacementID = @"b5cb96ce0b931e";
static NSString *const kSigmobPlacementID = @"b5d771f5a3458f";
static NSString *const kKSPlacementID = @"b5d807a31aa7dd";
static NSString *const kMyOfferPlacementID = @"b5db6c247dbb1e";
static NSString *const kOguryPlacementID = @"b5dde2379dc6ce";
static NSString *const kStartAppPlacementID = @"b5e7319f619931";
static NSString *const kFyberPlacementID = @"b5e96db106d8f2";
static NSString *const kGAMPlacementID = @"b5f23897bba4ca";
static NSString *const kHeliumPlacementID = @"b5f583ea323756";
static NSString *const kADXPlacementID = @"b5fa2500639c86";
static NSString *const kOnlineApiPlacementID = @"b5fa250b176abb";
static NSString *const kKidozPlacementID = @"b5feaa2c0a6191";
static NSString *const kMyTargetPlacementID = @"b5feaa2f32f161";
static NSString *const kMobrainPlacementID = @"b601cac7bb1a21";

#ifdef UNDER_DEVELOPMENT
    static NSString *const kOFMPlacementID = @"b600285fb4a0de";
#else
    static NSString *const kOFMPlacementID = @"b60001e703276f";
#endif
@implementation HBRewardedVideoVideoViewController
-(instancetype) initWithPlacementName:(NSString*)name {
    self = [super initWithNibName:nil bundle:nil];
    if (self != nil) {
        _name = name;
        _placementIDs = @{
                          kMintegralPlacement:kMintegralPlacementID,
                          kHeaderBiddingPlacement:kMintegralHeaderBiddingPlacementID,
                          kAllPlacementName:kAllPlacementID,
                          kInmobiPlacement:kInmobiPlacementID,
                          kFacebookPlacement:kFacebookPlacementID,
                          kFacebookHeaderBiddingPlacement:kFacebookHeaderBiddingPlacementID,
                          kAdMobPlacement:kAdMobPlacementID,
                          kGDTPlacement:kGDTPlacementID,
                          kMopubPlacementName:kMopubPlacementID,
                          kMopubVideoPlacementName:kMopubVideoPlacementID,
                          kApplovinPlacement:kApplovinPlacementID,
                          kTapjoyPlacementName:kTapjoyRVPlacementID,
                          kChartboostPlacementName:kChartboostRVPlacementID,
                          kIronsourcePlacementName:kIronsourceRVPlacementID,
                          kVunglePlacementName:kVungleRVPlacementID,
                          kAdcolonyPlacementName:kAdcolonyRVPlacementID,
                          kUnityAdsPlacementName:kUnityAdsPlacementID,
                          kTTPlacementName:kTTPlacementID,
                          kAppnextPlacement:kAppnextPlacementID,
                          kBaiduPlacement:kBaiduPlacementID,
                          kNendPlacement:kNendPlacementID,
                          kMaioPlacement:kMaioPlacementID,
                          kSigmobPlacement:kSigmobPlacementID,
                          kKSPlacement:kKSPlacementID,
                          kMyOfferPlacement:kMyOfferPlacementID,
                          kOguryPlacement:kOguryPlacementID,
                          kStartAppPlacement:kStartAppPlacementID,
                          kFyberPlacement:kFyberPlacementID,
                          kGAMPlacement:kGAMPlacementID,
                          kHeliumPlacement:kHeliumPlacementID,
                          kADXPlacement:kADXPlacementID,
                          kOnlineApiPlacement:kOnlineApiPlacementID,
                          kKidozPlacement:kKidozPlacementID,
                          kMyTargetPlacement:kMyTargetPlacementID,
                          kMobrainPlacement:kMobrainPlacementID
                          };
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _name;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _reloadADButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_reloadADButton addTarget:self action:@selector(reloadADButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [_reloadADButton setTitleColor:_reloadADButton.tintColor forState:UIControlStateNormal];
    [_reloadADButton setTitle:@"Reload AD" forState:UIControlStateNormal];
    [_reloadADButton setBackgroundColor:[UIColor grayColor]];
    _reloadADButton.frame = CGRectMake(.0f, CGRectGetMaxY(self.view.bounds) - 100.0f, (CGRectGetWidth(self.view.bounds) - 40) / 2.0f, 60.0f);
    [self.view addSubview:_reloadADButton];
    
    _showAdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_showAdButton addTarget:self action:@selector(showAD) forControlEvents:UIControlEventTouchUpInside];
    [_showAdButton setTitleColor:_showAdButton.tintColor forState:UIControlStateNormal];
    [_showAdButton setTitle:@"Show AD" forState:UIControlStateNormal];
    [_showAdButton setBackgroundColor:[UIColor grayColor]];
    _showAdButton.frame = CGRectMake(CGRectGetMaxX(_reloadADButton.frame) + 40.0f, CGRectGetMinY(_reloadADButton.frame), (CGRectGetWidth(self.view.bounds) - 40) / 2.0f, 60.0f);
    [self.view addSubview:_showAdButton];
    
    _clearAdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_clearAdButton addTarget:self action:@selector(clearAdButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [_clearAdButton setTitleColor:_clearAdButton.tintColor forState:UIControlStateNormal];
    [_clearAdButton setTitle:@"clear cache" forState:UIControlStateNormal];
    [_clearAdButton setBackgroundColor:[UIColor grayColor]];
    _clearAdButton.frame = CGRectMake(.0f, CGRectGetMinY(_reloadADButton.frame) - 20.0f - 60.0f, (CGRectGetWidth(self.view.bounds) - 40) / 2.0f, 60.0f);
    [self.view addSubview:_clearAdButton];
    
    _removeAdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_removeAdButton addTarget:self action:@selector(removeAdButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [_removeAdButton setTitleColor:_removeAdButton.tintColor forState:UIControlStateNormal];
    [_removeAdButton setTitle:@"Ad Ready?" forState:UIControlStateNormal];
    [_removeAdButton setBackgroundColor:[UIColor grayColor]];
    _removeAdButton.frame = CGRectMake(CGRectGetMaxX(_clearAdButton.frame) + 40.0f, CGRectGetMinY(_clearAdButton.frame), (CGRectGetWidth(self.view.bounds) - 40) / 2.0f, 60.0f);
    [self.view addSubview:_removeAdButton];
    
    _failureTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(.0f, 64.0f, CGRectGetWidth(self.view.bounds), 400.0f)];
    _failureTipsLabel.text = @"Failed to load ad";
    _failureTipsLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_failureTipsLabel];
    _failureTipsLabel.hidden = YES;
    
    [HBAdManager sharedManager].extra = @{kHBAdLoadingExtraUserIDKey:@"test_user_id"};
}

-(void) removeAdButtonTapped {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:[[HBAdManager sharedManager] isReadyRewardedVideoWithPlacementID:_placementIDs[_name]] ? @"Ready!" : @"Not Yet!" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
}

-(void) clearAdButtonTapped {
    [[HBAdManager sharedManager] clearCache];
}

-(void) dealloc {
    NSLog(@"dealloc");
}

-(void) reloadADButtonTapped {
//    _reload = YES;
    _failureTipsLabel.hidden = YES;
    [self.view addSubview:_loadingView];
    
    [[HBAdManager sharedManager] loadAd:_placementIDs[_name] extra:@{kHBAdLoadingExtraMediaExtraKey:@"media_val", kHBAdLoadingExtraUserIDKey:@"rv_test_user_id",kHBAdLoadingExtraRewardNameKey:@"reward_Name",kHBAdLoadingExtraRewardAmountKey:@(3)} delegate:self];
}

-(void) showAD {
    [[HBAdManager sharedManager] showRewardedVideoAd:_placementIDs[_name] scene:@"f5e54970dc84e6" inViewController:self delegate:self];
}

#pragma mark - loading delegate
-(void) didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"HBRewardedVideoVideoViewController::didFinishLoadingADWithPlacementID:%@", placementID);
    _failureTipsLabel.hidden = YES;
    [_loadingView removeFromSuperview];
//    if (!_reload) [self showAD];
//    _reload = NO;
}

-(void) didFailToLoadADWithPlacementID:(NSString*)placementID error:(NSError*)error {
    [_loadingView removeFromSuperview];
    _failureTipsLabel.hidden = NO;
    NSLog(@"HBRewardedVideoVideoViewController::didFailToLoadADWithPlacementID:%@ error:%@", placementID, error);
}
#pragma mark - showing delegate
-(void) rewardedVideoDidRewardSuccessForPlacemenID:(NSString *)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBRewardedVideoVideoViewController::rewardedVideoDidRewardSuccessForPlacemenID:%@ extra:%@",placementID,extra);
}

-(void) rewardedVideoDidStartPlayingForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBRewardedVideoVideoViewController::rewardedVideoDidStartPlayingForPlacementID:%@ extra:%@", placementID, extra);
    UIViewController *vc = self.presentedViewController;
    vc = nil;
}


-(void) rewardedVideoDidEndPlayingForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBRewardedVideoVideoViewController::rewardedVideoDidEndPlayingForPlacementID:%@ extra:%@", placementID, extra);
}

-(void) rewardedVideoDidFailToPlayForPlacementID:(NSString*)placementID error:(NSError*)error extra:(NSDictionary *)extra {
    NSLog(@"HBRewardedVideoVideoViewController::rewardedVideoDidFailToPlayForPlacementID:%@ error:%@ extra:%@", placementID, error, extra);
}

-(void) rewardedVideoDidCloseForPlacementID:(NSString*)placementID rewarded:(BOOL)rewarded extra:(NSDictionary *)extra {
    NSLog(@"HBRewardedVideoVideoViewController::rewardedVideoDidCloseForPlacementID:%@, rewarded:%@ extra:%@", placementID, rewarded ? @"yes" : @"no", extra);
}


-(void) rewardedVideoDidClickForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBRewardedVideoVideoViewController::rewardedVideoDidClickForPlacementID:%@ extra:%@", placementID, extra);
}

- (void)rewardedVideoDidDeepLinkOrJumpForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra result:(BOOL)success {
    NSLog(@"HBRewardedVideoVideoViewController:: rewardedVideoDidDeepLinkOrJumpForPlacementID:placementID:%@ with extra: %@, success:%@", placementID,extra, success ? @"YES" : @"NO");

}

// MARK:- OFMAdLoadingDelegate
- (void)didFinishLoadingOFMADWithPlacementID:(NSString *)placementID {
    NSLog(@"HBRewardedVideoVideoViewController::didFinishLoadingOFMADWithPlacementID:%@", placementID);

}

- (void)didFailToLoadOFMADWithPlacementID:(NSString *)placementID error:(NSError *)error {
    NSLog(@"HBRewardedVideoVideoViewController::didFailToLoadOFMADWithPlacementID:%@ error:%@", placementID, error);
}
@end
