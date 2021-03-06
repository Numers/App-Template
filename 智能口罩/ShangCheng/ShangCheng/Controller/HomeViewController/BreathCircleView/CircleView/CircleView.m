//
//  CircleView.m
//  Popping
//
//  Created by André Schneider on 21.05.14.
//  Copyright (c) 2014 André Schneider. All rights reserved.
//

#import "CircleView.h"
#import <POP/POP.h>
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define DefaultStrokeColor [UIColor colorWithWhite:0.498 alpha:0.700]

@interface CircleView()
@property(nonatomic) CAShapeLayer *circleLayer;
- (void)addCircleLayer;
- (void)animateToStrokeEnd:(CGFloat)strokeEnd;
@end

@implementation CircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSAssert(frame.size.width == frame.size.height, @"A circle must have the same height and width.");
        _startAngle = 117;
        _endAngle = 423;
        _lineWidth = 3.f;
        _strokeColor = DefaultStrokeColor;
    }
    return self;
}

-(void)beginGenerateView
{
    [self addCircleLayer];
}

#pragma mark - Instance Methods

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated
{
    if (animated) {
        [self animateToStrokeEnd:strokeEnd];
        return;
    }
    self.circleLayer.strokeEnd = strokeEnd;
}

#pragma mark - Property Setters

- (void)setStrokeColor:(UIColor *)strokeColor
{
    self.circleLayer.strokeColor = strokeColor.CGColor;
    _strokeColor = strokeColor;
}

#pragma mark - Private Instance methods

- (void)addCircleLayer
{
    CGFloat radius = CGRectGetWidth(self.bounds)/2 - _lineWidth/2;
    self.circleLayer = [CAShapeLayer layer];
    self.circleLayer.path = [UIBezierPath bezierPathWithArcCenter:self.center radius:radius startAngle:DEGREES_TO_RADIANS(_startAngle) endAngle:DEGREES_TO_RADIANS(_endAngle) clockwise:YES].CGPath;
    self.circleLayer.lineWidth = _lineWidth;
    self.circleLayer.strokeColor = _strokeColor.CGColor;
    self.circleLayer.fillColor = nil;
    self.circleLayer.lineCap = kCALineCapRound;
    self.circleLayer.lineJoin = kCALineJoinRound;

    [self.layer addSublayer:self.circleLayer];
}

-(void)setLineWidth:(CGFloat)lineWidth
{
    self.circleLayer.lineWidth = lineWidth;
    _lineWidth = lineWidth;
}

- (void)animateToStrokeEnd:(CGFloat)strokeEnd
{
    POPSpringAnimation *strokeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    strokeAnimation.toValue = @(strokeEnd);
//    strokeAnimation.springBounciness = 12.f;
    strokeAnimation.springSpeed = 0.f;
    strokeAnimation.removedOnCompletion = NO;
    [self.circleLayer pop_addAnimation:strokeAnimation forKey:@"layerStrokeAnimation"];
}

@end
