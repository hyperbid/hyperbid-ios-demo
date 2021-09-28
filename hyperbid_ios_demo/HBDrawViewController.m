//
//  HBDrawViewController.m
//  HyperBidSDKDemo
//
//  Created by HyperBid on 2020/2/25.
//  Copyright © 2020 HyperBid. All rights reserved.
//

#import "HBDrawViewController.h"
#import "HBNativeViewController.h"
#import "MTAutolayoutCategories.h"
#import "HBNativeViewController.h"
@import HyperBidNative;
@import HyperBidSDK;

static NSString *const kKSDrawPlacementID = @"b5e5ce042cabfb";
static NSString *const kTTDrawPlacementID = @"b5c2c6d62b9d65";
static NSString *const kLoadKey = @"load";
static NSString *const kCallbackKey = @"request";

@interface HBDrawViewController ()<UITableViewDelegate,UITableViewDataSource,HBNativeADDelegate>
@property(nonatomic, readonly) NSString *name;
@property(nonatomic, readonly) NSDictionary<NSString*, NSString*>* placementIDs;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *dataSource;
@property(nonatomic, strong)UIButton *returnBack;
@property(nonatomic, strong)UIButton *closeButton;
@property(nonatomic, readonly) UIButton *showAdButton;
@property(nonatomic, readonly) UIButton *reloadADButton;
@property(nonatomic, readonly) UIButton *readyButton;
@property(nonatomic, readonly) UILabel *failureTipsLabel;
@property(nonatomic, readonly) UIActivityIndicatorView *loadingView;
@property(nonatomic, readonly) NSMutableDictionary *numberOfLoadAndCallback;

@end

@implementation HBDrawViewController

-(instancetype) initWithPlacementName:(NSString *)name {
    if (self = [super init]) {
        _name = name;
        _placementIDs = @{
                            kKSDrawPlacement:kKSDrawPlacementID,
                            kTTDrawPlacementName:kTTDrawPlacementID
                          };
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.returnBack = [[UIButton alloc]initWithFrame:CGRectMake(20, 40, 50, 50)];
    [self.returnBack addTarget:self action:@selector(returnVC) forControlEvents:UIControlEventTouchUpInside];
    [self.returnBack setImage:[UIImage imageNamed:@"returnImage"] forState:UIControlStateNormal];
    [self.returnBack setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:self.returnBack];
    
    self.closeButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 50.0f, 40, 50, 50)];
    [self.closeButton addTarget:self action:@selector(closeAD) forControlEvents:UIControlEventTouchUpInside];
    [self.closeButton setImage:[UIImage imageNamed:@"closeImage"] forState:UIControlStateNormal];
    
    
    _reloadADButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_reloadADButton addTarget:self action:@selector(loadADButtonTapped) forControlEvents:UIControlEventTouchUpInside];
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
    
    _readyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_readyButton addTarget:self action:@selector(readyButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [_readyButton setTitleColor:_readyButton.tintColor forState:UIControlStateNormal];
    [_readyButton setTitle:@"Ad Ready?" forState:UIControlStateNormal];
    [_readyButton setBackgroundColor:[UIColor grayColor]];
    _readyButton.frame = CGRectMake(.0f, CGRectGetMinY(_reloadADButton.frame) - 20.0f - 60.0f, (CGRectGetWidth(self.view.bounds) - 40) / 2.0f, 60.0f);
    [self.view addSubview:_readyButton];
    
    _failureTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(.0f, 64.0f, CGRectGetWidth(self.view.bounds), 400.0f)];
    _failureTipsLabel.text = @"Failed to load ad";
    _failureTipsLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_failureTipsLabel];
    _failureTipsLabel.hidden = YES;
    
    if ([[HBAdManager sharedManager] isReadyNativeAdWithPlacementID:_placementIDs[_name]]) {
        [self showAD];
    } else {
        _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _loadingView.center = _failureTipsLabel.center;
        [_loadingView startAnimating];
        [self.view addSubview:_loadingView];
        [self increaseLoad];
        [[HBAdManager sharedManager] loadAd:_placementIDs[_name] extra:@{kHBExtraInfoNativeAdSizeKey:[NSValue valueWithCGSize:self.view.bounds.size]} delegate:self];
    }

}

- (void) returnVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) loadADButtonTapped {
    _failureTipsLabel.hidden = YES;
    [self.view addSubview:_loadingView];
    [[HBAdManager sharedManager] loadAd:_placementIDs[_name] extra:@{kHBExtraInfoNativeAdSizeKey:[NSValue valueWithCGSize:self.view.bounds.size]} delegate:self];
    
}
- (void) showAD {
    HBNativeADConfiguration *config = [[HBNativeADConfiguration alloc] init];
    config.ADFrame = self.view.bounds;
    config.delegate = self;
    config.renderingViewClass = [DMADView class];
    config.rootViewController = self;
    UIView *adView = [[HBAdManager sharedManager] retriveAdViewWithPlacementID:_placementIDs[_name] configuration:config];
    adView.tag = 3333;
    [self.view addSubview:adView];
    [adView addSubview:self.closeButton];
    if (adView == nil) NSLog(@"retrive ad view failed");
}

- (void) closeAD {
    [[self.view viewWithTag:3333] removeFromSuperview];

}
- (void) readyButtonTapped {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[[HBAdManager sharedManager] isReadyNativeAdWithPlacementID:_placementIDs[_name]] ? @"Ready!" : @"Not Yet!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) increaseLoad {
    _numberOfLoadAndCallback[kLoadKey] = @([_numberOfLoadAndCallback[kLoadKey] integerValue] + 1);
    [_numberOfLoadAndCallback writeToFile:[HBDrawViewController numberOfLoadPath] atomically:YES];
}

- (void) increaseCallback {
    _numberOfLoadAndCallback[kCallbackKey] = @([_numberOfLoadAndCallback[kCallbackKey] integerValue] + 1);
    [_numberOfLoadAndCallback writeToFile:[HBDrawViewController numberOfLoadPath] atomically:YES];
}

+(NSString*)numberOfLoadPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"native_load"];
}


-(void) didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"HBNativeDrawViewController:: didFinishLoadingADWithPlacementID:%@", placementID);
    [_loadingView removeFromSuperview];
    _failureTipsLabel.hidden = YES;
    if ([self.view viewWithTag:3333] == nil) {
        [self showAD];
    }
}

-(void) didFailToLoadADWithPlacementID:(NSString *)placementID error:(NSError *)error {
    NSLog(@"HBNativeDrawViewController:: didFailToLoadADWithPlacementID:%@ error:%@", placementID, error);
    [_loadingView removeFromSuperview];
    _failureTipsLabel.hidden = NO;
}
#pragma mark - delegate with extra

-(void) didStartPlayingVideoInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBNativeDrawViewController:: didStartPlayingVideoInAdView:placementID:%@with extra: %@", placementID,extra);
}

-(void) didEndPlayingVideoInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBNativeDrawViewController:: didEndPlayingVideoInAdView:placementID:%@", placementID);
}

-(void) didClickNativeAdInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBNativeDrawViewController:: didClickNativeAdInAdView:placementID:%@ with extra: %@", placementID,extra);
}

-(void) didShowNativeAdInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBNativeDrawViewController:: didShowNativeAdInAdView:placementID:%@ with extra: %@", placementID,extra);
    adView.mainImageView.hidden = [adView isVideoContents];
}

-(void) didEnterFullScreenVideoInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBNativeDrawViewController:: didEnterFullScreenVideoInAdView:placementID:%@", placementID);
}

-(void) didExitFullScreenVideoInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBNativeDrawViewController:: didExitFullScreenVideoInAdView:placementID:%@", placementID);
}

-(void) didTapCloseButtonInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBNativeDrawViewController:: didTapCloseButtonInAdView:placementID:%@ extra:%@", placementID, extra);
}
@end
