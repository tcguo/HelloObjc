//
//  SSTestManager.m
//  StudyObjc
//
//  Created by gtc on 2021/1/15.
//  Copyright © 2021 gtc. All rights reserved.
//

#import "SSTestManager.h"

NS_INLINE void ksk_syncRunOnMainQueue(void (^block)(void)) {
    if (!block) return;
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

@implementation SSTestManager

+ (instancetype)sharedInstance {
    static SSTestManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self.class alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self observeAppLife];
    }
    
    return self;
}

- (void)observeAppLife {
    ksk_syncRunOnMainQueue(^{
        // do something on main thread
        NSLog(@"test");
    });
}

@end
