//
//  ViewController.m
//  HyperBidSDKDemo
//
//  Created by Leo on 2019/10/31.
//  Copyright © 2019 HyperBid. All rights reserved.
//

#import "ViewController.h"
#import <HyperBidSDK/HBAPI.h>
#import "HBNativeViewController.h"
#import "HBBannerViewController.h"
#import "HBRewardedVideoVideoViewController.h"
#import "HBInterstitialViewController.h"
#import "HBNativeBannerViewController.h"
#import "HBDrawViewController.h"
#import <SafariServices/SafariServices.h>
#import "HBSplashViewController.h"
#import <UIKit/UIKit.h>
#import <AdSupport/AdSupport.h>

@import HyperBidSplash;
@import HyperBidNative;
@interface ViewController ()<UIPickerViewDelegate, UIPickerViewDataSource, HBSplashDelegate, HBNativeSplashDelegate, SFSafariViewControllerDelegate>
@property(nonatomic, readonly) NSArray<NSArray<NSString*>*>* placementNames;
@property(nonatomic) NSInteger currentRowSplash;
@property(nonatomic) NSInteger currentRowInterstitial;
@property(nonatomic) NSInteger currentRowBanner;
@property(nonatomic) NSInteger currentRowRV;
@property(nonatomic) NSInteger currentRowNative;
@property(nonatomic) NSInteger currentRowNativeBanner;
@property(nonatomic) NSInteger currentRowNativeSplash;
@property (weak, nonatomic) IBOutlet UITextField *splashTextField;
@property (weak, nonatomic) IBOutlet UITextField *interstitialTextField;
@property (weak, nonatomic) IBOutlet UITextField *bannerTextField;
@property (weak, nonatomic) IBOutlet UITextField *rvTextField;
@property (weak, nonatomic) IBOutlet UITextField *nativeTextField;
@property (weak, nonatomic) IBOutlet UITextField *nativeBannerTextField;
@property (weak, nonatomic) IBOutlet UITextField *nativeSplashTextField;
@property(nonatomic, readonly) UIPickerView *splashPickerView;
@property(nonatomic, readonly) UIPickerView *interstitialPickerView;
@property(nonatomic, readonly) UIPickerView *bannerPickerView;
@property(nonatomic, readonly) UIPickerView *rvPickerView;
@property(nonatomic, readonly) UIPickerView *nativePickerView;
@property(nonatomic, readonly) UIPickerView *nativeBannerPickerView;
@property(nonatomic, readonly) UIPickerView *nativeSplashPickerView;
@end

static NSString *const kCellIdentifier = @"cell";
@implementation ViewController
-(void) enterNextBanner {
#ifdef BANNER_AUTO_TEST
    if (_currentRow < [_placementNames[1] count]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self tableView:_tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:_currentRow++ inSection:1]];
        });
    } else {
        _currentRow = 0;
    }
#endif
}

-(void)getProxyStatus {
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"https://www.baidu.com/"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    NSDictionary *settings = proxies[0];
    if (![[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]){
        //检测到连接代理
    }
}

-(void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self enterNextBanner];
}

-(void) handlerBannerEvent:(NSNotification*)notification {
    [self enterNextBanner];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getProxyStatus];
    
    /*
     extern const CGFloat FBAdOptionsViewWidth;
     extern const CGFloat FBAdOptionsViewHeight;
     */
    _placementNames = @[@[kAllPlacementName, // Splash
                          kAdMobPlacement,
                          kADXPlacement,
                          kBaiduPlacement,
                          kGDTPlacement,
                          kGDTZoomOutPlacement,
                          kKSPlacement,
                          kMintegralPlacement,
                          kMobrainPlacement,
                          kMyOfferPlacement,
                          kOnlineApiPlacement,
                          kSigmobPlacement,
                          kTTPlacementName],
                        @[kAllPlacementName, // Interstitial
                          kAdcolonyPlacementName,
                          kAdMobPlacement,
                          kADXPlacement,
                          kApplovinPlacement,
                          kAppnextPlacement,
                          kBaiduPlacement,
                          kChartboostPlacementName,
                          kFacebookPlacement,
                          kFyberPlacement,
                          kGAMPlacement,
                          kGDTPlacement,
                          kHeaderBiddingPlacement,
                          kHeliumPlacement,
                          kInmobiPlacement,
                          kIronsourcePlacementName,
                          kKidozPlacement,
                          kKSPlacement,
                          kMaioPlacement,
                          kMintegralPlacement,
                          kMintegralVideoPlacement,
                          kMopubPlacementName,
                          kMobrainPlacement,
                          kMyOfferPlacement,
                          kMyTargetPlacement,
                          kNendPlacement,
                          kNendFullScreenInterstitialPlacement,
                          kNendInterstitialVideoPlacement,
                          kOFMPlacement,
                          kOguryPlacement,
                          kOnlineApiPlacement,
                          kSigmobRVIntPlacement,
                          kSigmobPlacement,
                          kStartAppPlacement,
                          kStartAppVideoPlacement,
                          kTapjoyPlacementName,
                          kTTPlacementName,
                          kTTVideoPlacement,
                          kUnityAdsPlacementName,
                          kVunglePlacementName],
                        @[kAllPlacementName, // Banner
                          kAdcolonyPlacementName,
                          kAdMobPlacement,
                          kADXPlacement,
                          kApplovinPlacement,
                          kAppnextPlacement,
                          kBaiduPlacement,
                          kChartboostPlacementName,
                          kFacebookPlacement,
                          kFyberPlacement,
                          kGAMPlacement,
                          kGDTPlacement,
                          kHeaderBiddingPlacement,
                          kInmobiPlacement,
                          kKidozPlacement,
                          kMintegralPlacement,
                          kMobrainPlacement,
                          kMopubPlacementName,
                          kMyOfferPlacement,
                          kMyTargetPlacement,
                          kNendPlacement,
                          kOnlineApiPlacement,
                          kStartAppPlacement,
                          kTTPlacementName,
                          kUnityAdsPlacementName,
                          kVunglePlacementName],
                        @[kAllPlacementName, // Rewarded Video
                          kAdcolonyPlacementName,
                          kAdMobPlacement,
                          kADXPlacement,
                          kApplovinPlacement,
                          kAppnextPlacement,
                          kBaiduPlacement,
                          kChartboostPlacementName,
                          kFacebookPlacement,
                          kFyberPlacement,
                          kGAMPlacement,
                          kGDTPlacement,
                          kHeaderBiddingPlacement,
                          kHeliumPlacement,
                          kInmobiPlacement,
                          kIronsourcePlacementName,
                          kKidozPlacement,
                          kKSPlacement,
                          kMaioPlacement,
                          kMintegralPlacement,
                          kMobrainPlacement,
                          kMopubPlacementName,
                          kMyOfferPlacement,
                          kMyTargetPlacement,
                          kNendPlacement,
                          kOguryPlacement,
                          kOnlineApiPlacement,
                          kSigmobPlacement,
                          kStartAppPlacement,
                          kTapjoyPlacementName,
                          kTTPlacementName,
                          kUnityAdsPlacementName,
                          kVunglePlacementName],
                        @[kAllPlacementName, // Native
                          kAdMobPlacement,
                          kADXPlacement,
                          kApplovinPlacement,
                          kAppnextPlacement,
                          kBaiduPlacement,
                          kFacebookPlacement,
                          kGAMPlacement,
                          kGDTPlacement,
                          kGDTTemplatePlacement,
                          kHeaderBiddingPlacement,
                          kInmobiPlacement,
                          kKSPlacement,
                          kKSDrawPlacement,
                          kMintegralPlacement,
                          kMintegralAdvancedPlacement,
                          kMobrainPlacement,
                          kMopubPlacementName,
                          kMPPlacement,
                          kMyOfferPlacement,
                          kNendPlacement,
                          kNendVideoPlacement,
                          kOnlineApiPlacement,
                          kTTFeedPlacementName,
                          kTTDrawPlacementName],
                        @[kAllPlacementName, // Nartive Banner
                          kAdMobPlacement,
                          kApplovinPlacement,
                          kAppnextPlacement,
                          kFacebookPlacement,
                          kFacebookNativeBannerPlacement,
                          kGDTPlacement,
                          kGDTTemplatePlacement,
                          kInmobiPlacement,
                          kKSPlacement,
                          kMintegralPlacement,
                          kMopubPlacementName,
                          kMPPlacement,
                          kNendPlacement,
                          kTTFeedPlacementName,
                          kTTDrawPlacementName],
                        @[kAllPlacementName, // Native Splash
                          kAdMobPlacement,
                          kApplovinPlacement,
                          kAppnextPlacement,
                          kFacebookPlacement,
                          kGDTPlacement,
                          kKSPlacement,
                          kMintegralPlacement,
                          kMPPlacement,
                          kTTFeedPlacementName]];
    
    // Splash
    _splashPickerView = [[UIPickerView alloc] init];
    _splashPickerView.delegate = self;
    _splashTextField.inputView = _splashPickerView;
    _splashTextField.text = _placementNames[0][0];
    [_splashPickerView selectRow:0 inComponent:0 animated:YES];
    _currentRowSplash = 0;
    
    {
        UIToolbar* toolBar = [[UIToolbar alloc] init];
        [toolBar sizeToFit];
        UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(action)];
        [toolBar setItems:@[button] animated:YES];
        [toolBar setUserInteractionEnabled:YES];
        _splashTextField.inputAccessoryView = toolBar;
    }
    
    // Interstitial
    _interstitialPickerView = [[UIPickerView alloc] init];
    _interstitialPickerView.delegate = self;
    _interstitialTextField.inputView = _interstitialPickerView;
    _interstitialTextField.text = _placementNames[1][0];
    [_interstitialPickerView selectRow:0 inComponent:0 animated:YES];
    _currentRowInterstitial = 0;
    
    {
        UIToolbar* toolBar = [[UIToolbar alloc] init];
        [toolBar sizeToFit];
        UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(action)];
        [toolBar setItems:@[button] animated:YES];
        [toolBar setUserInteractionEnabled:YES];
        _interstitialTextField.inputAccessoryView = toolBar;
    }
    
    // Banner
    _bannerPickerView = [[UIPickerView alloc] init];
    _bannerPickerView.delegate = self;
    _bannerTextField.inputView = _bannerPickerView;
    _bannerTextField.text = _placementNames[2][0];
    [_bannerPickerView selectRow:0 inComponent:0 animated:YES];
    _currentRowBanner = 0;
    
    {
        UIToolbar* toolBar = [[UIToolbar alloc] init];
        [toolBar sizeToFit];
        UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(action)];
        [toolBar setItems:@[button] animated:YES];
        [toolBar setUserInteractionEnabled:YES];
        _bannerTextField.inputAccessoryView = toolBar;
    }
    
    // Rewarded Video
    _rvPickerView = [[UIPickerView alloc] init];
    _rvPickerView.delegate = self;
    _rvTextField.inputView = _rvPickerView;
    _rvTextField.text = _placementNames[3][0];
    [_rvPickerView selectRow:0 inComponent:0 animated:YES];
    _currentRowRV = 0;
    
    {
        UIToolbar* toolBar = [[UIToolbar alloc] init];
        [toolBar sizeToFit];
        UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(action)];
        [toolBar setItems:@[button] animated:YES];
        [toolBar setUserInteractionEnabled:YES];
        _rvTextField.inputAccessoryView = toolBar;
    }
    
    // Native
    _nativePickerView = [[UIPickerView alloc] init];
    _nativePickerView.delegate = self;
    _nativeTextField.inputView = _nativePickerView;
    _nativeTextField.text = _placementNames[4][0];
    [_nativePickerView selectRow:0 inComponent:0 animated:YES];
    _currentRowNative = 0;
    
    {
        UIToolbar* toolBar = [[UIToolbar alloc] init];
        [toolBar sizeToFit];
        UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(action)];
        [toolBar setItems:@[button] animated:YES];
        [toolBar setUserInteractionEnabled:YES];
        _nativeTextField.inputAccessoryView = toolBar;
    }
    
    // Native Banner
    _nativeBannerPickerView = [[UIPickerView alloc] init];
    _nativeBannerPickerView.delegate = self;
    _nativeBannerTextField.inputView = _nativeBannerPickerView;
    _nativeBannerTextField.text = _placementNames[5][0];
    [_nativeBannerPickerView selectRow:0 inComponent:0 animated:YES];
    _currentRowNativeBanner = 0;
    
    {
        UIToolbar* toolBar = [[UIToolbar alloc] init];
        [toolBar sizeToFit];
        UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(action)];
        [toolBar setItems:@[button] animated:YES];
        [toolBar setUserInteractionEnabled:YES];
        _nativeBannerTextField.inputAccessoryView = toolBar;
    }
    
    // Native Splash
    _nativeSplashPickerView = [[UIPickerView alloc] init];
    _nativeSplashPickerView.delegate = self;
    _nativeSplashTextField.inputView = _nativeSplashPickerView;
    _nativeSplashTextField.text = _placementNames[6][0];
    [_nativeSplashPickerView selectRow:0 inComponent:0 animated:YES];
    _currentRowNativeSplash = 0;
    
    {
        UIToolbar* toolBar = [[UIToolbar alloc] init];
        [toolBar sizeToFit];
        UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(action)];
        [toolBar setItems:@[button] animated:YES];
        [toolBar setUserInteractionEnabled:YES];
        _nativeSplashTextField.inputAccessoryView = toolBar;
    }
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"GDPR" style:UIBarButtonItemStylePlain target:self action:@selector(policyButtonTapped)];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)action {
    [self.view endEditing:YES];
}

- (void)setOFM {
    
    NSLog(@"%@",[ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString);
//    BOOL enable = [[[NSUserDefaults standardUserDefaults] valueForKey:@"ofm_enable"] boolValue];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Enable OFM?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *enableAct = [UIAlertAction actionWithTitle:@"Enable" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ofm_enable"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
    
    UIAlertAction *disableAct = [UIAlertAction actionWithTitle:@"Disable" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ofm_enable"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
    UIAlertAction *cancelAct = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:enableAct];
    [alert addAction:disableAct];
    [alert addAction:cancelAct];
    [self presentViewController:alert animated:YES completion:NULL];
}

-(void)policyButtonTapped {
    [[HBAPI sharedInstance] getGDPRWithCallback:^(HBUserLocation location) {
        NSLog(@"---------:HBUserLocation:%ld",(long)location);
        NSLog(@"---------:dataConsentSet:%ld",(long)[HBAPI sharedInstance].dataConsentSet);

        [[HBAPI sharedInstance] showGDPRPageInViewController:self loadingFailureCallback:^(NSError *error) {
            NSLog(@"---------:loadingFailureCallback");
        } dismissalCallback:^{
            NSLog(@"---------:dismissalCallback");
        }];
    }];
}

- (IBAction)splashChooseButtonClicked:(id)sender {
    HBSplashViewController *tVC = [[HBSplashViewController alloc] initWithPlacementName:_placementNames[0][_currentRowSplash]];
    [self.navigationController pushViewController:tVC animated:YES];
}

- (IBAction)interstitialChooseButtonClicked:(id)sender {
    HBInterstitialViewController *tVC = [[HBInterstitialViewController alloc] initWithPlacementName:_placementNames[1][_currentRowInterstitial]];
    [self.navigationController pushViewController:tVC animated:YES];
}

- (IBAction)bannerChooseButtonClicked:(id)sender {
    HBBannerViewController *tVC = [[HBBannerViewController alloc] initWithPlacementName:_placementNames[2][_currentRowBanner]];
    [self.navigationController pushViewController:tVC animated:YES];
}

- (IBAction)rvChooseButtonClicked:(id)sender {
    HBRewardedVideoVideoViewController *tVC = [[HBRewardedVideoVideoViewController alloc] initWithPlacementName:_placementNames[3][_currentRowRV]];
    [self.navigationController pushViewController:tVC animated:YES];
}

- (IBAction)nativeChooseButtonClicked:(id)sender {
    if (_placementNames[4][_currentRowNative] == kKSDrawPlacement || _placementNames[4][_currentRowNative] == kTTDrawPlacementName) {
        HBDrawViewController *drawVC = [[HBDrawViewController alloc] initWithPlacementName:_placementNames[4][_currentRowNative]];
        drawVC.modalPresentationStyle = 0;
        [self presentViewController:drawVC animated:YES completion:nil];
    } else {
        HBNativeViewController *tVC = [[HBNativeViewController alloc] initWithPlacementName: _placementNames[4][_currentRowNative]];
        [self.navigationController pushViewController:tVC animated:YES];
    }
}

- (IBAction)nativeBannerChooseButtonClicked:(id)sender {
    HBNativeBannerViewController *tVC = [[HBNativeBannerViewController alloc] initWithPlacementName: _placementNames[5][_currentRowNativeBanner]];
    [self.navigationController pushViewController:tVC animated:YES];
}

- (IBAction)nativeSplashChooseButtonClicked:(id)sender {
    NSMutableDictionary *extra = [NSMutableDictionary dictionaryWithDictionary:@{kHBExtraInfoNativeAdTypeKey:@(HBGDTNativeAdTypeSelfRendering), kHBExtraInfoNativeAdSizeKey:[NSValue valueWithCGSize:CGSizeMake(CGRectGetWidth(self.view.bounds), 300.0f)], kHBExtraNativeImageSizeKey:kHBExtraNativeImageSize690_388, kHBNativeSplashShowingExtraCountdownIntervalKey:@3, kHBNatievSplashShowingExtraStyleKey:kHBNativeSplashShowingExtraStyleLandscape}];
    [HBNativeSplashWrapper loadNativeSplashAdWithPlacementID:[HBNativeViewController nativePlacementIDs][_placementNames[6][_currentRowNativeSplash]] extra:extra customData:nil delegate:self];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(pickerView == _splashPickerView) {
        return [_placementNames[0] count];
    }
    else if(pickerView == _interstitialPickerView) {
        return [_placementNames[1] count];
    }
    else if(pickerView == _bannerPickerView) {
        return [_placementNames[2] count];
    }
    else if(pickerView == _rvPickerView) {
        return [_placementNames[3] count];
    }
    else if(pickerView == _nativePickerView) {
        return [_placementNames[4] count];
    }
    else if(pickerView == _nativeBannerPickerView) {
        return [_placementNames[5] count];
    }
    else {
        return [_placementNames[6] count];
    }
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(pickerView == _splashPickerView) {
        return _placementNames[0][row];
    }
    else if(pickerView == _interstitialPickerView) {
        return _placementNames[1][row];
    }
    else if(pickerView == _bannerPickerView) {
        return _placementNames[2][row];
    }
    else if(pickerView == _rvPickerView) {
        return _placementNames[3][row];
    }
    else if(pickerView == _nativePickerView) {
        return _placementNames[4][row];
    }
    else if(pickerView == _nativeBannerPickerView) {
        return _placementNames[5][row];
    }
    else {
        return _placementNames[6][row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(pickerView == _splashPickerView) {
        _currentRowSplash = row;
        _splashTextField.text = _placementNames[0][row];
    }
    else if(pickerView == _interstitialPickerView) {
        _currentRowInterstitial = row;
        _interstitialTextField.text = _placementNames[1][row];
    }
    else if(pickerView == _bannerPickerView) {
        _currentRowBanner = row;
        _bannerTextField.text = _placementNames[2][row];
    }
    else if(pickerView == _rvPickerView) {
        _currentRowRV = row;
        _rvTextField.text = _placementNames[3][row];
    }
    else if(pickerView == _nativePickerView) {
        _currentRowNative = row;
        _nativeTextField.text = _placementNames[4][row];
    }
    else if(pickerView == _nativeBannerPickerView) {
        _currentRowNativeBanner = row;
        _nativeBannerTextField.text = _placementNames[5][row];
    }
    else {
        _currentRowNativeSplash = row;
        _nativeSplashTextField.text = _placementNames[6][row];
    }
}

#pragma mark - native splash delegate(s)
#define PORTRAIT 1
-(void) finishLoadingNativeSplashAdForPlacementID:(NSString*)placementID {
    NSLog(@"ViewController::finishLoadingNativeSplashAdForPlacementID:%@", placementID);
#ifdef PORTRAIT
    /*CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(.0f, .0f, width, 79.0f)];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor whiteColor];
    label.text = @"Joypac";
    NSMutableDictionary *extra = [NSMutableDictionary dictionaryWithDictionary:@{kHBNatievSplashShowingExtraStyleKey:kHBNativeSplashShowingExtraStylePortrait, kHBNativeSplashShowingExtraCountdownIntervalKey:@3, kHBNativeSplashShowingExtraContainerViewKey:label}];
    if ([kTTFeedPlacementName isEqualToString:_placementNames[[_splashSelection section]][[_splashSelection row]]]) {//for tt template
        extra[kHBNativeSplashShowingExtraCTAButtonBackgroundColorKey] = [UIColor clearColor];
        extra[kHBNativeSplashShowingExtraCTAButtonTitleColorKey] = [UIColor clearColor];
    }
    
    [HBNativeSplashWrapper showNativeSplashAdWithPlacementID:placementID extra:extra delegate:self];*/
#else
    /*CGFloat width = 100.0f;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds) - width, .0f, width, CGRectGetHeight([UIScreen mainScreen].bounds))];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor whiteColor];
    label.text = @"Joypac";
    [HBNativeSplashWrapper showNativeSplashAdWithPlacementID:placementID extra:@{kHBNatievSplashShowingExtraStyleKey:kHBNativeSplashShowingExtraStyleLandscape, kHBNativeSplashShowingExtraCountdownIntervalKey:@3, kHBNativeSplashShowingExtraContainerViewKey:label} delegate:self];*/
#endif
    
}

-(void) failedToLoadNativeSplashAdForPlacementID:(NSString*)placementID error:(NSError*)error {
    NSLog(@"ViewController::failedToLoadNativeSplashAdForPlacementID:%@ error:%@", placementID, error);
}

-(void) didShowNativeSplashAdForPlacementID:(NSString*)placementID {
    NSLog(@"ViewController::didShowNativeSplashAdForPlacementID:%@", placementID);
}

-(void) didClickNaitveSplashAdForPlacementID:(NSString*)placementID {
    NSLog(@"ViewController::didClickNaitveSplashAdForPlacementID:%@", placementID);
}

-(void) didCloseNativeSplashAdForPlacementID:(NSString*)placementID {
    NSLog(@"ViewController::didCloseNativeSplashAdForPlacementID:%@", placementID);
}
#pragma mark - HB Splash Delegate method(s)
-(void) didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"ViewController::didFinishLoadingADWithPlacementID:%@", placementID);
}

-(void) didFailToLoadADWithPlacementID:(NSString*)placementID error:(NSError*)error {
    NSLog(@"ViewController::didFailToLoadADWithPlacementID:%@ error:%@", placementID, error);
}

-(void)splashDidShowForPlacementID:(NSString*)placementID {
    NSLog(@"ViewController::splashDidShowForPlacementID:%@", placementID);
}

-(void)splashDidClickForPlacementID:(NSString*)placementID {
    NSLog(@"ViewController::splashDidClickForPlacementID:%@", placementID);
}

-(void)splashDidCloseForPlacementID:(NSString*)placementID {
    NSLog(@"ViewController::splashDidCloseForPlacementID:%@", placementID);
}

#pragma mark - splash delegate with networkID and adsourceID
-(void)didShowNativeSplashAdForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"ViewController::splashDidShowForPlacementID:%@ with extra: %@", placementID,extra);
}

-(void)didClickNaitveSplashAdForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"ViewController::splashDidClickForPlacementID:%@ with extra: %@", placementID,extra);
}

-(void)didCloseNativeSplashAdForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"ViewController::splashDidCloseForPlacementID:%@ with extra: %@", placementID,extra);
}

-(void)splashDidShowForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"ViewController::splashDidShowForPlacementID:%@ with extra: %@", placementID,extra);
    
}

-(void)splashDidClickForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"ViewController::splashDidClickForPlacementID:%@ with extra: %@", placementID,extra);
    
}

-(void)splashDidCloseForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra{
    NSLog(@"ViewController::splashDidCloseForPlacementID:%@ with extra: %@", placementID,extra);
}


// MARK:- SFSafariViewControllerDelegate
- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    [controller dismissViewControllerAnimated:true completion:^{
        
    }];
}

- (void)safariViewController:(SFSafariViewController *)controller initialLoadDidRedirectToURL:(NSURL *)URL {
    NSLog(@"%@",URL.absoluteString);
}

@end
