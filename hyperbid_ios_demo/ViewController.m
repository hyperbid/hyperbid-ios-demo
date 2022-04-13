//
//  ViewController.m
//  HyperBidSDKDemo
//
//  Created by Leo on 2019/10/31.
//  Copyright © 2019 HyperBid. All rights reserved.
//

#import "ViewController.h"
#import "HBHomeTableViewCell.h"
#import "HBHomeFootView.h"
#import <AppTrackingTransparency/ATTrackingManager.h>

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic) BOOL autoLoadEnable;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *autoEnableBtn;

@end

//static NSString *const kCellIdentifier = @"cell";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"HyperBid SDK Demo";
    
 
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self setupData];
    [self setupUI];
    [self checkTrackingPermission];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)checkTrackingPermission
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (@available(iOS 14, *)) {
            //iOS 14
            [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                
            }];
        } else {
            // Fallback on earlier versions
        }
    });
}

- (void)setupData
{
    self.dataSource = @[
        @{
            @"image":@"rewarded video",
            @"title":@"Reward Video",
            @"des":@"Users can engage with a video ad in exchange for in-app rewards.",
            @"autoClass":@"HBRewardVideoAutoAdViewController"
        },
        @{
            @"image":@"interstitial",
            @"title":@"Interstitial",
            @"des":@"Include Interstitial and FullScreen.Appears at natural breaks or transition points.",
            @"autoClass":@"HBInterstitialAutoAdViewController"
        },
        @{
            @"image":@"splash",
            @"title":@"Splash",
            @"des":@"Displayed immediately after the application is launched.",
        },
        @{
            @"image":@"banner",
            @"title":@"Banner",
            @"des":@"Flexible formats which could appear at the top, middle or bottom of your app.",
        },
        @{
            @"image":@"native",
            @"title":@"Native",
            @"des":@"Include Native,Vertical Draw Video and Pre-roll Ads.Most compatible with your native app code for video ads and graphic ads.",
        }
    ];
}

- (void)setupUI
{
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = false;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];

 
    
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[HBHomeFootView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScaleW(150))];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (IBAction)autoLoadEnable:(id)sender {
    self.autoLoadEnable = !self.autoLoadEnable;
    NSLog(@"auto load %@",self.autoLoadEnable ? @"enable" : @"disable");

    UIBarButtonItem *btnItem = self.navigationItem.rightBarButtonItem;
    UIButton *clearBtn = btnItem.customView;
    [clearBtn setTitleColor:self.autoLoadEnable ? [UIColor blackColor] : [UIColor lightGrayColor] forState:UIControlStateNormal];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScaleW(238 + 10);
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HBHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HBHomeTableViewCell idString]];
    cell.backgroundColor = kRGB(245, 245, 245);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = self.dataSource[indexPath.row];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@", dic[@"title"]];
    cell.subTitleLabel.text = [NSString stringWithFormat:@"%@", dic[@"des"]];
    cell.image = [NSString stringWithFormat:@"%@", dic[@"image"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataSource[indexPath.row];
    NSString *controllerName = dic[@"title"];
    controllerName = [controllerName stringByReplacingOccurrencesOfString:@" " withString:@""];
    Class class;
    NSString *classString = @"";
    if (self.autoLoadEnable && dic[@"autoClass"]) {
        classString = dic[@"autoClass"];
    }else {
        classString = [NSString stringWithFormat:@"HB%@ViewController", controllerName];
    }
    class = NSClassFromString(classString);

    if ([classString isEqualToString:@"HBTogetherLoadViewController"]) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Together" bundle:[NSBundle mainBundle]];
        UIViewController *vc = [storyboard instantiateInitialViewController];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
        UIViewController *con = [class new];
        con.navigationController.navigationBar.barTintColor = [UIColor blackColor];
        [self.navigationController pushViewController:con animated:YES];
        
    }
}

#pragma mark - lazy
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[HBHomeTableViewCell class] forCellReuseIdentifier:[HBHomeTableViewCell idString]];
    }
    return _tableView;
}

@end
