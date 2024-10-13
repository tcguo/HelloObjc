//
//  QTCircleAnimatorTransition.h
//  StudyObjc
//
//  Created by gtc on 2020/9/11.
//  Copyright © 2020 gtc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    TransitionModePresent,
    TransitionModeDismiss,
} TransitionMode;
@interface QTCircleAnimatorTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) TransitionMode mode;
- (instancetype)initWithTargetView:(UIView *)view color:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
