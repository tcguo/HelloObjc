//
//  QTCircleAnimatorTransition.m
//  StudyObjc
//
//  Created by gtc on 2020/9/11.
//  Copyright © 2020 gtc. All rights reserved.
//

#import "QTCircleAnimatorTransition.h"

static inline CGRect frameForCirle(CGPoint center, CGSize size, CGPoint start) {
    CGFloat lengthX = fmax(start.x, size.width - start.x);
    CGFloat lengthY = fmax(start.y, size.height - start.y);
    CGFloat offset = sqrt(lengthX*lengthX + lengthY*lengthY)*2;
    return CGRectMake(0, 0, offset, offset);
}

@interface QTCircleAnimatorTransition()
@property (nonatomic, strong) UIColor *circleColor;
@property (nonatomic, assign) CGPoint circleOrigin;
@property (nonatomic, strong) UIView *circleView;
@end


@implementation QTCircleAnimatorTransition

- (instancetype)initWithTargetView:(UIView *)view color:(UIColor *)color  {
    self = [super init];
    if (self) {
        self.circleOrigin = view.center;
        self.circleColor = color;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.45;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = transitionContext.containerView;
    
    
    if (_mode == TransitionModePresent) {
        UIView *presentView = [transitionContext viewForKey:UITransitionContextToViewKey];
        CGPoint viewCenter = presentView.center;
        CGSize viewSize = presentView.frame.size;
        
        CGRect rect = frameForCirle(viewCenter, viewSize, self.circleOrigin);
        _circleView = [[UIView alloc] initWithFrame:rect];
        _circleView.center = self.circleOrigin;
        _circleView.layer.cornerRadius = (_circleView.frame.size.width/2.0);
        
        _circleView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        _circleView.backgroundColor = self.circleColor;
        [containerView addSubview:_circleView];
        
        presentView.center = self.circleOrigin;
        presentView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        
        [containerView addSubview:presentView];
        [UIView animateWithDuration:0.45 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.circleView.transform = CGAffineTransformIdentity;
            presentView.transform = CGAffineTransformIdentity;
            presentView.center = viewCenter;
        } completion:^(BOOL finished) {
            [self.circleView removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    }
    
    if (_mode == TransitionModeDismiss) {
        UIView *returnView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        CGPoint viewCenter = returnView.center;
        CGSize  viewSize = returnView.frame.size;
        
        CGRect rect = frameForCirle(viewCenter, viewSize, self.circleOrigin);
        _circleView = [[UIView alloc] initWithFrame:rect];
        _circleView.center = self.circleOrigin;
        _circleView.layer.cornerRadius = (_circleView.frame.size.width/2.0);
        _circleView.transform = CGAffineTransformIdentity;
        _circleView.backgroundColor = self.circleColor;
        [containerView insertSubview:self.circleView belowSubview:returnView];
        
        [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.circleView.transform = CGAffineTransformMakeScale(0.001, 0.001);
            returnView.transform = CGAffineTransformMakeScale(0.001, 0.001);
            returnView.center = self.circleOrigin;
            returnView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [returnView removeFromSuperview];
            [self.circleView removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
        
    }
    
}

@end
