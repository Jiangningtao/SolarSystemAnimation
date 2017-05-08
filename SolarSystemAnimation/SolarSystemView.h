//
//  SolarSystemView.h
//  SolarSystemAnimation
//
//  Created by 姜宁桃 on 2017/5/6.
//  Copyright © 2017年 姜宁桃. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SolarSystemView : UIView

+ (instancetype)solarSystemView;


/*
    * 给太阳系添加公转动画
        x : 中心点x坐标
        y : 中心点y坐标
        radius : 半径
        duration : 持续时间
        count : 持续次数
 */
- (void)addRevolutionAnimationWithX:(CGFloat)x Y:(CGFloat)y Radius:(NSInteger)radius duration:(NSInteger)duration Count:(NSInteger)count;

// 添加公转动画
- (void)startRevolutionAnimation;
// 移除公转动画
- (void)removeRovolutionAnimation;

@end
