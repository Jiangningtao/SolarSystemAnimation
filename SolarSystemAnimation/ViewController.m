//
//  ViewController.m
//  SolarSystemAnimation
//
//  Created by 姜宁桃 on 2017/5/6.
//  Copyright © 2017年 姜宁桃. All rights reserved.
//

#import "ViewController.h"
#import "SunImageView.h"
#import "SolarSystemView.h"
#import "StarImageView.h"

#define SNOW_IMAGENAME         @"snow"
#define IMAGE_X                arc4random()%(int)screen_width
#define IMAGE_ALPHA            ((float)(arc4random()%10))/10
#define IMAGE_WIDTH            arc4random()%20 + 10
#define PLUS_HEIGHT            screen_height/25

@interface ViewController ()<CAAnimationDelegate>
{
    SunImageView * _sunImageView;
    SolarSystemView * _solarSystemView;
    StarImageView * _starImageView;
    
    UIImageView * _meteor;   //  流星
    UIImageView * _meteor1;    // 流星1
    CGPoint _controlPoint;
    CGPoint _endPoint;
    CGPoint _controlPoint1;
    CGPoint _endPoint1;
}

@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        
        [self prefersStatusBarHidden];
        
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    
    // 下雪动画
    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(makeSnow) userInfo:nil repeats:YES];
}

- (void)configUI
{
    // 初始化🌞
    _sunImageView = [SunImageView sunImageView];
    _sunImageView.center = CGPointMake(80, 80);
    [self.view addSubview:_sunImageView];
    _sunImageView.alpha = 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _sunImageView.alpha = 1;
    } completion:^(BOOL finished) {
        
        // 太阳开始自转
        [_sunImageView startRoatationAnimation];
        
        // 初始化太阳系（即🌍和🌛）
        _solarSystemView = [SolarSystemView solarSystemView];
        _solarSystemView.center = CGPointMake(screen_width/2, screen_height/2-40);
        [self.view addSubview:_solarSystemView];
        _solarSystemView.alpha = 0;
        
        // 显示太阳系
        [UIView animateWithDuration:0.6 animations:^{
            // 添加公转动画
            [_solarSystemView addRevolutionAnimationWithX:_sunImageView.center.x Y:_sunImageView.center.y Radius:140 duration:24 Count:1000];
            [_solarSystemView startRevolutionAnimation];
            
            _solarSystemView.alpha = 1;
        } completion:^(BOOL finished) {
            
           // 初始化✨
            // 中心点的x坐标数组
            NSArray * centerXArr = @[@"150", @"160", @"198", @"205", @"234", @"263", @"290"];
            // 中心点的y坐标数组
            NSArray * centerYArr = @[@"75", @"43", @"40", @"68", @"80", @"98", @"90"];
            // 动画开始时scaleSx， Sy数组
            NSArray * originalSxArr = @[@"0.8", @"1.0", @"0.6", @"1.2", @"1.0", @"0.9", @"1.3"];
            // 动画结束时scaleSx， Sy数组
            NSArray * finalSxArr = @[@"1.2", @"0.6", @"1.2", @"0.35", @"0.4", @"0.3", @"0.6"];
            // 动画开始时延迟
            NSArray * originalDelay = @[@"0.2", @"0.4", @"0.3", @"0.6", @"0.5", @"0.8", @"0.7"];
            // 动画结束时延迟
            NSArray * finalDelay = @[@"0.6", @"0.5", @"0.7", @"0.35", @"0.4", @"0.3", @"0.6"];
            
            for (int i = 0; i < 7; i++) {
                StarImageView * star = [StarImageView starImageView];
                star.center = CGPointMake([centerXArr[i] floatValue], [centerYArr[i] floatValue]);
                [star starAnimationWithStar:star originalScaleSx:[originalSxArr[i] floatValue] originalDelay:[originalDelay[i] floatValue] finalScaleFx:[finalSxArr[i] floatValue] finalDelay:[finalDelay[i] floatValue]];
                [self.view addSubview:star];
            }
        }];
    }];
    
    _meteor = [UIImageView imageViewWithFrame:CGRectMake(-20, 200, 17, 16) image:@"star1"];
    [self.view addSubview:_meteor];
    _controlPoint = CGPointMake(screen_width/2, 100);
    _endPoint = CGPointMake(screen_width+20, 80);
    _meteor1 = [UIImageView imageViewWithFrame:CGRectMake(-20, 250, 12, 11) image:@"star4"];
    [self.view addSubview:_meteor1];
    _controlPoint1 = CGPointMake(screen_width/2-40, 100);
    _endPoint1 = CGPointMake(screen_width+20, 40);
    
    [NSTimer scheduledTimerWithTimeInterval:5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        [self configMeteorMoveAnimation];       // 流星动画
    }];
}


// 流星🌠动画
- (void)configMeteorMoveAnimation
{
    
    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, _meteor.center.x, _meteor.center.y);
        CGPathAddQuadCurveToPoint(path, NULL, _controlPoint.x, _controlPoint.y, _endPoint.x, _endPoint.y);
        CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation.delegate = self;
        animation.duration = 1.5;
        animation.fillMode = kCAFillModeForwards;
        animation.repeatCount = 2;
        animation.path = path;
        animation.removedOnCompletion = NO;
        CGPathRelease(path);
        [_meteor.layer addAnimation:animation forKey:@"meteor"];
    } completion:^(BOOL finished) {
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, _meteor1.center.x, _meteor1.center.y);
        CGPathAddQuadCurveToPoint(path, NULL, _controlPoint1.x, _controlPoint1.y, _endPoint1.x, _endPoint1.y);
        CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation.delegate = self;
        animation.duration = 1;
        animation.fillMode = kCAFillModeForwards;
        animation.repeatCount = 2;
        animation.path = path;
        animation.removedOnCompletion = NO;
        CGPathRelease(path);
        [_meteor1.layer addAnimation:animation forKey:@"meteor"];
    }];
}

// 下雪动画
- (void)makeSnow
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:SNOW_IMAGENAME]];
    float x = IMAGE_WIDTH;
    imageView.frame = CGRectMake(IMAGE_X, -30, x, x);
    imageView.alpha = IMAGE_ALPHA;
    [self.view addSubview:imageView];
    
    [self snowFall:imageView];
    
}

- (void)snowFall:(UIImageView *)aImageView
{
    [UIView beginAnimations:[NSString stringWithFormat:@"%li",(long)aImageView.tag] context:nil];
    [UIView setAnimationDuration:6];
    [UIView setAnimationDelegate:self];
    aImageView.frame = CGRectMake(aImageView.frame.origin.x, screen_height, aImageView.frame.size.width, aImageView.frame.size.height);
    NSLog(@"%@",aImageView);
    [UIView commitAnimations];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 隐藏statusBar
- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}

@end
