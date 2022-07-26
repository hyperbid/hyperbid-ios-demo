//
//  HBNativeViewController.m
//  HyperBidSDKDemo
//
//  Created by mac on 2021/12/6.
//

#import "HBNativeViewController.h"
#import "HBADFootView.h"
#import "HBModelButton.h"
//#import "HBNativeRenderView.h"
#import "HBNativeMessageStreamViewController.h"
#import "HBDrawViewController.h"
#import "HBNativeShowViewController.h"
#import "HBMenuView.h"
#import "HBSuspendedButton.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import "HBNativeSelfRenderView.h"

NSString *const kMPPlacement = @"MobPower";
NSString *const kInmobiPlacement = @"Inmobi";
NSString *const kFacebookPlacement = @"Facebook";
NSString *const kFacebookHeaderBiddingPlacement = @"Facebook(Header Bidding)";
NSString *const kAdMobPlacement = @"AdMob";
NSString *const kApplovinPlacement = @"Applovin";
NSString *const kMintegralAdvancedPlacement = @"Mintegral(Advanced)";
NSString *const kMintegralPlacement = @"Mintegral";
NSString *const kGDTPlacement = @"GDT";
NSString *const kGDTTemplatePlacement = @"GDT(Template)";

NSString *const kTTFeedPlacementName = @"TT(Feed)";
NSString *const kTTDrawPlacementName = @"TT(Draw)";
NSString *const kAllPlacementName = @"All";
NSString *const kNendVideoPlacement = @"Nend(Video)";
NSString *const kSigmobPlacement = @"Sigmob";
NSString *const kKSDrawPlacement = @"KS(Draw)";
NSString *const kGAMPlacement = @"GAM";


static NSString *const kMPPlacementID = @"b5c2084d12aca4";
static NSString *const kPlacement0ID = @"b5ad9ba61dcb39";
static NSString *const kInmobiPlacementID = @"b5b0f553483724";
static NSString *const kMintegralAdvancedPlacementID = @"b5ee1d26cb56ee";
static NSString *const kMintegralPlacementID = @"b5b0f555698607";
static NSString *const kMintegralHeaderBiddingPlacementID = @"b5d1333d023691";
static NSString *const kFacebookPlacementID = @"b5b0f551340ea9";
static NSString *const kFacebookHeaderBiddingPlacementID = @"b5d13342d52304";
static NSString *const kAdMobPlacementID = @"b5b0f55228375a";
static NSString *const kApplovinPlacementID = @"b5b0f554ec9c4e";

static NSString *const kGDTPlacementID = @"b5bacac5f73476";
static NSString *const kGDTTemplatePlacementID = @"b5bacac780e03b";
static NSString *const kAllPlacementID = @"b5b0f5663c6e4a";
static NSString *const kTTFeedPlacementID = @"b5c2c6d50e7f44";
static NSString *const kNendPlacementID = @"b5cb96d44c0c5f";
static NSString *const kNendVideoPlacementID = @"b5cb96d5291e93";
static NSString *const kBaiduPlacementID = @"b5d36c4ad68a26";
static NSString *const kKSPlacementID = @"b5e4613e50cbf2";//@"b5e43ac9ca3fc5";
static NSString *const kGAMPlacementID = @"b5f238964f3e6f";
static NSString *const kTTDrawPlacementID = @"b5c2c6d62b9d65";
static NSString *const kSigmobPlacementID = @"b5d771f5a3458f";

@import HyperBidNative;

@interface HBNativeViewController () <HBAdLoadingDelegate, HBNativeADDelegate>

@property (nonatomic, strong) HBADFootView *footView;

@property (nonatomic, strong) HBModelButton *nativeBtn;

@property (nonatomic, strong) HBModelButton *drawBtn;

@property (nonatomic, strong) HBModelButton *preRollBtn;

@property (nonatomic, strong) HBMenuView *menuView;

@property (nonatomic, strong) UITextView *textView;

@property(nonatomic) HBNativeADView *adView;


@property (nonatomic, strong) HBSuspendedButton *suspendedBtn;

@property (copy, nonatomic) NSString *placementID;

@property (copy, nonatomic) NSDictionary<NSString *, NSString *> *placementIDs_native;
@property (copy, nonatomic) NSDictionary<NSString *, NSString *> *placementIDs_draw;
@property (copy, nonatomic) NSDictionary<NSString *, NSString *> *placementIDs_preRoll;
@property (copy, nonatomic) NSDictionary<NSString *, NSString *> *placementIDs;
@property(nonatomic,retain) UIView * renderView;
@property (nonatomic, copy) NSString *nativeStr;

@property (nonatomic, strong) UIView *showView;

@property(nonatomic, strong) NSString *togetherLoadAdStr;

@property(nonatomic, strong) HBNativeSelfRenderView *nativeSelfRenderView;
@property(nonatomic,retain) UIImageView * iconview;

@end

@implementation HBNativeViewController

- (void)dealloc
{
    NSLog(@"🔥----ATNativeViewController销毁%@", NSStringFromSelector(_cmd));
    [self removeAd];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kRGB(245, 245, 245);
    self.title = @"Native";
    [self setupData];
    [self setupUI];
    [self changeModel:self.nativeBtn];
}

- (void)setupData
{
    self.placementID = self.placementIDs.allValues.firstObject;
}

- (NSDictionary<NSString *,NSString *> *)placementIDs_native{
    
    return @{
        @"MyOffer":                 @"b5f33878ee0646",
        @"GAM":                     @"b5f238964f3e6f",
        @"Mintegral-(Advanced)":    @"b5ee1d26cb56ee",
        @"Header Bidding":          @"b5d1333d023691",
        @"Nend":                    @"b5cb96d44c0c5f",
        @"Nend-(Video)":            @"b5cb96d5291e93",
        @"TT-(Feed)":               @"b5c2c6d50e7f44",
        @"Pangle":                  @"b612f6a831fe71",
        @"MobPower":                @"b5c2084d12aca4",
        @"Facebook":                @"b5b0f551340ea9",
        @"Facebook(NativeBanner)":  @"b5ee89fd60cddc",
        @"AdMob":                   @"b5b0f55228375a",
        @"Inmobi":                  @"b5b0f553483724",
        @"Mintegral":               @"b5b0f555698607",
        @"GDT-(self randerer)":     @"b5bacac5f73476",
        @"GDT-(Template)":          @"b5bacac780e03b",
        @"Vungle":@"b62a6f6d459cf5",
        @"Baidu":                   @"b5d36c4ad68a26",
        @"KS":                      @"b5e4613e50cbf2",
        @"ADX":                     @"b5fa25023d0767",
        @"OnlineApi":               @"b5fa2508579446",
        @"All":                     @"b5b0f5663c6e4a",
        @"Gromore":                 @"b601cac6b99ead",
        @"Sigmob":                  @"b6170cda99de6d",
        @"DirectOffer":             @"b61bfff2c812cb",
        @"Klevin":                  @"b6172985f45143",
        @"MyTarget":                @"b625ce4791005d",
        @"DSP":                     @"b628f3c9eb47db",
    };
}

- (NSDictionary<NSString *,NSString *> *)placementIDs_draw{
    
    return @{
        @"TT(Draw)":                @"b5c2c6d62b9d65",
        @"KS(Draw)":                @"b5e5ce042cabfb",
    };
}
- (NSDictionary<NSString *,NSString *> *)placementIDs_preRoll{
    return @{
        @"TT(Feed)":                @"b5c2c6d50e7f44"
    };
}

- (void)setupUI
{
    UIButton *clearBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    [clearBtn setTitle:@"clear log" forState:UIControlStateNormal];
    [clearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(clearLog) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:clearBtn];
    self.navigationItem.rightBarButtonItem = btnItem;
    
    [self.view addSubview:self.nativeBtn];
    [self.view addSubview:self.drawBtn];
    [self.view addSubview:self.preRollBtn];
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.footView];
    [self.view addSubview:self.suspendedBtn];
    
    
    
    
    
    [self.nativeBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo((kScreenW - kScaleW(26) * 4) / 3);
        make.height.mas_equalTo(kScaleW(360));
        make.top.equalTo(self.view.mas_top).offset(kNavigationBarHeight + kScaleW(20));
        make.left.equalTo(self.view.mas_left).offset(kScaleW(26));
    }];

    [self.drawBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nativeBtn.mas_right).offset(kScaleW(26));
        make.width.mas_equalTo((kScreenW - kScaleW(26) * 4) / 3);
        make.height.mas_equalTo(self.nativeBtn.mas_height);
        make.top.equalTo(self.view.mas_top).offset(kNavigationBarHeight + kScaleW(20));
    }];

    [self.preRollBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(kScaleW(-26));
        make.width.mas_equalTo((kScreenW - kScaleW(26) * 4) / 3);
        make.height.mas_equalTo(self.nativeBtn.mas_height);
        make.top.equalTo(self.view.mas_top).offset(kNavigationBarHeight + kScaleW(20));
    }];

    [self.menuView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenW - kScaleW(52));
        make.height.mas_equalTo(kScaleW(242));
        make.top.equalTo(self.nativeBtn.mas_bottom).offset(kScaleW(20));
        make.centerX.equalTo(self.view.mas_centerX);
    }];

    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.menuView.mas_bottom).offset(kScaleW(20));
        make.bottom.equalTo(self.footView.mas_top).offset(kScaleW(-20));
        make.width.mas_equalTo(kScreenW - kScaleW(52));
        make.centerX.equalTo(self.view.mas_centerX);
    }];

    [self.footView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(kScaleW(340));
    }];
    
    [self.suspendedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(kScaleW(100));
        make.top.equalTo(self.view.mas_top).offset(kScaleW(200));
        make.right.equalTo(self.view.mas_right);
    }];
}

#pragma mark - together load
- (void)togetherLoadAd:(NSString *)togetherLoadAdStr{
    self.togetherLoadAdStr = togetherLoadAdStr;
    NSLog(@"同时加载原生广告位---%@",self.placementID);

    if (self.placementID) {
        [self loadAd];
    }
}

- (NSString *)placementID{
    if (self.togetherLoadAdStr.length) {
        NSString *tempID = self.placementIDs_native[self.togetherLoadAdStr];
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
- (void)changeModel:(UIButton *)sender
{
    if ((self.nativeBtn.isSelected && sender == self.nativeBtn) || (self.drawBtn.isSelected && sender == self.drawBtn) || (self.preRollBtn.isSelected && sender == self.preRollBtn)) {
        return;
    }
    if (sender.tag == 0) {
        self.nativeBtn.selected = YES;
        self.drawBtn.selected = NO;
        self.preRollBtn.selected = NO;
        self.placementIDs = self.placementIDs_native;
        [self.menuView showSubMenu];
        
       
        
    } else if (sender.tag == 1) {
        self.nativeBtn.selected = NO;
        self.drawBtn.selected = YES;
        self.preRollBtn.selected = NO;
        self.placementIDs = self.placementIDs_draw;
        [self.menuView hiddenSubMenu];
        
      
    } else {
        self.nativeBtn.selected = NO;
        self.drawBtn.selected = NO;
        self.preRollBtn.selected = YES;
        self.placementIDs = self.placementIDs_preRoll;
        [self.menuView hiddenSubMenu];
        
        
    }
    [self.nativeBtn setButtonIsSelectBoard];
    [self.drawBtn setButtonIsSelectBoard];
    [self.preRollBtn setButtonIsSelectBoard];
    
    [self resetPlacementID];
}

- (void)resetPlacementID {
    [self.menuView resetMenuList:self.placementIDs.allKeys];
    self.placementID = self.togetherLoadAdStr.length ? self.placementIDs[self.togetherLoadAdStr] : self.placementIDs.allValues.firstObject;
}


- (void)loadAd
{
    
    
    
    if (self.adView) {
        [self.adView clearAdCache];
        self.adView = nil;
        [self.renderView removeFromSuperview];
    }
    
    CGSize size = CGSizeMake(kScreenW, 350);
    if ([self.placementIDs_draw.allValues containsObject:self.placementID]) {
        size = self.view.frame.size;
    }
    NSDictionary *extra = @{
        kHBExtraInfoNativeAdSizeKey:[NSValue valueWithCGSize:size],
        kHBExtraNativeImageSizeKey:kHBExtraNativeImageSize690_388,
        kHBNativeAdSizeToFitKey:@YES,
        // Start APP
        kHBExtraNativeIconImageSizeKey: @(HB_SIZE_72X72),
        kHBExtraStartAPPNativeMainImageSizeKey:@(HB_SIZE_1200X628),
    };
    [[HBAdManager sharedManager] loadAd:self.placementID extra:extra delegate:self];
}

- (void)checkAd
{
    // list
    NSArray *array = [[HBAdManager sharedManager] getNativeValidAdsForPlacementID:self.placementID];
    NSLog(@"ValidAds.count:%ld--- ValidAds:%@",array.count,array);

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[[HBAdManager sharedManager] isReadyNativeAdWithPlacementID:self.placementID] ? @"Ready!" : @"Not Yet!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

- (void)showAd
{
    
    BOOL ready = [[HBAdManager sharedManager] isReadyNativeAdWithPlacementID:self.placementID];
    
    if (ready == NO) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Not Yet!" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
        }];
        return;
    }
    
    if (self.nativeBtn.isSelected && [self.nativeStr isEqualToString:@"Native List"]) {
        // 列表
        HBNativeMessageStreamViewController *messageVc = [[HBNativeMessageStreamViewController alloc] initWithAdView:self.adView];
        [self.navigationController pushViewController:messageVc animated:YES];
    } else if (self.drawBtn.isSelected) {
        [self showDrawAd];
    } else {
        

        HBNativeADConfiguration *config = [self getNativeADConfiguration];//:vc];
        
        
        HBNativeAdOffer *offer = [[HBAdManager sharedManager] getNativeAdOfferWithPlacementID:self.placementID];
        
//        HBNativeShowViewController *showVc = [[HBNativeShowViewController alloc] initWithAdView:nativeADView placementID:self.placementID offer:offer];
        
        HBNativeSelfRenderView *selfRenderView = [self getSelfRenderViewOffer:offer];
        
        HBNativeADView *nativeADView = [self getNativeADView:config offer:offer selfRenderView:selfRenderView];
        
        
        [self prepareWithNativePrepareInfo:selfRenderView nativeADView:nativeADView];
        
        [offer rendererWithConfiguration:config selfRenderView:selfRenderView nativeADView:nativeADView];
                
        
        HBNativeAdRenderType nativeAdRenderType = [nativeADView getCurrentNativeAdRenderType];
        
        if (nativeAdRenderType == HBNativeAdRenderExpress) {
            NSLog(@"🔥--原生模板");
            NSLog(@"🔥--原生模板广告宽高：%lf，%lf",offer.nativeAd.nativeExpressAdViewWidth,offer.nativeAd.nativeExpressAdViewHeight);
        }else{
            NSLog(@"🔥--原生自渲染");
        }
        
        BOOL isVideoContents = [nativeADView isVideoContents];
        NSLog(@"🔥--是否为原生视频广告：%d",isVideoContents);
        
        if ([offer.adOfferInfo[@"network_firm_id"] integerValue] == 67) {
            config.mediaViewFrame = CGRectMake(0, kNavigationBarHeight, kScreenW, 350);
        }
        
        self.renderView = selfRenderView;
  
        
        HBNativeShowViewController * vc = [[HBNativeShowViewController alloc]initWithAdView:nativeADView placementID:_placementID offer:offer];
 

       [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)removeAd
{
    if (self.adView && self.adView.superview) {
        [self.adView removeFromSuperview];
    }
//    self.adView = nil;
}

- (void)showLog:(NSString *)logStr
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *logS = self.textView.text;
        NSString *log = nil;
        if (![logS isEqualToString:@""]) {
            log = [NSString stringWithFormat:@"%@\n\n%@", logS, logStr];
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

#pragma mark - Show

- (HBNativeADConfiguration *)getNativeADConfiguration{
    HBNativeADConfiguration *config = [[HBNativeADConfiguration alloc] init];
    config.ADFrame = CGRectMake(0, kNavigationBarHeight, kScreenW, 350);
    config.mediaViewFrame = CGRectMake(0, kNavigationBarHeight + 150.0f, kScreenW, 350 - kNavigationBarHeight - 150);
    
    config.delegate = self;
    config.sizeToFit = YES;
    config.rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    config.context = @{
        kHBNativeAdConfigurationContextAdOptionsViewFrameKey:[NSValue valueWithCGRect:CGRectMake(CGRectGetWidth(self.view.bounds) - 43.0f, .0f, 43.0f, 18.0f)],
        kHBNativeAdConfigurationContextAdLogoViewFrameKey:[NSValue valueWithCGRect:CGRectMake(.0f, .0f, 54.0f, 18.0f)],
        kHBNativeAdConfigurationContextNetworkLogoViewFrameKey:[NSValue valueWithCGRect:CGRectMake(CGRectGetWidth(config.ADFrame) - 54.0f, CGRectGetHeight(config.ADFrame) - 18.0f, 54.0f, 18.0f)]
    };
    return config;
}

- (HBNativeSelfRenderView *)getSelfRenderViewOffer:(HBNativeAdOffer *)offer{
    
    HBNativeSelfRenderView *selfRenderView = [[HBNativeSelfRenderView alloc]initWithOffer:offer];
            
    self.nativeSelfRenderView = selfRenderView;
    
 
    selfRenderView.backgroundColor = randomColor;
    
    return selfRenderView;
}

- (HBNativeADView *)getNativeADView:(HBNativeADConfiguration *)config offer:(HBNativeAdOffer *)offer selfRenderView:(HBNativeSelfRenderView *)selfRenderView{
    
    HBNativeADView *nativeADView = [[HBNativeADView alloc]initWithConfiguration:config currentOffer:offer placementID:self.placementID];
    
    
    
    UIView *mediaView = [nativeADView getMediaView];

    
    NSMutableArray *array = [@[selfRenderView.iconImageView,selfRenderView.titleLabel,selfRenderView.textLabel,selfRenderView.ctaLabel,selfRenderView.mainImageView] mutableCopy];
    
    if (mediaView) {
        [array addObject:mediaView];
    }
    
    [nativeADView registerClickableViewArray:array];
    
    nativeADView.backgroundColor = randomColor;

    mediaView.backgroundColor = [UIColor redColor];
    
    selfRenderView.mediaView = mediaView;
    
    [selfRenderView addSubview:mediaView];
    
    [mediaView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(selfRenderView);
            make.top.equalTo(selfRenderView.mainImageView.mas_top);
    }];

    self.adView = nativeADView;
    
    return nativeADView;
}

- (void)prepareWithNativePrepareInfo:(HBNativeSelfRenderView *)selfRenderView nativeADView:(HBNativeADView *)nativeADView{
    
    HBNativePrepareInfo *info = [HBNativePrepareInfo loadPrepareInfo:^(HBNativePrepareInfo * _Nonnull prepareInfo) {
        prepareInfo.textLabel = selfRenderView.textLabel;
        prepareInfo.advertiserLabel = selfRenderView.advertiserLabel;
        prepareInfo.titleLabel = selfRenderView.titleLabel;
        prepareInfo.ratingLabel = selfRenderView.ratingLabel;
        prepareInfo.iconImageView = selfRenderView.iconImageView;
        prepareInfo.mainImageView = selfRenderView.mainImageView;
        prepareInfo.logoImageView = selfRenderView.logoImageView;
        prepareInfo.sponsorImageView = selfRenderView.sponsorImageView;
        prepareInfo.dislikeButton = selfRenderView.dislikeButton;
        prepareInfo.ctaLabel = selfRenderView.ctaLabel;
        prepareInfo.mediaView = selfRenderView.mediaView;
    }];
    
    [nativeADView prepareWithNativePrepareInfo:info];
}

#pragma mark - draw
- (void)showDrawAd{
    
    // Draw
    HBNativeADConfiguration *config = [[HBNativeADConfiguration alloc] init];
    config.ADFrame = CGRectMake(0, kNavigationBarHeight, kScreenW, kScreenH - kNavigationBarHeight);;
    config.delegate = self;
    config.mediaViewFrame = CGRectMake(0, kNavigationBarHeight + 150.0f, kScreenW, kScreenH - kNavigationBarHeight - 150);
    config.rootViewController = self;

    
    HBNativeAdOffer *offer = [[HBAdManager sharedManager] getNativeAdOfferWithPlacementID:self.placementID];
    HBNativeSelfRenderView *selfRenderView = [[HBNativeSelfRenderView alloc]initWithOffer:offer];
    self.nativeSelfRenderView = selfRenderView;
    selfRenderView.backgroundColor = [UIColor redColor];
    
    HBNativeADView *nativeADView = [[HBNativeADView alloc]initWithConfiguration:config currentOffer:offer placementID:self.placementID];
    
    
    UIView *mediaView = [nativeADView getMediaView];

    NSMutableArray *array = [@[selfRenderView.iconImageView,selfRenderView.titleLabel,selfRenderView.textLabel,selfRenderView.ctaLabel,selfRenderView.mainImageView] mutableCopy];
    
    if (mediaView) {
        [array addObject:mediaView];
    }
    [nativeADView registerClickableViewArray:array];
    
    mediaView.frame = CGRectMake(0, kNavigationBarHeight + 150.0f, kScreenW, kScreenH - kNavigationBarHeight - 150);
//    mediaView.backgroundColor = randomColor;
    [selfRenderView addSubview:mediaView];
    
    [selfRenderView addSubview:nativeADView.videoAdView];
    [selfRenderView addSubview:nativeADView.dislikeDrawButton];
    [selfRenderView addSubview:nativeADView.adLabel];
    [selfRenderView addSubview:nativeADView.logoImageView];
    [selfRenderView addSubview:nativeADView.logoADImageView];
    
    nativeADView.videoAdView.frame = CGRectMake(0, kNavigationBarHeight + 50.0f, kScreenW, kScreenH - kNavigationBarHeight - 50);
    
    nativeADView.dislikeDrawButton.frame = CGRectMake(kScreenW - 50, kNavigationBarHeight + 80.0f , 50,50);
    
    nativeADView.adLabel.frame = CGRectMake(kScreenW - 50, kNavigationBarHeight + 150.0f, kScreenW, 50);
    
    nativeADView.logoImageView.frame = CGRectMake(kScreenW - 50, kNavigationBarHeight + 200.0f, 50, 50);
    nativeADView.logoADImageView.frame = CGRectMake(kScreenW - 50, kNavigationBarHeight + 250.0f, 50, 50);
    
    HBNativePrepareInfo *info = [HBNativePrepareInfo loadPrepareInfo:^(HBNativePrepareInfo * _Nonnull prepareInfo) {
        prepareInfo.textLabel = selfRenderView.textLabel;
        prepareInfo.advertiserLabel = selfRenderView.advertiserLabel;
        prepareInfo.titleLabel = selfRenderView.titleLabel;
        prepareInfo.ratingLabel = selfRenderView.ratingLabel;
        prepareInfo.iconImageView = selfRenderView.iconImageView;
        prepareInfo.mainImageView = selfRenderView.mainImageView;
        prepareInfo.logoImageView = selfRenderView.logoImageView;
        prepareInfo.sponsorImageView = selfRenderView.sponsorImageView;
        prepareInfo.dislikeButton = selfRenderView.dislikeButton;
        prepareInfo.ctaLabel = selfRenderView.ctaLabel;
        prepareInfo.mediaView = mediaView;
    }];
    [nativeADView prepareWithNativePrepareInfo:info];
    
    
    [offer rendererWithConfiguration:config selfRenderView:selfRenderView nativeADView:nativeADView];
    
    HBDrawViewController *drawVc = [[HBDrawViewController alloc] initWithAdView:nativeADView];
    
    [self.navigationController pushViewController:drawVc animated:YES];

    
    
}

#pragma mark - delegate with extra
- (void)didStartLoadingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra{
    
    NSLog(@"广告源--AD--开始--ATNativeViewController::didStartLoadingADSourceWithPlacementID:%@---extra:%@", placementID,extra);
    
//    [self showLog:[NSString stringWithFormat:@"didStartLoadingADSourceWithPlacementID:%@---extra:%@", placementID,extra]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    });
}

- (void)didFinishLoadingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra{
    
    NSLog(@"广告源--AD--完成--ATNativeViewController::didFinishLoadingADSourceWithPlacementID:%@---extra:%@", placementID,extra);
    
//    [self showLog:[NSString stringWithFormat:@"didFinishLoadingADSourceWithPlacementID:%@---extra:%@", placementID,extra]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    });
}

- (void)didFailToLoadADSourceWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra error:(NSError*)error{
    NSLog(@"广告源--AD--失败--ATNativeViewController::didFailToLoadADSourceWithPlacementID:%@---error:%@", placementID,error);
    
//    [self showLog:[NSString stringWithFormat:@"didFailToLoadADSourceWithPlacementID:%@--%@", placementID],error];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    });
}

// bidding
- (void)didStartBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra{
    
    NSLog(@"广告源--bid--开始--ATNativeViewController::didStartBiddingADSourceWithPlacementID:%@---extra:%@", placementID,extra);
    
//    [self showLog:[NSString stringWithFormat:@"didStartBiddingADSourceWithPlacementID:%@---extra:%@", placementID,extra]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    });
}

- (void)didFinishBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra{
    
    NSLog(@"广告源--bid--完成--ATNativeViewController::didFinishBiddingADSourceWithPlacementID:%@--extra:%@", placementID,extra);
    
//    [self showLog:[NSString stringWithFormat:@"didFinishBiddingADSourceWithPlacementID:%@---extra:%@", placementID,extra]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    });
}

- (void)didFailBiddingADSourceWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra error:(NSError*)error{
    
    NSLog(@"广告源--bid--失败--ATNativeViewController::didFailBiddingADSourceWithPlacementID:%@--error:%@", placementID,error);
    
//    [self showLog:[NSString stringWithFormat:@"didFailBiddingADSourceWithPlacementID:%@", placementID]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    });
}

-(void) didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"HBNativeViewController:: didFinishLoadingADWithPlacementID:%@", placementID);
    
    [self showLog:[NSString stringWithFormat:@"didFinishLoading:%@", placementID]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    });
}

-(void) didFailToLoadADWithPlacementID:(NSString *)placementID error:(NSError *)error {
    NSLog(@"HBNativeViewController:: didFailToLoadADWithPlacementID:%@ error:%@", placementID, error);
    
    [self showLog:[NSString stringWithFormat:@"didFailToLoad:%@ errorCode:%ld", placementID, (long)error.code]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    });
}

#pragma mark - delegate with extra
-(void) didStartPlayingVideoInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBNativeViewController:: didStartPlayingVideoInAdView:placementID:%@with extra: %@", placementID,extra);
    
    [self showLog:[NSString stringWithFormat:@"didStartPlayingVideoInAdView:%@", placementID]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    });
}

-(void) didEndPlayingVideoInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBNativeViewController:: didEndPlayingVideoInAdView:placementID:%@ extra: %@", placementID,extra);
    
    [self showLog:[NSString stringWithFormat:@"didEndPlayingVideoInAdView:%@", placementID]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    });
}

-(void) didClickNativeAdInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBNativeViewController:: didClickNativeAdInAdView:placementID:%@ with extra: %@", placementID,extra);
    
    [self showLog:[NSString stringWithFormat:@"didClickNativeAdInAdView:%@", placementID]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    });
}

- (void) didDeepLinkOrJumpInAdView:(HBNativeADView *)adView placementID:(NSString *)placementID extra:(NSDictionary *)extra result:(BOOL)success {
    NSLog(@"HBNativeViewController:: didDeepLinkOrJumpInAdView:placementID:%@ with extra: %@, success:%@", placementID,extra, success ? @"YES" : @"NO");
    
    [self showLog:[NSString stringWithFormat:@"HBNativeViewController:: didDeepLinkOrJumpInAdView:%@, success:%@", placementID, success ? @"YES" : @"NO"]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    });
}

-(void) didShowNativeAdInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBNativeViewController:: didShowNativeAdInAdView:placementID:%@ with extra: %@", placementID,extra);
    
    self.nativeSelfRenderView.mainImageView.hidden = [adView isVideoContents];
    
    [self showLog:[NSString stringWithFormat:@"didShowNativeAdInAdView:%@", placementID]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    });
}

-(void) didEnterFullScreenVideoInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBNativeViewController:: didEnterFullScreenVideoInAdView:placementID:%@", placementID);
    
    [self showLog:[NSString stringWithFormat:@"didEnterFullScreenVideoInAdView:%@", placementID]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    });
}

-(void) didExitFullScreenVideoInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBNativeViewController:: didExitFullScreenVideoInAdView:placementID:%@", placementID);
    
    [self showLog:[NSString stringWithFormat:@"didExitFullScreenVideoInAdView:%@", placementID]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    });
}

-(void) didTapCloseButtonInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBNativeViewController:: didTapCloseButtonInAdView:placementID:%@ extra:%@", placementID, extra);
    
    [self.adView removeFromSuperview];
    self.adView = nil;
    adView = nil;
    [self showLog:[NSString stringWithFormat:@"didTapCloseButtonInAdView:placementID:%@", placementID]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    });
}

- (void)didCloseDetailInAdView:(HBNativeADView *)adView placementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBNativeViewController:: didCloseDetailInAdView:placementID:%@ extra:%@", placementID, extra);

    [self showLog:[NSString stringWithFormat:@"didCloseDetailInAdView:placementID:%@", placementID]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    });
}

-(void) nativeAdDidClickInAdViewForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBNativeViewController:: nativeAdDidClickInAdViewForPlacementID:placementID:%@ extra:%@", placementID, extra);
    
    [self showLog:[NSString stringWithFormat:@"nativeAdDidClickInAdViewForPlacementID:%@", placementID]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    });
}

-(void) nativeAdDeepLinkOrJumpForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra result:(BOOL)success {
    NSLog(@"HBNativeViewController:: nativeAdDeepLinkOrJumpForPlacementID:placementID:%@ extra:%@", placementID, extra);
    
    [self showLog:[NSString stringWithFormat:@"nativeAdDeepLinkOrJumpForPlacementID:placementID:%@", placementID]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    });
}

-(void) nativeAdDidStartPlayingVideoInAdViewForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBNativeViewController:: nativeAdDidStartPlayingVideoInAdViewForPlacementID:placementID:%@ extra:%@", placementID, extra);
    
    [self showLog:[NSString stringWithFormat:@"nativeAdDidStartPlayingVideoInAdViewForPlacementID:%@", placementID]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    });
}

-(void) nativeAdDidEndPlayingVideoInAdViewForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBNativeViewController:: nativeAdDidEndPlayingVideoInAdViewForPlacementID:placementID:%@ extra:%@", placementID, extra);
    
    [self showLog:[NSString stringWithFormat:@"nativeAdDidEndPlayingVideoInAdViewForPlacementID:%@", placementID]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    });
}

-(void) nativeAdDidEnterFullScreenVideoInAdViewForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBNativeViewController:: nativeAdDidEnterFullScreenVideoInAdViewForPlacementID:placementID:%@ extra:%@", placementID, extra);
    
    [self showLog:[NSString stringWithFormat:@"nativeAdDidEnterFullScreenVideoInAdViewForPlacementID:%@", placementID]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    });
}

-(void) nativeAdDidExitFullScreenVideoInAdViewForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"nativeAdDidExitFullScreenVideoInAdViewForPlacementID:%@", placementID);
    
    [self showLog:[NSString stringWithFormat:@"nativeAdDidExitFullScreenVideoInAdViewForPlacementID:%@", placementID]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    });
}

-(void) nativeAdDidTapCloseButtonInAdViewForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBNativeViewController:: nativeAdDidTapCloseButtonInAdViewForPlacementID:placementID:%@ extra:%@", placementID, extra);
    
    [self showLog:[NSString stringWithFormat:@"nativeAdDidTapCloseButtonInAdViewForPlacementID:%@", placementID]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.suspendedBtn recordWithPlacementId:self.placementID protocol:NSStringFromSelector(_cmd)];
    });
}


#pragma mark - lazy
- (HBADFootView *)footView
{
    if (!_footView) {
//        _footView = [[HBADFootView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScaleW(340))];
//
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
        
        if (![NSStringFromClass([self class]) containsString:@"Auto"]) {
            [_footView.loadBtn setTitle:@"Load Native AD" forState:UIControlStateNormal];
            [_footView.readyBtn setTitle:@"Is Native AD Ready" forState:UIControlStateNormal];
            [_footView.showBtn setTitle:@"Show Native AD" forState:UIControlStateNormal];
        }
        
    }
    return _footView;
}

- (HBModelButton *)nativeBtn
{
    if (!_nativeBtn) {
        _nativeBtn = [[HBModelButton alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScaleW(532))];
        _nativeBtn.tag = 0;
        _nativeBtn.backgroundColor = [UIColor whiteColor];
        _nativeBtn.layer.borderWidth = kScaleW(5);
        _nativeBtn.modelLabel.text = @"Native";
        _nativeBtn.image.image = [UIImage imageNamed:@"Native"];
        [_nativeBtn addTarget:self action:@selector(changeModel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nativeBtn;
}

- (HBModelButton *)drawBtn
{
    if (!_drawBtn) {
        _drawBtn = [[HBModelButton alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScaleW(532))];
        _drawBtn.tag = 1;
        _drawBtn.backgroundColor = [UIColor whiteColor];
        _drawBtn.layer.borderWidth = kScaleW(5);
        _drawBtn.modelLabel.text = @"Vertical-Draw Video";
        _drawBtn.image.image = [UIImage imageNamed:@"Vertical Draw video"];
        [_drawBtn addTarget:self action:@selector(changeModel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _drawBtn;
}

- (HBModelButton *)preRollBtn
{
    if (!_preRollBtn) {
        _preRollBtn = [[HBModelButton alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScaleW(532))];
        _preRollBtn.tag = 2;
        _preRollBtn.backgroundColor = [UIColor whiteColor];
        _preRollBtn.layer.borderWidth = kScaleW(5);
        _preRollBtn.modelLabel.text = @"Pre-Roll";
        _preRollBtn.image.image = [UIImage imageNamed:@"Pre-roll AD"];
        [_preRollBtn addTarget:self action:@selector(changeModel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _preRollBtn;
}

- (HBMenuView *)menuView
{
    if (!_menuView) {
        NSArray *list = @[@"Native", @"Native List"];
        _menuView = [[HBMenuView alloc] initWithMenuList:self.placementIDs.allKeys subMenuList:list];
        _menuView.layer.masksToBounds = YES;
        _menuView.layer.cornerRadius = 5;
        __weak typeof (self) weakSelf = self;
        [_menuView setSelectMenu:^(NSString * _Nonnull selectMenu) {
            weakSelf.placementID = weakSelf.placementIDs[selectMenu];
            NSLog(@"select placementId:%@", weakSelf.placementID);
        }];
        [_menuView setSelectSubMenu:^(NSString * _Nonnull selectSubMenu) {
            weakSelf.nativeStr = selectSubMenu;
            NSLog(@"%@", selectSubMenu);
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

- (UIView *)showView
{
    if (!_showView) {
        _showView = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _showView.backgroundColor = [UIColor whiteColor];
    }
    return _showView;
}

- (HBSuspendedButton *)suspendedBtn
{
    if (!_suspendedBtn) {
        _suspendedBtn = [[HBSuspendedButton alloc] initWithProtocolList:@[@"HBAdLoadingDelegate", @"HBNativeADDelegate"]];
        [_suspendedBtn setImage:[UIImage imageNamed:@"HyperBid_logo"] forState:UIControlStateNormal];
        _suspendedBtn.layer.masksToBounds = YES;
        _suspendedBtn.layer.cornerRadius = kScaleW(50);
        _suspendedBtn.layer.borderWidth = kScaleW(1);
        _suspendedBtn.layer.borderColor = [[UIColor grayColor] CGColor];
    }
    return _suspendedBtn;
}

@end
