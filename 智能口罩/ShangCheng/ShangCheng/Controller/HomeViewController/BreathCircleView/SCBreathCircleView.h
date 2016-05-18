//
//  SCBreathCircleView.h
//  ShangCheng
//
//  Created by baolicheng on 16/1/21.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import "SCBreathView.h"
typedef enum{
    UnConnected = 1,
    UnBindDevice,
    NoDataDevice
}ConnectFailedType;

@protocol SCBreathCircleViewProtocol <NSObject>

-(void)goBuyView;
-(void)goBindView;
-(void)reConnect;

@end
@class PHCircleView,SCAuraView,SCConnectFailedStatusView,SCBindUncompleteStatusView,SCConnectSuccessStatusView,SCDataLostStatusView;
@interface SCBreathCircleView : UIView
{
    SCBreathView *breathView;
    PHCircleView *circleView;
    SCAuraView *auraView;
    
    SCConnectSuccessStatusView *connectSuccessView;
    SCBindUncompleteStatusView *bindUncompleteView;
    SCConnectFailedStatusView *connectFailedView;
    SCDataLostStatusView *dataLostView;
    
    NSArray *pmDescArr;
    NSArray *angleArr;
}
@property(nonatomic, assign) id<SCBreathCircleViewProtocol> delegate;
-(void)inilizeView;
-(void)beginLoading;
-(void)setupViewWithFaildType:(ConnectFailedType)type;
-(void)setupViewWithPmValue:(float)pmValue WithFormaldeHyde:(float)formaldeHyde;
-(void)endLoading;
@end
