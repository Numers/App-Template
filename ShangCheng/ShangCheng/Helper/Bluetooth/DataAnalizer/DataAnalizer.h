//
//  DataAnalizer.h
//  ShangCheng
//
//  Created by baolicheng on 16/1/19.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DataAnalizerProtocol <NSObject>
-(void)outputDataString:(NSString *)data;
@end
@interface DataAnalizer : NSObject
{
    NSMutableString *dataContainer;
    BOOL dataIsCompletely;
}
@property(nonatomic, assign) id<DataAnalizerProtocol> delegate;
-(void)inputData:(NSData *)data;
@end
