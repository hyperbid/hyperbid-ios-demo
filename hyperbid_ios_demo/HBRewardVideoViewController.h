//
//  HBReWardVideoViewController.h
//  HyperBidSDKDemo
//
//  Created by mac on 2021/12/6.
//

#import <UIKit/UIKit.h>

#import "HBADFootView.h"
#import "HBMenuView.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kYandexPlacement;

@interface HBRewardVideoViewController : UIViewController

@property (copy, nonatomic) NSString *placementID;

@property (copy, nonatomic) NSDictionary<NSString *, NSString *> *placementIDs;

@property (nonatomic, strong) HBMenuView *menuView;

@property (nonatomic, strong) HBADFootView *footView;


- (void)togetherLoadAd:(NSString *)togetherLoadAdStr;

- (void)showAd;

@end

NS_ASSUME_NONNULL_END
