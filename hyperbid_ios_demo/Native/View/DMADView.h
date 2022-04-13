//
//  DMADView.h
//  HyperBidSDKDemo
//
//  Created by mac on 2021/12/8.
//

#import <HyperBidNative/HyperBidNative.h>

NS_ASSUME_NONNULL_BEGIN

@interface DMADView : HBNativeADView

@property(nonatomic, readonly) UILabel *advertiserLabel;
@property(nonatomic, readonly) UILabel *textLabel;
@property(nonatomic, readonly) UILabel *titleLabel;
@property(nonatomic, readonly) UILabel *ctaLabel;
@property(nonatomic, readonly) UILabel *ratingLabel;
@property(nonatomic, readonly) UIImageView *iconImageView;
@property(nonatomic, readonly) UIImageView *mainImageView;
@property(nonatomic, readonly) UIImageView *logoImageView;
@property(nonatomic, readonly) UIImageView *sponsorImageView;
@property(nonatomic, readonly) UIButton *dislikeButton;

@end

NS_ASSUME_NONNULL_END
