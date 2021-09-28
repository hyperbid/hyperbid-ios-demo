//
//  HBNativeBannerViewController.h
//  HyperBidSDKDemo
//
//  Created by Leo on 2019/4/10.
//  Copyright © 2019 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kMPPlacement;
extern NSString *const kInmobiPlacement;
extern NSString *const kFacebookPlacement;
extern NSString *const kFacebookNativeBannerPlacement;
extern NSString *const kAdMobPlacement;
extern NSString *const kApplovinPlacement;
extern NSString *const kMopubPlacementName;
extern NSString *const kMopubVideoPlacementName;
extern NSString *const kMintegralPlacement;
extern NSString *const kGDTPlacement;
extern NSString *const kGDTTemplatePlacement;
extern NSString *const kAppnextPlacement;
extern NSString *const kTTFeedPlacementName;
extern NSString *const kTTDrawPlacementName;
extern NSString *const kAllPlacementName;
extern NSString *const kNendPlacement;
extern NSString *const kMaioPlacement;
extern NSString *const kKSPlacement;
@interface HBNativeBannerViewController : UIViewController
-(instancetype) initWithPlacementName:(NSString*)name;
@end
