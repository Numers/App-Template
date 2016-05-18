//
//  SCConnectSuccessStatusView.m
//  ShangCheng
//
//  Created by baolicheng on 16/1/28.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import "SCConnectSuccessStatusView.h"
#define AirQualityLabelTopToCenter 15.0f
#define PMValueLabelBottomToCenter 10.0f
@implementation SCConnectSuccessStatusView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self initLable];
    }
    return self;
}

-(void)initLable
{
    lblPmValue = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
    [lblPmValue setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 - PMValueLabelBottomToCenter - 20)];
    [lblPmValue setFont:[UIFont boldSystemFontOfSize:50.0f]];
    [lblPmValue setTextAlignment:NSTextAlignmentCenter];
    [lblPmValue setTextColor:[UIColor whiteColor]];
    [lblPmValue setText:@"0"];
    [self addSubview:lblPmValue];
    
    UILabel *lblUnitName = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2+45, self.frame.size.height / 2 - PMValueLabelBottomToCenter - 20, 44, 20)];
    [lblUnitName setTextAlignment:NSTextAlignmentCenter];
    [lblUnitName setFont:[UIFont boldSystemFontOfSize:10.0f]];
    [lblUnitName setTextColor:[UIColor whiteColor]];
    [lblUnitName setText:@"ug/m3"];
    [self addSubview:lblUnitName];
    
    lblFormaldeHyde = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2+45, self.frame.size.height / 2 - PMValueLabelBottomToCenter - 35, 44, 20)];
    [lblFormaldeHyde setTextAlignment:NSTextAlignmentCenter];
    [lblFormaldeHyde setFont:[UIFont boldSystemFontOfSize:10.0f]];
    [lblFormaldeHyde setTextColor:[UIColor whiteColor]];
    [lblFormaldeHyde setText:@"甲醛：35"];
    [self addSubview:lblFormaldeHyde];
    
    lblName = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 70, self.frame.size.height/2 + AirQualityLabelTopToCenter + 9, 70, 18)];
    [lblName setFont:[UIFont boldSystemFontOfSize:28.0f]];
    [lblName setTextAlignment:NSTextAlignmentCenter];
    [lblName setTextColor:[UIColor whiteColor]];
    [lblName setText:@"口罩"];
    [self addSubview:lblName];
    
    lblAirQuality = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2, self.frame.size.height/2 + AirQualityLabelTopToCenter, 60, 18)];
    [lblAirQuality setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [lblAirQuality setTextAlignment:NSTextAlignmentCenter];
    [lblAirQuality setTextColor:[UIColor blueColor]];
    [lblAirQuality setBackgroundColor:[UIColor yellowColor]];
    [lblAirQuality.layer setCornerRadius:5.0f];
    [lblAirQuality.layer setMasksToBounds:YES];
    [lblAirQuality setText:@"轻度污染"];
    [self addSubview:lblAirQuality];
    
    lblDescription = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2, self.frame.size.height/2 + AirQualityLabelTopToCenter + 18, 88, 18)];
    [lblDescription setFont:[UIFont boldSystemFontOfSize:10.0f]];
    [lblDescription setTextAlignment:NSTextAlignmentLeft];
    [lblDescription setTextColor:[UIColor whiteColor]];
    [lblDescription setText:@"实时PM2.5指数"];
    [self addSubview:lblDescription];
}

-(AirLeavel)airLeavelWithPmValue:(float)pmValue
{
    if (pmValue > 0 && pmValue < 35) {
        return Clear;
    }
    
    if (pmValue < 75) {
        return Nice;
    }
    
    if (pmValue < 115) {
        return Good;
    }
    
    if (pmValue < 150) {
        return LittlePollution;
    }
    
    if (pmValue < 250) {
        return MiddlePollution;
    }
    
    if (pmValue < 500) {
        return HeavyPollution;
    }
    
    if (pmValue >= 500) {
        return BadPollution;
    }
    return Clear;
}
-(void)setupViewWithPmValue:(float)pmValue WithFormaldeHyde:(float)formaldeHyde
{
    if (pmValue > 500.0f) {
        [lblPmValue setFont:[UIFont systemFontOfSize:40.0f]];
        [lblPmValue setText:@"500+"];
    }else{
        [lblPmValue setFont:[UIFont systemFontOfSize:45.0f]];
        [lblPmValue setText:[NSString stringWithFormat:@"%.0lf",pmValue]];
    }
    [lblPmValue sizeToFit];
    [lblPmValue setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 - PMValueLabelBottomToCenter - 20)];
    
    [lblFormaldeHyde setText:[NSString stringWithFormat:@"甲醛：%.0lf",formaldeHyde]];
    
    AirLeavel leavel = [self airLeavelWithPmValue:pmValue];
    switch (leavel) {
        case Clear:
        {
            [lblAirQuality setText:@"空气纯净"];
            [lblAirQuality setTextColor:[UIColor colorWithRed:0.000 green:0.722 blue:0.933 alpha:1.000]];
            [lblAirQuality setBackgroundColor:[UIColor whiteColor]];
        }
            break;
        case Nice:
        {
            [lblAirQuality setText:@"空气优良"];
            [lblAirQuality setTextColor:[UIColor whiteColor]];
            [lblAirQuality setBackgroundColor:[UIColor colorWithRed:0.314 green:0.890 blue:0.761 alpha:1.000]];
        }
            break;
        case Good:
        {
            [lblAirQuality setText:@"空气良好"];
            [lblAirQuality setTextColor:[UIColor whiteColor]];
            [lblAirQuality setBackgroundColor:[UIColor colorWithRed:0.494 green:0.827 blue:0.129 alpha:1.000]];
        }
            break;
        case LittlePollution:
        {
            [lblAirQuality setText:@"轻度污染"];
            [lblAirQuality setTextColor:[UIColor colorWithRed:0.031 green:0.169 blue:0.290 alpha:1.000]];
            [lblAirQuality setBackgroundColor:[UIColor colorWithRed:0.992 green:0.816 blue:0.200 alpha:1.000]];
        }
            break;
        case MiddlePollution:
        {
            [lblAirQuality setText:@"中度污染"];
            [lblAirQuality setTextColor:[UIColor whiteColor]];
            [lblAirQuality setBackgroundColor:[UIColor colorWithRed:0.969 green:0.455 blue:0.031 alpha:1.000]];
        }
            break;
        case HeavyPollution:
        {
            [lblAirQuality setText:@"重度污染"];
            [lblAirQuality setTextColor:[UIColor whiteColor]];
            [lblAirQuality setBackgroundColor:[UIColor colorWithRed:0.969 green:0.118 blue:0.031 alpha:1.000]];
        }
            break;
        case BadPollution:
        {
            [lblAirQuality setText:@"严重污染"];
            [lblAirQuality setTextColor:[UIColor whiteColor]];
            [lblAirQuality setBackgroundColor:[UIColor colorWithRed:0.765 green:0.004 blue:0.592 alpha:1.000]];
        }
            break;
        default:
            break;
    }
}
@end
