//
//  QTBaseViewController+Animation.h
//  StudyObjc
//
//  Created by gtc on 2020/9/10.
//  Copyright © 2020 gtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTBaseNavigtiaonController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController(Animation)<QTNavigationControllerDelegate>

- (id<UIViewControllerAnimatedTransitioning>)qt_navigationController:(UINavigationController *)navigationController
animationControllerForOperation:(UINavigationControllerOperation)operation
             fromViewController:(UIViewController *)fromViewController
                                                    toViewController:(UIViewController *)toViewController;

- (id<UIViewControllerInteractiveTransitioning>)qt_navigationController:(UINavigationController *)navigationController
interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController;

@end

NS_ASSUME_NONNULL_END
