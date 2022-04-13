//
//  HBNativeRenderView.h
//  HyperBidSDKDemo
//
//  Created by Jean on 2021/10/29.
//

#import <HyperBidNative/HyperBidNative.h>

NS_ASSUME_NONNULL_BEGIN

@interface HBNativeRenderView : HBNativeADView

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
