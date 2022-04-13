//
//  HBNativeMessageStreamViewController.m
//  HyperBidSDKDemo
//
//  Created by mac on 2021/12/7.
//

#import "HBNativeMessageStreamViewController.h"


@interface HBNativeMessageStreamTableViewCell : UITableViewCell

+ (NSString *)idString;

@end

@implementation HBNativeMessageStreamTableViewCell

+ (NSString *)idString
{
    return @"HBNativeMessageStreamTableViewCell_cell";
}

@end

@interface HBNativeMessageStreamViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UIView *adView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger count;

@end

@implementation HBNativeMessageStreamViewController

- (instancetype)initWithAdView:(UIView *)adView
{
    if (self = [super init]) {
        _adView = adView;
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kRGB(245, 245, 245);
    self.title = @"Native List";
    
    self.count = 20;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    __weak typeof(self) weakself = self;
    
  
    }

- (void)loadMore
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.count += 20;
      
        [self.tableView reloadData];
    });
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row !=0 && indexPath.row % 5 == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:[HBNativeMessageStreamTableViewCell idString]];
        if (cell.contentView.subviews.count == 0) {
            [cell.contentView addSubview:self.adView];
        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"native_show_cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row !=0 && indexPath.row % 5 == 0) {
        return self.adView.frame.size.height + 150;
    }
    return 130;
}

#pragma mark - lazy
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"native_show_cell"];
        [_tableView registerClass:[HBNativeMessageStreamTableViewCell class] forCellReuseIdentifier:[HBNativeMessageStreamTableViewCell idString]];
    }
    return _tableView;
}

@end
