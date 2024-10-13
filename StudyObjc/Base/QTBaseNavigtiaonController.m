//
//  QTBaseNavigtiaonController.m
//  StudyObjc
//
//  Created by gtc on 2020/5/30.
//  Copyright © 2020 gtc. All rights reserved.
//

#import "QTBaseNavigtiaonController.h"
#import "QTBaseViewController.h"
#import "UIViewController+Animation.h"

@interface QTBaseNavigtiaonController ()<UINavigationControllerDelegate>

@end

@implementation QTBaseNavigtiaonController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.translucent = YES;
    self.hidesBottomBarWhenPushed = YES;
    self.navigationBarHidden = NO;
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.delegate = self;
    self.navigationBar.backItem.backBarButtonItem.target = self;
    self.navigationBar.backItem.backBarButtonItem.action = @selector(goback:);
}

- (void)goback:(id)sender {
    if (self.topViewController.presentedViewController) {
        [self.topViewController.presentedViewController dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    if (self.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    // Nav转场
    if (![fromVC isKindOfClass:[QTBaseViewController class]] && ![toVC isKindOfClass:[QTBaseViewController class]]) {
        return nil;
    }
    if (operation != UINavigationControllerOperationPush && operation != UINavigationControllerOperationPop) {
        return nil;
    }
    
    id<UIViewControllerAnimatedTransitioning> transitioning = nil;
    if ([toVC respondsToSelector:@selector(qt_navigationController:animationControllerForOperation:fromViewController:toViewController:)]) {
        transitioning = [toVC qt_navigationController:navigationController animationControllerForOperation:operation fromViewController:fromVC toViewController:toVC];
    }
    if (!transitioning) {
         transitioning = [fromVC qt_navigationController:navigationController animationControllerForOperation:operation fromViewController:fromVC toViewController:toVC];
    }
    return transitioning;
    
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController  {
    return [navigationController.topViewController qt_navigationController:navigationController interactionControllerForAnimationController:animationController];
}

@end
