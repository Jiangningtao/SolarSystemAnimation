//
//  SunImageView.m
//  SolarSystemAnimation
//
//  Created by 姜宁桃 on 2017/5/6.
//  Copyright © 2017年 姜宁桃. All rights reserved.
//

#import "SunImageView.h"

@interface SunImageView ()
{
    CABasicAnimation *animation;
}

@end

@implementation SunImageView

+ (instancetype)sunImageView
{
    return [[SunImageView alloc] initWithFrame:CGRectMake(0, 0, 108, 108)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"sun"];
        [self autoRoatationAnimation];
    }
    return self;
}

// 自转动画
- (void)autoRoatationAnimation
{
    animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
    animation.duration  = 60;
    animation.autoreverses = NO;
    animation.fillMode =kCAFillModeForwards;
    animation.repeatCount = 1000;
}

// 添加自转动画
- (void)startRoatationAnimation
{
    [self.layer addAnimation:animation forKey:nil];
}

// 移除自转动画
- (void)endRotationAnimation
{
    [self.layer removeAllAnimations];
}

@end
