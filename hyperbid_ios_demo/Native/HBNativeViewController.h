//
//  HBNativeViewController.h
//  HyperBidSDKDemo
//
//  Created by Leo on 17/04/2018.
//  Copyright © 2018 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
@import HyperBidSDK;
#ifdef NATIVE_INTEGRATED
@import HyperBidNative;
#endif

#import <HyperBidNative/HBNativeADView.h>

extern NSString *const kMPPlacement;
extern NSString *const kInmobiPlacement;
extern NSString *const kFacebookPlacement;
extern NSString *const kFacebookHeaderBiddingPlacement;
extern NSString *const kAdMobPlacement;
extern NSString *const kApplovinPlacement;
extern NSString *const kMintegralAdvancedPlacement;
extern NSString *const kMintegralPlacement;
extern NSString *const kHeaderBiddingPlacement;
extern NSString *const kGDTPlacement;
extern NSString *const kGDTTemplatePlacement;

extern NSString *const kTTFeedPlacementName;
//extern NSString *const kTTDrawPlacementName;
extern NSString *const kAllPlacementName;
extern NSString *const kBaiduPlacement;
extern NSString *const kNendPlacement;
extern NSString *const kNendVideoPlacement;
extern NSString *const kMaioPlacement;
extern NSString *const kSigmobPlacement;
extern NSString *const kKSPlacement;
extern NSString *const kGAMPlacement;




//extern NSString *const kKSDrawPlacement;
@interface HBNativeViewController : UIViewController
+(NSDictionary<NSString*, NSString*>*)nativePlacementIDs;
@end
