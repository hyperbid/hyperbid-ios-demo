//
//  HBBannerViewController.h
//  HyperBidSDKDemo
//
//  Created by Leo on 19/09/2018.
//  Copyright © 2018 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString *const kInmobiPlacement;
extern NSString *const kFacebookPlacement;
extern NSString *const kAdMobPlacement;
extern NSString *const kApplovinPlacement;

extern NSString *const kGDTPlacement;

extern NSString *const kMintegralPlacement;
extern NSString *const kTapjoyPlacementName;
extern NSString *const kChartboostPlacementName;
extern NSString *const kIronsourcePlacementName;
extern NSString *const kVunglePlacementName;
extern NSString *const kAdcolonyPlacementName;
extern NSString *const kUnityAdsPlacementName;
extern NSString *const kAllPlacementName;
extern NSString *const kTTPlacementName;
extern NSString *const kBaiduPlacement;
extern NSString *const kNendPlacement;
extern NSString *const kBannerShownNotification;
extern NSString *const kBannerLoadingFailedNotification;
extern NSString *const kHeaderBiddingPlacement;
extern NSString *const kFyberPlacement;
extern NSString *const kStartAppPlacement;
extern NSString *const kChartboostPlacementName;
extern NSString *const kVunglePlacementName;
extern NSString *const kAdcolonyPlacementName;
extern NSString *const kGAMPlacement;
extern NSString * const kYandexPlacement;
extern NSString *const kKidozPlacement;
extern NSString *const kMyTargetPlacement;


@interface HBBannerViewController : UIViewController
-(instancetype) initWithPlacementName:(NSString*)name;
@end
