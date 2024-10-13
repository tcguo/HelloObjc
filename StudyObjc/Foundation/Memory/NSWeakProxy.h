//
//  NSWeakProxy.h
//  StudyObjc
//
//  Created by gtc on 2023/8/19.
//  Copyright © 2023 gtc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSWeakProxy : NSProxy

+ (instancetype)proxyWithTarget:(id)target;
- (instancetype)initWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
