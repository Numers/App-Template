//
//  SCConnectFailedStatusView.m
//  ShangCheng
//
//  Created by baolicheng on 16/1/28.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import "SCConnectFailedStatusView.h"

@implementation SCConnectFailedStatusView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithWhite:1.0f alpha:0.39f]];
        [self.layer setCornerRadius:frame.size.width / 2];
        [self.layer setMasksToBounds:YES];
        [self inilizeView];
    }
    return self;
}

-(void)inilizeView
{
    UIImageView *imgConnect = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Home_Connect_Image"]];
    [imgConnect sizeToFit];
    [imgConnect setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 - 45)];
    [self addSubview:imgConnect];
    
    lblName = [[UILabel alloc] init];
    [lblName setFont:[UIFont fontWithName:@"HelveticaNeue" size:16.0]];
    [lblName setTextAlignment:NSTextAlignmentCenter];
    [lblName setTextColor:[UIColor colorWithRed:0.000 green:0.490 blue:0.655 alpha:1.000]];
    [lblName setText:@"未连接设备"];
    [lblName sizeToFit];
    [lblName setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)];
    [self addSubview:lblName];
    
    btnConnect = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 106, 40)];
    [btnConnect setBackgroundColor:[UIColor colorWithRed:0.494 green:0.827 blue:0.129 alpha:1.000]];
    [btnConnect setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 + 50.0f)];
    [btnConnect.layer setCornerRadius:11.0f];
    [btnConnect.layer setMasksToBounds:YES];
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"刷新连接" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:17.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [btnConnect setAttributedTitle:title forState:UIControlStateNormal];
    [btnConnect addTarget:self action:@selector(clickConnectBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnConnect];
}

-(void)clickConnectBtn
{
    if ([self.delegate respondsToSelector:@selector(reconnect)]) {
        [self.delegate reconnect];
    }
}
@end
