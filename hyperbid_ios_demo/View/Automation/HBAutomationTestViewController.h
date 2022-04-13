//
//  HBAutomationTestViewController.h
//  HyperBidSDKDemo
//
//  Created by mac on 2022/1/21.
//  Copyright © 2022 HyperBid. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HBAutomationTestViewController : UIViewController

- (void)getProtocolMethodListFromProtocolList:(NSArray *)protocolList;

- (void)recordWithPlacementId:(NSString *)placementId protocol:(NSString *)protocolMethod;

@end

NS_ASSUME_NONNULL_END
