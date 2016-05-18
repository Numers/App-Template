//
//  SCBreathCircleView.m
//  ShangCheng
//
//  Created by baolicheng on 16/1/21.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import "SCBreathCircleView.h"
#import "PHCircleView.h"
#import "SCAuraView.h"
#import "SCConnectFailedStatusView.h"
#import "SCConnectSuccessStatusView.h"
#import "SCBindUncompleteStatusView.h"
#import "SCDataLostStatusView.h"
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define BreathViewWidth (UIScreenMainFrame.size.width - 14.0f)
#define BreathViewHeight (UIScreenMainFrame.size.width - 14.0f)
@interface SCBreathCircleView()<SCBingUncompleteStatusViewProtocol,SCConnectFailedStatusViewProtocol,SCDataLostStatusViewProtocol>
@end
@implementation SCBreathCircleView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(void)inilizeView
{
    pmDescArr = @[@"0\n纯净",@"35\n优良",@"75\n良好",@"115\n轻污",@"150\n中污",@"250\n重污",@"500\n严污"];
    angleArr = @[@243,@192,@141,@90,@39,@(-12),@(-63)];
    
    NSLog(@"%lf,%lf",self.frame.size.width,self.frame.size.height);
    breathView = [[SCBreathView alloc] initWithFrame:CGRectMake(0, 0, BreathViewWidth, BreathViewHeight)];
    [breathView setLineWidth:6.0f];
    [breathView setIntervalWidth:2.0f];
    [breathView generateView];
    [self addSubview:breathView];

    float insideRadius = [breathView returnInsideCircleRadius];
    circleView = [[PHCircleView alloc] initWithFrame:CGRectMake(0, 0, insideRadius * 2 - 8, insideRadius * 2 - 8)];
    [circleView setCenter:CGPointMake(BreathViewWidth / 2, BreathViewHeight/2)];
    [circleView setLineWidth:6.0f];
    [circleView inilizedView];
    [circleView setStrokeColor:[UIColor colorWithRed:1.000 green:0.683 blue:0.159 alpha:1.000]];
    [self insertSubview:circleView aboveSubview:breathView];
    [circleView setHidden:YES];

    [self initDescriptionLable];
}

-(void)removeAllStatusView
{
    if (connectFailedView) {
        [connectFailedView removeFromSuperview];
        connectFailedView = nil;
    }
    
    if (connectSuccessView) {
        [connectSuccessView removeFromSuperview];
        connectSuccessView = nil;
    }
    
    if (bindUncompleteView) {
        [bindUncompleteView removeFromSuperview];
        bindUncompleteView = nil;
    }
    
    if (dataLostView) {
        [dataLostView removeFromSuperview];
        dataLostView = nil;
    }
}

-(void)setupViewWithFaildType:(ConnectFailedType)type
{
    [self removeAllStatusView];
    if (![circleView isHidden]) {
        [circleView setHidden:YES];
    }
    
    if (breathView) {
        [breathView stopAnimate];
    }
//    [self setProgress:0.0f WithAnimate:NO];
    float insideRadius = [breathView returnInsideCircleRadius];
    switch (type) {
        case UnConnected:
        {
            connectFailedView = [[SCConnectFailedStatusView alloc] initWithFrame:CGRectMake(0, 0, insideRadius * 2, insideRadius * 2)];
            [connectFailedView setCenter:CGPointMake(BreathViewWidth/2, BreathViewHeight/2)];
            connectFailedView.delegate = self;
            [self insertSubview:connectFailedView belowSubview:circleView];
        }
            break;
        case UnBindDevice:
        {
            bindUncompleteView = [[SCBindUncompleteStatusView alloc] initWithFrame:CGRectMake(0, 0, insideRadius * 2, insideRadius * 2)];
            [bindUncompleteView setCenter:CGPointMake(BreathViewWidth/2, BreathViewHeight/2)];
            bindUncompleteView.delegate = self;
            [self insertSubview:bindUncompleteView belowSubview:circleView];
        }
            break;
        case NoDataDevice:
        {
            dataLostView = [[SCDataLostStatusView alloc] initWithFrame:CGRectMake(0, 0, insideRadius * 2, insideRadius * 2)];
            [dataLostView setCenter:CGPointMake(BreathViewWidth/2, BreathViewHeight/2)];
            dataLostView.delegate = self;
            [self insertSubview:dataLostView belowSubview:circleView];
        }
            break;
        default:
            break;
    }
}

-(void)setupViewWithPmValue:(float)pmValue WithFormaldeHyde:(float)formaldeHyde
{
    if (connectFailedView) {
        [connectFailedView removeFromSuperview];
        connectFailedView = nil;
    }
    
    if (bindUncompleteView) {
        [bindUncompleteView removeFromSuperview];
        bindUncompleteView = nil;
    }
    
    if (dataLostView) {
        [dataLostView removeFromSuperview];
        dataLostView = nil;
    }
    
    if (!connectSuccessView) {
        float insideRadius = [breathView returnInsideCircleRadius];
        connectSuccessView = [[SCConnectSuccessStatusView alloc] initWithFrame:CGRectMake(0, 0, insideRadius * 2, insideRadius * 2)];
        [connectSuccessView setCenter:CGPointMake(BreathViewWidth/2, BreathViewHeight/2)];
        [self insertSubview:connectSuccessView belowSubview:circleView];
    }
    [connectSuccessView setupViewWithPmValue:pmValue WithFormaldeHyde:formaldeHyde];
    float progress = [self calculatePmValue:pmValue];
    [self setProgress:progress WithAnimate:NO];
}

-(float)calculatePmValue:(float)pmValue
{
    float value = 0.0f;
    if (pmValue < 0) {
        value = 0.0f;
    }
    
    if (pmValue >=0 && pmValue < 35) {
        value = pmValue * 16.67/35.0f;
    }
    
    if (pmValue >=35 && pmValue < 75) {
        value = (pmValue - 35) * 16.67 / 40.0f + 16.67;
    }
    
    if (pmValue >= 75 && pmValue < 115) {
        value = (pmValue - 75) * 16.67 / 40.0f + 33.33;
    }
    
    if (pmValue >= 115 && pmValue < 150) {
        value = (pmValue - 115) * 16.67 / 35.0f + 50;
    }
    
    if (pmValue >= 150 && pmValue < 250) {
        value = (pmValue - 150) * 16.67 / 100.0f + 66.67;
    }
    
    if (pmValue >= 250 && pmValue < 500) {
        value = (pmValue - 250) * 16.67 / 250.0f + 83.33;
    }
    
    if (pmValue >= 500) {
        value = 100;
    }
    return value;
}

-(void)initDescriptionLable
{
    float insideRadius = [breathView returnInsideCircleRadius] + 17.0f;
    NSInteger i = 0;
    for (NSNumber *angle in angleArr) {
        float deltaY = -insideRadius * sin(DEGREES_TO_RADIANS([angle integerValue]));
        float deltaX = insideRadius * cos(DEGREES_TO_RADIANS([angle integerValue]));
        
        UILabel *lblDesc = [[UILabel alloc] init];
        [lblDesc setNumberOfLines:0];
        [lblDesc setTextAlignment:NSTextAlignmentCenter];
        NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:[pmDescArr objectAtIndex:i] attributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:10.0],NSForegroundColorAttributeName:[UIColor colorWithRed:0.004 green:0.439 blue:0.584 alpha:1.000]}];
        [lblDesc setAttributedText:attributeStr];
        [lblDesc sizeToFit];
        [lblDesc setCenter:CGPointMake(BreathViewWidth / 2 + deltaX, BreathViewHeight / 2 + deltaY)];
        [self insertSubview:lblDesc aboveSubview:breathView];
        i++;
    }
}

-(void)beginLoading
{
    if (breathView) {
        [breathView stopAnimate];
    }
    
    if (auraView) {
        [self endLoading];
    }
    
    if (circleView) {
        [circleView setHidden:YES];
    }
    
    float insideRadius = [breathView returnInsideCircleRadius];
    auraView = [[SCAuraView alloc] initWithFrame:CGRectMake(0, 0, insideRadius * 2 - 8, insideRadius * 2 - 8)];
    [auraView setCenter:CGPointMake(BreathViewWidth / 2, BreathViewHeight/2)];
    [auraView setLineWidth:6.0f];
    [auraView beginGenerateView];
    [auraView setStrokeEnd:1.0f animated:NO];
    [self insertSubview:auraView aboveSubview:circleView];
    [auraView startRotation];
}

-(void)endLoading
{
    if (auraView) {
        [auraView stopRotation];
        auraView = nil;
    }
}

-(void)setProgress:(float)progress WithAnimate:(BOOL)animate
{
    if (circleView) {
        [circleView setHidden:NO];
        [circleView setProgress:progress WithAnimate:animate];
        if (breathView) {
            if (![breathView isAnimateing]) {
                [breathView beginAnimate];
            }
        }
    }
}

#pragma -mark SCBingUncompleteStatusViewProtocol
-(void)goBuy
{
    if ([self.delegate respondsToSelector:@selector(goBuyView)]) {
        [self.delegate goBuyView];
    }
}

-(void)goBind
{
    if ([self.delegate respondsToSelector:@selector(goBindView)]) {
        [self.delegate goBindView];
    }
}

#pragma -mark SCConnectFailedStatusViewProtocol
-(void)reconnect
{
    if ([self.delegate respondsToSelector:@selector(reConnect)]) {
        [self.delegate reConnect];
    }
}

#pragma -mark SCDataLostStatusViewProtocol
-(void)resetDeviceConnect
{
    if ([self.delegate respondsToSelector:@selector(reConnect)]) {
        [self.delegate reConnect];
    }
}
@end
