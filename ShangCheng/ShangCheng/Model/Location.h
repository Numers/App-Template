//
//  Location.h
//  ShangCheng
//
//  Created by baolicheng on 16/1/20.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject
@property(nonatomic) float lat;
@property(nonatomic) float lng;
@property(nonatomic,copy) NSString *cityName;
@end