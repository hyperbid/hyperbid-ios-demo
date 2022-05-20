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
#import "HBADFootView.h"
#import "HBModelButton.h"
#import "HBMenuView.h"
#import "HBSuspendedButton.h"

@import HyperBidSDK;
@import HyperBidBanner;


static NSString *const kGDTPlacementID = @"b5bacad0803fd1";
static NSString *const kTTPlacementID = @"b5bacacfc470c9";
static NSString *const kAdmobPlacementID = @"b5bacacef17717";
static NSString *const kApplovinPlacementID = @"b5bacace1549da";
static NSString *const kFacebookPlacementID = @"b5baf502bb23e3";

static NSString *const kInmobiPlacementID = @"b5baf522891992";
static NSString *const kAllPlacementID = @"b5bacaccb61c29";

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


//static NSString *const kFacebookInHousePlacementID = @"b5d146f9483215";
static NSString *const kKidozPlacementID = @"b5feaa2cfe2959";
static NSString *const kMyTargetPlacementID = @"b5feaa31284737";


NSString *const kBannerShownNotification = @"banner_shown";
NSString *const kBannerLoadingFailedNotification = @"banner_failed_to_load";
@interface HBBannerViewController ()<HBBannerDelegate>

{
    CGSize _adSize;
}

@property (nonatomic, strong) HBADFootView *footView;

@property (nonatomic, strong) UIView *modelBackView;

@property (nonatomic, strong) HBModelButton *modelButton;

@property (nonatomic, strong) HBMenuView *menuView;

@property (nonatomic, strong) UITextView *textView;

@property (copy, nonatomic) NSString *placementID;

@property (nonatomic, strong) UIView *adView;

@property (nonatomic, strong) HBSuspendedButton *suspendedBtn;

@property (copy, nonatomic) NSDictionary<NSString *, NSString *> *placementIDs;

@property(nonatomic, strong) NSString *togetherLoadAdStr;

@end

@implementation HBBannerViewController

-(instancetype)init{
    self = [super init];
    _placementIDs = @{
                      kGDTPlacement:kGDTPlacementID,
                      kTTPlacementName:kTTPlacementID,
                      kAdMobPlacement:kAdmobPlacementID,
                      kApplovinPlacement:kApplovinPlacementID,
                      kFacebookPlacement:kFacebookPlacementID,
                      kInmobiPlacement:kInmobiPlacementID,
                      kAllPlacementName:kAllPlacementID,
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
                      kKidozPlacement:kKidozPlacementID,
                      kMyTargetPlacement:kMyTargetPlacementID
                      };
    return self;
}
- (NSDictionary<NSString *,NSString *> *)placementIDs{
    return @{
        @"GAM":             @"b5f2389932a2ec",
        @"Chartboost":      @"b5ee89f1a7eaf2",
        @"Vungle":          @"b5ee89f3e63d80",
        @"Adcolony":        @"b5ee89f4d1791e",
        @"StartApp":        @"b5ed47a285a23a",
        @"HeaderBidding":   @"b5d146f9483215",
        @"Nend":            @"b5cb96d97400b3",
        @"Facebook":        @"b5baf502bb23e3",
        @"Mintegral":       @"b5dd363166a5ea",
        @"AdMob":           @"b5bacacef17717",
        @"Inmobi":          @"b5baf522891992",
        @"Applovin":        @"b5bacace1549da",
        @"Baidu":           @"b5c04dda229f7e",
        @"Fyber":           @"b5e96db4cb0682",
        @"Unity Ads":       @"b5c21a04406722",
        @"Kidoz":           @"b5feaa2cfe2959",
        @"MyTarget":        @"b5feaa31284737",
        @"All":             @"b5bacaccb61c29",
        @"Gromore":         @"b601cac8974c40",
        @"Max":             @"b604080d063430",
        @"GDT":             @"b5bacad0803fd1"
    };
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRGB(245, 245, 245);
    [self setupUI];
    self.title = @"Banner";
    
    [self setupData];
    _adSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 250.0f);
    
}
- (void)setupData
{
    self.placementID = self.placementIDs.allValues.firstObject;
}
- (void)setupUI
{
    UIButton *clearBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    [clearBtn setTitle:@"clear log" forState:UIControlStateNormal];
    [clearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(clearLog) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:clearBtn];
    self.navigationItem.rightBarButtonItem = btnItem;
    
    [self.view addSubview:self.modelBackView];
    [self.view addSubview:self.modelButton];
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.footView];
//    [self.view addSubview:self.suspendedBtn];
    
    [self.modelBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(kScreenW - kScaleW(52));
        make.height.mas_equalTo(kScaleW(360));
        make.top.equalTo(self.view.mas_top).offset( kScaleW(20));
    }];
    
    [self.modelButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(kScaleW(340));
        make.height.mas_equalTo(kScaleW(360));
        make.top.equalTo(self.modelBackView.mas_top);
    }];

    [self.menuView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenW - kScaleW(52));
        make.height.mas_equalTo(kScaleW(242));
        make.top.equalTo(self.modelBackView.mas_bottom).offset(kScaleW(20));
        make.centerX.equalTo(self.view.mas_centerX);
    }];

    [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.menuView.mas_bottom).offset(kScaleW(20));
        make.bottom.equalTo(self.footView.mas_top).offset(kScaleW(-20));
        make.width.mas_equalTo(kScreenW - kScaleW(52));
        make.centerX.equalTo(self.view.mas_centerX);
    }];

    [self.footView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(kScaleW(-30));
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(kScaleW(340));
    }];
    
//    [self.suspendedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.mas_equalTo(kScaleW(100));
//        make.top.equalTo(self.view.mas_top).offset(kScaleW(200));
//        make.right.equalTo(self.view.mas_right);
//    }];
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}


#pragma mark - together load
- (void)togetherLoadAd:(NSString *)togetherLoadAdStr{
    self.togetherLoadAdStr = togetherLoadAdStr;
    NSLog(@"Together Load banner ad placement---%@",self.placementID);

    if (self.placementID) {
        [self loadAd];
    }
}

- (NSString *)placementID{
    if (self.togetherLoadAdStr.length) {
        
        NSString *tempID = self.placementIDs[self.togetherLoadAdStr];
        __block NSString *placementIDStr;
        if (tempID == nil) {
            [self.placementIDs enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
                if ([key containsString:self.togetherLoadAdStr]) {
                    placementIDStr = obj;
                    *stop = YES;
                }
            }];
            return placementIDStr ? placementIDStr : _placementID;
        }else{
            return tempID;
        }
    }else{
        return _placementID;
    }
}

#pragma mark - Action
- (void)loadAd
{
    [[HBAdManager sharedManager] loadAd:self.placementID extra:@{kHBAdLoadingExtraBannerAdSizeKey:[NSValue valueWithCGSize:_adSize], kHBAdLoadingExtraBannerSizeAdjustKey:@NO} delegate:self];
}

- (void)checkAd
{
    // list
    NSArray *array = [[HBAdManager sharedManager] getBannerValidAdsForPlacementID:self.placementID];
    NSLog(@"ValidAds -- %@",array);
    
//    HBCheckLoadModel *model = [[HBAdManager sharedManager] checkBannerLoadStatusForPlacementID:self.placementID];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[[HBAdManager sharedManager] isReadyBannerAdWithPlacementID:self.placementID] ? @"Ready!" : @"Not Yet!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

- (void)showAd
{
    if ([[HBAdManager sharedManager] isReadyBannerAdWithPlacementID:self.placementID]) {
        NSInteger tag = 3333;
        [[self.view viewWithTag:tag] removeFromSuperview];
        HBBannerView *bannerView = [[HBAdManager sharedManager] getBannerViewWithPlacementID:self.placementID scene:@"f600938d045dd3"];
        if (bannerView != nil) {
            bannerView.delegate = self;
            bannerView.presentingViewController = self;
            bannerView.translatesAutoresizingMaskIntoConstraints = NO;
            bannerView.tag = tag;
            self.adView = [[UIView alloc]init];// bannerView;
            self.adView.backgroundColor =  [UIColor colorWithRed:73/255.f green:109/255.f blue:255/255.f alpha:0.8f];
            [self.adView addSubview:bannerView];
            
            [self.view insertSubview:self.adView belowSubview:self.footView];
           
            
            [self.adView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.equalTo(self.view);
                make.centerX.equalTo(self.view.mas_centerX);
                make.top.equalTo(self.view);
                make.bottom.equalTo(self.view);
                
            }];
            
            [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.adView).offset(100);
            }];
            
            
            
        }else {
            NSLog(@"BannerView is nil for placementID:%@", self.placementID);
        }
    } else {
        NSLog(@"Banner ad's not ready for placementID:%@", self.placementID);
    }
}

- (void)removeAd
{
    if (self.adView && self.adView.superview) {
        [self.adView removeFromSuperview];
    }
}

- (void)showLog:(NSString *)logStr
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *logS = self.textView.text;
        NSString *log = nil;
        if (![logS isEqualToString:@""]) {
            log = [NSString stringWithFormat:@"%@\n%@", logS, logStr];
        } else {
            log = [NSString stringWithFormat:@"%@", logStr];
        }
        self.textView.text = log;
        [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length, 1)];
    });
}

- (void)clearLog
{
    self.textView.text = @"";
}

#pragma mark - delegate method(s)
- (void)didStartLoadingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra{
    
    NSLog(@"Ad source--AD--start--ATBannerViewController::didStartLoadingADSourceWithPlacementID:%@---extra:%@", placementID,extra);
    
//    [self showLog:[NSString stringWithFormat:@"didStartLoadingADSourceWithPlacementID:%@---extra:%@", placementID,extra]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)didFinishLoadingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra{
    
    NSLog(@"Ad source--AD--finish--ATBannerViewController::didFinishLoadingADSourceWithPlacementID:%@---extra:%@", placementID,extra);
    
//    [self showLog:[NSString stringWithFormat:@"didFinishLoadingADSourceWithPlacementID:%@---extra:%@", placementID,extra]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)didFailToLoadADSourceWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra error:(NSError*)error{
    NSLog(@"Ad source--AD--Fail--ATBannerViewController::didFailToLoadADSourceWithPlacementID:%@---error:%@", placementID,error);
    
//    [self showLog:[NSString stringWithFormat:@"didFailToLoadADSourceWithPlacementID:%@--%@", placementID],error];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

// bidding
- (void)didStartBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra{
    
    NSLog(@"Ad source--bid--start--ATBannerViewController::didStartBiddingADSourceWithPlacementID:%@---extra:%@", placementID,extra);
    
//    [self showLog:[NSString stringWithFormat:@"didStartBiddingADSourceWithPlacementID:%@---extra:%@", placementID,extra]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)didFinishBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra{
    
    NSLog(@"Ad source--bid--finish--ATBannerViewController::didFinishBiddingADSourceWithPlacementID:%@--extra:%@", placementID,extra);
    
//    [self showLog:[NSString stringWithFormat:@"didFinishBiddingADSourceWithPlacementID:%@---extra:%@", placementID,extra]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)didFailBiddingADSourceWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra error:(NSError*)error{
    
    NSLog(@"Ad source--bid--fail--ATBannerViewController::didFailBiddingADSourceWithPlacementID:%@--error:%@", placementID,error);
    
//    [self showLog:[NSString stringWithFormat:@"didFailBiddingADSourceWithPlacementID:%@", placementID]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void) didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"HBBannerViewController::didFinishLoadingADWithPlacementID:%@", placementID);
    
    [self showLog:[NSString stringWithFormat:@"didFinishLoadingADWithPlacementID:%@", placementID]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void) didFailToLoadADWithPlacementID:(NSString*)placementID error:(NSError*)error {
    NSLog(@"HBBannerViewController::didFailToLoadADWithPlacementID:%@ error:%@", placementID, error);
    
    [self showLog:[NSString stringWithFormat:@"HBBannerViewController::didFailToLoadADWithPlacementID:%@ errorCode:%ld", placementID, error.code]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void) bannerView:(HBBannerView *)bannerView failedToAutoRefreshWithPlacementID:(NSString *)placementID error:(NSError *)error {
    NSLog(@"HBBannerViewController::bannerView:failedToAutoRefreshWithPlacementID:%@ error:%@", placementID, error);
    
    [self showLog:[NSString stringWithFormat:@"bannerView:failedToAutoRefreshWithPlacementID:%@ errorCode:%ld", placementID, error.code]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

#pragma mark - add networkID and adsourceID delegate
- (void)bannerView:(HBBannerView *)bannerView didDeepLinkOrJumpForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra result:(BOOL)success {
    NSLog(@"HBBannerViewController:: didDeepLinkOrJumpForPlacementID:placementID:%@ with extra: %@, success:%@", placementID,extra, success ? @"YES" : @"NO");
    
    [self showLog:[NSString stringWithFormat:@"didDeepLinkOrJumpForPlacementID:%@, success:%@", placementID, success ? @"YES" : @"NO"]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void) bannerView:(HBBannerView*)bannerView didShowAdWithPlacementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBBannerViewController::bannerView:didShowAdWithPlacementID:%@ with extra: %@", placementID,extra);
    
    [self showLog:[NSString stringWithFormat:@"bannerView:didShowAdWithPlacementID:%@", placementID]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void) bannerView:(HBBannerView*)bannerView didClickWithPlacementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBBannerViewController::bannerView:didClickWithPlacementID:%@ with extra: %@", placementID,extra);
    
    [self showLog:[NSString stringWithFormat:@"bannerView:didClickWithPlacementID:%@", placementID]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void) bannerView:(HBBannerView*)bannerView didAutoRefreshWithPlacement:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBBannerViewController::bannerView:didAutoRefreshWithPlacement:%@ with extra: %@", placementID,extra);
    
    [self showLog:[NSString stringWithFormat:@"bannerView:didAutoRefreshWithPlacement:%@", placementID]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void) bannerView:(HBBannerView*)bannerView didTapCloseButtonWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra {
    NSLog(@"HBBannerViewController::bannerView:didTapCloseButtonWithPlacementID:%@ extra: %@", placementID,extra);
    
    [self.adView removeFromSuperview];
    self.adView = nil;
    
    [self showLog:[NSString stringWithFormat:@"bannerView:didTapCloseButtonWithPlacementID:%@", placementID]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void) bannerDidShowForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra {
    NSLog(@"HBBannerViewController::bannerDidShowForPlacementID:%@ with extra: %@", placementID,extra);
    
    [self showLog:[NSString stringWithFormat:@"bannerDidShowForPlacementID:%@", placementID]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void) bannerDidCloseForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra {
    NSLog(@"HBBannerViewController::bannerView:bannerDidCloseForPlacementID:%@ extra: %@", placementID,extra);
    
    [self showLog:[NSString stringWithFormat:@"bannerView:bannerDidCloseForPlacementID:%@", placementID]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void) bannerDidClickForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra {
    NSLog(@"HBBannerViewController::bannerDidClickForPlacementID:%@ with extra: %@", placementID,extra);
    
    [self showLog:[NSString stringWithFormat:@"bannerDidClickForPlacementID:%@", placementID]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void) bannerDeepLinkOrJumpForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra result:(BOOL)success {
    NSLog(@"HBBannerViewController:: bannerDeepLinkOrJumpForPlacementID:placementID:%@ with extra: %@, success:%@", placementID,extra, success ? @"YES" : @"NO");
    
    [self showLog:[NSString stringWithFormat:@"bannerDeepLinkOrJumpForPlacementID:placementID:%@, success:%@", placementID, success ? @"YES" : @"NO"]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

#pragma mark - lazy
- (HBADFootView *)footView
{
    if (!_footView) {
//        _footView = [[HBADFootView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScaleW(340))];
        _footView = [[HBADFootView alloc] initWithRemoveBtn];
        __weak typeof(self) weakSelf = self;
        [_footView setClickLoadBlock:^{
            NSLog(@"ad load");
            [weakSelf loadAd];
        }];
        [_footView setClickReadyBlock:^{
            NSLog(@"ad ready");
            [weakSelf checkAd];
        }];
        [_footView setClickShowBlock:^{
            NSLog(@"ad show");
            [weakSelf showAd];
        }];
        [_footView setClickRemoveBlock:^{
            NSLog(@"ad remove");
            [weakSelf removeAd];
        }];
    }
    return _footView;
}

- (UIView *)modelBackView
{
    if (!_modelBackView) {
        _modelBackView = [[UIView alloc] init];
        _modelBackView.backgroundColor = [UIColor whiteColor];
        _modelBackView.layer.masksToBounds = YES;
        _modelBackView.layer.cornerRadius = 5;
    }
    return _modelBackView;
}

- (HBModelButton *)modelButton
{
    if (!_modelButton) {
        _modelButton = [[HBModelButton alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScaleW(532))];
        _modelButton.backgroundColor = [UIColor whiteColor];
        _modelButton.modelLabel.text = @"Banner";
        _modelButton.image.image = [UIImage imageNamed:@"banner"];
    }
    return _modelButton;
}

- (HBMenuView *)menuView
{
    if (!_menuView) {
        _menuView = [[HBMenuView alloc] initWithMenuList:self.placementIDs.allKeys subMenuList:nil];
        _menuView.layer.masksToBounds = YES;
        _menuView.layer.cornerRadius = 5;
        __weak typeof (self) weakSelf = self;
        [_menuView setSelectMenu:^(NSString * _Nonnull selectMenu) {
            weakSelf.placementID = weakSelf.placementIDs[selectMenu];
            NSLog(@"🚗select placementId:%@", weakSelf.placementID);
        }];
    }
    return _menuView;
}

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.layer.masksToBounds = YES;
        _textView.layer.cornerRadius = 5;
        _textView.editable = NO;
        _textView.text = @"";
    }
    return _textView;
}

- (HBSuspendedButton *)suspendedBtn
{
    if (!_suspendedBtn) {
        _suspendedBtn = [[HBSuspendedButton alloc] initWithProtocolList:@[@"HBAdLoadingDelegate", @"HBBannerDelegate"]];
        [_suspendedBtn setImage:[UIImage imageNamed:@"HyperBid_logo"] forState:UIControlStateNormal];
        _suspendedBtn.layer.masksToBounds = YES;
        _suspendedBtn.layer.cornerRadius = kScaleW(50);
        _suspendedBtn.layer.borderWidth = kScaleW(1);
        _suspendedBtn.layer.borderColor = [[UIColor grayColor] CGColor];
    }
    return _suspendedBtn;
}


@end
