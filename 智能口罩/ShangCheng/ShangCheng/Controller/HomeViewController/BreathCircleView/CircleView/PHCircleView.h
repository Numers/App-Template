//
//  PHCircleView.h
//  PocketHealth
//
//  Created by macmini on 15-1-22.
//  Copyright (c) 2015年 YiLiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CircleView;
@protocol PHCircleViewDelegate <NSObject>
@optional
-(void)clickCircleView:(id)sender;

@end
@interface PHCircleView : UIView
{
    CircleView *backCircleView;
    CircleView *frontCircleView;
    UIColor *strokeColor;
    float _lineWith;
}

@property(nonatomic, weak)  id<PHCircleViewDelegate> delegate;
-(void)inilizedView;

-(void)setBackCircleView;

-(void)setLineWidth:(float)lineWidth;

-(void)setBackCircleViewStrokeColor:(UIColor *)color;

-(void)setStrokeColor:(UIColor *)color;

-(void)setProgress:(CGFloat)progress WithAnimate:(BOOL)animate;
@end
