//
//  SCWheatherManager.h
//  ShangCheng
//
//  Created by baolicheng on 16/1/20.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RFNetWorkManager.h"
@class Location;
@interface SCWheatherManager : NSObject
+(id)defaultManager;

-(void)requestWheatherInfoWithUid:(NSString *)uid WithToken:(NSString *)token WithLocation:(Location *)location Success:(ApiSuccessCallback)success Error:(ApiErrorCallback)error Failed:(ApiFailedCallback)failed;
@end
