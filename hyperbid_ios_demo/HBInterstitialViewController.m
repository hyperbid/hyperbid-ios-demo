//
//  HBInterstitialViewController.m
//  HyperBidSDKDemo
//
//  Created by Leo on 21/09/2018.
//  Copyright © 2018 Leo. All rights reserved.
//

#import "HBInterstitialViewController.h"
#import "HyperBidAdManager.h"

@import HyperBidSDK;
@import HyperBidInterstitial;

NSString *const kMintegralVideoPlacement = @"Mintegral(Video)";
NSString *const kTTVideoPlacement = @"TT(Video)";
NSString *const kNendInterstitialVideoPlacement = @"Nend(Video)";
NSString *const kNendFullScreenInterstitialPlacement = @"Nend(Full Screen)";
NSString *const kHeaderBiddingPlacement = @"Header Bidding";
NSString *const kStartAppPlacement = @"StartApp";
NSString *const kStartAppVideoPlacement = @"StartApp(Video)";
NSString *const kFyberPlacement = @"Fyber";
NSString *const kSigmobRVIntPlacement = @"Sibmob(RV)";
NSString *const kOFMPlacement = @"OFM";

static NSString *const kGDTPlacementID = @"b5bacad8ea3036";
static NSString *const kTTPlacementID = @"b5bacad7373b89";
static NSString *const kTTVideoPlacementID = @"b5bacad80a0fb1";
static NSString *const kAdmobPlacementID = @"b5bacad6860972";
static NSString *const kMintegralPlacementID = @"b5bacad46a8bbb";
static NSString *const kMintegralVideoPlacementID = @"b5bacad5962e84";
static NSString *const kMintegralHeaderBiddingPlacementID = @"b5d13340a1dd21";
static NSString *const kApplovinPlacementID = @"b5bacad34e4294";
static NSString *const kFacebookPlacementID = @"b5baf4bf9829e4";
static NSString *const kFacebookHeaderBiddingPlacementID = @"b5d133421525a6";
static NSString *const kAllPlacementID = @"b5bacad26a752a";
static NSString *const kInmobiPlacementID = @"b5baf524062aca";
static NSString *const kMopubPlacementID = @"b5baf56f03dbe9";
static NSString *const kChartboostPlacementID = @"b5baf5cd422553";
static NSString *const kTapjoyPlacementID = @"b5baf5ebe8df89";
static NSString *const kIronsourcePlacementID = @"b5baf617891a2e";
static NSString *const kVunglePlacementID = @"b5baf61edafdbb";
static NSString *const kAdColonyPlacementID = @"b5baf620280a65";
static NSString *const kAppnextPlacementID = @"b5bc7fb9cbfff1";
static NSString *const kBaiduPlacementID = @"b5c04ddc6ba49e";
static NSString *const kUnityAdsPlacementID = @"b5c21a055a51ab";
static NSString *const kNendPlacementID = @"b5cb96db9b3b0f";
static NSString *const kNendVideoPlacementID = @"b5cb96dd930c57";
static NSString *const kNendFullScreenPlacementID = @"b5cb96df0f1914";
static NSString *const kMaioPlacementID = @"b5cb96cf795c4b";
static NSString *const kSigmobPlacementID = @"b5ed8ceb5a286d";
static NSString *const kSigmobIntRVPlacementID = @"b5d771f79e4a32";
static NSString *const kKSPlacementID = @"b5d807a4846f50";
static NSString *const kMyOfferPlacementID = @"b5db6c26999c31";
static NSString *const kOguryPlacementID = @"b5dde238f2d2ce";
static NSString *const kStartAppPlacementID = @"b5e731a0acabdf";
static NSString *const kStartAppVideoPlacementID = @"b5e732a9577182";
static NSString *const kFyberPlacementID = @"b5e96db2198474";
static NSString *const kGAMPlacementID = @"b5f2389ab6ee63";
static NSString *const kHeliumPlacementID = @"b5f583ec12143f";
static NSString *const kADXPlacementID = @"b5fa25016e80bd";
static NSString *const kOnlineApiPlacementID = @"b5fa250771e076";
static NSString *const kKidozPlacementID = @"b5feaa2df0e121";
static NSString *const kMyTargetPlacementID = @"b5feaa306e483c";
static NSString *const kMobrainPlacementID = @"b601cac971d07c";

#ifdef UNDER_DEVELOPMENT
    static NSString *const kOFMPlacementID = @"b6002860de4410";
#else
    static NSString *const kOFMPlacementID = @"b60001e740f168";
#endif

@interface HBInterstitialViewController ()<HBInterstitialDelegate>
@property(nonatomic, readonly) NSString *name;
@property(nonatomic, readonly) NSDictionary<NSString*, NSString*>* placementIDs;
@property(nonatomic, readonly) UIActivityIndicatorView *loadingView;
@property(nonatomic, readonly) UILabel *failureTipsLabel;
@property(nonatomic, readonly) UIButton *reloadADButton;
@property(nonatomic, readonly) UIButton *clearAdButton;
@property(nonatomic, readonly) UIButton *showAdButton;
@property(nonatomic, readonly) UIButton *removeAdButton;
@end

@implementation HBInterstitialViewController
-(instancetype) initWithPlacementName:(NSString *)name {
    if (self = [super init]) {
        _name = name;
        _placementIDs = @{
                          kGDTPlacement:kGDTPlacementID,
                          kTTPlacementName:kTTPlacementID,
                          kTTVideoPlacement:kTTVideoPlacementID,
                          kAdMobPlacement:kAdmobPlacementID,
                          kMintegralPlacement:kMintegralPlacementID,
                          kMintegralVideoPlacement:kMintegralVideoPlacementID,
                          kHeaderBiddingPlacement:kMintegralHeaderBiddingPlacementID,
                          kApplovinPlacement:kApplovinPlacementID,
                          kFacebookPlacement:kFacebookPlacementID,
                          kFacebookHeaderBiddingPlacement:kFacebookHeaderBiddingPlacementID,
                          kInmobiPlacement:kInmobiPlacementID,
                          kMopubPlacementName:kMopubPlacementID,
                          kChartboostPlacementName:kChartboostPlacementID,
                          kTapjoyPlacementName:kTapjoyPlacementID,
                          kIronsourcePlacementName:kIronsourcePlacementID,
                          kVunglePlacementName:kVunglePlacementID,
                          kAdcolonyPlacementName:kAdColonyPlacementID,
                          kAllPlacementName:kAllPlacementID,
                          kAppnextPlacement:kAppnextPlacementID,
                          kBaiduPlacement:kBaiduPlacementID,
                          kUnityAdsPlacementName:kUnityAdsPlacementID,
                          kNendPlacement:kNendPlacementID,
                          kNendInterstitialVideoPlacement:kNendVideoPlacementID,
                          kNendFullScreenInterstitialPlacement:kNendFullScreenPlacementID,
                          kMaioPlacement:kMaioPlacementID,
                          kSigmobPlacement:kSigmobPlacementID,
                          kSigmobRVIntPlacement:kSigmobIntRVPlacementID,
                          kKSPlacement:kKSPlacementID,
                          kMyOfferPlacement:kMyOfferPlacementID,
                          kOguryPlacement:kOguryPlacementID,
                          kStartAppPlacement:kStartAppPlacementID,
                          kStartAppVideoPlacement:kStartAppVideoPlacementID,
                          kFyberPlacement:kFyberPlacementID,
                          kGAMPlacement:kGAMPlacementID,
                          kHeliumPlacement:kHeliumPlacementID,
                          kADXPlacement:kADXPlacementID,
                          kOnlineApiPlacement:kOnlineApiPlacementID,
                          kKidozPlacement:kKidozPlacementID,
                          kMyTargetPlacement:kMyTargetPlacementID,
                          kOFMPlacement:kOFMPlacementID,
                          kMobrainPlacement:kMobrainPlacementID
                          };
    }
    return self;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    [[HBAPI sharedInstance] setCustomData:@{@"test_key":@"test_val"} forPlacementID:kGDTPlacementID];
    
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
}


//Ad ready?
-(void) removeAdButtonTapped {
    BOOL isReady = NO;
    isReady = [[HBAdManager sharedManager] isReadyInterstitialWithPlacementID:_placementIDs[_name]];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:isReady ? @"Ready!" : @"Not Yet!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
//    //check load status
//    [[HBAdManager sharedManager] checkInterstitialReadyAdInfo:_placementIDs[_name]];
}

-(void) clearAdButtonTapped {
    [[HBAdManager sharedManager] clearCache];
}

-(void) dealloc {
    NSLog(@"dealloc");
}

-(void) reloadADButtonTapped {
    NSLog(@"Begin loading interstitial ad");
    _failureTipsLabel.hidden = YES;
    [self.view addSubview:_loadingView];
    [[HBAdManager sharedManager] loadAd:_placementIDs[_name] extra:[_name isEqualToString:kSigmobRVIntPlacement] ? @{kHBInterstitialExtraUsesRewardedVideo:@YES} : @{} delegate:self];
    
}

-(void) showAD {
    [[HBAdManager sharedManager] showInterstitialAd:_placementIDs[_name] scene:@"f5e549727efc49" inViewController:self delegate:self];
}

#pragma mark - delegate method(s)
-(void) didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"HBInterstitialViewController::didFinishLoadingADWithPlacementID:%@", placementID);
    _showAdButton.enabled = YES;
}

-(void) didFailToLoadADWithPlacementID:(NSString*)placementID error:(NSError*)error {
    NSLog(@"HBInterstitialViewController::didFailToLoadADWithPlacementID:%@ error:%@", placementID, error);
}

// ofm
-(void) didFinishLoadingOFMADWithPlacementID:(NSString *)placementID {
    NSLog(@"HBInterstitialViewController::didFinishLoadingOFMADWithPlacementID:%@", placementID);
    _showAdButton.enabled = YES;
}

-(void) didFailToLoadOFMADWithPlacementID:(NSString*)placementID error:(NSError*)error {
    NSLog(@"HBInterstitialViewController::didFailToLoadOFMADWithPlacementID:%@ error:%@", placementID, error);
}

#pragma mark - delegate with networkID and adsourceID

-(void) interstitialDidShowForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBInterstitialViewController::interstitialDidShowForPlacementID:%@ extra:%@", placementID, extra);
}

-(void) interstitialFailedToShowForPlacementID:(NSString*)placementID error:(NSError*)error extra:(NSDictionary *)extra {
    NSLog(@"HBInterstitialViewController::interstitialFailedToShowForPlacementID:%@ error:%@ extra:%@", placementID, error, extra);
}

-(void) interstitialDidFailToPlayVideoForPlacementID:(NSString*)placementID error:(NSError*)error extra:(NSDictionary*)extra {
    NSLog(@"HBInterstitialViewController::interstitialDidFailToPlayVideoForPlacementID:%@ error:%@ extra:%@", placementID, error, extra);
}

-(void) interstitialDidStartPlayingVideoForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBInterstitialViewController::interstitialDidStartPlayingVideoForPlacementID:%@ extra:%@", placementID, extra);
}

-(void) interstitialDidEndPlayingVideoForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBInterstitialViewController::interstitialDidEndPlayingVideoForPlacementID:%@ extra:%@", placementID, extra);
}

-(void) interstitialDidCloseForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBInterstitialViewController::interstitialDidCloseForPlacementID:%@ extra:%@", placementID, extra);
}

-(void) interstitialDidClickForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBInterstitialViewController::interstitialDidClickForPlacementID:%@ extra:%@", placementID, extra);
}

- (void)interstitialDeepLinkOrJumpForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra result:(BOOL)success {
    NSLog(@"HBInterstitialViewController:: interstitialDeepLinkOrJumpForPlacementID:placementID:%@ with extra: %@, success:%@", placementID,extra, success ? @"YES" : @"NO");

}
@end
