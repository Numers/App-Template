//
//  SCDataLostStatusView.h
//  ShangCheng
//
//  Created by baolicheng on 16/1/28.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SCDataLostStatusViewProtocol <NSObject>
-(void)resetDeviceConnect;
@end
@interface SCDataLostStatusView : UIView
{
    UILabel *lblName;
    UIButton *btnConnect;
}
@property(nonatomic, assign) id<SCDataLostStatusViewProtocol> delegate;
@end
