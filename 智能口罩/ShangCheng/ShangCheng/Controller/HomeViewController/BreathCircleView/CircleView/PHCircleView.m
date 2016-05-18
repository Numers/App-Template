//
//  PHCircleView.m
//  PocketHealth
//
//  Created by macmini on 15-1-22.
//  Copyright (c) 2015年 YiLiao. All rights reserved.
//

#import "PHCircleView.h"
#import "CircleView.h"
#define DefaultStrokeColor [UIColor grayColor]
#define DefaultLineWidth 8.0f

@implementation PHCircleView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        _lineWith = DefaultLineWidth;
    }
    return self;
}

-(void)inilizedView
{
    [self setBackCircleView];
    UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleClick)];
    [self addGestureRecognizer:singleRecognizer];
}

-(void)singleClick
{
    if ([_delegate respondsToSelector:@selector(clickCircleView:)]) {
        [_delegate clickCircleView:self];
    }
}


-(void)setBackCircleView
{
    backCircleView = [[CircleView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [backCircleView setLineWidth:_lineWith];
    [backCircleView beginGenerateView];
    [self addSubview:backCircleView];
    [backCircleView setStrokeEnd:1.0f animated:NO];
}

-(void)setLineWidth:(float)lineWidth
{
    _lineWith = lineWidth;
}

-(void)setBackCircleViewStrokeColor:(UIColor *)color
{
    [backCircleView setStrokeColor:color];
}

-(void)setStrokeColor:(UIColor *)color
{
    strokeColor = color;
}

-(void)setProgress:(CGFloat)progress WithAnimate:(BOOL)animate
{
    if (frontCircleView != nil) {
        [frontCircleView removeFromSuperview];
        frontCircleView = nil;
    }
    frontCircleView = [[CircleView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [frontCircleView setBackgroundColor:[UIColor clearColor]];
    if (strokeColor == nil) {
        strokeColor = DefaultStrokeColor;
    }
    [frontCircleView setStrokeColor:strokeColor];
    [frontCircleView setLineWidth:_lineWith];
    [frontCircleView beginGenerateView];
    [self addSubview:frontCircleView];
    [frontCircleView setStrokeEnd:progress/100.0f animated:animate];
}

@end
