//
//  SCAuraView.m
//  ShangCheng
//
//  Created by baolicheng on 16/1/21.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import "SCAuraView.h"
#import <POP/POP.h>
#define RotationDuration 0.6f
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define DefaultStrokeColor [UIColor colorWithRed:1.000 green:0.683 blue:0.159 alpha:1.000]
@interface SCAuraView()
@property(nonatomic,strong) CAShapeLayer *circleLayer;
@property(nonatomic,strong) CAShapeLayer *backCircleLayer;
- (void)addCircleLayer;
- (void)animateToStrokeEnd:(CGFloat)strokeEnd;
@end
@implementation SCAuraView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSAssert(frame.size.width == frame.size.height, @"A circle must have the same height and width.");
        _startAngle = 83;
        _endAngle = 98;
        _lineWidth = 3.f;
        _strokeColor = DefaultStrokeColor;
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

-(void)beginGenerateView
{
    [self addCircleLayer];
}

-(void)startRotation
{
    [self setHidden:NO];
    [self.backCircleLayer setHidden:YES];
    [self.circleLayer setHidden:NO];
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = RotationDuration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 2.0f;
    rotationAnimation.delegate = self;
    
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.circleLayer setHidden:YES];
    [self.backCircleLayer setHidden:NO];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^(void){
        [self startRotation];
    });
}

-(void)stopRotation
{
    if (_circleLayer) {
        [_circleLayer removeFromSuperlayer];
        _circleLayer = nil;
    }
    
    if (_backCircleLayer) {
        [_backCircleLayer removeFromSuperlayer];
        _backCircleLayer = nil;
    }
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}
#pragma mark - Instance Methods

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated
{
    if (animated) {
        [self animateToStrokeEnd:strokeEnd];
        return;
    }
    [self.circleLayer setStrokeEnd:strokeEnd];
}

#pragma mark - Property Setters

- (void)setStrokeColor:(UIColor *)strokeColor
{
    _strokeColor = strokeColor;
    [self setNeedsDisplay];
}

#pragma mark - Private Instance methods

- (void)addCircleLayer
{
    CGFloat radius = CGRectGetWidth(self.frame)/2 - _lineWidth/2;
    self.circleLayer = [CAShapeLayer layer];
    self.circleLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:radius startAngle:DEGREES_TO_RADIANS(_startAngle) endAngle:DEGREES_TO_RADIANS(_endAngle) clockwise:YES].CGPath;
    self.circleLayer.lineWidth = _lineWidth;
    self.circleLayer.strokeColor = _strokeColor.CGColor;
    self.circleLayer.fillColor = nil;
    self.circleLayer.lineCap = kCALineCapRound;
    self.circleLayer.lineJoin = kCALineJoinRound;
    [self.circleLayer setHidden:YES];
    
    [self.layer addSublayer:self.circleLayer];
    
    self.backCircleLayer = [CAShapeLayer layer];
    self.backCircleLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:radius startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(360) clockwise:YES].CGPath;
    self.backCircleLayer.lineWidth = _lineWidth;
    self.backCircleLayer.strokeColor = _strokeColor.CGColor;
    self.backCircleLayer.fillColor = nil;
    self.backCircleLayer.lineCap = kCALineCapRound;
    self.backCircleLayer.lineJoin = kCALineJoinRound;
    [self.backCircleLayer setHidden:YES];
    [self.layer insertSublayer:self.backCircleLayer below:self.circleLayer];
    [self.backCircleLayer setStrokeEnd:1.0f];
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
    strokeAnimation.springBounciness = 12.f;
    strokeAnimation.removedOnCompletion = NO;
    [self.circleLayer pop_addAnimation:strokeAnimation forKey:@"layerStrokeAnimation"];
}

-(void)drawRect:(CGRect)rect
{
    self.circleLayer.strokeColor = _strokeColor.CGColor;
}
@end
