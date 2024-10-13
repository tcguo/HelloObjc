//
//  QTBaseViewController+Animation.m
//  StudyObjc
//
//  Created by gtc on 2020/9/10.
//  Copyright © 2020 gtc. All rights reserved.
//

#import "UIViewController+Animation.h"

@implementation UIViewController (Animation)

- (id<UIViewControllerAnimatedTransitioning>)qt_navigationController:(UINavigationController *)navigationController
                                     animationControllerForOperation:(UINavigationControllerOperation)operation
                                                  fromViewController:(UIViewController *)fromViewController
                                                    toViewController:(UIViewController *)toViewController {
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)qt_navigationController:(UINavigationController *)navigationController
                            interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    return nil;
}


@end
