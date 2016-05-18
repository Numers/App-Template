//
//  SCViewWebJsBridge.h
//  ShangCheng
//
//  Created by baolicheng on 15/12/24.
//  Copyright © 2015年 RenRenFenQi. All rights reserved.
//

#import "WebViewJsBridge.h"
@protocol SCViewWebJsBridgeDelegate<NSObject>
-(void)showShareView;
@end
@interface SCViewWebJsBridge : WebViewJsBridge
@property(nonatomic, assign) id<SCViewWebJsBridgeDelegate> delegate;
@end
