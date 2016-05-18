//
//  SCBindUncompleteStatusView.m
//  ShangCheng
//
//  Created by baolicheng on 16/1/28.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import "SCBindUncompleteStatusView.h"

@implementation SCBindUncompleteStatusView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithWhite:1.0f alpha:0.39f]];
        [self.layer setCornerRadius:frame.size.width / 2];
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
    [lblName setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [lblName setTextAlignment:NSTextAlignmentCenter];
    [lblName setTextColor:[UIColor colorWithRed:0.000 green:0.490 blue:0.655 alpha:1.000]];
    [lblName setText:@"您还未绑定口罩"];
    [lblName sizeToFit];
    [lblName setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)];
    [self addSubview:lblName];
    
    btnBind = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 73, 27)];
    [btnBind setBackgroundColor:[UIColor colorWithRed:0.494 green:0.827 blue:0.129 alpha:1.000]];
    [btnBind setCenter:CGPointMake(self.frame.size.width / 2 - 42, self.frame.size.height / 2 + 50.0f)];
    [btnBind.layer setCornerRadius:6.0f];
    [btnBind.layer setMasksToBounds:YES];
    NSAttributedString *bindTitle = [[NSAttributedString alloc] initWithString:@"去绑定" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:16.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [btnBind setAttributedTitle:bindTitle forState:UIControlStateNormal];
    [btnBind addTarget:self action:@selector(clickGoBindBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnBind];
    
    btnBuy = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 73, 27)];
    [btnBuy setBackgroundColor:[UIColor colorWithRed:0.494 green:0.827 blue:0.129 alpha:1.000]];
    [btnBuy setCenter:CGPointMake(self.frame.size.width / 2 + 42, self.frame.size.height / 2 + 50.0f)];
    [btnBuy.layer setCornerRadius:6.0f];
    [btnBuy.layer setMasksToBounds:YES];
    NSAttributedString *buyTitle = [[NSAttributedString alloc] initWithString:@"去购买" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:16.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [btnBuy setAttributedTitle:buyTitle forState:UIControlStateNormal];
    [btnBuy addTarget:self action:@selector(clickGoBuyBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnBuy];
}

-(void)clickGoBindBtn
{
    if ([self.delegate respondsToSelector:@selector(goBind)]) {
        [self.delegate goBind];
    }
}

-(void)clickGoBuyBtn
{
    if ([self.delegate respondsToSelector:@selector(goBuy)]) {
        [self.delegate goBuy];
    }
}
@end
