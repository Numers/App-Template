//
//  Whether.h
//  ShangCheng
//
//  Created by baolicheng on 16/1/20.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Location;
@interface Whether : NSObject
@property(nonatomic) float indexAPI;
@property(nonatomic) float indexPM10;
@property(nonatomic) float indexCO;
@property(nonatomic) float indexSO2;
@property(nonatomic) float indexNO2;
@property(nonatomic) float indexO3;
@property(nonatomic, strong) Location *location;
@end
