//
//  UIBasicAnimationDemoController.m
//  StudyObjc
//
//  Created by gtc on 2021/10/22.
//  Copyright © 2021 gtc. All rights reserved.
//

#import "UIBasicAnimationDemoController.h"

@interface UIBasicAnimationDemoController ()

@property (nonatomic, strong) UIView *moveView;

@end

@implementation UIBasicAnimationDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"GCD 测试" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 150, 50);
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 4;
    btn.layer.borderColor = UIColor.redColor.CGColor;
    btn.layer.borderWidth = 1;
    [btn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    
    self.moveView = UIView.new;
    self.moveView.frame = CGRectMake(0, 200, 50, 50);
    self.moveView.backgroundColor = UIColor.redColor;
    [self.view addSubview:self.moveView];
}

- (void)test:(id)sender {
    // 旋转+平移（CABasicAnimation 方式）
    CABasicAnimation *transAnimaion = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    transAnimaion.repeatCount = LONG_MAX;
    transAnimaion.duration = 2;
    transAnimaion.removedOnCompletion = NO;
    transAnimaion.fillMode = kCAFillModeForwards;
    transAnimaion.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    [self.moveView.layer addAnimation:transAnimaion forKey:@"modd"];

    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(25, 225)];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 225)];
    moveAnimation.duration = 2;
    moveAnimation.removedOnCompletion = NO;
    moveAnimation.fillMode = kCAFillModeForwards;
    [self.moveView.layer addAnimation:moveAnimation forKey:@"ymove"];
    
    // 旋转+平移（CGAffineTransform 方式）旋转有问题，不是绕着z轴

//    CGAffineTransform transform = CGAffineTransformIdentity;
//    transform = CGAffineTransformRotate(transform, M_PI*0.25);
//    transform = CGAffineTransformTranslate(transform, 200, 0);
//
//    [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
//        self.moveView.transform = transform;
//    } completion:^(BOOL finished) {
//
//    }];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
