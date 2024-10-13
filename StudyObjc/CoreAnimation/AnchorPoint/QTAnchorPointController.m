//
//  QTAnchorPointController.m
//  StudyObjc
//
//  Created by gtc on 2020/9/10.
//  Copyright © 2020 gtc. All rights reserved.
//

#import "QTAnchorPointController.h"

@interface QTAnchorPointController ()
@property (nonatomic, strong) UIView *view1;
@end

@implementation QTAnchorPointController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *view1 = [self createViewWithFrame:CGRectMake(100, 150, 50, 50)];
    [self.view addSubview:view1];
    self.view1 = view1;
    
    UIButton *changeBtn = [self createButtonWithFrame:CGRectMake(280, 150, 80, 45) title:@"anchor" target:self selector:@selector(changeAnchor)];
    [self.view addSubview:changeBtn];
    
    UIButton *transBtn = [self createButtonWithFrame:CGRectMake(280, 200, 80, 45) title:@"transformZ" target:self selector:@selector(transformView)];
    [self.view addSubview:transBtn];
}

- (void)changeAnchor {
    UIView *originView = [self createViewWithFrame:self.view1.frame];
    [self.view addSubview:originView];
    originView.layer.borderWidth = 1.f;
    
    NSLog(@"center = %@, origin = %@ position = %@", [NSValue valueWithCGPoint:self.view1.center], [NSValue valueWithCGRect:self.view1.frame], [NSValue valueWithCGPoint:self.view1.layer.position]);
    
    self.view1.layer.anchorPoint = CGPointMake(1.f, 1.f);
    NSLog(@"center = %@, origin = %@ position = %@", [NSValue valueWithCGPoint:self.view1.center], [NSValue valueWithCGRect:self.view1.frame], [NSValue valueWithCGPoint:self.view1.layer.position]);
}

- (void)transformView {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = [NSNumber numberWithFloat: -M_PI * 2.0 ];
    animation.repeatCount = MAXFLOAT;
    animation.duration = 1.45f;
    animation.cumulative = YES;
    [self.view1.layer addAnimation:animation forKey:nil];
}

@end
