//
//  ZXAppStartManager.m
//  ZhaoXinBao
//
//  Created by baolicheng on 15/11/12.
//  Copyright © 2015年 pangqingyao. All rights reserved.
//

#import "ZXAppStartManager.h"
#import "RFGeneralManager.h"
#import "AppDelegate.h"
#import "AppUtils.h"
#import "SCGuidViewController.h"
#import "SCLoginScrollViewController.h"
#import "SCHomeViewController.h"
#import "SCPersonalViewController.h"
#import "SCShopMallViewController.h"
#define HostProfilePlist @"PersonProfile.plist"
static ZXAppStartManager *manager;
@implementation ZXAppStartManager
+(id)defaultManager
{
    if (manager == nil) {
        manager = [[ZXAppStartManager alloc] init];
    }
    return manager;
}

-(Member *)currentHost
{
    if (host == nil) {
        host = [self getProfileFromPlist];
    }
    return host;
}

-(void)setHostMember:(Member *)member
{
    if (member) {
        host = member;
        [self saveProfileToPlist];
    }
}

-(void)removeLocalHostMemberData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *selfInfoPath = [documentsPath stringByAppendingPathComponent:HostProfilePlist];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:selfInfoPath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:selfInfoPath error:nil];
    }
    
    host = nil;
}

-(void)saveProfileToPlist
{
    NSDictionary *dic = [host dictionaryInfo];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *selfInfoPath = [documentsPath stringByAppendingPathComponent:HostProfilePlist];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:selfInfoPath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:selfInfoPath error:nil];
    }
    
    [dic writeToFile:selfInfoPath atomically:YES];
}

-(Member *)getProfileFromPlist
{
    Member *member = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *selfInfoPath = [documentsPath stringByAppendingPathComponent:HostProfilePlist];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:selfInfoPath])
    {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:selfInfoPath];
        if (dic != nil) {
            member = [[Member alloc] initlizedWithDictionary:dic];
        }
    }
    return member;
}

-(void)startApp
{
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"NavBackIndicatorImage"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"NavBackIndicatorImage"]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    [[RFGeneralManager defaultManager] getGlovalVarWithVersion];
    [self currentHost];
    if (host) {
        NSString *autoLogin = [AppUtils localUserDefaultsForKey:KMY_AutoLogin];
        if ([autoLogin isEqualToString:@"1"]) {
            [self setHomeView];
        }else{
//            [self setLoginView];
            [self setHomeView];
        }
    }else{
//        [self setGuidView];
        [self setHomeView];
    }
}

-(void)setHomeView
{
    _tabBarController = [[UITabBarController alloc] init];
    [_tabBarController.tabBar setTranslucent:NO];
    [_tabBarController.navigationItem setHidesBackButton:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SCHomeViewController *scHomeVC = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewIdentify"];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:scHomeVC];
    SCShopMallViewController *scShopMallVC = [storyboard instantiateViewControllerWithIdentifier:@"ShopMallViewIdentify"];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:scShopMallVC];
    SCPersonalViewController *scPersonalVC = [storyboard instantiateViewControllerWithIdentifier:@"PersonalViewIdentify"];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:scPersonalVC];
    _tabBarController.viewControllers = @[nav1,nav2,nav3];
    UITabBar *tabBar = _tabBarController.tabBar;
    UITabBarItem *item1 = [tabBar.items objectAtIndex:0];
    //    [item1 setImage:[UIImage imageNamed:@"usercenter-tabbarhealth-notselect"]];
    //    [item1 setSelectedImage:[UIImage imageNamed:@"usercenter-tabbarhealth-select"]];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:1];
    //    [item2 setImage:[UIImage imageNamed:@"usercenter-tabbarchat-notselect"]];
    //    [item2 setSelectedImage:[UIImage imageNamed:@"usercenter-tabbarchat-select"]];
    UITabBarItem *item3 = [tabBar.items objectAtIndex:2];
    //    [item3 setImage:[UIImage imageNamed:@"usercenter-tabbarprofile-notselect"]];
    //    [item3 setSelectedImage:[UIImage imageNamed:@"usercenter-tabbarprofile-select"]];
    item1.title = @"首页";
    [item1 setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} forState:UIControlStateNormal];
    item2.title = @"商城";
    [item2 setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} forState:UIControlStateNormal];
    item3.title = @"我的";
    [item3 setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} forState:UIControlStateNormal];
    [_tabBarController setSelectedIndex:0];
    [[(AppDelegate *)[UIApplication sharedApplication].delegate window] setRootViewController:_tabBarController];
}

-(void)pushHomeViewWithSelectIndex:(NSInteger)index
{
    _tabBarController = [[UITabBarController alloc] init];
    [_tabBarController.tabBar setTranslucent:NO];
    [_tabBarController.navigationItem setHidesBackButton:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SCHomeViewController *scHomeVC = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewIdentify"];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:scHomeVC];
    SCShopMallViewController *scShopMallVC = [storyboard instantiateViewControllerWithIdentifier:@"ShopMallViewIdentify"];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:scShopMallVC];
    SCPersonalViewController *scPersonalVC = [storyboard instantiateViewControllerWithIdentifier:@"PersonalViewIdentify"];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:scPersonalVC];
    _tabBarController.viewControllers = @[nav1,nav2,nav3];
    UITabBar *tabBar = _tabBarController.tabBar;
    UITabBarItem *item1 = [tabBar.items objectAtIndex:0];
    //    [item1 setImage:[UIImage imageNamed:@"usercenter-tabbarhealth-notselect"]];
    //    [item1 setSelectedImage:[UIImage imageNamed:@"usercenter-tabbarhealth-select"]];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:1];
    //    [item2 setImage:[UIImage imageNamed:@"usercenter-tabbarchat-notselect"]];
    //    [item2 setSelectedImage:[UIImage imageNamed:@"usercenter-tabbarchat-select"]];
    UITabBarItem *item3 = [tabBar.items objectAtIndex:2];
    //    [item3 setImage:[UIImage imageNamed:@"usercenter-tabbarprofile-notselect"]];
    //    [item3 setSelectedImage:[UIImage imageNamed:@"usercenter-tabbarprofile-select"]];
    item1.title = @"首页";
    [item1 setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} forState:UIControlStateNormal];
    item2.title = @"商城";
    [item2 setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} forState:UIControlStateNormal];
    item3.title = @"我的";
    [item3 setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} forState:UIControlStateNormal];
    [_tabBarController setSelectedIndex:0];
    [_navigationController pushViewController:_tabBarController animated:YES];
}



-(void)setGuidView
{
    SCGuidViewController *zxGuidVC = [[SCGuidViewController alloc] init];
    _navigationController = [[UINavigationController alloc] initWithRootViewController:zxGuidVC];
    [[(AppDelegate *)[UIApplication sharedApplication].delegate window] setRootViewController:_navigationController];
}

-(void)setLoginView
{
    SCLoginScrollViewController *zxLoginScrollVC = [[SCLoginScrollViewController alloc] init];
    _navigationController = [[UINavigationController alloc] initWithRootViewController:zxLoginScrollVC];
    [[(AppDelegate *)[UIApplication sharedApplication].delegate window] setRootViewController:_navigationController];
}

-(void)loginOut
{
    [_navigationController popToRootViewControllerAnimated:NO];
    _navigationController = nil;
    [self setLoginView];
    [AppUtils localUserDefaultsValue:@"0" forKey:KMY_AutoLogin];
}
@end
