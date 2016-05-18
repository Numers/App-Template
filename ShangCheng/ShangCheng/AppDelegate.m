//
//  AppDelegate.m
//  ShangCheng
//
//  Created by baolicheng on 15/12/14.
//  Copyright © 2015年 RenRenFenQi. All rights reserved.
//

#import "AppDelegate.h"
#import "ZXAppStartManager.h"
#import "APService.h"
#import "MobClick.h"
#import "ThirdPartToolsMacros.h"
#import "RFGeneralManager.h"
#import <BaiduMapAPI_Base/BMKMapManager.h>

@interface AppDelegate ()
{
    BMKMapManager *bmkManager;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[ZXAppStartManager defaultManager] startApp];
    //百度地图
    bmkManager = [[BMKMapManager alloc] init];
    BOOL ret = [bmkManager start:BaiduMap_KEY generalDelegate:nil];
    if (!ret) {
        NSLog(@"百度地图启动失败");
    }
//    //注册推送
//    [self pushSettingWithOptions:launchOptions];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushDidLogin:) name:kJPFNetworkDidLoginNotification object:nil];
//    
//    /**
//     *
//     *  友盟统计
//     */
//    [MobClick startWithAppkey:UMENG_KEY reportPolicy:BATCH channelId:nil];
//    [MobClick setAppVersion:XcodeAppVersion];
//    [MobClick setCrashReportEnabled:YES];
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)pushDidLogin:(NSNotification *)notification
{
    [APService setBadge:0];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    // 取消本地通知
    [APService clearAllLocalNotifications];
    _registerID = [APService registrationID];
    [APService setTags:[NSSet setWithObject:_registerID] callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
    [[RFGeneralManager defaultManager] sendClientIdSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } Error:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } Failed:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)tagsAliasCallback:(int)iResCode tags:(NSSet *)tags alias:(NSString *)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

-(void)pushSettingWithOptions:(NSDictionary *)launchOptions
{
    // Required
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    [APService setupWithOption:launchOptions];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
