//
//  QTBezierPathController.m
//  StudyObjc
//
//  Created by gtc on 2020/8/3.
//  Copyright © 2020 gtc. All rights reserved.
//

#import "QTBezierPathController.h"

@interface QTBezierPathController ()

@property (nonatomic, strong) UIView *bgView;
@end

@implementation QTBezierPathController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(20, 64, 80, 80)];
    _bgView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_bgView];
    self.view.backgroundColor = [UIColor blackColor];
    [self drawOneBezierPath];
    
}

- (void)drawOneBezierPath {
    // 请画出一条开始和结束比较慢，中间比较快的贝塞尔曲线(即UIViewAnimationOptionCurveEaseInOut)。另外能否画出一条有弹性效果的曲线？
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    [bezier moveToPoint:CGPointMake(100, 200)];
    [bezier addLineToPoint:CGPointMake(200, 200)];
    
    [bezier moveToPoint:CGPointMake(300, 200)];
    [bezier addLineToPoint:CGPointMake(400, 200)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = 15.f;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.borderWidth = 5.f;
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.path = bezier.CGPath;
//    layer.shadowColor = [UIColor whitment
    [self.view.layer addSublayer:layer];
    
    
}

- (void)drawProgressBar {
    CAShapeLayer *outLayer = [CAShapeLayer layer];
    outLayer.frame = _bgView.bounds;
    outLayer.backgroundColor = [UIColor yellowColor].CGColor;
    outLayer.strokeColor = [UIColor redColor].CGColor;
    outLayer.lineWidth = 5.f;
    outLayer.fillColor = [UIColor greenColor].CGColor;
    outLayer.lineJoin = kCALineJoinRound;
    outLayer.lineCap = kCALineCapRound;
    //    outLayer.strokeEnd = 1.0;
    //    outLayer.strokeStart = 0.0;
    //    outLayer.path = [UIBezierPath bezierPathWithRoundedRect:_bgView.frame cornerRadius:_bgView.frame.size.width/2.f].CGPath;
    
    CGFloat radius = _bgView.frame.size.width/2.f;
    //    CGFloat startAngle = -M_PI_2;
    //    CGFloat endAngle = (M_PI_2 + M_PI);
    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle = (M_PI_2 + M_PI);
    
    CGPoint center = CGPointMake(radius, radius);
    outLayer.path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES].CGPath;
    
    [_bgView.layer addSublayer:outLayer];
    
    CABasicAnimation *baseAni = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    baseAni.fromValue = @0.f;
    baseAni.toValue = @1.f;
    baseAni.duration = 1.5f;
    baseAni.removedOnCompletion = NO;
    baseAni.fillMode = kCAFillModeForwards;
    baseAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [outLayer addAnimation:baseAni forKey:@"strokeEndAnimation"];
}



@end
