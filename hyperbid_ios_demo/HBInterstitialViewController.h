//
//  HBInterstitialViewController.h
//  HyperBidSDKDemo
//
//  Created by Leo on 21/09/2018.
//  Copyright © 2018 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString *const kInmobiPlacement;
extern NSString *const kFacebookPlacement;
extern NSString *const kFacebookHeaderBiddingPlacement;
extern NSString *const kAdMobPlacement;
extern NSString *const kApplovinPlacement;
extern NSString *const kMopubPlacementName;
extern NSString *const kMopubVideoPlacementName;
extern NSString *const kMintegralPlacement;
extern NSString *const kMintegralVideoPlacement;
extern NSString *const kHeaderBiddingPlacement;
extern NSString *const kGDTPlacement;
extern NSString *const kTapjoyPlacementName;
extern NSString *const kChartboostPlacementName;
extern NSString *const kIronsourcePlacementName;
extern NSString *const kVunglePlacementName;
extern NSString *const kAdcolonyPlacementName;
extern NSString *const kUnityAdsPlacementName;
extern NSString *const kAllPlacementName;
extern NSString *const kTTPlacementName;
extern NSString *const kTTVideoPlacement;
extern NSString *const kAppnextPlacement;
extern NSString *const kBaiduPlacement;
extern NSString *const kNendPlacement;
extern NSString *const kNendInterstitialVideoPlacement;
extern NSString *const kNendFullScreenInterstitialPlacement;
extern NSString *const kMaioPlacement;
extern NSString *const kSigmobPlacement;
extern NSString *const kSigmobRVIntPlacement;
extern NSString *const kKSPlacement;
extern NSString *const kMyOfferPlacement;
extern NSString *const kOguryPlacement;
extern NSString *const kStartAppPlacement;
extern NSString *const kStartAppVideoPlacement;
extern NSString *const kFyberPlacement;
extern NSString *const kGAMPlacement;
extern NSString *const kHeliumPlacement;
extern NSString *const kADXPlacement;
extern NSString *const kOnlineApiPlacement;
extern NSString *const kKidozPlacement;
extern NSString *const kMyTargetPlacement;
extern NSString *const kOFMPlacement;
extern NSString *const kMobrainPlacement;

@interface HBInterstitialViewController : UIViewController
-(instancetype) initWithPlacementName:(NSString*)name;
@end
