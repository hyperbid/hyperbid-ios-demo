//
//  HBDrawViewController.m
//  HyperBidSDKDemo
//
//  Created by mac on 2021/12/7.
//

#import "HBDrawViewController.h"

@interface HBDrawViewController ()

@property (nonatomic, weak) UIView *adView;

@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation HBDrawViewController

- (instancetype)initWithAdView:(UIView *)adView
{
    if (self = [super init]) {
        _adView = adView;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.adView];
    
//    [self addCloseBtn];
}


- (void)addCloseBtn
{
    [self.view addSubview:self.closeBtn];
}

#pragma mark - Action
- (void)clickClose
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - lazy
- (UIButton *)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 50, kStatusBarHeight + 20, kScaleW(60), kScaleW(50))];
        [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(clickClose) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

@end
