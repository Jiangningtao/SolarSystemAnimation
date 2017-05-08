//
//  StarImageView.m
//  SolarSystemAnimation
//
//  Created by 姜宁桃 on 2017/5/6.
//  Copyright © 2017年 姜宁桃. All rights reserved.
//

#import "StarImageView.h"

@implementation StarImageView

+ (instancetype)starImageView
{
    return [[StarImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 11)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 给星星✨加上闪烁动画
        self.image = [UIImage imageNamed:@"star1"];
    }
    return self;
}

- (void)starAnimationWithStar:(StarImageView *)star originalScaleSx:(CGFloat)sx originalDelay:(CGFloat)od finalScaleFx:(CGFloat)fx finalDelay:(CGFloat)fd
{
    [UIView animateWithDuration:1 delay:od options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        star.transform = CGAffineTransformMakeScale(sx, sx);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.7 delay:fd options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            star.transform = CGAffineTransformMakeScale(fx, fx);
        } completion:^(BOOL finished) {
        
            [self starAnimationWithStar:star originalScaleSx:sx originalDelay:od finalScaleFx:fx finalDelay:fd];
        }];
    }];
}


@end
