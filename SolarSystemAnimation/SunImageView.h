//
//  SunImageView.h
//  SolarSystemAnimation
//
//  Created by 姜宁桃 on 2017/5/6.
//  Copyright © 2017年 姜宁桃. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SunImageView : UIImageView

// 初始化一个 sun
+ (instancetype)sunImageView;

// 添加自转动画
- (void)startRoatationAnimation;

// 移除自转动画
- (void)endRotationAnimation;


@end
