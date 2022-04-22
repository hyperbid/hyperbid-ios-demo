//
//  HBModelButton.m
//  HyperBidSDKDemo
//
//  Created by mac on 2021/12/6.
//

#import "HBModelButton.h"

@interface HBModelButton()

@end

@implementation HBModelButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    
    [self addSubview:self.image];
    [self addSubview:self.modelLabel];
    
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScaleW(123));
        make.height.mas_equalTo(kScaleW(199));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(kScaleW(52));
    }];
    
    [self.modelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.mas_width);
        make.bottom.equalTo(self.mas_bottom).offset(-kScaleW(52));
        make.height.mas_equalTo(kScaleW(34));
    }];
}

- (void)setButtonIsSelectBoard
{
    self.layer.borderColor = self.isSelected ? mainColor.CGColor : [UIColor whiteColor].CGColor;
}

- (void)setSelectColor:(UIColor *)color
{
    [self setBackgroundImage:[self imageWithColor:color] forState:UIControlStateSelected];
}

- (void)setNormalColor:(UIColor *)color
{
    [self setBackgroundImage:[self imageWithColor:color] forState:UIControlStateNormal];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

#pragma mark - lazy
- (UIImageView *)image
{
    if (!_image) {
        _image = [[UIImageView alloc] init];
        _image.backgroundColor = [UIColor whiteColor];
        _image.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _image;
}

- (UILabel *)modelLabel
{
    if (!_modelLabel) {
        _modelLabel = [[UILabel alloc] init];
        _modelLabel.textAlignment = NSTextAlignmentCenter;
        _modelLabel.textColor = [UIColor blackColor];
    }
    return _modelLabel;
}

@end
