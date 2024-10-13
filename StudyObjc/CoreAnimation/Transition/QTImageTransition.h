//
//  QTImageTransition.h
//  StudyObjc
//
//  Created by gtc on 2020/9/11.
//  Copyright © 2020 gtc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QTImageTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) CGRect fromRect;
@property (nonatomic, assign) UINavigationControllerOperation operation;
@end

NS_ASSUME_NONNULL_END
