//
//  DataAnalizer.m
//  ShangCheng
//
//  Created by baolicheng on 16/1/19.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import "DataAnalizer.h"
#define DataCompleteSysmbol @"\n"
@implementation DataAnalizer
-(id)init
{
    self = [super init];
    if (self) {
        dataIsCompletely = YES;
    }
    return self;
}

-(void)inputData:(NSData *)data
{
    if (!data) {
        return;
    }
    
    if (dataIsCompletely) {
        dataContainer = [[NSMutableString alloc] init];
        dataIsCompletely = NO;
    }
    
     NSString *value= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([value hasSuffix:DataCompleteSysmbol]) {
        value = [value stringByReplacingCharactersInRange:NSMakeRange(value.length - DataCompleteSysmbol.length, DataCompleteSysmbol.length) withString:@""];
        dataIsCompletely = YES;
    }
    
    [dataContainer appendString:value];
    
    if (dataIsCompletely) {
        if ([self.delegate respondsToSelector:@selector(outputDataString:)]) {
            NSString *outputStr = [NSString stringWithFormat:@"%@",dataContainer];
            [self.delegate outputDataString:outputStr];
        }
    }
}
@end
