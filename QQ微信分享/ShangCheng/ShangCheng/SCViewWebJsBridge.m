//
//  SCViewWebJsBridge.m
//  ShangCheng
//
//  Created by baolicheng on 15/12/24.
//  Copyright © 2015年 RenRenFenQi. All rights reserved.
//

#import "SCViewWebJsBridge.h"

@implementation SCViewWebJsBridge
-(void)shareAll
{
    if ([self.delegate respondsToSelector:@selector(showShareView)]) {
        [self.delegate showShareView];
    }
}
@end
