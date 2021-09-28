//
//  HyperBidAdManager.h
//  HyperBidSDKDemo
//
//  Created by Leo on 2020/1/10.
//  Copyright © 2020 HyperBid. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSInteger const HyperBidAPITypeHyperBid;
extern NSInteger const HyperBidAPITypeOFM;

@interface HyperBidAdManager : NSObject
+(instancetype) sharedManager;
@property (atomic, readwrite) NSInteger currentAPIType;
-(void) initSDKAPIWithAPIType:(NSInteger)apiType;
-(void) initSDKAPIWithAppID:(NSString*)appID appKey:(NSString*)appKey;
@end

NS_ASSUME_NONNULL_END
