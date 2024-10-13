//
//  QTBaseViewController.m
//  StudyObjc
//
//  Created by gtc on 2020/5/30.
//  Copyright © 2020 gtc. All rights reserved.
//

#import "QTBaseViewController.h"

@interface QTBaseViewController ()

@end

@implementation QTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}


- (UIView *)createViewWithFrame:(CGRect)frame {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [UIColor randomColor].CGColor;
    view.layer.borderWidth = 2.f;
    view.layer.masksToBounds = YES;
    view.frame = frame;
    return view;
}

- (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title target:(id)target selector:(SEL)selector {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor randomColor].CGColor;
    btn.layer.borderWidth = 2.f;
    btn.layer.cornerRadius = 5.f;
    btn.layer.masksToBounds = YES;
    return btn;
}

@end
