//
//  SCHomeContainerView.m
//  ShangCheng
//
//  Created by baolicheng on 16/1/22.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import "SCHomeContainerView.h"
#import "Whether.h"
#import "Location.h"

@implementation SCHomeContainerView
-(void)initlizeView
{
    self.breathCircleView.delegate = self;
    [self.breathCircleView inilizeView];
}

-(void)startLoadingData
{
    [self.breathCircleView beginLoading];
}

-(void)setWhetherIndex:(Whether *)whether
{
    [self.lblCity setText:whether.location.cityName];
    [self.lblAQIIndex setText:[NSString stringWithFormat:@"AQI：%@",whether.indexAQI]];
    [self.lblPM10Index setText:[NSString stringWithFormat:@"PM10：%@",whether.indexPM10]];
    [self.lblCOIndex setText:[NSString stringWithFormat:@"CO：%@",whether.indexCO]];
    [self.lblSO2Index setText:[NSString stringWithFormat:@"SO2：%@",whether.indexSO2]];
    [self.lblNO2Index setText:[NSString stringWithFormat:@"NO2：%@",whether.indexNO2]];
    [self.lblO3Index setText:[NSString stringWithFormat:@"O3：%@",whether.indexO3]];
}

-(void)endLoadingWithData:(float)pmValue WithFormaldeHyde:(float)formaldeHyde
{
    [self.breathCircleView endLoading];
    [self.breathCircleView setupViewWithPmValue:pmValue WithFormaldeHyde:formaldeHyde];
}

-(void)endLoadingWithFailedType:(ConnectFailedType)type
{
    [self.breathCircleView endLoading];
    [self.breathCircleView setupViewWithFaildType:type];
}

#pragma -mark SCBreathCircleViewProtocol
-(void)goBuyView
{
    if ([self.delegate respondsToSelector:@selector(goBuyView)]) {
        [self.delegate goBuyView];
    }
}

-(void)goBindView
{
    if ([self.delegate respondsToSelector:@selector(goBindView)]) {
        [self.delegate goBindView];
    }
}

-(void)reConnect
{
    if ([self.delegate respondsToSelector:@selector(reConnect)]) {
        [self.delegate reConnect];
    }
}
@end
