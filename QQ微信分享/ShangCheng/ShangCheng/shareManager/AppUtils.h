//
//  AppUtils.h
//  ZhaoXinBao
//
//  Created by baolicheng on 15/11/11.
//  Copyright © 2015年 pangqingyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppUtils : NSObject
+ (void)showInfo:(NSString*)str;
+ (void)showProgressBarForView:(UIView *)view;
+ (void)hideProgressBarForView:(UIView *)view;
@end
