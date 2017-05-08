//
//  SolarSystemView.m
//  SolarSystemAnimation
//
//  Created by 姜宁桃 on 2017/5/6.
//  Copyright © 2017年 姜宁桃. All rights reserved.
//

#import "SolarSystemView.h"

@interface SolarSystemView ()
{
    UIImageView * _earthImageView;
    UIImageView * _moonImageView;
    CAKeyframeAnimation * revolutionAnimation;
}


@end

@implementation SolarSystemView

+ (instancetype)solarSystemView
{
    return [[SolarSystemView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubViews];
    }
    return self;
}

- (void)setSubViews
{
    // 初始化 地球🌍
    _earthImageView = [UIImageView imageViewWithFrame:CGRectMake(30, 30, 60, 60) image:@"earth"];
    [self addSubview:_earthImageView];
    
    // 初始化 月亮🌛
    _moonImageView = [UIImageView imageViewWithFrame:CGRectMake(0, _moonImageView.center.y - 12.5 , 25, 25) image:@"moon"];
    [self addSubview:_moonImageView];
    
    // 地球和月亮的自转
    [self autoRotationAnimation];
    
    // 🌛围绕🌍做公转
    CGMutablePathRef path2 = CGPathCreateMutable();
    CGPathAddArc(path2, NULL, _earthImageView.center.x, _earthImageView.center.y, 50, 0,M_PI * 2, 0);
    CAKeyframeAnimation * animation2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation2.path = path2;
    CGPathRelease(path2);
    animation2.duration = 24;
    animation2.repeatCount = 500;
    animation2.autoreverses = NO;
    animation2.rotationMode =kCAAnimationRotateAuto;
    animation2.fillMode =kCAFillModeForwards;
    [_moonImageView.layer addAnimation:animation2 forKey:@"animation2"];
}

- (void)autoRotationAnimation
{
    // 🌛自转
    CABasicAnimation *animation1 =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation1.fromValue = [NSNumber numberWithFloat:0.f];
    animation1.toValue =  [NSNumber numberWithFloat: M_PI *2];
    animation1.duration  = 60;
    animation1.autoreverses = NO;
    animation1.fillMode =kCAFillModeForwards;
    animation1.repeatCount = 10;
    [_moonImageView.layer addAnimation:animation1 forKey:nil];
    
    // 🌍自转
    CABasicAnimation *animation2 =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation2.fromValue = [NSNumber numberWithFloat:0.f];
    animation2.toValue =  [NSNumber numberWithFloat: M_PI *2];
    animation2.duration  = 24;
    animation2.autoreverses = NO;
    animation2.fillMode =kCAFillModeForwards;
    animation2.repeatCount = 10;
    [_earthImageView.layer addAnimation:animation2 forKey:nil];
}

// solarSystemView公转
- (void)addRevolutionAnimationWithX:(CGFloat)x Y:(CGFloat)y Radius:(NSInteger)radius duration:(NSInteger)duration Count:(NSInteger)count
{
    // 太阳系（🌍和🌛）围绕太阳公转
    CGMutablePathRef path1 = CGPathCreateMutable();
    CGPathAddArc(path1, NULL, x, y, radius, 0,M_PI * 2, 0);
    revolutionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    revolutionAnimation.path = path1;
    CGPathRelease(path1);
    revolutionAnimation.duration = duration;
    revolutionAnimation.repeatCount = count;
    revolutionAnimation.autoreverses = NO;
    revolutionAnimation.rotationMode =kCAAnimationRotateAuto;
    revolutionAnimation.fillMode =kCAFillModeForwards;
}

- (void)startRevolutionAnimation
{
    [self.layer addAnimation:revolutionAnimation forKey:@"revolutonAnimation"];
}

- (void)removeRovolutionAnimation
{
    [self.layer removeAnimationForKey:@"revolutonAnimation"];
}

@end
