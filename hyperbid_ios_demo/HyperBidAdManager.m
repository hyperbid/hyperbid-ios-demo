//
//  HyperBidAdManager.m
//  HyperBidSDKDemo
//
//  Created by Leo on 2020/1/10.
//  Copyright © 2020 HyperBid. All rights reserved.
//

#import "HyperBidAdManager.h"
//iOS 14
#import <AppTrackingTransparency/AppTrackingTransparency.h>

@import HyperBidSDK;

NSInteger const HyperBidAPITypeHyperBid = 1;

#define HBID @"a61e062ded9a70"
#define HBKey @"bd8af264b1a54c4deba868875ee89916"


@implementation HyperBidAdManager
+(instancetype) sharedManager {
    static HyperBidAdManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[HyperBidAdManager alloc] init];
        
    });
    return sharedManager;
}

-(void) initSDKAPIWithAPIType:(NSInteger)apiType {
        [HBAPI setDebugLog:YES];
        [HBAPI initCheck];
        
        //channel&subchannle -> customData.channel&subchannel
        [HBAPI sharedInstance].channel = @"test_channel";
        [HBAPI sharedInstance].subchannel = @"test_subchannel";
        [HBAPI sharedInstance].customData = @{kHBCustomDataUserIDKey:@"test_custom_user_id",
                                              kHBCustomDataChannelKey:@"custom_data_channel",
                                              kHBCustomDataSubchannelKey:@"custom_data_subchannel",
                                              kHBCustomDataAgeKey:@18,
                                              kHBCustomDataGenderKey:@1,
                                              kHBCustomDataNumberOfIAPKey:@19,
                                              kHBCustomDataIAPAmountKey:@20.0f,
                                              kHBCustomDataIAPCurrencyKey:@"usd",
                                              kHBCustomDataSegmentIDKey:@16382351
        };
       [HBAPI setHeaderBiddingTestModeWithDeviceID:@"2C898254-0F15-463D-9D55-582CFE55E4B0"];
        //customData.channel&subchannel -> channel&subchannle
    //    [HBAPI sharedInstance].customData = @{kHBCustomDataChannelKey:@"custom_data_channel",
    //                                          kHBCustomDataSubchannelKey:@"custom_data_subchannel"
    //    };
    //    [HBAPI sharedInstance].channel = @"test_channel";
    //    [HBAPI sharedInstance].subchannel = @"test_subchannel";
        
        //setting custom data for placement, channel&subchannel will be ignored
        [[HBAPI sharedInstance] setCustomData:@{kHBCustomDataChannelKey:@"placement_custom_data_channel",
                                              kHBCustomDataSubchannelKey:@"placement_custom_data_subchannel"
        } forPlacementID:@"b5c1b048c498b9"];
        
        [[HBAPI sharedInstance] setExludeAppleIds:@[@"id529479190"]];
        
    //    [[HBAPI sharedInstance] setDeniedUploadInfos:@[kHBDeviceDataInfoOSVersionNameKey,
    //                                                       kHBDeviceDataInfoOSVersionCodeKey,
    //                                                       kHBDeviceDataInfoPackageNameKey,
    //                                                       kHBDeviceDataInfoAppVersionCodeKey,
    //                                                       kHBDeviceDataInfoAppVersionNameKey,
    //                                                       kHBDeviceDataInfoBrandKey,
    //                                                       kHBDeviceDataInfoModelKey,
    //                                                       kHBDeviceDataInfoScreenKey,
    //                                                       kHBDeviceDataInfoNetworkTypeKey,
    //                                                       kHBDeviceDataInfoMNCKey,
    //                                                       kHBDeviceDataInfoMCCKey,
    //                                                       kHBDeviceDataInfoLanguageKey,
    //                                                       kHBDeviceDataInfoTimeZoneKey,
    //                                                       kHBDeviceDataInfoUserAgentKey,
    //                                                       kHBDeviceDataInfoOrientKey,
    //                                                       kHBDeviceDataInfoIDFAKey,
    //                                                       kHBDeviceDataInfoIDFVKey]];
        
        [[HBAPI sharedInstance] getGDPRWithCallback:^(HBUserLocation location) {
            if (location == HBUserLocationInEU) {
                NSLog(@"----------ATUserLocationInEU");
                if ([HBAPI sharedInstance].dataConsentSet == HBDataConsentSetUnknown) {
                    NSLog(@"----------ATDataConsentSetUnknown");
                }
            }else if (location == HBUserLocationOutOfEU){
                NSLog(@"----------ATUserLocationOutOfEU");
            }else{
                NSLog(@"----------ATUserLocationUnknown");
            }
        }];
        
    //    [HBAPI setAdLogoVisible:YES];
        
        if (@available(iOS 14, *)) {
            //iOS 14
            [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                [[HBAPI sharedInstance] initWithAppID:HBID appKey:HBKey error:nil];
            }];
        } else {
            // Fallback on earlier versions
            [[HBAPI sharedInstance] initWithAppID:HBID appKey:HBKey error:nil];
        }
}

-(void) initSDKAPIWithAppID:(NSString*)appID appKey:(NSString*)appKey {
    
}

@end
