//
//  HBNativeShowViewController.h
//  HyperBidSDKDemo
//
//  Created by mac on 2021/12/7.
//

#import <UIKit/UIKit.h>
@import HyperBidNative;

NS_ASSUME_NONNULL_BEGIN

@interface HBNativeShowViewController : UIViewController

- (instancetype)initWithAdView:(HBNativeADView *)adView placementID:(NSString *)placementID offer:(HBNativeAdOffer *)offer;
@property (nonatomic, strong) HBNativeADView *adView;

@end

NS_ASSUME_NONNULL_END
