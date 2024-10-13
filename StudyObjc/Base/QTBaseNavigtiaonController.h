//
//  QTBaseNavigtiaonController.h
//  StudyObjc
//
//  Created by gtc on 2020/5/30.
//  Copyright © 2020 gtc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QTNavigationControllerDelegate <NSObject>

- (id<UIViewControllerAnimatedTransitioning>)qt_navigationController:(UINavigationController *)navigationController
                                     animationControllerForOperation:(UINavigationControllerOperation)operation
                                                  fromViewController:(UIViewController *)fromViewController
                                                    toViewController:(UIViewController *)toViewController;

- (id<UIViewControllerInteractiveTransitioning>)qt_navigationController:(UINavigationController *)navigationController
                            interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController;

@end


@interface QTBaseNavigtiaonController : UINavigationController

@end

NS_ASSUME_NONNULL_END
