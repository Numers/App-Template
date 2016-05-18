//
//  SCConnectFailedStatusView.h
//  ShangCheng
//
//  Created by baolicheng on 16/1/28.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SCConnectFailedStatusViewProtocol <NSObject>
-(void)reconnect;
@end
@interface SCConnectFailedStatusView : UIView
{
    UILabel *lblName;
    UIButton *btnConnect;
}
@property(nonatomic, assign) id<SCConnectFailedStatusViewProtocol> delegate;
@end
