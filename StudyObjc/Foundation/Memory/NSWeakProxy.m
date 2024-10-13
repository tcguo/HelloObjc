//
//  NSWeakProxy.m
//  StudyObjc
//
//  Created by gtc on 2023/8/19.
//  Copyright © 2023 gtc. All rights reserved.
//

#import "NSWeakProxy.h"

@interface NSWeakProxy ()
@property (weak,nonatomic,readonly)id target;
- (void)test;
@end

@implementation NSWeakProxy

+ (instancetype)proxyWithTarget:(id)target {
    return [[self alloc] initWithTarget:target];
}

- (instancetype)initWithTarget:(id)target {
    _target = target;
    return self;
}

// 重写- (NSMethodSignature *)methodSignatureForSelector:(SEL)see方法获得方法签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    return [self.target methodSignatureForSelector:aSelector];
}

// 5.重写- (void)forwardInvocation:(NSInvocation *)invocation方法改变调用对象，也就是说，让消息实际上发给真正的实现这个方法的类
- (void)forwardInvocation:(NSInvocation *)invocation{
    SEL sel = [invocation selector];
    if ([self.target respondsToSelector:sel]) {
        [invocation invokeWithTarget:self.target];
    }
}
- (BOOL)respondsToSelector:(SEL)aSelector{
    return [self.target respondsToSelector:aSelector];
}

// 调用
// self.timer = [NSTimer timerWithTimeInterval:1 target:[WeakProxy proxyWithTarget:self] selector:@selector(timerInvoked:) userInfo:nil repeats:YES];

@end
