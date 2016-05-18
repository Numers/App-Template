//
//  SCLoginManager.h
//  ShangCheng
//
//  Created by baolicheng on 16/2/1.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RFNetWorkManager.h"
@interface SCLoginManager : NSObject
+(id)defaultManager;

-(void)loginWithMobile:(NSString *)phone WithPassword:(NSString *)password Success:(ApiSuccessCallback)success Error:(ApiErrorCallback)error Failed:(ApiFailedCallback)failed;
@end
