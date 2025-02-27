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

/**
 多看看这篇文章的介绍
 https://zsisme.gitbooks.io/ios-/content/chapter3/anchor.html
 */
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
    NSLog(@"center = %@, frame = %@ position = %@", [NSValue valueWithCGPoint:self.view1.center], [NSValue valueWithCGRect:self.view1.frame], [NSValue valueWithCGPoint:self.view1.layer.position]);
    
    NSLog(@"center = %@, origin = %@ position = %@", [NSValue valueWithCGPoint:self.view1.center], [NSValue valueWithCGRect:self.view1.frame], [NSValue valueWithCGPoint:self.view1.layer.position]);
    
    self.view1.layer.anchorPoint = CGPointMake(0.f, 0.f);
    NSLog(@"center = %@, origin = %@ position = %@", [NSValue valueWithCGPoint:self.view1.center], [NSValue valueWithCGRect:self.view1.frame], [NSValue valueWithCGPoint:self.view1.layer.position]);
    
    // anchorPoint和position永远重合。position就是layer中的anchorPoint在superLayer中的位置坐标。
    // 只是在不同坐标系，center等于position，即使锚点改变了，position的位置和数值不会变。
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
