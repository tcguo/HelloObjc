//
//  QTImageTransition.m
//  StudyObjc
//
//  Created by gtc on 2020/9/11.
//  Copyright © 2020 gtc. All rights reserved.
//

#import "QTImageTransition.h"

static inline CGFloat QuarticEaseOut(CGFloat p)
{
    CGFloat f = (p - 1);
    return f * f * f * (1 - p) + 1;
}

static CGAffineTransform interpolationTransform2(CGAffineTransform transform, CGAffineTransform endTransform, CGFloat p)
{
    CGAffineTransform newTransform = CGAffineTransformIdentity;
    newTransform.a = transform.a + (endTransform.a - transform.a) * p;
    newTransform.b = transform.b + (endTransform.b - transform.b) * p;
    newTransform.c = transform.c + (endTransform.c - transform.c) * p;
    newTransform.d = transform.d + (endTransform.d - transform.d) * p;
    newTransform.tx = transform.tx + (endTransform.tx - transform.tx) * p;
    newTransform.ty = transform.ty + (endTransform.ty - transform.ty) * p;
    return newTransform;
}


@implementation QTImageTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.35;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (self.operation == UINavigationControllerOperationPush) {
        UIView *containerView = transitionContext.containerView;
        UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
        toVC.view.frame = containerView.bounds;
        [containerView insertSubview:toVC.view aboveSubview:fromVC.view];
        
        CGFloat fromScale = CGRectGetWidth(self.fromRect)/CGRectGetWidth(toVC.view.bounds);
        CGPoint fromcenter = CGRectGetCenter(self.fromRect);
        CGPoint toCenter = CGRectGetCenter(toVC.view.frame);
        
        CGAffineTransform transform = CGAffineTransformMakeTranslation(fromcenter.x - toCenter.x, fromcenter.y - toCenter.y);
        transform = CGAffineTransformScale(transform, fromScale, fromScale);
        toVC.view.transform = transform;
        toVC.view.alpha = 1.f;
        
        CGAffineTransform endTransform = CGAffineTransformIdentity;
        [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            int64_t endStep = 30;
            CGFloat step = 1.f / endStep;
            
            for (int i = 0; i< endStep; i++) {
                [UIView addKeyframeWithRelativeStartTime:i*step relativeDuration:step animations:^{
                    CGAffineTransform newTransform;
                    
                    CGFloat p0 = (i + 1.0) / 30.0;
                    if (p0 > 1.0) {
                        p0 = 1.0;
                    }
                    CGFloat p1 = QuarticEaseOut(p0);
                    
                    newTransform = interpolationTransform2(transform, endTransform, p1);
                    toVC.view.transform = newTransform;
                }];
            }
        } completion:^(BOOL finished) {
            toVC.view.transform = CGAffineTransformIdentity;
            toVC.view.layer.mask = nil;
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
        
        return;
        [UIView animateWithDuration:0.35 delay:0.f options:UIViewAnimationOptionCurveLinear animations:^{
            toVC.view.transform = CGAffineTransformIdentity;
            toVC.view.center = toCenter;
        } completion:^(BOOL finished) {
            toVC.view.layer.mask = nil;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    
    if (self.operation == UINavigationControllerOperationPop) {
        [self reverseAnimateTransition:transitionContext];
    }
}

- (void)reverseAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    UIViewController *topVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *bottomVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    bottomVC.view.frame = containerView.bounds;
    [containerView insertSubview:bottomVC.view belowSubview:topVC.view];
    
    CGRect thumbnailFrame = self.fromRect;
    
    CGPoint c0 = CGRectGetCenter(thumbnailFrame);
    CGPoint c1 = CGRectGetCenter(topVC.view.frame);
    
    CGFloat scaleX = CGRectGetWidth(thumbnailFrame) / CGRectGetWidth(topVC.view.bounds);
    CGFloat scaleY = CGRectGetHeight(thumbnailFrame) / CGRectGetHeight(topVC.view.bounds);
    CGAffineTransform thumbnailTransform = CGAffineTransformMakeTranslation(c0.x - c1.x, c0.y - c1.y);
    thumbnailTransform = CGAffineTransformScale(thumbnailTransform, scaleX, scaleY);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        topVC.view.transform = thumbnailTransform;
        topVC.view.alpha = 0.f;
    } completion:^(BOOL finished) {
        [topVC.view removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
