//
//  HBInterstitialViewController.m
//  HyperBidSDKDemo
//
//  Created by Leo on 21/09/2018.
//  Copyright © 2018 Leo. All rights reserved.
//

#import "HBInterstitialViewController.h"
#import "HyperBidAdManager.h"
#import "HBModelButton.h"
#import "HBADFootView.h"
#import "HBMenuView.h"

#import "HBSuspendedButton.h"
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
static NSString *const kChartboostPlacementID = @"b5baf5cd422553";
static NSString *const kTapjoyPlacementID = @"b5baf5ebe8df89";
static NSString *const kIronsourcePlacementID = @"b5baf617891a2e";
static NSString *const kVunglePlacementID = @"b5baf61edafdbb";
static NSString *const kAdColonyPlacementID = @"b5baf620280a65";

static NSString *const kBaiduPlacementID = @"b5c04ddc6ba49e";
static NSString *const kUnityAdsPlacementID = @"b5c21a055a51ab";
static NSString *const kNendPlacementID = @"b5cb96db9b3b0f";
static NSString *const kNendVideoPlacementID = @"b5cb96dd930c57";
static NSString *const kNendFullScreenPlacementID = @"b5cb96df0f1914";
static NSString *const kMaioPlacementID = @"b5cb96cf795c4b";
static NSString *const kSigmobPlacementID = @"b5ed8ceb5a286d";
static NSString *const kSigmobIntRVPlacementID = @"b5d771f79e4a32";
static NSString *const kKSPlacementID = @"b5d807a4846f50";
static NSString *const kOguryPlacementID = @"b5dde238f2d2ce";
static NSString *const kStartAppPlacementID = @"b5e731a0acabdf";
static NSString *const kStartAppVideoPlacementID = @"b5e732a9577182";
static NSString *const kFyberPlacementID = @"b5e96db2198474";
static NSString *const kGAMPlacementID = @"b5f2389ab6ee63";
static NSString *const kHeliumPlacementID = @"b5f583ec12143f";

static NSString *const kKidozPlacementID = @"b5feaa2df0e121";
static NSString *const kMyTargetPlacementID = @"b5feaa306e483c";



@interface HBInterstitialViewController ()<HBInterstitialDelegate>
@property(nonatomic, readonly) NSString *name;
@property(nonatomic, readonly) NSDictionary<NSString*, NSString*>* placementIDs;
@property(nonatomic, readonly) UIActivityIndicatorView *loadingView;



@property (copy, nonatomic) NSString *placementID;
@property (nonatomic, strong) HBModelButton *fullScreenBtn;

@property (nonatomic, strong) HBModelButton *interstitialBtn;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) HBSuspendedButton *suspendedBtn;

@property (copy, nonatomic) NSDictionary<NSString *, NSString *> *placementIDs_inter;
@property (copy, nonatomic) NSDictionary<NSString *, NSString *> *placementIDs_fullScreen;

@property(nonatomic, strong) NSString *togetherLoadAdStr;
@property(nonatomic,assign) BOOL isAuto;


@property (nonatomic, strong) HBADFootView *footView;
@property (nonatomic, strong) HBMenuView *menuView;

@end

@implementation HBInterstitialViewController

-(instancetype)init{
    self = [super init];
    
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
                      kChartboostPlacementName:kChartboostPlacementID,
                      kTapjoyPlacementName:kTapjoyPlacementID,
                      kIronsourcePlacementName:kIronsourcePlacementID,
                      kVunglePlacementName:kVunglePlacementID,
                      kAdcolonyPlacementName:kAdColonyPlacementID,
                      kAllPlacementName:kAllPlacementID,
                      kBaiduPlacement:kBaiduPlacementID,
                      kUnityAdsPlacementName:kUnityAdsPlacementID,
                      kNendPlacement:kNendPlacementID,
                      kNendInterstitialVideoPlacement:kNendVideoPlacementID,
                      kNendFullScreenInterstitialPlacement:kNendFullScreenPlacementID,
                      kMaioPlacement:kMaioPlacementID,
                      kSigmobPlacement:kSigmobPlacementID,
                      kSigmobRVIntPlacement:kSigmobIntRVPlacementID,
                      kKSPlacement:kKSPlacementID,
                      kOguryPlacement:kOguryPlacementID,
                      kStartAppPlacement:kStartAppPlacementID,
                      kStartAppVideoPlacement:kStartAppVideoPlacementID,
                      kFyberPlacement:kFyberPlacementID,
                      kGAMPlacement:kGAMPlacementID,
                      kHeliumPlacement:kHeliumPlacementID,
                      kKidozPlacement:kKidozPlacementID,
                      kMyTargetPlacement:kMyTargetPlacementID
                      };
    return  self;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    [[HBAPI sharedInstance] setCustomData:@{@"test_key":@"test_val"} forPlacementID:kGDTPlacementID];
    
    self.title = @"Intersitial";
    self.view.backgroundColor = kRGB(245, 245, 245);
    
    [self setupUI];
    [self changeModel:self.fullScreenBtn];
    
    [HBInterstitialAutoAdManager sharedInstance].delegate = self;
    
    
    
}


- (void)setupUI
{
    UIButton *clearBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    [clearBtn setTitle:@"clear log" forState:UIControlStateNormal];
    [clearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(clearLog) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:clearBtn];
    self.navigationItem.rightBarButtonItem = btnItem;
    
    [self.view addSubview:self.fullScreenBtn];
    [self.view addSubview:self.interstitialBtn];
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.footView];
//    [self.view addSubview:self.suspendedBtn];
    
    [self.fullScreenBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo((kScreenW - kScaleW(26) * 3) / 2);
        make.height.mas_equalTo(kScaleW(360));
        make.top.equalTo(self.view.mas_top).offset( kScaleW(20));
        make.left.equalTo(self.view.mas_left).offset(kScaleW(26));
    }];

    [self.interstitialBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(kScaleW(-26));
        make.width.mas_equalTo((kScreenW - kScaleW(26) * 3) / 2);
        make.height.mas_equalTo(kScaleW(360));
        make.top.equalTo(self.view.mas_top).offset( kScaleW(20));
    }];

    [self.menuView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenW - kScaleW(52));
        make.height.mas_equalTo(kScaleW(242));
        make.top.equalTo(self.fullScreenBtn.mas_bottom).offset(kScaleW(20));
        make.centerX.equalTo(self.view.mas_centerX);
    }];

    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.menuView.mas_bottom).offset(kScaleW(20));
        make.bottom.equalTo(self.footView.mas_top).offset(kScaleW(-20));
        make.width.mas_equalTo(kScreenW - kScaleW(52));
        make.centerX.equalTo(self.view.mas_centerX);
    }];

    [self.footView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
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

- (void)setupData
{
    self.placementID = self.placementIDs.allValues.firstObject;
}

#pragma mark - Action
#pragma mark - Action
- (void)changeModel:(UIButton *)sender
{
    if ((self.fullScreenBtn.isSelected && sender == self.fullScreenBtn) || (self.interstitialBtn.isSelected && sender == self.interstitialBtn)) {
        return;
    }
//    self.fullScreenBtn.selected = sender == self.fullScreenBtn;
//    self.interstitialBtn.selected = sender == self.interstitialBtn;
    [self.fullScreenBtn setButtonIsSelectBoard];
    [self.interstitialBtn setButtonIsSelectBoard];
//
    
//    if (!self.interstitialBtn.isSelected) {
//        self.interstitialBtn.image.image = [UIImage imageNamed:@"banner_unselect"];
//    }else{
//        self.interstitialBtn.image.image = [UIImage imageNamed:@"banner"];
//    }
//
//    if (!self.fullScreenBtn.isSelected) {
//        self.fullScreenBtn.image.image = [UIImage imageNamed:@"Interstitial-fullscreen_unselect"];
//    }else{
//        self.fullScreenBtn.image.image = [UIImage imageNamed:@"Interstitial-fullscreen"];
//    }
    
    
 
    [self resetPlacementID];
}

- (void)resetPlacementID {
    [self.menuView resetMenuList:self.placementIDs.allKeys];
    self.placementID = self.placementIDs.allValues.firstObject;
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
    
    [self.view addSubview:_loadingView];
    [[HBAdManager sharedManager] loadAd:_placementIDs[_name] extra:[_name isEqualToString:kSigmobRVIntPlacement] ? @{kHBInterstitialExtraUsesRewardedVideo:@YES} : @{} delegate:self];
    
}

- (void)loadAd
{
    CGSize size = CGSizeMake(CGRectGetWidth(self.view.bounds) - 30.0f, 300.0f);
    NSDictionary *extraDic = @{
        kHBInterstitialExtraAdSizeKey:[NSValue valueWithCGSize:size],
    };

    [[HBAdManager sharedManager] loadAd:self.placementID extra:
     extraDic delegate:self];
}

- (void)checkAd
{
    
//    HBCheckLoadModel *checkLoadModel = [[HBAdManager sharedManager] checkInterstitialReadyAdInfo:self.placementID];
    
    NSArray *checkArray = [[HBAdManager sharedManager] getInterstitialValidAdsForPlacementID:self.placementID];
    
    NSLog(@"HBInterstitialViewController--checkLoadModel--%ld----:%@",checkArray.count,checkArray);

    
    BOOL isReady = [[HBAdManager sharedManager] isReadyInterstitialWithPlacementID:self.placementID];
    
    if (_isAuto) {
        isReady = [[HBInterstitialAutoAdManager sharedInstance] autoLoadInterstitialReadyForPlacementID:self.placementID];
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:isReady ? @"Ready!" : @"Not Yet!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

- (void)showAd
{
   
    if (self.isAuto) {
    

        
        [[HBInterstitialAutoAdManager sharedInstance] showAutoLoadInterstitialWithPlacementID:self.placementID scene:@"f5e549727efc49" inViewController:self delegate:self];
        
        
    }else{
        [[HBAdManager sharedManager] showInterstitialAd:self.placementID scene:@"f5e549727efc49" inViewController:self delegate:self];
        
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
#pragma mark - delegate method(s)
- (void)didStartLoadingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra{
    
    NSLog(@"广告源--AD--开始--ATInterstitialViewController::didStartLoadingADSourceWithPlacementID:%@---extra:%@", placementID,extra);
    
//    [self showLog:[NSString stringWithFormat:@"didStartLoadingADSourceWithPlacementID:%@---extra:%@", placementID,extra]];
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)didFinishLoadingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra{
    
    NSLog(@"广告源--AD--完成--ATInterstitialViewController::didFinishLoadingADSourceWithPlacementID:%@---extra:%@", placementID,extra);
    
//    [self showLog:[NSString stringWithFormat:@"didFinishLoadingADSourceWithPlacementID:%@---extra:%@", placementID,extra]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)didFailToLoadADSourceWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra error:(NSError*)error{
    NSLog(@"广告源--AD--失败--ATInterstitialViewController::didFailToLoadADSourceWithPlacementID:%@---error:%@", placementID,error);
    
//    [self showLog:[NSString stringWithFormat:@"didFailToLoadADSourceWithPlacementID:%@--%@", placementID],error];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

// bidding
- (void)didStartBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra{
    
    NSLog(@"广告源--bid--开始--ATInterstitialViewController::didStartBiddingADSourceWithPlacementID:%@---extra:%@", placementID,extra);
    
//    [self showLog:[NSString stringWithFormat:@"didStartBiddingADSourceWithPlacementID:%@---extra:%@", placementID,extra]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)didFinishBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra{
    
    NSLog(@"广告源--bid--完成--ATInterstitialViewController::didFinishBiddingADSourceWithPlacementID:%@--extra:%@", placementID,extra);
    
//    [self showLog:[NSString stringWithFormat:@"didFinishBiddingADSourceWithPlacementID:%@---extra:%@", placementID,extra]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)didFailBiddingADSourceWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra error:(NSError*)error{
    
    NSLog(@"广告源--bid--失败--ATInterstitialViewController::didFailBiddingADSourceWithPlacementID:%@--error:%@", placementID,error);
    
//    [self showLog:[NSString stringWithFormat:@"didFailBiddingADSourceWithPlacementID:%@", placementID]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void) didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"HBInterstitialViewController::didFinishLoadingADWithPlacementID:%@", placementID);
    
    [self showLog:[NSString stringWithFormat:@"didFinishLoadingADWithPlacementID:%@", placementID]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void) didFailToLoadADWithPlacementID:(NSString*)placementID error:(NSError*)error {
    NSLog(@"HBInterstitialViewController::didFailToLoadADWithPlacementID:%@ error:%@", placementID, error);
    
    [self showLog:[NSString stringWithFormat:@"didFailToLoadADWithPlacementID:%@ errorCode:%ld", placementID, error.code]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void) interstitialDidShowForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBInterstitialViewController::interstitialDidShowForPlacementID:%@ extra:%@", placementID, extra);
    
    [self showLog:[NSString stringWithFormat:@"interstitialDidShowForPlacementID:%@", placementID]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void) interstitialFailedToShowForPlacementID:(NSString*)placementID error:(NSError*)error extra:(NSDictionary *)extra {
    NSLog(@"HBInterstitialViewController::interstitialFailedToShowForPlacementID:%@ error:%@ extra:%@", placementID, error, extra);
    
    [self showLog:[NSString stringWithFormat:@"interstitialFailedToShowForPlacementID:%@ error:%@", placementID, error]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void) interstitialDidFailToPlayVideoForPlacementID:(NSString*)placementID error:(NSError*)error extra:(NSDictionary*)extra {
    NSLog(@"HBInterstitialViewController::interstitialDidFailToPlayVideoForPlacementID:%@ error:%@ extra:%@", placementID, error, extra);
    
    [self showLog:[NSString stringWithFormat:@"interstitialDidFailToPlayVideoForPlacementID:%@ errorCode:%ld", placementID, error.code]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void) interstitialDidStartPlayingVideoForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBInterstitialViewController::interstitialDidStartPlayingVideoForPlacementID:%@ extra:%@", placementID, extra);
    
    [self showLog:[NSString stringWithFormat:@"HBInterstitialViewController::interstitialDidStartPlayingVideoForPlacementID:%@", placementID]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void) interstitialDidEndPlayingVideoForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBInterstitialViewController::interstitialDidEndPlayingVideoForPlacementID:%@ extra:%@", placementID, extra);
    
    [self showLog:[NSString stringWithFormat:@"interstitialDidEndPlayingVideoForPlacementID:%@", placementID]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void) interstitialDidCloseForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBInterstitialViewController::interstitialDidCloseForPlacementID:%@ extra:%@", placementID, extra);
    
    [self showLog:[NSString stringWithFormat:@"interstitialDidCloseForPlacementID:%@", placementID]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

-(void) interstitialDidClickForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBInterstitialViewController::interstitialDidClickForPlacementID:%@ extra:%@", placementID, extra);
    
    [self showLog:[NSString stringWithFormat:@"interstitialDidClickForPlacementID:%@", placementID]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}

- (void)interstitialDeepLinkOrJumpForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra result:(BOOL)success {
    NSLog(@"HBInterstitialViewController:: interstitialDeepLinkOrJumpForPlacementID:placementID:%@ with extra: %@, success:%@", placementID,extra, success ? @"YES" : @"NO");
    
    [self showLog:[NSString stringWithFormat:@"interstitialDeepLinkOrJumpForPlacementID:placementID:%@, success:%@", placementID, success ? @"YES" : @"NO"]];
    
    [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
}


#pragma mark - lazy
- (HBADFootView *)footView
{
    if (!_footView) {
//        _footView = [[HBADFootView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScaleW(340))];
//        _footView.removeBtn.hidden = YES;
//        _footView.showBtn.frame = CGRectMake(kScaleW(26), kScaleW(230), (kScreenW - kScaleW(52)), kScaleW(90));
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

- (HBModelButton *)fullScreenBtn
{
    if (!_fullScreenBtn) {
        _fullScreenBtn = [[HBModelButton alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScaleW(532))];
        _fullScreenBtn.tag = 0;
        _fullScreenBtn.backgroundColor = [UIColor whiteColor];
        _fullScreenBtn.layer.borderWidth = kScaleW(5);
        _fullScreenBtn.modelLabel.text = @"FullScreen";
        _fullScreenBtn.image.image = [UIImage imageNamed:@"Interstitial-fullscreen"];
        [_fullScreenBtn addTarget:self action:@selector(changeModel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullScreenBtn;
}

- (HBModelButton *)interstitialBtn
{
    if (!_interstitialBtn) {
        _interstitialBtn = [[HBModelButton alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScaleW(532))];
        _interstitialBtn.tag = 1;
        _interstitialBtn.backgroundColor = [UIColor whiteColor];
        _interstitialBtn.layer.borderWidth = kScaleW(5);
        _interstitialBtn.modelLabel.text = @"Interstitial";
        _interstitialBtn.image.image = [UIImage imageNamed:@"banner"];
        [_interstitialBtn addTarget:self action:@selector(changeModel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _interstitialBtn;
}

- (HBMenuView *)menuView
{
    if (!_menuView) {
        _menuView = [[HBMenuView alloc] initWithMenuList:self.placementIDs.allKeys subMenuList:nil];
        _menuView.turnAuto = true;
        _menuView.layer.masksToBounds = YES;
        _menuView.layer.cornerRadius = 5;
        __weak typeof (self) weakSelf = self;
        [_menuView setSelectMenu:^(NSString * _Nonnull selectMenu) {
            weakSelf.placementID = weakSelf.placementIDs[selectMenu];
            NSLog(@"select placementId:%@", weakSelf.placementID);
            
            if (weakSelf.isAuto) {
                [[HBInterstitialAutoAdManager sharedInstance]addAutoLoadAdPlacementIDArray:@[weakSelf.placementID]];
            }
     
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
       
        [[HBInterstitialAutoAdManager sharedInstance]addAutoLoadAdPlacementIDArray:@[self.placementID]];
    }
    else{
        [[HBInterstitialAutoAdManager sharedInstance]removeAutoLoadAdPlacementIDArray:@[self.placementID]];
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
        _textView.text = @"";
    }
    return _textView;
}

- (HBSuspendedButton *)suspendedBtn
{
    if (!_suspendedBtn) {
        _suspendedBtn = [[HBSuspendedButton alloc] initWithProtocolList:@[@"HBAdLoadingDelegate", @"HBInterstitialDelegate"]];
        [_suspendedBtn setImage:[UIImage imageNamed:@"HyperBid_logo"] forState:UIControlStateNormal];
        _suspendedBtn.layer.masksToBounds = YES;
        _suspendedBtn.layer.cornerRadius = kScaleW(50);
        _suspendedBtn.layer.borderWidth = kScaleW(1);
        _suspendedBtn.layer.borderColor = [[UIColor grayColor] CGColor];
    }
    return _suspendedBtn;
}

@end
