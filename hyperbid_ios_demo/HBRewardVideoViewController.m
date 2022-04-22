//
//  HBReWardVideoViewController.m
//  HyperBidSDKDemo
//
//  Created by mac on 2021/12/6.
//

#import "HBRewardVideoViewController.h"
#import <HyperBidRewardedVideo/HyperBidRewardedVideo.h>
#import "HBModelButton.h"
#import "HBSuspendedButton.h"
#import "HBInterstitialViewController.h"
#import "HBSplashViewController.h"
//#import  "HBRewardedVideoAutoAdManager.h"

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

static NSString *const kGDTPlacementID = @"b5c0f7cd196a4c";
static NSString *const kTapjoyRVPlacementID = @"b5b44a0ac855ff";//to be modified
static NSString *const kChartboostRVPlacementID = @"b5b44a09a5c912";//to be modified
static NSString *const kIronsourceRVPlacementID = @"b5b44a0bf09475";//to be modified
static NSString *const kVungleRVPlacementID = @"b5b44a0d05d707";//to be modified
static NSString *const kAdcolonyRVPlacementID = @"b5b44a0de295ad";//to be modified
static NSString *const kUnityAdsPlacementID = @"b5b44a0c7b9b64";//to be modified
static NSString *const kAllPlacementID = @"b5b44a0f115321";
static NSString *const kTTPlacementID = @"b5b72b21184aa8";
static NSString *const kBaiduPlacementID = @"b5c04dd81c1af3";
static NSString *const kNendPlacementID = @"b5cb96d6f68fdb";
static NSString *const kMaioPlacementID = @"b5cb96ce0b931e";
static NSString *const kSigmobPlacementID = @"b5d771f5a3458f";
static NSString *const kKSPlacementID = @"b5d807a31aa7dd";
static NSString *const kOguryPlacementID = @"b5dde2379dc6ce";
static NSString *const kStartAppPlacementID = @"b5e7319f619931";
static NSString *const kFyberPlacementID = @"b5e96db106d8f2";
static NSString *const kGAMPlacementID = @"b5f23897bba4ca";
static NSString *const kHeliumPlacementID = @"b5f583ea323756";

static NSString *const kKidozPlacementID = @"b5feaa2c0a6191";
static NSString *const kMyTargetPlacementID = @"b5feaa2f32f161";




@interface HBRewardVideoViewController () <HBAdLoadingDelegate, HBRewardedVideoDelegate>

@property (nonatomic, strong) UIView *modelBackView;

@property (nonatomic, strong) HBModelButton *modelButton;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) HBSuspendedButton *suspendedBtn;

@property(nonatomic, strong) HBInterstitialViewController *interstitialViewController;

@property(nonatomic, strong) NSString *selectMenuStr;
@property(nonatomic, strong) NSString *togetherLoadAdStr;
@property(nonatomic,assign) bool isAuto;
@end

@implementation HBRewardVideoViewController

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kRGB(245, 245, 245);
    self.title = @"Reward Video";
    [self setupData];
    [self setupUI];
    [HBRewardedVideoAutoAdManager sharedInstance].delegate = self;

    self.interstitialViewController = [[HBInterstitialViewController alloc]init];
}


- (NSDictionary<NSString *,NSString *> *)placementIDs{
    
    _placementIDs = @{
                      kMintegralPlacement:kMintegralPlacementID,
                      kHeaderBiddingPlacement:kMintegralHeaderBiddingPlacementID,
                      kAllPlacementName:kAllPlacementID,
                      kInmobiPlacement:kInmobiPlacementID,
                      kFacebookPlacement:kFacebookPlacementID,
                      kFacebookHeaderBiddingPlacement:kFacebookHeaderBiddingPlacementID,
                      kAdMobPlacement:kAdMobPlacementID,
                      kGDTPlacement:kGDTPlacementID,
                      kApplovinPlacement:kApplovinPlacementID,
                      kTapjoyPlacementName:kTapjoyRVPlacementID,
                      kChartboostPlacementName:kChartboostRVPlacementID,
                      kIronsourcePlacementName:kIronsourceRVPlacementID,
                      kVunglePlacementName:kVungleRVPlacementID,
                      kAdcolonyPlacementName:kAdcolonyRVPlacementID,
                      kUnityAdsPlacementName:kUnityAdsPlacementID,
                      kTTPlacementName:kTTPlacementID,
                      kBaiduPlacement:kBaiduPlacementID,
                      kNendPlacement:kNendPlacementID,
                      kMaioPlacement:kMaioPlacementID,
                      kSigmobPlacement:kSigmobPlacementID,
                      kKSPlacement:kKSPlacementID,
                      kOguryPlacement:kOguryPlacementID,
                      kStartAppPlacement:kStartAppPlacementID,
                      kFyberPlacement:kFyberPlacementID,
                      kGAMPlacement:kGAMPlacementID,
                      kHeliumPlacement:kHeliumPlacementID,
                      kKidozPlacement:kKidozPlacementID,
                      kMyTargetPlacement:kMyTargetPlacementID,
                  
                      };
    return _placementIDs;
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
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    [self.view addSubview:self.modelBackView];
    [self.view addSubview:self.modelButton];
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.footView];
    
    [self.modelBackView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(kScreenW - kScaleW(52));
        make.height.mas_equalTo(kScaleW(360));
        make.top.equalTo(self.view.mas_top).offset(kScaleW(20));
    }];
    
    [self.modelButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(kScaleW(340));
        make.height.mas_equalTo(kScaleW(360));
        make.top.equalTo(self.modelBackView.mas_top);
    }];

    [self.menuView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenW - kScaleW(52));
        make.height.mas_equalTo(kScaleW(242));
        make.top.equalTo(self.modelBackView.mas_bottom).offset(kScaleW(20));
        make.centerX.equalTo(self.view.mas_centerX);
    }];

    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.menuView.mas_bottom).offset(kScaleW(20));
        make.bottom.equalTo(self.footView.mas_top).offset(kScaleW(-20));
        make.width.mas_equalTo(kScreenW - kScaleW(52));
        make.centerX.equalTo(self.view.mas_centerX);
    }];

    [self.footView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(kScaleW(-30));
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(kScaleW(340));
    }];
    
    
}
#pragma mark - together load
- (void)togetherLoadAd:(NSString *)togetherLoadAdStr{
    self.togetherLoadAdStr = togetherLoadAdStr;
    NSLog(@"together load ad---%@",self.placementID);

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
    NSDictionary *dict = @{
        kHBAdLoadingExtraMediaExtraKey:@"media_val", kHBAdLoadingExtraUserIDKey:@"rv_test_user_id",kHBAdLoadingExtraRewardNameKey:@"reward_Name",kHBAdLoadingExtraRewardAmountKey:@(3),
        kHBExtraInfoRootViewControllerKey:self,
//        kHBRewardedVideoKlevinRewardTriggerKey : @1,
//        kHBRewardedVideoKlevinRewardTimeKey : @3,
    };
    [[HBAdManager sharedManager] loadAd:self.placementID extra:dict delegate:self];
}



- (void)checkAd
{
    [[HBAdManager sharedManager] checkRewardedVideoReadyAdInfo:self.placementID];
    // list
    NSArray *array = [[HBAdManager sharedManager] getRewardedVideoValidAdsForPlacementID:self.placementID];
    NSLog(@"ValidAds -- %@",array);
    
    
    BOOL ready =  [[HBAdManager sharedManager] isReadyRewardedVideoWithPlacementID:self.placementID];
    
    if (self.isAuto) {
        ready = [[HBRewardedVideoAutoAdManager sharedInstance] autoLoadRewardedVideoReadyForPlacementID:self.placementID];
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:ready? @"Ready!" : @"Not Yet!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

- (void)showAd
{
    
    if (self.isAuto) {
        [[HBRewardedVideoAutoAdManager sharedInstance]  showAutoLoadRewardedVideoWithPlacementID:self.placementID scene:@"f5e549727efc49" inViewController:self delegate:self];
    }else
  
    [[HBAdManager sharedManager] showRewardedVideoAd:self.placementID scene:@"f5e54970dc84e6" inViewController:self delegate:self];
        
        
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

#pragma mark - loading delegate
- (void)didStartLoadingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra{
    
    NSLog(@"广告源--AD--开始--ATRewardVideoViewController::didStartLoadingADSourceWithPlacementID:%@---extra:%@", placementID,extra);
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
//    [self showLog:[NSString stringWithFormat:@"didStartLoadingADSourceWithPlacementID:%@---extra:%@", placementID,extra]];
}

- (void)didFinishLoadingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra{
    
    NSLog(@"广告源--AD--完成--ATRewardVideoViewController::didFinishLoadingADSourceWithPlacementID:%@---extra:%@", placementID,extra);
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    
//    [self showLog:[NSString stringWithFormat:@"didFinishLoadingADSourceWithPlacementID:%@---extra:%@", placementID,extra]];
    
}

- (void)didFailToLoadADSourceWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra error:(NSError*)error{
    NSLog(@"广告源--AD--失败--ATRewardVideoViewController::didFailToLoadADSourceWithPlacementID:%@---error:%@", placementID,error);
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    
//    [self showLog:[NSString stringWithFormat:@"didFailToLoadADSourceWithPlacementID:%@--%@", placementID],error];
    
}

// bidding
- (void)didStartBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra{
    
    NSLog(@"广告源--bid--开始--ATRewardVideoViewController::didStartBiddingADSourceWithPlacementID:%@---extra:%@", placementID,extra);
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    
//    [self showLog:[NSString stringWithFormat:@"didStartBiddingADSourceWithPlacementID:%@---extra:%@", placementID,extra]];
    
}

- (void)didFinishBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra{
    
    NSLog(@"广告源--bid--完成--ATRewardVideoViewController::didFinishBiddingADSourceWithPlacementID:%@--extra:%@", placementID,extra);
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    
//    [self showLog:[NSString stringWithFormat:@"didFinishBiddingADSourceWithPlacementID:%@---extra:%@", placementID,extra]];
    
}

- (void)didFailBiddingADSourceWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra error:(NSError*)error{
    
    NSLog(@"广告源--bid--失败--ATRewardVideoViewController::didFailBiddingADSourceWithPlacementID:%@--error:%@", placementID,error);
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    
//    [self showLog:[NSString stringWithFormat:@"didFailBiddingADSourceWithPlacementID:%@", placementID]];
}


-(void) didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"HBRewardedVideoViewController::didFinishLoadingADWithPlacementID:%@", placementID);
    
    [self showLog:[NSString stringWithFormat:@"didFinishLoading:%@", placementID]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void) didFailToLoadADWithPlacementID:(NSString*)placementID error:(NSError*)error {
    
    NSLog(@"HBRewardedVideoViewController::didFailToLoadADWithPlacementID:%@ error:%@", placementID, error);
    
    [self showLog:[NSString stringWithFormat:@"didFailToLoad:%@ errorCode:%ld", placementID, (long)error.code]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

#pragma mark - showing delegate
-(void) rewardedVideoDidRewardSuccessForPlacemenID:(NSString *)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBRewardedVideoViewController::rewardedVideoDidRewardSuccessForPlacemenID:%@ extra:%@",placementID,extra);
    
    [self showLog:[NSString stringWithFormat:@"rewardedVideoDidRewardSuccess:%@", placementID]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void) rewardedVideoDidStartPlayingForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBRewardedVideoViewController::rewardedVideoDidStartPlayingForPlacementID:%@ extra:%@", placementID, extra);
    UIViewController *vc = self.presentedViewController;
    vc = nil;
    
    [self showLog:[NSString stringWithFormat:@"rewardedVideoDidStartPlaying:%@", placementID]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}


-(void) rewardedVideoDidEndPlayingForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBRewardedVideoViewController::rewardedVideoDidEndPlayingForPlacementID:%@ extra:%@", placementID, extra);
    
    [self showLog:[NSString stringWithFormat:@"rewardedVideoDidEndPlaying:%@", placementID]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void) rewardedVideoDidFailToPlayForPlacementID:(NSString*)placementID error:(NSError*)error extra:(NSDictionary *)extra {
    NSLog(@"HBRewardedVideoViewController::rewardedVideoDidFailToPlayForPlacementID:%@ error:%@ extra:%@", placementID, error, extra);
    
    [self showLog:[NSString stringWithFormat:@"rewardedVideoDidFailToPlay:%@ errorCode:%ld", placementID, (long)error.code]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void) rewardedVideoDidCloseForPlacementID:(NSString*)placementID rewarded:(BOOL)rewarded extra:(NSDictionary *)extra {
    NSLog(@"HBRewardedVideoViewController::rewardedVideoDidCloseForPlacementID:%@, rewarded:%@ extra:%@", placementID, rewarded ? @"yes" : @"no", extra);
    
    [self showLog:[NSString stringWithFormat:@"rewardedVideoDidClose:%@, rewarded:%@", placementID, rewarded ? @"yes" : @"no"]];
}


-(void) rewardedVideoDidClickForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBRewardedVideoViewController::rewardedVideoDidClickForPlacementID:%@ extra:%@", placementID, extra);
    
    [self showLog:[NSString stringWithFormat:@"rewardedVideoDidClick:%@", placementID]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)rewardedVideoDidDeepLinkOrJumpForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra result:(BOOL)success {
    NSLog(@"HBRewardedVideoViewController:: rewardedVideoDidDeepLinkOrJumpForPlacementID:placementID:%@ with extra: %@, success:%@", placementID,extra, success ? @"YES" : @"NO");
    
    [self showLog:[NSString stringWithFormat:@"rewardedVideoDidDeepLinkOrJump:%@, success:%@", placementID, success ? @"YES" : @"NO"]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

// rewarded video again
-(void) rewardedVideoAgainDidStartPlayingForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra {
    NSLog(@"HBRewardedVideoViewController::rewardedVideoAgainDidStartPlayingForPlacementID:%@ extra:%@", placementID, extra);
    
    [self showLog:[NSString stringWithFormat:@"rewardedVideoAgainDidStartPlaying:%@", placementID]];
}

-(void) rewardedVideoAgainDidEndPlayingForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra {
    NSLog(@"HBRewardedVideoViewController::rewardedVideoAgainDidEndPlayingForPlacementID:%@ extra:%@", placementID, extra);
    
    [self showLog:[NSString stringWithFormat:@"rewardedVideoAgainDidEndPlaying:%@", placementID]];
}

-(void) rewardedVideoAgainDidFailToPlayForPlacementID:(NSString*)placementID error:(NSError*)error extra:(NSDictionary*)extra {
    NSLog(@"HBRewardedVideoViewController::rewardedVideoAgainDidFailToPlayForPlacementID:%@ extra:%@", placementID, extra);
    
    [self showLog:[NSString stringWithFormat:@"rewardedVideoAgainDidFailToPlay:%@ errorCode:%ld", placementID, (long)error.code]];
}

-(void) rewardedVideoAgainDidClickForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra {
    NSLog(@"HBRewardedVideoViewController::rewardedVideoAgainDidClickForPlacementID:%@ extra:%@", placementID, extra);
    
    [self showLog:[NSString stringWithFormat:@"rewardedVideoAgainDidClick:%@", placementID]];
}

-(void) rewardedVideoAgainDidRewardSuccessForPlacemenID:(NSString*)placementID extra:(NSDictionary*)extra {
    NSLog(@"HBRewardedVideoViewController::rewardedVideoAgainDidRewardSuccessForPlacemenID:%@ extra:%@", placementID, extra);
    
    [self showLog:[NSString stringWithFormat:@"rewardedVideoAgainDidRewardSuccess:%@", placementID]];
}

#pragma mark - lazy
- (HBADFootView *)footView
{
    if (!_footView) {
        _footView = [[HBADFootView alloc] init];
//        _footView = [[HBADFootView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScaleW(340))];
//        _footView.removeBtn.hidden = YES;
//
//        _footView.showBtn.frame = CGRectMake(kScaleW(26), kScaleW(230), (kScreenW - kScaleW(52)), kScaleW(90));

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
//        _modelButton = [[HBModelButton alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScaleW(532))];
        _modelButton = [[HBModelButton alloc] init];
        _modelButton.backgroundColor = [UIColor whiteColor];
        _modelButton.modelLabel.text = @"Reward Video";
        _modelButton.image.image = [UIImage imageNamed:@"rewarded video"];
    }
    return _modelButton;
}

- (HBMenuView *)menuView
{
    if (!_menuView) {
        _menuView = [[HBMenuView alloc] initWithMenuList:self.placementIDs.allKeys subMenuList:nil];
        _menuView.layer.masksToBounds = YES;
        _menuView.turnAuto = true;
        _menuView.layer.cornerRadius = 5;
        __weak typeof(self) weakSelf = self;
        
        [_menuView setSelectMenu:^(NSString * _Nonnull selectMenu) {
            
            
            weakSelf.placementID = weakSelf.placementIDs[selectMenu];
            NSLog(@"select placementId:%@", weakSelf.placementID);
            weakSelf.selectMenuStr = selectMenu;
            
            
            [weakSelf turnOnAuto:false];
            
      
        }];
        
        [_menuView setTurnOnAuto:^(Boolean isOn) {
            
            [weakSelf turnOnAuto:isOn];
            
            
        }];
        
    }
    return _menuView;
}

-(void)turnOnAuto:(Boolean)isOn {
    self.footView.loadBtn.hidden = isOn;
    if (isOn) {
       
        [[HBRewardedVideoAutoAdManager sharedInstance]addAutoLoadAdPlacementIDArray:@[self.placementID]];
    }
    else{
        [[HBRewardedVideoAutoAdManager sharedInstance]removeAutoLoadAdPlacementIDArray:@[self.placementID]];
    }
    self.isAuto = isOn;
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
        _suspendedBtn = [[HBSuspendedButton alloc] initWithProtocolList:@[@"HBAdLoadingDelegate", @"HBRewardedVideoDelegate"]];
        [_suspendedBtn setImage:[UIImage imageNamed:@"HyperBid_logo"] forState:UIControlStateNormal];
        _suspendedBtn.layer.masksToBounds = YES;
        _suspendedBtn.layer.cornerRadius = kScaleW(50);
        _suspendedBtn.layer.borderWidth = kScaleW(1);
        _suspendedBtn.layer.borderColor = [[UIColor grayColor] CGColor];
    }
    return _suspendedBtn;
}

@end
