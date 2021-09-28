//
//  HBDrawViewController.h
//  HyperBidSDKDemo
//
//  Created by HyperBid on 2020/2/25.
//  Copyright © 2020 HyperBid. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN
extern NSString *const kKSDrawPlacement;
extern NSString *const kTTDrawPlacementName;

@interface HBDrawViewController : UIViewController
-(instancetype) initWithPlacementName:(NSString*)name;
+(NSDictionary<NSString*, NSString*>*)nativePlacementIDs;
@end

NS_ASSUME_NONNULL_END
