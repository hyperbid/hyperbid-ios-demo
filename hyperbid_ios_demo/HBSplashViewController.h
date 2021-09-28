//
//  HBSplashViewController.h
//  HyperBidSDKDemo
//
//  Created by Jean on 2020/12/3.
//  Copyright © 2020 HyperBid. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kMintegralPlacement;
extern NSString *const kSigmobPlacement;
extern NSString *const kGDTPlacement;
extern NSString *const kGDTZoomOutPlacement;
extern NSString *const kBaiduPlacement;
extern NSString *const kTTPlacementName;
extern NSString *const kAdMobPlacement;
extern NSString *const kKSPlacement;
extern NSString *const kMyOfferPlacement;
extern NSString *const kADXPlacement;
extern NSString *const kOnlineApiPlacement;
extern NSString *const kAllPlacementName;
extern NSString *const kMobrainPlacement;

@interface HBSplashViewController : UIViewController

- (instancetype)initWithPlacementName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
