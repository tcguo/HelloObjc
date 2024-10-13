//
//  QTToViewController.m
//  StudyObjc
//
//  Created by gtc on 2020/9/10.
//  Copyright © 2020 gtc. All rights reserved.
//

#import "QTToViewController.h"
#import "QTImageTransition.h"
@interface QTToViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIImageView *workImage1;
@property (nonatomic, strong) QTImageTransition *transAnimation;
@property (nonatomic, strong) UIImage *image;
@end

@implementation QTToViewController

- (instancetype)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.workImage1 = [[UIImageView alloc] initWithImage:self.image];
    self.workImage1.userInteractionEnabled = YES;
    self.workImage1.frame = CGRectMake(0, 64, SCREEN_WIDTH, kScreenHeight-64);
    [self.view addSubview:self.workImage1];
    
    UIButton *backBtn = [self createButtonWithFrame:CGRectMake(150, 20, 40, 25) title:@"dismiss" target:self selector:@selector(dismiss:)];
    [self.view addSubview:backBtn];
}

- (void)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)qt_navigationController:(UINavigationController *)navigationController
animationControllerForOperation:(UINavigationControllerOperation)operation
             fromViewController:(UIViewController *)fromViewController
                                                    toViewController:(UIViewController *)toViewController {

    self.transAnimation.operation = operation;
    return self.transAnimation;
}

- (QTImageTransition *)transAnimation {
    if (!_transAnimation) {
        _transAnimation = [[QTImageTransition alloc] init];
        _transAnimation.fromRect = _fromRect;
    }
    return _transAnimation;
}

@end
