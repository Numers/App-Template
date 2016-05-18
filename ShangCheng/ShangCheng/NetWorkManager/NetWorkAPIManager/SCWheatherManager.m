//
//  SCWheatherManager.m
//  ShangCheng
//
//  Created by baolicheng on 16/1/20.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import "SCWheatherManager.h"
#import "Location.h"
static SCWheatherManager *scWheatherManager;
@implementation SCWheatherManager
+(id)defaultManager
{
    if (scWheatherManager == nil) {
        scWheatherManager = [[SCWheatherManager alloc] init];
    }
    return scWheatherManager;
}

-(void)requestWheatherInfoWithUid:(NSString *)uid WithToken:(NSString *)token WithLocation:(Location *)location Success:(ApiSuccessCallback)success Error:(ApiErrorCallback)error Failed:(ApiFailedCallback)failed;
{
    success(nil,nil);
}
@end
