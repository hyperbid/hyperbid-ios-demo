//
//  HBNativeViewController.m
//  HyperBidSDKDemo
//
//  Created by Leo on 17/04/2018.
//  Copyright © 2018 Leo. All rights reserved.
//

#define NATIVE_INTEGRATED

#import "HBNativeViewController.h"
#import "MTAutolayoutCategories.h"
#import "HyperBidAdManager.h"

NSString *const kMPPlacement = @"MobPower";
NSString *const kInmobiPlacement = @"Inmobi";
NSString *const kFacebookPlacement = @"Facebook";
NSString *const kFacebookHeaderBiddingPlacement = @"Facebook(Header Bidding)";
NSString *const kAdMobPlacement = @"AdMob";
NSString *const kApplovinPlacement = @"Applovin";
NSString *const kMintegralAdvancedPlacement = @"Mintegral(Advanced)";
NSString *const kMintegralPlacement = @"Mintegral";
NSString *const kMopubPlacementName = @"Mopub";
NSString *const kMopubVideoPlacementName = @"Mopub Video Placement";
NSString *const kGDTPlacement = @"GDT";
NSString *const kGDTTemplatePlacement = @"GDT(Template)";
NSString *const kAppnextPlacement = @"Appnext";
NSString *const kTTFeedPlacementName = @"TT(Feed)";
NSString *const kTTDrawPlacementName = @"TT(Draw)";
NSString *const kAllPlacementName = @"All";
NSString *const kNendVideoPlacement = @"Nend(Video)";
NSString *const kSigmobPlacement = @"Sigmob";
NSString *const kKSDrawPlacement = @"KS(Draw)";
NSString *const kGAMPlacement = @"GAM";
NSString *const kOnlineApiPlacement = @"OnlineApi";
NSString *const kMobrainPlacement = @"Mobrain";

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
static NSString *const kMopubPlacementID = @"b5b0f55624527a";
static NSString *const kGDTPlacementID = @"b5bacac5f73476";
static NSString *const kGDTTemplatePlacementID = @"b5bacac780e03b";
static NSString *const kMopubVideoPlacementID = @"b5afbe325b1303";
static NSString *const kAppnextPlacementID = @"b5bc7fb2787f1e";
static NSString *const kAllPlacementID = @"b5b0f5663c6e4a";
static NSString *const kTTFeedPlacementID = @"b5c2c6d50e7f44";
static NSString *const kNendPlacementID = @"b5cb96d44c0c5f";
static NSString *const kNendVideoPlacementID = @"b5cb96d5291e93";
static NSString *const kBaiduPlacementID = @"b5d36c4ad68a26";
static NSString *const kKSPlacementID = @"b5e4613e50cbf2";//@"b5e43ac9ca3fc5";
static NSString *const kGAMPlacementID = @"b5f238964f3e6f";
static NSString *const kMyOfferPlacementID = @"b5f33878ee0646";
static NSString *const kADXPlacementID = @"b5fa25023d0767";
static NSString *const kOnlineApiPlacementID = @"b5fa2508579446";
static NSString *const kMobrainPlacementID = @"b601cac6b99ead";

#ifdef UNDER_DEVELOPMENT
    static NSString *const kOFMNativeTestPlacementID = @"b600285f12f41a";
#else
    static NSString *const kOFMNativeTestPlacementID = @"b60001e6f883da";
#endif

//static NSString *const kKSDrawPlcementID = @"b5e4613e50cbf2";
//static NSString *const kTTDrawPlacementID = @"b5c2c6d62b9d65";

#ifdef NATIVE_INTEGRATED


@implementation DMADView
-(void) initSubviews {
    [super initSubviews];
    _advertiserLabel = [UILabel autolayoutLabelFont:[UIFont boldSystemFontOfSize:15.0f] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    [self addSubview:_advertiserLabel];
    
    _titleLabel = [UILabel autolayoutLabelFont:[UIFont boldSystemFontOfSize:18.0f] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    [self addSubview:_titleLabel];
    
    _textLabel = [UILabel autolayoutLabelFont:[UIFont systemFontOfSize:15.0f] textColor:[UIColor blackColor]];
    [self addSubview:_textLabel];
    
    _ctaLabel = [UILabel autolayoutLabelFont:[UIFont systemFontOfSize:15.0f] textColor:[UIColor blackColor]];
    [self addSubview:_ctaLabel];
    
    _ratingLabel = [UILabel autolayoutLabelFont:[UIFont systemFontOfSize:15.0f] textColor:[UIColor blackColor]];
    [self addSubview:_ratingLabel];
    
    _iconImageView = [UIImageView autolayoutView];
    _iconImageView.layer.cornerRadius = 4.0f;
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_iconImageView];
    
    _mainImageView = [UIImageView autolayoutView];
    _mainImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_mainImageView];
    
    _logoImageView = [UIImageView autolayoutView];
    _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_logoImageView];
    
    _sponsorImageView = [UIImageView autolayoutView];
    _sponsorImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_sponsorImageView];
    
    _dislikeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _dislikeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_dislikeButton];
}

-(NSArray<UIView*>*)clickableViews {
    NSMutableArray<UIView*> *clickableViews = [NSMutableArray<UIView*> arrayWithObjects:_iconImageView, _ctaLabel, _mainImageView, nil];
    if (self.mediaView != nil) { [clickableViews addObject:self.mediaView]; }
    return clickableViews;
}

-(void) layoutMediaView {
    self.mediaView.frame = CGRectMake(0, 120.0f, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 120.0f);
}

-(void) makeConstraintsForSubviews {
    [super makeConstraintsForSubviews];
    NSDictionary *viewsDict = nil;
    if (self.mediaView != nil) {
        viewsDict = @{@"titleLabel":self.titleLabel, @"textLabel":self.textLabel, @"ctaLabel":self.ctaLabel, @"ratingLabel":self.ratingLabel, @"iconImageView":self.iconImageView, @"mainImageView":self.mainImageView, @"logoImageView":self.logoImageView, @"mediaView":self.mediaView, @"advertiserLabel":self.advertiserLabel, @"sponsorImageView":self.sponsorImageView};
    } else {
        viewsDict = @{@"titleLabel":self.titleLabel, @"textLabel":self.textLabel, @"ctaLabel":self.ctaLabel, @"ratingLabel":self.ratingLabel, @"iconImageView":self.iconImageView, @"logoImageView":self.logoImageView, @"mainImageView":self.mainImageView, @"advertiserLabel":self.advertiserLabel, @"sponsorImageView":self.sponsorImageView};
    }
    [self addConstraintsWithVisualFormat:@"|[mainImageView]|" options:0 metrics:nil views:viewsDict];
    [self addConstraintsWithVisualFormat:@"[logoImageView(60)]-5-|" options:0 metrics:nil views:viewsDict];
    [self addConstraintsWithVisualFormat:@"V:[logoImageView(20)]-5-|" options:0 metrics:nil views:viewsDict];
    [self addConstraintsWithVisualFormat:@"V:[iconImageView]-20-[mainImageView]|" options:0 metrics:nil views:viewsDict];
    
    [self addConstraintWithItem:self.iconImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.iconImageView attribute:NSLayoutAttributeHeight multiplier:1.0f constant:.0f];
    
    [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self addConstraintsWithVisualFormat:@"|-15-[iconImageView(90)]-8-[titleLabel]-8-[sponsorImageView]-15-|" options:NSLayoutFormatAlignAllTop metrics:nil views:viewsDict];
    [self addConstraintsWithVisualFormat:@"V:|-15-[titleLabel]-8-[textLabel]-8-[ctaLabel]-8-[ratingLabel]-8-[advertiserLabel]" options:NSLayoutFormatAlignAllLeading | NSLayoutFormatAlignAllTrailing metrics:nil views:viewsDict];
    
    NSLayoutConstraint *btn_right = [NSLayoutConstraint constraintWithItem:self.dislikeButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-50];
    NSLayoutConstraint *btn_top = [NSLayoutConstraint constraintWithItem:self.dislikeButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:-0];
    NSLayoutConstraint *btn_width = [NSLayoutConstraint constraintWithItem:self.dislikeButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:40];
    NSLayoutConstraint *btn_height = [NSLayoutConstraint constraintWithItem:self.dislikeButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:40];
    [self addConstraints:@[btn_right,btn_top,btn_width,btn_height]];
    
    UIImage *closeImg = [UIImage imageNamed:@"icon_webview_close" inBundle:[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"HyperBidSDK" ofType:@"bundle"]] compatibleWithTraitCollection:nil];
    [_dislikeButton setImage:closeImg forState:0];
    
}

-(void) makeConstraintsDrawVideoAssets {
    NSMutableDictionary<NSString*, UIView*> *viewsDict = [NSMutableDictionary<NSString*, UIView*> dictionary];
    if (self.dislikeButton != nil) { viewsDict[@"dislikeButton"] = self.dislikeButton; }
    if (self.adLabel != nil) { viewsDict[@"adLabel"] = self.adLabel; }
    if (self.logoImageView != nil) { viewsDict[@"logoImageView"] = self.logoImageView; }
    if (self.logoADImageView != nil) { viewsDict[@"logoAdImageView"] = self.logoADImageView; }
    if (self.videoAdView != nil) { viewsDict[@"videoView"] = self.videoAdView; }
    
    if ([viewsDict count] == 5) {
        self.dislikeButton.translatesAutoresizingMaskIntoConstraints = self.adLabel.translatesAutoresizingMaskIntoConstraints = self.logoImageView.translatesAutoresizingMaskIntoConstraints = self.logoADImageView.translatesAutoresizingMaskIntoConstraints = self.videoAdView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraintsWithVisualFormat:@"V:[logoAdImageView]-15-|" options:0 metrics:nil views:viewsDict];
        [self addConstraintsWithVisualFormat:@"|-15-[dislikeButton]-5-[adLabel]-5-[logoImageView]-5-[logoAdImageView]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDict];
        [self addConstraintsWithVisualFormat:@"|[videoView]|" options:0 metrics:nil views:viewsDict];
        [self addConstraintsWithVisualFormat:@"V:[videoView(height)]|" options:0 metrics:@{@"height":@(CGRectGetHeight(self.bounds) - 120.0f)} views:viewsDict];
    }
}
@end
#endif

#ifdef NATIVE_INTEGRATED
@interface HBNativeViewController()<HBNativeADDelegate>
#else
@interface HBNativeViewController()
#endif
@property(nonatomic, readonly) NSDictionary *placementIDs;
@property(nonatomic, readonly) NSString *name;
@property(nonatomic, readonly) UIActivityIndicatorView *loadingView;
@property(nonatomic, readonly) UIButton *reloadADButton;
@property(nonatomic, readonly) UIButton *clearAdButton;
@property(nonatomic, readonly) UIButton *showAdButton;
@property(nonatomic, readonly) UILabel *failureTipsLabel;
@property(nonatomic, readonly) UIButton *removeAdButton;
@property(nonatomic, readonly) UIButton *readyButton;
@property(nonatomic, readonly) NSMutableDictionary *numberOfLoadAndCallback;
@end
static NSString *const kLoadKey = @"load";
static NSString *const kCallbackKey = @"request";
@implementation HBNativeViewController
#ifdef NATIVE_INTEGRATED
-(instancetype) initWithPlacementName:(NSString*)name {
    self = [super initWithNibName:nil bundle:nil];
    if (self != nil) {
        _name = name;
        _placementIDs = [HBNativeViewController nativePlacementIDs];
    }
    _numberOfLoadAndCallback = [NSMutableDictionary dictionaryWithContentsOfFile:[HBNativeViewController numberOfLoadPath]];
    if (_numberOfLoadAndCallback == nil) { _numberOfLoadAndCallback = [NSMutableDictionary dictionary]; }
    return self;
}

+(NSDictionary<NSString*, NSString*>*)nativePlacementIDs {
    return @{
             kMPPlacement:kMPPlacementID,
             kMintegralPlacement:kMintegralPlacementID,
             kMintegralAdvancedPlacement:kMintegralAdvancedPlacementID,
             kHeaderBiddingPlacement:kMintegralHeaderBiddingPlacementID,
             kAllPlacementName:kAllPlacementID,
             kInmobiPlacement:kInmobiPlacementID,
             kFacebookPlacement:kFacebookPlacementID,
             kFacebookHeaderBiddingPlacement:kFacebookHeaderBiddingPlacementID,
             kAdMobPlacement:kAdMobPlacementID,
             kMopubPlacementName:kMopubPlacementID,
             kMopubVideoPlacementName:kMopubVideoPlacementID,
             kApplovinPlacement:kApplovinPlacementID,
             kGDTPlacement:kGDTPlacementID,
             kGDTTemplatePlacement:kGDTTemplatePlacementID,
             kAppnextPlacement:kAppnextPlacementID,
             kTTFeedPlacementName:kTTFeedPlacementID,
             kNendPlacement:kNendPlacementID,
             kNendVideoPlacement:kNendVideoPlacementID,
             kBaiduPlacement:kBaiduPlacementID,
             kKSPlacement:kKSPlacementID,
             kGAMPlacement:kGAMPlacementID,
             kMyOfferPlacement:kMyOfferPlacementID,
             kADXPlacement:kADXPlacementID,
             kOnlineApiPlacement:kOnlineApiPlacementID,
             kMobrainPlacement:kMobrainPlacementID
             };
}

+(NSString*)numberOfLoadPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"native_load"];
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

    if ([[HBAdManager sharedManager] isReadyNativeAdWithPlacementID:_placementIDs[_name]]) {
            [self showAD];
    } else {
            _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            _loadingView.center = _failureTipsLabel.center;
            [_loadingView startAnimating];
            [self.view addSubview:_loadingView];
            [self increaseLoad];
        [[HBAdManager sharedManager] loadAd:_placementIDs[_name] extra:@{kHBExtraInfoNativeAdTypeKey:@([@{kGDTPlacement:@(HBGDTNativeAdTypeSelfRendering), kGDTTemplatePlacement:@(HBGDTNativeAdTypeTemplate), kMintegralPlacement:@(HBGDTNativeAdTypeSelfRendering)}[_name] integerValue]), kHBExtraInfoNativeAdSizeKey:[NSValue valueWithCGSize:CGSizeMake(CGRectGetWidth(self.view.bounds) - 50.0f, 350.0f)], kHBExtraNativeImageSizeKey:kHBExtraNativeImageSize690_388} delegate:self];
    }
    
}

-(void) increaseLoad {
    _numberOfLoadAndCallback[kLoadKey] = @([_numberOfLoadAndCallback[kLoadKey] integerValue] + 1);
    [_numberOfLoadAndCallback writeToFile:[HBNativeViewController numberOfLoadPath] atomically:YES];
}

-(void) increaseCallback {
    _numberOfLoadAndCallback[kCallbackKey] = @([_numberOfLoadAndCallback[kCallbackKey] integerValue] + 1);
    [_numberOfLoadAndCallback writeToFile:[HBNativeViewController numberOfLoadPath] atomically:YES];
}

-(void) readyButtonTapped {

    HBCheckLoadModel *model = [[HBAdManager sharedManager] checkNativeLoadStatusForPlacementID:_placementIDs[_name]];
        
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[[HBAdManager sharedManager] isReadyNativeAdWithPlacementID:_placementIDs[_name]] ? @"Ready!" : @"Not Yet!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
}

-(void) removeAdButtonTapped {
    [[self.view viewWithTag:adViewTag] removeFromSuperview];
}

-(void) clearAdButtonTapped {
//    [[HBAdManager sharedManager] clearCache];
}

-(void) dealloc {
    NSLog(@"dealloc");
}

static NSInteger adViewTag = 3333;
-(void) reloadADButtonTapped {
    _failureTipsLabel.hidden = YES;
    [self.view addSubview:_loadingView];
    [self increaseLoad];
    [[HBAdManager sharedManager] loadAd:_placementIDs[_name] extra:@{kHBExtraInfoNativeAdTypeKey:@([@{kGDTPlacement:@(HBGDTNativeAdTypeSelfRendering), kGDTTemplatePlacement:@(HBGDTNativeAdTypeTemplate)}[_name] integerValue]), kHBExtraInfoNativeAdSizeKey:[NSValue valueWithCGSize:CGSizeMake(CGRectGetWidth(self.view.bounds) - 30.0f, 300.0f)], kHBExtraNativeImageSizeKey:kHBExtraNativeImageSize690_388} delegate:self];
}

-(void) showAD {
    //Remove previously shown ad first.
    [self removeAdButtonTapped];
    if([HyperBidAdManager sharedManager].currentAPIType == HyperBidAPITypeHyperBid){
        HBNativeADConfiguration *config = [[HBNativeADConfiguration alloc] init];
        config.ADFrame = CGRectMake(.0f, 100.0f, CGRectGetWidth(self.view.bounds), 350.0f);
        config.mediaViewFrame = CGRectMake(0, 120.0f, CGRectGetWidth(self.view.bounds), 350.0f - 120.0f);
        config.delegate = self;

        config.renderingViewClass = [DMADView class];
        config.rootViewController = self;
        config.context = @{kHBNativeAdConfigurationContextAdOptionsViewFrameKey:[NSValue valueWithCGRect:CGRectMake(CGRectGetWidth(self.view.bounds) - 43.0f, .0f, 43.0f, 18.0f)], kHBNativeAdConfigurationContextAdLogoViewFrameKey:[NSValue valueWithCGRect:CGRectMake(.0f, .0f, 54.0f, 18.0f)], kHBNativeAdConfigurationContextNetworkLogoViewFrameKey:[NSValue valueWithCGRect:CGRectMake(CGRectGetWidth(config.ADFrame) - 18.0f, CGRectGetHeight(config.ADFrame) - 18.0f, 18.0f, 18.0f)]};
        UIView *adView = [[HBAdManager sharedManager] retriveAdViewWithPlacementID:_placementIDs[_name] configuration:config scene:@"f600938967feb5"];
        adView.tag = adViewTag;
        [self.view addSubview:adView];
        if (adView == nil) NSLog(@"retrive ad view failed");
    }
}
    
-(void) didStartPlayingVideoInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID {
    NSLog(@"HBNativeViewController:: didStartPlayingVideoInAdView:placementID:%@", placementID);
}

-(void) didEndPlayingVideoInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID {
    NSLog(@"HBNativeViewController:: didEndPlayingVideoInAdView:placementID:%@", placementID);
}

-(void) didClickNativeAdInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID {
    NSLog(@"HBNativeViewController:: didClickNativeAdInAdView:placementID:%@", placementID);
}

-(void) didShowNativeAdInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID {
    NSLog(@"HBNativeViewController:: didShowNativeAdInAdView:placementID:%@", placementID);
    adView.mainImageView.hidden = [adView isVideoContents];
}

-(void) didFinishLoadingADWithPlacementID:(NSString *)placementID {
    [self increaseCallback];
    NSLog(@"HBNativeViewController:: didFinishLoadingADWithPlacementID:%@", placementID);
    [_loadingView removeFromSuperview];
    _failureTipsLabel.hidden = YES;
    if ([self.view viewWithTag:adViewTag] == nil) {
        [self showAD];
    }
}

-(void) didFailToLoadADWithPlacementID:(NSString *)placementID error:(NSError *)error {
    [self increaseCallback];
    NSLog(@"HBNativeViewController:: didFailToLoadADWithPlacementID:%@ error:%@", placementID, error);
    [_loadingView removeFromSuperview];
    _failureTipsLabel.hidden = NO;
}

-(void) didEnterFullScreenVideoInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID {
    NSLog(@"HBNativeViewController:: didEnterFullScreenVideoInAdView:placementID:%@", placementID);
}

-(void) didExitFullScreenVideoInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID {
    NSLog(@"HBNativeViewController:: didExitFullScreenVideoInAdView:placementID:%@", placementID);
}
#pragma mark - delegate with extra
-(void) didStartPlayingVideoInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBNativeViewController:: didStartPlayingVideoInAdView:placementID:%@with extra: %@", placementID,extra);
}

-(void) didEndPlayingVideoInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBNativeViewController:: didEndPlayingVideoInAdView:placementID:%@", placementID);
}

-(void) didClickNativeAdInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBNativeViewController:: didClickNativeAdInAdView:placementID:%@ with extra: %@", placementID,extra);
}

- (void) didDeepLinkOrJumpInAdView:(HBNativeADView *)adView placementID:(NSString *)placementID extra:(NSDictionary *)extra result:(BOOL)success {
    NSLog(@"HBNativeViewController:: didDeepLinkOrJumpInAdView:placementID:%@ with extra: %@, success:%@", placementID,extra, success ? @"YES" : @"NO");
}

-(void) didShowNativeAdInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBNativeViewController:: didShowNativeAdInAdView:placementID:%@ with extra: %@", placementID,extra);
    adView.mainImageView.hidden = [adView isVideoContents];
}

-(void) didEnterFullScreenVideoInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBNativeViewController:: didEnterFullScreenVideoInAdView:placementID:%@", placementID);
}

-(void) didExitFullScreenVideoInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"HBNativeViewController:: didExitFullScreenVideoInAdView:placementID:%@", placementID);
}

-(void) didTapCloseButtonInAdView:(HBNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBNativeViewController:: didTapCloseButtonInAdView:placementID:%@ extra:%@", placementID, extra);
}

-(void) didFinishLoadingOFMADWithPlacementID:(NSString *)placementID {
    NSLog(@"HBNativeViewController::didFinishLoadingOFMADWithPlacementID:%@", placementID);
//    [_loadingView removeFromSuperview];
}

-(void) didFailToLoadOFMADWithPlacementID:(NSString*)placementID error:(NSError*)error {
    NSLog(@"HBNativeViewController::didFailToLoadOFMADWithPlacementID:%@ error:%@", placementID, error);
}

-(void) nativeAdDidShowInAdViewForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBNativeViewController:: nativeAdDidShowInAdViewForPlacementID:placementID:%@ extra:%@", placementID, extra);
}

//Called when user click the ad
-(void) nativeAdDidClickInAdViewForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBNativeViewController:: nativeAdDidClickInAdViewForPlacementID:placementID:%@ extra:%@", placementID, extra);
}

-(void) nativeAdDeepLinkOrJumpForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra result:(BOOL)success {
    NSLog(@"HBNativeViewController:: nativeAdDeepLinkOrJumpForPlacementID:placementID:%@ extra:%@", placementID, extra);
}

-(void) nativeAdDidStartPlayingVideoInAdViewForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBNativeViewController:: nativeAdDidStartPlayingVideoInAdViewForPlacementID:placementID:%@ extra:%@", placementID, extra);
}

-(void) nativeAdDidEndPlayingVideoInAdViewForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBNativeViewController:: nativeAdDidEndPlayingVideoInAdViewForPlacementID:placementID:%@ extra:%@", placementID, extra);
}

-(void) nativeAdDidEnterFullScreenVideoInAdViewForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBNativeViewController:: nativeAdDidEnterFullScreenVideoInAdViewForPlacementID:placementID:%@ extra:%@", placementID, extra);
}

-(void) nativeAdDidExitFullScreenVideoInAdViewForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBNativeViewController:: nativeAdDidExitFullScreenVideoInAdViewForPlacementID:placementID:%@ extra:%@", placementID, extra);
}

-(void) nativeAdDidTapCloseButtonInAdViewForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"HBNativeViewController:: nativeAdDidTapCloseButtonInAdViewForPlacementID:placementID:%@ extra:%@", placementID, extra);
}


#endif
@end
