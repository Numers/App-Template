//
//  SCLocationHelper.h
//  ShangCheng
//
//  Created by baolicheng on 16/1/20.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>

#define LocationAndWhetherInfoUpdateNotify @"LocationAndWhetherInfoUpdateNotify"
@class Location,Whether;
@interface SCLocationHelper : NSObject<BMKLocationServiceDelegate>
{
    BMKLocationService *locationManager;
    Location *currentLocation;
    Whether *currentWhether;
    
    NSTimer *timer;
}
+(id)defaultHelper;
-(void)startLocationService;
-(Location *)returnCurrentLocation;
-(Whether *)returnCurrentWhether;
@end
