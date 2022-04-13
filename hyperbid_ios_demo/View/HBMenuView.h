//
//  HBMenuView.h
//  HyperBidSDKDemo
//
//  Created by mac on 2021/12/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HBMenuView : UIView

@property (nonatomic) BOOL multiple;

@property (nonatomic, copy) void(^selectMenu)(NSString *selectMenu);
@property (nonatomic, copy) void(^selectMenus)(NSArray<NSString *> *selectMenus);

@property (nonatomic, copy) void(^selectSubMenu)(NSString *selectSubMenu);
@property (nonatomic, copy) void(^turnOnAuto)(Boolean isOn);
@property(nonatomic,assign)BOOL turnAuto;
- (instancetype)initWithMenuList:(NSArray *)menuList subMenuList:(NSArray * __nullable)subMenuList;

- (void)resetMenuList:(NSArray *)menuList;

- (void)hiddenSubMenu;

- (void)showSubMenu;

@end

NS_ASSUME_NONNULL_END
