//
//  AppUtils.m
//  ZhaoXinBao
//
//  Created by baolicheng on 15/11/11.
//  Copyright © 2015年 pangqingyao. All rights reserved.
//

#import "AppUtils.h"
#import "MBProgressHUD.h"
#import "LZProgressView.h"
#define MBTAG  1001
#define AMTAG  1111

@implementation AppUtils
+ (BOOL)isNullStr:(NSString *)str
{
    if (str == nil || [str isEqual:[NSNull null]] || str.length == 0) {
        return  YES;
    }
    
    return NO;
}

+ (void)showLoadInfo:(NSString *)text{
    UIWindow *appRootView = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *HUD = (MBProgressHUD *)[appRootView viewWithTag:MBTAG];
    if (HUD == nil) {
        HUD = [[MBProgressHUD alloc] initWithView:appRootView];
        HUD.tag = MBTAG;
        [appRootView addSubview:HUD];
        [HUD show:YES];
    }
    
    HUD.removeFromSuperViewOnHide = YES; // 设置YES ，MB 再消失的时候会从super 移除
    
    if ([self isNullStr:text]) {
        //        HUD.animationType = MBProgressHUDAnimationZoom;
        [HUD hide:YES];
    }else{
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = text;
        HUD.labelFont = [UIFont fontWithName:@"HelveticaNeue" size:15];
        [HUD hide:YES afterDelay:1];
    }
}

+ (void)showInfo:(NSString*)str
{
    [self showLoadInfo:str];
}

+ (void)showProgressBarForView:(UIView *)view
{
    LZProgressView *HUD = (LZProgressView *)[view viewWithTag:AMTAG];
    if (HUD == nil) {
        CGRect frame = CGRectMake(0, 0, 26, 26);
        HUD = [[LZProgressView alloc] initWithFrame:frame andLineWidth:3.0f andLineColor:@[[UIColor orangeColor],[UIColor grayColor]]];
        HUD.tag = AMTAG;
        HUD.center = CGPointMake(view.center.x, view.center.y);
        [view addSubview:HUD];
    }
    [HUD startAnimation];
}

+ (void)hideProgressBarForView:(UIView *)view
{
    LZProgressView *HUD = (LZProgressView *)[view viewWithTag:AMTAG];
    if (HUD != nil) {
        [HUD stopAnimation];
    }
}

@end
