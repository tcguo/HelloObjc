//
//  QTFromController.m
//  StudyObjc
//
//  Created by gtc on 2020/9/10.
//  Copyright © 2020 gtc. All rights reserved.
//

#import "QTFromController.h"
#import "QTToViewController.h"
#import "QTCircleAnimatorTransition.h"

@interface QTFromController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIImageView *workImage1;
@property (nonatomic, strong) UIImageView *workImage2;
@property (nonatomic, strong) UIImageView *workImage3;
@property (nonatomic, strong) UIImageView *workImage4;

@property (nonatomic, strong) UIImageView *workImage5;
@property (nonatomic, strong) UIImageView *workImage6;
@property (nonatomic, strong) UIImageView *selectedImage;
@property (nonatomic, strong) QTCircleAnimatorTransition *circleAnimation;
@end

@implementation QTFromController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSData *data1 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"work1.webp" ofType:nil]];
    NSData *data2 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"work2.webp" ofType:nil]];
    NSData *data3 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"work3.webp" ofType:nil]];
    NSData *data4 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"work4.webp" ofType:nil]];
    YYImage *image1 =  [YYImage imageWithData:data1];
    YYImage *image2 =  [YYImage imageWithData:data2];
    YYImage *image3 =  [YYImage imageWithData:data3];
    YYImage *image4 =  [YYImage imageWithData:data4];
    self.workImage1 = [[UIImageView alloc] initWithImage:image1];
    self.workImage2 = [[UIImageView alloc] initWithImage:image2];
    self.workImage3 = [[UIImageView alloc] initWithImage:image3];
    self.workImage4 = [[UIImageView alloc] initWithImage:image4];
    self.workImage5 = [[UIImageView alloc] initWithImage:nil];
    self.workImage6 = [[UIImageView alloc] initWithImage:nil];
    self.workImage5.backgroundColor = [UIColor redColor];
    self.workImage6.backgroundColor = [UIColor blueColor];
    
    self.workImage1.userInteractionEnabled = YES;
    self.workImage2.userInteractionEnabled = YES;
    self.workImage3.userInteractionEnabled = YES;
    self.workImage4.userInteractionEnabled = YES;
    self.workImage5.userInteractionEnabled = YES;
    self.workImage6.userInteractionEnabled = YES;
    CGFloat width = (SCREEN_WIDTH-55)/2.f;
    self.workImage1.frame = CGRectMake(20, 100, width, 180);
    self.workImage2.frame = CGRectMake(CGRectGetMaxX(self.workImage1.frame)+10, 100, width, 180);
    self.workImage3.frame = CGRectMake(20, CGRectGetMaxY(self.workImage1.frame)+10, width, 100);
    self.workImage4.frame = CGRectMake(CGRectGetMaxX(self.workImage3.frame)+10, CGRectGetMaxY(self.workImage1.frame)+10, width, 100);
    
    self.workImage5.frame = CGRectMake(20, CGRectGetMaxY(self.workImage4.frame)+50, width, width);
    self.workImage6.frame = CGRectMake(CGRectGetMaxX(self.workImage5.frame)+10, CGRectGetMaxY(self.workImage4.frame)+50, width, width);
    self.workImage5.layer.cornerRadius = (width/2.f);
    self.workImage5.layer.masksToBounds = YES;
    self.workImage6.layer.cornerRadius = (width/2.f);
    self.workImage6.layer.masksToBounds = YES;
    
    [self.view addSubview:self.workImage1];
    [self.view addSubview:self.workImage2];
    [self.view addSubview:self.workImage3];
    [self.view addSubview:self.workImage4];
    [self.view addSubview:self.workImage5];
    [self.view addSubview:self.workImage6];
    
    UITapGestureRecognizer *tapGR1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    UITapGestureRecognizer *tapGR2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    UITapGestureRecognizer *tapGR3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    UITapGestureRecognizer *tapGR4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    
    [self.workImage1 addGestureRecognizer:tapGR1];
    [self.workImage2 addGestureRecognizer:tapGR2];
    [self.workImage3 addGestureRecognizer:tapGR3];
    [self.workImage4 addGestureRecognizer:tapGR4];
    
    UITapGestureRecognizer *tapGR5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage2:)];
    UITapGestureRecognizer *tapGR6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage2:)];
    [self.workImage5 addGestureRecognizer:tapGR5];
    [self.workImage6 addGestureRecognizer:tapGR6];
}

- (void)tapImage:(UITapGestureRecognizer *)sender {
    UIImageView *imageView = (UIImageView *)sender.view;
    UIImage *image = [(UIImageView *)sender.view image];
    
    QTToViewController *toVC = [[QTToViewController alloc] initWithImage:image];
    toVC.fromRect = imageView.frame;
    [self.navigationController pushViewController:toVC animated:YES];
}

- (void)tapImage2:(UITapGestureRecognizer *)sender {
    UIImageView *imageView = (UIImageView *)sender.view;
    self.selectedImage = imageView;
    QTToViewController *toVC = [[QTToViewController alloc] initWithImage:self.workImage1.image];
    toVC.transitioningDelegate = self;
    toVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:toVC animated:YES completion:nil];
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    QTCircleAnimatorTransition *circle = [[QTCircleAnimatorTransition alloc] initWithTargetView:self.selectedImage color:self.selectedImage.backgroundColor];
    circle.mode = TransitionModePresent;
    return circle;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    QTCircleAnimatorTransition *circle = [[QTCircleAnimatorTransition alloc] initWithTargetView:self.selectedImage color:self.selectedImage.backgroundColor];
    circle.mode = TransitionModeDismiss;
    return circle;
}

@end
