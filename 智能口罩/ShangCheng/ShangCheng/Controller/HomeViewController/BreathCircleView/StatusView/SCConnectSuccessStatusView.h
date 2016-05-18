//
//  SCConnectSuccessStatusView.h
//  ShangCheng
//
//  Created by baolicheng on 16/1/28.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    Clear = 1,
    Nice,
    Good,
    LittlePollution,
    MiddlePollution,
    HeavyPollution,
    BadPollution
}AirLeavel;
@interface SCConnectSuccessStatusView : UIView
{
    UILabel *lblPmValue;
    UILabel *lblFormaldeHyde;
    UILabel *lblName;
    UILabel *lblAirQuality;
    UILabel *lblDescription;
}

-(void)setupViewWithPmValue:(float)pmValue WithFormaldeHyde:(float)formaldeHyde;
@end
