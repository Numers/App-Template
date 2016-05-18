//
//  SCAuraView.h
//  ShangCheng
//
//  Created by baolicheng on 16/1/21.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCAuraView : UIView
@property(nonatomic) UIColor *strokeColor;
@property(nonatomic) CGFloat lineWidth;
@property(nonatomic) CGFloat startAngle;
@property(nonatomic) CGFloat endAngle;

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated;
-(void)beginGenerateView;
-(void)startRotation;
-(void)stopRotation;
@end
