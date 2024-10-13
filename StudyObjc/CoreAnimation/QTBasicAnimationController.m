//
//  QTBasicAnimationController.m
//  StudyObjc
//
//  Created by gtc on 2020/5/30.
//  Copyright © 2020 gtc. All rights reserved.
//

#import "QTBasicAnimationController.h"

@interface QTBasicAnimationController ()
@property (nonatomic, strong) UIView *redview;
@end

@implementation QTBasicAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.redview = [[UIView alloc] init];
    self.redview.backgroundColor = [UIColor redColor];
    self.redview.layer.anchorPoint = CGPointMake(0, 0);
    self.redview.frame = CGRectMake(100, 100, 100, 100);
    
    // scale
//     [self scale];
    [self scaleFixAnchorPoint];
}

- (void)scaleFixAnchorPoint {
    [self.view addSubview:self.redview];
    UIView *bView = [[UIView alloc] init];
    bView.backgroundColor = [UIColor blueColor];
    [self.redview addSubview:bView];
    NSLog(@"redview frame %@", [NSValue valueWithCGRect:self.redview.frame]);
    [UIView animateWithDuration:0.35 animations:^{
        self.redview.transform = CGAffineTransformMakeScale(2, 2);
    }];
    bView.frame = CGRectMake(0, 0, 50, 50);
    
//    self.redview.transform = CGAffineTransformMakeScale(2, 2);
    NSLog(@"redview frame %@", [NSValue valueWithCGRect:self.redview.frame]);
    //redview bounds NSRect: {{0, 0}, {100, 100}}, 缩放不会改变他的bounds
    NSLog(@"redview bounds %@", [NSValue valueWithCGRect:self.redview.bounds]);
    
    //bView frame NSRect: {{0, 0}, {50, 50}}, 父视图缩放不影响子视图的改变
    NSLog(@"bView frame %@", [NSValue valueWithCGRect:bView.frame]);
    NSLog(@"bView bounds %@", [NSValue valueWithCGRect:bView.bounds]);
    
}

- (void)scale {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = [NSNumber numberWithFloat:0.5];
    animation.toValue = [NSNumber numberWithFloat:1.0];
    animation.duration = 1.0;
    animation.autoreverses = YES;
    animation.repeatCount = 10;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.redview.layer addAnimation:animation forKey:@"zoom"];
}

@end
