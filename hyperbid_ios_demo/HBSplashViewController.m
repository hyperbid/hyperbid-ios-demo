//
//  HBSplashViewController.m
//  HyperBidSDKDemo
//
//  Created by Jean on 2020/12/3.
//  Copyright © 2020 HyperBid. All rights reserved.
//

#import "HBSplashViewController.h"
#import <HyperBidNative/HyperBidNative.h>
#import "HyperBidAdManager.h"

@import HyperBidSDK;
@import HyperBidSplash;

NSString *const kGDTZoomOutPlacement = @"GDT(V+)";

static NSString *const kMintegralPlacementID = @"b5ee89f9859d05";
static NSString *const kSigmobPlacementID = @"b5d771f34bc73d";
static NSString *const kGDTPlacementID = @"b5c1b0470c7e4a";
static NSString *const kGDTZoomOutPlacementID = @"b5fd75a304f0a4";
static NSString *const kBaiduPlacementID = @"b5c1b047a970fe";
static NSString *const kTTPlacementID = @"b5c1b048c498b9";
static NSString *const kAdmobPlacementID = @"b5f842af26114c";
static NSString *const kKSPlacementID = @"b5fb767e454cce";
static NSString *const kAllPlacementID = @"b5c22f0e5cc7a0";
static NSString *const kMyofferPlacementID = @"b5f33c33431ca0";
static NSString *const kADXPlacementID = @"b5fa25036683d2";
static NSString *const kOnlineApiPlacementID = @"b5fa2509a93b71";
static NSString *const kMobrainPlacementID = @"b601a111ad6efa";

#ifdef UNDER_DEVELOPMENT
    static NSString *const kOFMPlacementID = @"b60028618171df";
#else
    static NSString *const kOFMPlacementID = @"b60001e758832c";
#endif

@interface HBSplashViewController ()<HBSplashDelegate,HBNativeSplashDelegate>

@property(nonatomic, readonly) UIActivityIndicatorView *loadingView;
@property(nonatomic, readonly) UIButton *reloadADButton;
@property(nonatomic, readonly) UIButton *clearAdButton;
@property(nonatomic, readonly) UIButton *showAdButton;
@property(nonatomic, readonly) UILabel *failureTipsLabel;
@property(nonatomic, readonly) UIButton *readyButton;
@property(nonatomic, readonly) NSString *name;
@property(nonatomic, readonly) NSDictionary *placementIDs;
@end

@implementation HBSplashViewController

- (instancetype)initWithPlacementName:(NSString *)name {
    self = [super initWithNibName:nil bundle:nil];
    if (self != nil) {
        _name = name;
        _placementIDs = @{
            kMintegralPlacement:kMintegralPlacementID,
            kSigmobPlacement:kSigmobPlacementID,
            kGDTPlacement:kGDTPlacementID,
            kGDTZoomOutPlacement:kGDTZoomOutPlacementID,
            kBaiduPlacement:kBaiduPlacementID,
            kTTPlacementName:kTTPlacementID,
            kAdMobPlacement:kAdmobPlacementID,
            kKSPlacement:kKSPlacementID,
            kAllPlacementName:kAllPlacementID,
            kMyOfferPlacement:kMyofferPlacementID,
            kADXPlacement:kADXPlacementID,
            kOnlineApiPlacement:kOnlineApiPlacementID,
            kMobrainPlacement:kMobrainPlacementID
        };
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _name;
    
    [self setupSubviews];
}

- (void)setupSubviews {
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
    
    _readyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_readyButton addTarget:self action:@selector(readyButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [_readyButton setTitleColor:_readyButton.tintColor forState:UIControlStateNormal];
    [_readyButton setTitle:@"Ad Ready?" forState:UIControlStateNormal];
    [_readyButton setBackgroundColor:[UIColor grayColor]];
    _readyButton.frame = CGRectMake(CGRectGetMaxX(_clearAdButton.frame) + 40.0f, CGRectGetMinY(_clearAdButton.frame), (CGRectGetWidth(self.view.bounds) - 40) / 2.0f, 60.0f);
    [self.view addSubview:_readyButton];
    
    _failureTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(.0f, 64.0f, CGRectGetWidth(self.view.bounds), 400.0f)];
    _failureTipsLabel.text = @"Failed to load ad";
    _failureTipsLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_failureTipsLabel];
    _failureTipsLabel.hidden = YES;
}

// MARK:- data
- (NSDictionary *)getSplashInfo:(NSString *)name {
    NSDictionary *extra = nil;
    NSTimeInterval tolerateTimeout = 5.5f;
    if ([name isEqualToString:kMintegralPlacement]) {
        extra = @{kHBSplashExtraNetworkFirmID:@6,
                  kHBSplashExtraAdSourceIDKey:@"68147",
                  kHBSplashExtraMintegralAppID:@"104036",
                  kHBSplashExtraMintegralAppKey:@"ef13ef712aeb0f6eb3d698c4c08add96",
                  kHBSplashExtraMintegralUnitID:@"275050",
                  kHBSplashExtraTolerateTimeoutKey:@(tolerateTimeout)
        };
    } else if ([name isEqualToString:kSigmobPlacement]) {
        extra = @{kHBSplashExtraNetworkFirmID:@29,
                  kHBSplashExtraAdSourceIDKey:@"12302",
                  kHBSplashExtraSigmobAppKey:@"eccdcdbd9adbd4a7",
                  kHBSplashExtraSigmobAppID:@"6877",
                  kHBSplashExtraSigmobPlacementID:@"ea1f8f9bd12",
                  kHBSplashExtraTolerateTimeoutKey:@(tolerateTimeout)
        };
    } else if ([name isEqualToString:kGDTPlacement]) {
        extra = @{kHBSplashExtraNetworkFirmID:@8,
                  kHBSplashExtraAdSourceIDKey:@"12302",
                  kHBSplashExtraGDTAppID:@"1105344611",
                  kHBSplashExtraGDTUnitID:@"9040714184494018",
                  kHBSplashExtraTolerateTimeoutKey:@(tolerateTimeout)
        };
    } else if ([name isEqualToString:kBaiduPlacement]) {
        extra = @{kHBSplashExtraNetworkFirmID:@22,
                  kHBSplashExtraAdSourceIDKey:@"1074",
                  kHBSplashExtraBaiduAppID:@"ccb60059",
                  kHBSplashExtraBaiduAdPlaceID:@"2058492",
                  kHBSplashExtraTolerateTimeoutKey:@(tolerateTimeout)
        };
    } else if ([name isEqualToString:kTTPlacementName]) {
        extra = @{kHBSplashExtraNetworkFirmID:@15,
                  kHBSplashExtraAdSourceIDKey:@"3628",
                  kHBSplashExtraAppID:@"5000546",
                  kHBSplashExtraSlotID:@"800546808",
                  kHBSplashExtraTolerateTimeoutKey:@(tolerateTimeout)
        };
    } else if ([name isEqualToString:kAdMobPlacement]) {
        extra = @{kHBSplashExtraNetworkFirmID:@2,
                  kHBSplashExtraAdSourceIDKey:@"145203",
                  kHBSplashExtraAdmobAppID:@"ca-app-pub-9488501426181082~6772985580,",
                  kHBSplashExtraAdmobUnitID:@"ca-app-pub-3940256099942544/1033173712",
                  kHBSplashExtraAdmobOrientation:@(1),
                  kHBSplashExtraTolerateTimeoutKey:@(tolerateTimeout)
        };
    } else if ([name isEqualToString:kKSPlacement]) {
        extra = @{kHBSplashExtraNetworkFirmID:@28,
                  kHBSplashExtraAdSourceIDKey:@"197933",
                  kHBSplashExtraKSAppID:@"501400011",
                  kHBSplashExtraKSPosID:@"5014000369",
                  kHBSplashExtraShowDirectionKey:@(0),
                  kHBSplashExtraTolerateTimeoutKey:@(tolerateTimeout)
        };
    } else if ([name isEqualToString:kAllPlacementName]) {
        extra = @{kHBSplashExtraNetworkFirmID:@6,
                  kHBSplashExtraAdSourceIDKey:@"72004",
                  kHBSplashExtraMintegralAppID:@"104036",
                  kHBSplashExtraMintegralAppKey:@"ef13ef712aeb0f6eb3d698c4c08add96",
                  kHBSplashExtraMintegralUnitID:@"275050",
                  kHBSplashExtraTolerateTimeoutKey:@(tolerateTimeout)
        };
    } else {
        extra = @{
            kHBSplashExtraTolerateTimeoutKey:@(tolerateTimeout)
       };
    }
    
    return extra;
}

// MARK:- actions
-(void) readyButtonTapped {
    // another method
//    HBCheckLoadModel *checkLoadModel = [[HBAdManager sharedManager] checkSplashLoadStatusForPlacementID:_placementIDs[_name]];
//    NSMutableDictionary *info = [NSMutableDictionary dictionary];
//    info[@"result"] = @{@"isLoading":checkLoadModel.isLoading ? @"YES" : @"NO", @"isReady":checkLoadModel.isReady ? @"YES" : @"NO", @"adOfferInfo":checkLoadModel.adOfferInfo};
//    NSLog(@"%@",[NSString stringWithFormat:@"\nAPI invocation info:\n*****************************\n%@ \n*****************************", info]);
    
    BOOL ready = [[HBAdManager sharedManager] splashReadyForPlacementID:_placementIDs[_name]];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:ready ? @"Ready!" : @"Not Yet!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)clearAdButtonTapped {
    
}

- (void)reloadADButtonTapped {
    
    UILabel *label = nil;
    label = [[UILabel alloc] initWithFrame:CGRectMake(.0f, .0f, CGRectGetWidth([UIScreen mainScreen].bounds), 100.0f)];
    label.text = @"Container";
    label.textColor = [UIColor redColor];
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    NSMutableDictionary *mutableDict = [self getSplashInfo:_name].mutableCopy;
    
    [mutableDict setValue:self forKey:kHBSplashExtraRootViewControllerKey];
    [mutableDict setValue:@"887423907" forKey:kHBSplashExtraRIDKey];
    [mutableDict setValue:@"5135958" forKey:kHBSplashExtraAppIDKey];
    [mutableDict setValue:@(1) forKey:kHBSplashExtraMobrainAdnTypeKey];
    [mutableDict setValue:@"" forKey:kHBSplashExtraMobrainAppKeyKey];
    [[HBAdManager sharedManager] loadAd:_placementIDs[_name] extra:mutableDict delegate:self containerView:nil];
}

- (void)showAD {
    UIWindow *mainWindow = nil;
    if ( @available(iOS 13.0, *) ) {
        mainWindow = [UIApplication sharedApplication].windows.firstObject;
        [mainWindow makeKeyWindow];
    }else {
        mainWindow = [UIApplication sharedApplication].keyWindow;
    }
    
    [[HBAdManager sharedManager] showSplashWithPlacementID:_placementIDs[_name] window:mainWindow delegate:self];
}

// MARK:- splash delegate

- (void)didFailToLoadADWithPlacementID:(NSString *)placementID error:(NSError *)error {
    NSLog(@"HBSplashViewController::didFailToLoadADWithPlacementID:%@ error:%@",placementID,error);
}

- (void)didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"HBSplashViewController::didFinishLoadingADWithPlacementID:%@",placementID);
}

- (void)splashDeepLinkOrJumpForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra result:(BOOL)success {
    NSLog(@"HBSplashViewController:: splashDeepLinkOrJumpForPlacementID:placementID:%@ with extra: %@, success:%@", placementID,extra, success ? @"YES" : @"NO");
}

- (void)splashDidClickForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBSplashViewController::splashDidClickForPlacementID:%@ extra:%@",placementID,extra);

}

- (void)splashDidCloseForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBSplashViewController::splashDidCloseForPlacementID:%@ extra:%@",placementID,extra);

}

- (void)splashDidShowForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBSplashViewController::splashDidShowForPlacementID:%@ extra:%@",placementID,extra);
}

-(void)splashZoomOutViewDidClickForPlacementID:(NSString*)placementID extra:(NSDictionary *) extra {
    NSLog(@"HBSplashViewController::splashZoomOutViewDidClickForPlacementID:%@ extra:%@",placementID,extra);
}

-(void)splashZoomOutViewDidCloseForPlacementID:(NSString*)placementID extra:(NSDictionary *) extra {
    NSLog(@"HBSplashViewController::splashZoomOutViewDidCloseForPlacementID:%@ extra:%@",placementID,extra);
}

// MARK:- HBNativeSplashDelegate
- (void)didClickNaitveSplashAdForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBSplashViewController::didClickNaitveSplashAdForPlacementID:%@ extra:%@",placementID,extra);
}

- (void)didCloseNativeSplashAdForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBSplashViewController::didCloseNativeSplashAdForPlacementID:%@ extra:%@",placementID,extra);
}

- (void)didNativeSplashDeeplinkOrJumpForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra result:(BOOL)success {
    NSLog(@"HBSplashViewController::didCloseNativeSplashAdForPlacementID:%@ extra:%@, result:%@",placementID,extra, success ? @"YES" : @"NO");
}

- (void)didShowNativeSplashAdForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBSplashViewController::didShowNativeSplashAdForPlacementID:%@ extra:%@",placementID,extra);
}

- (void)failedToLoadNativeSplashAdForPlacementID:(NSString *)placementID error:(NSError *)error {
    NSLog(@"HBSplashViewController::didShowNativeSplashAdForPlacementID:%@ error:%@",placementID,error);
}

- (void)finishLoadingNativeSplashAdForPlacementID:(NSString *)placementID {
    NSLog(@"HBSplashViewController::finishLoadingNativeSplashAdForPlacementID:%@",placementID);
}

// MARK:-
-(void) didFinishLoadingOFMADWithPlacementID:(NSString *)placementID {
    NSLog(@"HBSplashViewController::didFinishLoadingADWithPlacementID:%@", placementID);
    _failureTipsLabel.hidden = YES;
    [_loadingView removeFromSuperview];
//    if (!_reload) [self showAD];
//    _reload = NO;
}

-(void) didFailToLoadOFMADWithPlacementID:(NSString*)placementID error:(NSError*)error {
    [_loadingView removeFromSuperview];
    _failureTipsLabel.hidden = NO;
    NSLog(@"HBSplashViewController::didFailToLoadADWithPlacementID:%@ error:%@", placementID, error);
}
@end
