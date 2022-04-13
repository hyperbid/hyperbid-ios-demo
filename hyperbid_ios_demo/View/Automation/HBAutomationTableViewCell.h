//
//  HBAutomationTableViewCell.h
//  HyperBidSDKDemo
//
//  Created by mac on 2022/1/21.
//  Copyright © 2022 HyperBid. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HBAutomationTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) UILabel *methodLabel;

+ (NSString *)idString;

@end

NS_ASSUME_NONNULL_END
