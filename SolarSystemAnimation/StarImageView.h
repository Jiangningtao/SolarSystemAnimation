//
//  StarImageView.h
//  SolarSystemAnimation
//
//  Created by 姜宁桃 on 2017/5/6.
//  Copyright © 2017年 姜宁桃. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarImageView : UIImageView

// 初始化星星
+ (instancetype)starImageView;

// 给星星添加动画
- (void)starAnimationWithStar:(StarImageView *)star originalScaleSx:(CGFloat)sx originalDelay:(CGFloat)od finalScaleFx:(CGFloat)fx finalDelay:(CGFloat)fd;

@end
