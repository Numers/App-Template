//
//  ZXAppStartManager.h
//  ZhaoXinBao
//
//  Created by baolicheng on 15/11/12.
//  Copyright © 2015年 pangqingyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Member.h"

@interface ZXAppStartManager : NSObject
{
    Member *host;
}

@property(nonatomic, strong) UINavigationController *navigationController;
@property(nonatomic, strong) UITabBarController *tabBarController;

+(id)defaultManager;
-(Member *)currentHost;
-(void)setHostMember:(Member *)member;

-(void)startApp;
-(void)loginOut;
@end
