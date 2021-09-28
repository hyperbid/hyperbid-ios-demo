//
//  HBBannerViewController.m
//  HyperBidSDKDemo
//
//  Created by Leo on 19/09/2018.
//  Copyright © 2018 Leo. All rights reserved.
//

#import "HBBannerViewController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "HyperBidAdManager.h"

@import HyperBidSDK;
@import HyperBidBanner;


static NSString *const kGDTPlacementID = @"b5bacad0803fd1";
static NSString *const kTTPlacementID = @"b5bacacfc470c9";
static NSString *const kAdmobPlacementID = @"b5bacacef17717";
static NSString *const kApplovinPlacementID = @"b5bacace1549da";
static NSString *const kFacebookPlacementID = @"b5baf502bb23e3";
static NSString *const kMopubPlacementID = @"b5baf57068e0b6";
static NSString *const kInmobiPlacementID = @"b5baf522891992";
static NSString *const kAllPlacementID = @"b5bacaccb61c29";
static NSString *const kAppnextPlacementID = @"b5bc7fb78288e9";
static NSString *const kBaiduPlacementID = @"b5c04dda229f7e";
static NSString *const kUnityAdsPlacementID = @"b5c21a04406722";
static NSString *const kNendPlacementID = @"b5cb96d97400b3";
static NSString *const kMintegralPlacementID = @"b5dd363166a5ea";
static NSString *const kBannerHeaderBiddingPlacementID = @"b5d146f9483215";
static NSString *const kFyberPlacementID = @"b5e96db4cb0682";
static NSString *const kStartAppPlacementID = @"b5ed47a285a23a";
static NSString *const kChartboostPlacementID = @"b5ee89f1a7eaf2";
static NSString *const kVunglePlacementID = @"b5ee89f3e63d80";
static NSString *const kAdColonyPlacementID = @"b5ee89f4d1791e";
static NSString *const kGAMPlacementID = @"b5f2389932a2ec";
static NSString *const kMyofferPlacementID = @"b5f33c3231eb91";
static NSString *const kADXPlacementID = @"b5fa24ff8a7446";
static NSString *const kOnlineApiPlacementID = @"b5fa2508fbdaf6";
//static NSString *const kFacebookInHousePlacementID = @"b5d146f9483215";
static NSString *const kKidozPlacementID = @"b5feaa2cfe2959";
static NSString *const kMyTargetPlacementID = @"b5feaa31284737";
static NSString *const kMobrainPlacementID = @"b601cac8974c40";

#ifdef UNDER_DEVELOPMENT
    static NSString *const kOFMBannerTestPlacementID = @"b600286067b736";
#else
    static NSString *const kOFMBannerTestPlacementID = @"b60001e71b4d74";
#endif

NSString *const kBannerShownNotification = @"banner_shown";
NSString *const kBannerLoadingFailedNotification = @"banner_failed_to_load";
@interface HBBannerViewController ()<HBBannerDelegate>
@property(nonatomic, readonly) NSString *name;
@property(nonatomic, readonly) NSDictionary<NSString*, NSString*>* placementIDs;
@property(nonatomic, readonly) UIActivityIndicatorView *loadingView;
@property(nonatomic, readonly) UIButton *reloadADButton;
@property(nonatomic, readonly) UIButton *clearAdButton;
@property(nonatomic, readonly) UIButton *showAdButton;
@property(nonatomic, readonly) UILabel *failureTipsLabel;
@property(nonatomic, readonly) UIButton *removeAdButton;
@property(nonatomic, weak) UIView *bannerView;
@property(nonatomic, weak) UIView *embededView;
@property(nonatomic, readonly) UIButton *readyButton;
@property(nonatomic, readonly) CGSize adSize;
@end

@implementation HBBannerViewController
-(instancetype) initWithPlacementName:(NSString*)name {
    self = [super initWithNibName:nil bundle:nil];
    if (self != nil) {
        _name = name;
        _placementIDs = @{
                          kGDTPlacement:kGDTPlacementID,
                          kTTPlacementName:kTTPlacementID,
                          kAdMobPlacement:kAdmobPlacementID,
                          kApplovinPlacement:kApplovinPlacementID,
                          kFacebookPlacement:kFacebookPlacementID,
                          kMopubPlacementName:kMopubPlacementID,
                          kInmobiPlacement:kInmobiPlacementID,
                          kAllPlacementName:kAllPlacementID,
                          kAppnextPlacement:kAppnextPlacementID,
                          kBaiduPlacement:kBaiduPlacementID,
                          kUnityAdsPlacementName:kUnityAdsPlacementID,
                          kNendPlacement:kNendPlacementID,
                          kMintegralPlacement:kMintegralPlacementID,
                          kHeaderBiddingPlacement:kBannerHeaderBiddingPlacementID,
                          kFyberPlacement:kFyberPlacementID,
                          kStartAppPlacement:kStartAppPlacementID,
                          kVunglePlacementName:kVunglePlacementID,
                          kChartboostPlacementName:kChartboostPlacementID,
                          kAdcolonyPlacementName:kAdColonyPlacementID,
                          kGAMPlacement:kGAMPlacementID,
                          kMyOfferPlacement:kMyofferPlacementID,
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = _name;
    _reloadADButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_reloadADButton addTarget:self action:@selector(reloadADButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [_reloadADButton setTitleColor:_reloadADButton.tintColor forState:UIControlStateNormal];
    [_reloadADButton setTitle:@"Reload AD" forState:UIControlStateNormal];
    [_reloadADButton setBackgroundColor:[UIColor grayColor]];
    _reloadADButton.frame = CGRectMake(.0f, CGRectGetMaxY(self.view.bounds) - 100.0f, (CGRectGetWidth(self.view.bounds) - 40) / 2.0f, 60.0f);
    [self.view addSubview:_reloadADButton];
    
    _showAdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_showAdButton addTarget:self action:@selector(showBanner) forControlEvents:UIControlEventTouchUpInside];
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
    [_removeAdButton setTitle:@"Remove Ad" forState:UIControlStateNormal];
    [_removeAdButton setBackgroundColor:[UIColor grayColor]];
    _removeAdButton.frame = CGRectMake(CGRectGetMaxX(_clearAdButton.frame) + 40.0f, CGRectGetMinY(_clearAdButton.frame), (CGRectGetWidth(self.view.bounds) - 40) / 2.0f, 60.0f);
    [self.view addSubview:_removeAdButton];
    
    _readyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_readyButton addTarget:self action:@selector(readyButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [_readyButton setTitleColor:_readyButton.tintColor forState:UIControlStateNormal];
    [_readyButton setTitle:@"Ad Ready?" forState:UIControlStateNormal];
    [_readyButton setBackgroundColor:[UIColor grayColor]];
    _readyButton.frame = CGRectMake(CGRectGetMinX(_clearAdButton.frame), CGRectGetMinY(_clearAdButton.frame) - 65.0f, (CGRectGetWidth(self.view.bounds) - 40) / 2.0f, 60.0f);
    [self.view addSubview:_readyButton];
    
    _failureTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(.0f, 64.0f, CGRectGetWidth(self.view.bounds), 400.0f)];
    _failureTipsLabel.text = @"Failed to load ad";
    _failureTipsLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_failureTipsLabel];
    _failureTipsLabel.hidden = YES;
    
    _adSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 250.0f);
    if([HyperBidAdManager sharedManager].currentAPIType == HyperBidAPITypeHyperBid){
        if ([[HBAdManager sharedManager] isReadyBannerAdWithPlacementID:_placementIDs[_name]]) {
            NSLog(@"HBBannerViewController::banner ad ready, will show");
            [self showBanner];
        } else {
            NSLog(@"HBBannerViewController::banner ad not ready, will load");
            [self reloadADButtonTapped];
        }
    }
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self removeAdButtonTapped];
}

-(void) readyButtonTapped {
        HBCheckLoadModel *model = [[HBAdManager sharedManager] checkBannerLoadStatusForPlacementID:_placementIDs[_name]];

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:[[HBAdManager sharedManager] isReadyBannerAdWithPlacementID:_placementIDs[_name]] ? @"Ready!" : @"Not Yet!" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
}

-(void) reloadADButtonTapped {
    _failureTipsLabel.hidden = YES;
    [self.view addSubview:_loadingView];
    
    //GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth 自适应
    //GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth 竖屏
    //GADLandscapeAnchoredAdaptiveBannerAdSizeWithWidth 横屏
    GADAdSize admobSize = GADLandscapeAnchoredAdaptiveBannerAdSizeWithWidth(CGRectGetWidth(self.view.bounds));
    if([HyperBidAdManager sharedManager].currentAPIType == HyperBidAPITypeHyperBid){
        [[HBAdManager sharedManager] loadAd:_placementIDs[_name] extra:@{kHBAdLoadingExtraBannerAdSizeKey:[NSValue valueWithCGSize:_adSize], kHBAdLoadingExtraBannerSizeAdjustKey:@NO,kHBAdLoadingExtraAdmobBannerSizeKey:[NSValue valueWithCGSize:admobSize.size],kHBAdLoadingExtraAdmobAdSizeFlagsKey:@(admobSize.flags)} delegate:self];
    }
}

-(void) removeAdButtonTapped {
    [[self.view viewWithTag:3333] removeFromSuperview];
    NSLog(@"banner removed");
}

-(void) clearAdButtonTapped {
    HBBannerViewController *tVC = [[HBBannerViewController alloc] initWithPlacementName:kGDTPlacement];
    [self.navigationController pushViewController:tVC animated:YES];
}

-(void) dealloc {
     [[self.view viewWithTag:3333] removeFromSuperview];
    NSLog(@"HBBannerViewController::dealloc");
}

-(void) showBanner {
        if ([[HBAdManager sharedManager] isReadyBannerAdWithPlacementID:_placementIDs[_name]]) {
            NSInteger tag = 3333;
            [[self.view viewWithTag:tag] removeFromSuperview];
            HBBannerView *bannerView = [[HBAdManager sharedManager] getBannerViewWithPlacementID:_placementIDs[_name] scene:@"f600938d045dd3"];
            if (bannerView != nil) {
                bannerView.delegate = self;
                bannerView.presentingViewController = self;
                bannerView.translatesAutoresizingMaskIntoConstraints = NO;
                bannerView.tag = tag;
                bannerView.layer.borderColor = [UIColor redColor].CGColor;
                bannerView.layer.borderWidth = .5f;
                bannerView.backgroundColor = [UIColor colorWithRed:.0f green:.0f blue:1.0f alpha:.4f];
                [self.view addSubview:bannerView];
                [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:bannerView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:.0f]];
                [self.view addConstraint:[NSLayoutConstraint constraintWithItem:bannerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) + CGRectGetHeight(self.navigationController.navigationBar.frame)]];
                [self.view addConstraint:[NSLayoutConstraint constraintWithItem:bannerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:_adSize.width]];
                [self.view addConstraint:[NSLayoutConstraint constraintWithItem:bannerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:_adSize.height]];
            }else {
                NSLog(@"BannerView is nil for placementID:%@", _placementIDs[_name]);
            }
        } else {
            NSLog(@"Banner ad's not ready for placementID:%@", _placementIDs[_name]);
        }
}

#pragma mark - delegate method(s)
-(void) didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"HBBannerViewController::didFinishLoadingADWithPlacementID:%@", placementID);
    [_loadingView removeFromSuperview];
}

-(void) didFailToLoadADWithPlacementID:(NSString*)placementID error:(NSError*)error {
    NSLog(@"HBBannerViewController::didFailToLoadADWithPlacementID:%@ error:%@", placementID, error);
    _failureTipsLabel.hidden = NO;
#ifdef BANNER_AUTO_TEST
    [[NSNotificationCenter defaultCenter] postNotificationName:kBannerLoadingFailedNotification object:nil];
    [self.navigationController popViewControllerAnimated:NO];
#endif
}


-(void) bannerView:(HBBannerView *)bannerView failedToAutoRefreshWithPlacementID:(NSString *)placementID error:(NSError *)error {
    NSLog(@"HBBannerViewController::bannerView:failedToAutoRefreshWithPlacementID:%@ error:%@", placementID, error);
}

#pragma mark - add networkID and adsourceID delegate
- (void)bannerView:(HBBannerView *)bannerView didDeepLinkOrJumpForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra result:(BOOL)success {
    NSLog(@"HBBannerViewController:: didDeepLinkOrJumpForPlacementID:placementID:%@ with extra: %@, success:%@", placementID,extra, success ? @"YES" : @"NO");
}

-(void) bannerView:(HBBannerView*)bannerView didShowAdWithPlacementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBBannerViewController::bannerView:didShowAdWithPlacementID:%@ with extra: %@", placementID,extra);
#ifdef BANNER_AUTO_TEST
    [[NSNotificationCenter defaultCenter] postNotificationName:kBannerShownNotification object:nil];
    [self.navigationController popViewControllerAnimated:NO];
#endif
}
-(void) bannerView:(HBBannerView*)bannerView didClickWithPlacementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBBannerViewController::bannerView:didClickWithPlacementID:%@ with extra: %@", placementID,extra);
}
-(void) bannerView:(HBBannerView*)bannerView didCloseWithPlacementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBBannerViewController::bannerView:didCloseWithPlacementID:%@ with extra: %@", placementID,extra);
}
-(void) bannerView:(HBBannerView*)bannerView didAutoRefreshWithPlacement:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBBannerViewController::bannerView:didAutoRefreshWithPlacement:%@ with extra: %@", placementID,extra);
}

-(void) bannerView:(HBBannerView*)bannerView didTapCloseButtonWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra {
    NSLog(@"HBBannerViewController::bannerView:didTapCloseButtonWithPlacementID:%@ extra: %@", placementID,extra);
}

-(void) didFinishLoadingOFMADWithPlacementID:(NSString *)placementID {
    NSLog(@"HBBannerViewController::didFinishLoadingOFMADWithPlacementID:%@", placementID);
    [_loadingView removeFromSuperview];
}
-(void) didFailToLoadOFMADWithPlacementID:(NSString*)placementID error:(NSError*)error {
    NSLog(@"HBBannerViewController::didFailToLoadOFMADWithPlacementID:%@ error:%@", placementID, error);
    _failureTipsLabel.hidden = NO;
#ifdef BANNER_AUTO_TEST
    [[NSNotificationCenter defaultCenter] postNotificationName:kBannerLoadingFailedNotification object:nil];
    [self.navigationController popViewControllerAnimated:NO];
#endif
}

-(void) bannerDidShowForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra {
    NSLog(@"HBBannerViewController::bannerDidShowForPlacementID:%@ with extra: %@", placementID,extra);
#ifdef BANNER_AUTO_TEST
    [[NSNotificationCenter defaultCenter] postNotificationName:kBannerShownNotification object:nil];
    [self.navigationController popViewControllerAnimated:NO];
#endif
}
-(void) bannerDidCloseForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra {
    NSLog(@"HBBannerViewController::bannerView:bannerDidCloseForPlacementID:%@ extra: %@", placementID,extra);
}
-(void) bannerDidClickForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra {
    NSLog(@"HBBannerViewController::bannerDidClickForPlacementID:%@ with extra: %@", placementID,extra);
}
-(void) bannerDeepLinkOrJumpForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra result:(BOOL)success {
    NSLog(@"HBBannerViewController:: bannerDeepLinkOrJumpForPlacementID:placementID:%@ with extra: %@, success:%@", placementID,extra, success ? @"YES" : @"NO");
}


@end
