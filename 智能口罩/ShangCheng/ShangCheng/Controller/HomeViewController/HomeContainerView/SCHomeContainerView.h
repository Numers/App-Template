//
//  SCHomeContainerView.h
//  ShangCheng
//
//  Created by baolicheng on 16/1/22.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCBreathCircleView.h"
@protocol SCHomeContainerViewProtocol <NSObject>
-(void)goBuyView;
-(void)goBindView;
-(void)reConnect;
@end
@class SCBreathCircleView,Whether;
@interface SCHomeContainerView : UIView<SCBreathCircleViewProtocol>
@property(nonatomic, strong) IBOutlet SCBreathCircleView *breathCircleView;
@property(nonatomic, strong) IBOutlet UILabel *lblCity;
@property(nonatomic, strong) IBOutlet UILabel *lblAQIIndex;
@property(nonatomic, strong) IBOutlet UILabel *lblPM10Index;
@property(nonatomic, strong) IBOutlet UILabel *lblCOIndex;
@property(nonatomic, strong) IBOutlet UILabel *lblSO2Index;
@property(nonatomic, strong) IBOutlet UILabel *lblNO2Index;
@property(nonatomic, strong) IBOutlet UILabel *lblO3Index;
@property(nonatomic, assign) id<SCHomeContainerViewProtocol> delegate;
-(void)initlizeView;
-(void)startLoadingData;
-(void)setWhetherIndex:(Whether *)whether;
-(void)endLoadingWithData:(float)pmValue WithFormaldeHyde:(float)formaldeHyde;
-(void)endLoadingWithFailedType:(ConnectFailedType)type;
@end
