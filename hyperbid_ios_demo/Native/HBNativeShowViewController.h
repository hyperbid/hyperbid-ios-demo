//
//  HBNativeShowViewController.h
//  HyperBidSDKDemo
//
//  Created by mac on 2021/12/7.
//

#import <UIKit/UIKit.h>
#import "DMADView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HBNativeShowViewController : UIViewController

- (instancetype)initWithAdView:(DMADView *)adView placementID:(NSString *)placementID;

@end

NS_ASSUME_NONNULL_END
