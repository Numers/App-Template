//
//  SCHeadCircleView.m
//  ShangCheng
//
//  Created by baolicheng on 16/2/3.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import "SCHeadCircleView.h"
#define AnimateDuration 1.5f
@implementation SCHeadCircleView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        circleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:circleImageView];
    }
    return self;
}

-(void)startRotationWithImage:(UIImage *)image WithDirection:(BOOL)isPositive
{
    direction = isPositive;
    if (circleImageView) {
        [circleImageView setImage:image];
        [circleImageView sizeToFit];
        [self startRotation];
    }
}

-(void)startRotation
{
    if (circleImageView) {
        CABasicAnimation *rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        if (direction) {
            rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
        }else{
            rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 * -1];
        }
        rotationAnimation.duration = AnimateDuration;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = 100.f;
        rotationAnimation.delegate = self;
        [circleImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self startRotation];
}
@end
