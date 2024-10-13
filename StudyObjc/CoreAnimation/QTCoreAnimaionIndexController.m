//
//  QTCoreAnimaionIndexController.m
//  StudyObjc
//
//  Created by gtc on 2020/5/30.
//  Copyright © 2020 gtc. All rights reserved.
//

#import "QTCoreAnimaionIndexController.h"

@interface QTCoreAnimaionIndexController ()

@end

@implementation QTCoreAnimaionIndexController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"核心动画";
}

- (void)configDataSource {
    
    [super configDataSource];
    
    [self.dataDict setObject:@"QTUIKitsIndexController" forKey:@"CALayer"];
    [self.dataDict setObject:@"QTBezierPathController" forKey:@"贝塞尔曲线"];
    [self.dataDict setObject:@"QTBasicAnimationController" forKey:@"CABasicAnimation"];
    [self.dataDict setObject:@"QTRuntimeIndexController" forKey:@"CAKeyframeAnimation"];
    [self.dataDict setObject:@"QTAnchorPointController" forKey:@"锚点"];
    [self.dataDict setObject:@"QTFromController" forKey:@"转场Transition"];
    [self.dataDict setObject:@"QTPlayButtonController" forKey:@"Demo1"];
    [self.dataDict setObject:@"UIBasicAnimationDemoController" forKey:@"Demo2"];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
