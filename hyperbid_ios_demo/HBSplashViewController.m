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
#import "HBADFootView.h"
#import "HBModelButton.h"
#import "HBMenuView.h"
#import "HBSuspendedButton.h"

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





@interface HBSplashViewController ()<HBSplashDelegate,HBNativeSplashDelegate>

@property (nonatomic, strong) HBADFootView *footView;

@property (nonatomic, strong) UIView *modelBackView;

@property (nonatomic, strong) HBModelButton *modelButton;

@property (nonatomic, strong) HBMenuView *menuView;

@property (nonatomic, strong) UITextView *textView;

@property (copy, nonatomic) NSString *placementID;

@property(nonatomic, strong) UIButton *skipButton;

@property (nonatomic, strong) HBSuspendedButton *suspendedBtn;

@property (copy, nonatomic) NSDictionary<NSString *, NSString *> *placementIDs;

@property(nonatomic, strong) NSString *togetherLoadAdStr;



@end

@implementation HBSplashViewController

-(instancetype)init{
    
    self = [super init];
    
            _placementIDs = @{
                kMintegralPlacement:kMintegralPlacementID,
                kSigmobPlacement:kSigmobPlacementID,
                kGDTPlacement:kGDTPlacementID,
                kGDTZoomOutPlacement:kGDTZoomOutPlacementID,
                kBaiduPlacement:kBaiduPlacementID,
                kTTPlacementName:kTTPlacementID,
                kAdMobPlacement:kAdmobPlacementID,
                kKSPlacement:kKSPlacementID,
                kAllPlacementName:kAllPlacementID
            };
    
    return self;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Splash";
    self.view.backgroundColor = kRGB(245, 245, 245);
    [self setupSubviews];
    
    [self setupData];
    
}
- (void)setupData
{
    self.placementID = self.placementIDs.allValues.firstObject;
}

- (void)setupSubviews {
    UIButton *clearBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    [clearBtn setTitle:@"clear log" forState:UIControlStateNormal];
    [clearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(clearLog) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:clearBtn];
    self.navigationItem.rightBarButtonItem = btnItem;
    
    [self.view addSubview:self.modelBackView];
    [self.modelBackView addSubview:self.modelButton];
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.footView];
 
    
    [self.modelBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(kScreenW - kScaleW(52));
        make.height.mas_equalTo(kScaleW(360));
        make.top.equalTo(self.view.mas_top).offset( kScaleW(20));
    }];
    
    [self.modelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(kScaleW(340));
        make.height.mas_equalTo(kScaleW(360));
        make.top.equalTo(self.modelBackView.mas_top);
    }];
    
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenW - kScaleW(52));
        make.height.mas_equalTo(kScaleW(242));
        make.top.equalTo(self.modelBackView.mas_bottom).offset(kScaleW(20));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.menuView.mas_bottom).offset(kScaleW(20));
        make.bottom.equalTo(self.footView.mas_top).offset(kScaleW(-20));
        make.width.mas_equalTo(kScreenW - kScaleW(52));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(kScaleW(-30));
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(kScaleW(340));
    }];
    
   
}

- (void)clearLog
{
    self.textView.text = @"";
}

#pragma mark - Action
- (void)loadAd
{
    UILabel *label = nil;
    label = [[UILabel alloc] initWithFrame:CGRectMake(.0f, .0f, CGRectGetWidth([UIScreen mainScreen].bounds), 100.0f)];
    label.text = @"Container";
    label.textColor = [UIColor redColor];
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self forKey:kHBExtraInfoRootViewControllerKey];
//    [mutableDict setValue:self forKey:kHBSplashExtraRootViewControllerKey];
    [mutableDict setValue:@5.5 forKey:kHBSplashExtraTolerateTimeoutKey];
    
    [[HBAdManager sharedManager] loadAd:self.placementID extra:mutableDict delegate:self containerView:label defaultAdSourceConfig:@"{\"unit_id\":1331013,\"nw_firm_id\":22,\"adapter_class\":\"HBBaiduSplashAdapter\",\"content\":\"{\\\"button_type\\\":\\\"0\\\",\\\"ad_place_id\\\":\\\"7852632\\\",\\\"app_id\\\":\\\"e232e8e6\\\"}\"}"];
}

- (void)checkAd
{
    // another method
    //    HBCheckLoadModel *checkLoadModel = [[HBAdManager sharedManager] checkSplashLoadStatusForPlacementID:self.placementID];
    
    // list
    NSArray *caches = [[HBAdManager sharedManager] getSplashValidAdsForPlacementID:self.placementID];
    NSLog(@"ValidAds -- %@",caches);

    BOOL ready = [[HBAdManager sharedManager] splashReadyForPlacementID:self.placementID];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:ready ? @"Ready!" : @"Not Yet!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

- (void)showAd
{
    UIWindow *mainWindow = nil;
    if ( @available(iOS 13.0, *) ) {
        mainWindow = [UIApplication sharedApplication].windows.firstObject;
        [mainWindow makeKeyWindow];
    }else {
        mainWindow = [UIApplication sharedApplication].keyWindow;
    }
    
    self.skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.skipButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    self.skipButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 80 - 20, 50, 80, 21);
    self.skipButton.layer.cornerRadius = 10.5;
    self.skipButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:@50000 forKey:kHBSplashExtraCountdownKey];
    [mutableDict setValue:self.skipButton forKey:kHBSplashExtraCustomSkipButtonKey];
    [mutableDict setValue:@500 forKey:kHBSplashExtraCountdownIntervalKey];
    [[HBAdManager sharedManager] showSplashWithPlacementID:self.placementID window:mainWindow extra:mutableDict delegate:self];
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

// MARK:- splash delegate
#pragma mark - delegates

- (void)didStartLoadingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra{
    
    NSLog(@"广告源--AD--开始--ATSplashViewController::didStartLoadingADSourceWithPlacementID:%@---extra:%@", placementID,extra);
    
//    [self showLog:[NSString stringWithFormat:@"didStartLoadingADSourceWithPlacementID:%@---extra:%@", placementID,extra]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)didFinishLoadingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra{
    
    NSLog(@"广告源--AD--完成--ATSplashViewController::didFinishLoadingADSourceWithPlacementID:%@---extra:%@", placementID,extra);
    
//    [self showLog:[NSString stringWithFormat:@"didFinishLoadingADSourceWithPlacementID:%@---extra:%@", placementID,extra]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)didFailToLoadADSourceWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra error:(NSError*)error{
    NSLog(@"广告源--AD--失败--ATSplashViewController::didFailToLoadADSourceWithPlacementID:%@---error:%@", placementID,error);
    
//    [self showLog:[NSString stringWithFormat:@"didFailToLoadADSourceWithPlacementID:%@--%@", placementID],error];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

// bidding
- (void)didStartBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra{
    
    NSLog(@"广告源--bid--开始--ATSplashViewController::didStartBiddingADSourceWithPlacementID:%@---extra:%@", placementID,extra);
    
//    [self showLog:[NSString stringWithFormat:@"didStartBiddingADSourceWithPlacementID:%@---extra:%@", placementID,extra]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)didFinishBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra{
    
    NSLog(@"广告源--bid--完成--ATSplashViewController::didFinishBiddingADSourceWithPlacementID:%@--extra:%@", placementID,extra);
    
//    [self showLog:[NSString stringWithFormat:@"didFinishBiddingADSourceWithPlacementID:%@---extra:%@", placementID,extra]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)didFailBiddingADSourceWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra error:(NSError*)error{
    
    NSLog(@"广告源--bid--失败--ATSplashViewController::didFailBiddingADSourceWithPlacementID:%@--error:%@", placementID,error);
    
//    [self showLog:[NSString stringWithFormat:@"didFailBiddingADSourceWithPlacementID:%@", placementID]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)didFinishLoadingSplashADWithPlacementID:(NSString *)placementID isTimeout:(BOOL)isTimeout
{
    NSLog(@"开屏成功:%@----是否超时:%d",placementID,isTimeout);
    NSLog(@"开屏didFinishLoadingSplashADWithPlacementID:");
    [self showLog:[NSString stringWithFormat:@"开屏成功:%@----是否超时:%d",placementID,isTimeout]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)didTimeoutLoadingSplashADWithPlacementID:(NSString *)placementID
{
    NSLog(@"开屏超时:%@",placementID);
    NSLog(@"开屏didTimeoutLoadingSplashADWithPlacementID:");

    [self showLog:[NSString stringWithFormat:@"开屏超时:%@",placementID]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)didFailToLoadADWithPlacementID:(NSString *)placementID error:(NSError *)error {

    NSLog(@"开屏ATSplashViewController:: didFailToLoadADWithPlacementID");

    [self showLog:[NSString stringWithFormat:@"开屏加载失败:%@--%@",placementID,error]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)didFinishLoadingADWithPlacementID:(NSString *)placementID {

    NSLog(@"开屏ATSplashViewController:: didFinishLoadingADWithPlacementID");

    [self showLog:[NSString stringWithFormat:@"开屏加载成功:%@",placementID]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)splashDeepLinkOrJumpForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra result:(BOOL)success
{
    NSLog(@"开屏ATSplashViewController:: splashDeepLinkOrJumpForPlacementID:placementID:%@ with extra: %@, success:%@", placementID,extra, success ? @"YES" : @"NO");
    
    [self showLog:[NSString stringWithFormat:@"splashDeepLinkOrJumpForPlacementID:placementID:%@ with extra: %@, success:%@", placementID,extra, success ? @"YES" : @"NO"]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)splashDidClickForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra
{
    NSLog(@"开屏ATSplashViewController::splashDidClickForPlacementID:%@ extra:%@",placementID,extra);
    [self showLog:[NSString stringWithFormat:@"splashDidClickForPlacementID:%@ extra:%@",placementID,extra]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)splashDidCloseForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra
{
    NSLog(@"开屏ATSplashViewController::splashDidCloseForPlacementID:%@ extra:%@",placementID,extra);
    [self showLog:[NSString stringWithFormat:@"splashDidCloseForPlacementID:%@ extra:%@",placementID,extra]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)splashDidShowForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra
{
    NSLog(@"开屏ATSplashViewController::splashDidShowForPlacementID:%@ extra:%@",placementID,extra);
    [self showLog:[NSString stringWithFormat:@"splashDidShowForPlacementID:%@ extra:%@",placementID,extra]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void)splashZoomOutViewDidClickForPlacementID:(NSString*)placementID extra:(NSDictionary *) extra
{
    NSLog(@"开屏ATSplashViewController::splashZoomOutViewDidClickForPlacementID:%@ extra:%@",placementID,extra);
    [self showLog:[NSString stringWithFormat:@"splashZoomOutViewDidClickForPlacementID:%@ extra:%@",placementID,extra]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void)splashZoomOutViewDidCloseForPlacementID:(NSString*)placementID extra:(NSDictionary *) extra
{
    NSLog(@"开屏ATSplashViewController::splashZoomOutViewDidCloseForPlacementID:%@ extra:%@",placementID,extra);
    [self showLog:[NSString stringWithFormat:@"splashZoomOutViewDidCloseForPlacementID:%@ extra:%@",placementID,extra]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)splashDetailDidClosedForPlacementID:(NSString*)placementID extra:(NSDictionary *) extra
{
    NSLog(@"HBSplashViewController::splashDetailDidClosedForPlacementID:%@ extra:%@",placementID,extra);
    [self showLog:[NSString stringWithFormat:@"splashDetailDidClosedForPlacementID:%@ extra:%@",placementID,extra]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)splashDidShowFailedForPlacementID:(NSString*)placementID error:(NSError *)error extra:(NSDictionary *) extra
{
    NSLog(@"开屏ATSplashViewController::splashDidShowFailedForPlacementID:%@ error:%@ extra:%@",placementID,error,extra);
    [self showLog:[NSString stringWithFormat:@"splashDidShowFailedForPlacementID:%@ error:%@ extra:%@",placementID,error,extra]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)splashCountdownTime:(NSInteger)countdown forPlacementID:(NSString *)placementID extra:(NSDictionary *)extra
{
    NSLog(@"开屏ATSplashViewController::splashCountdownTime:%ld forPlacementID:%@",countdown,placementID);
    [self showLog:[NSString stringWithFormat:@"splashCountdownTime:%ld forPlacementID:%@",countdown,placementID]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *title = [NSString stringWithFormat:@"%lds | Skip",countdown/1000];
        if (countdown/1000) {
            [self.skipButton setTitle:title forState:UIControlStateNormal];
        }
    });
}

#pragma mark - lazy
- (HBADFootView *)footView
{
    if (!_footView) {
        _footView = [[HBADFootView alloc] init];

        __weak typeof(self) weakSelf = self;
        [_footView setClickLoadBlock:^{
            NSLog(@"点击加载");
            [weakSelf loadAd];
        }];
        [_footView setClickReadyBlock:^{
            NSLog(@"点击准备");
            [weakSelf checkAd];
        }];
        [_footView setClickShowBlock:^{
            NSLog(@"点击展示");
            [weakSelf showAd];
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
        _modelButton.modelLabel.text = @"Splash";
        _modelButton.image.image = [UIImage imageNamed:@"splash"];
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
        _textView.text = nil;
    }
    return _textView;
}

- (HBSuspendedButton *)suspendedBtn
{
    if (!_suspendedBtn) {
        _suspendedBtn = [[HBSuspendedButton alloc] initWithProtocolList:@[@"HBAdLoadingDelegate", @"HBSplashDelegate"]];
        [_suspendedBtn setImage:[UIImage imageNamed:@"HyperBid_logo"] forState:UIControlStateNormal];
        _suspendedBtn.layer.masksToBounds = YES;
        _suspendedBtn.layer.cornerRadius = kScaleW(50);
        _suspendedBtn.layer.borderWidth = kScaleW(1);
        _suspendedBtn.layer.borderColor = [[UIColor grayColor] CGColor];
    }
    return _suspendedBtn;
}

@end
