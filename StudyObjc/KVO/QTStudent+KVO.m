//
//  QTStudent+KVO.m
//  StudyObjc
//
//  Created by gtc on 2023/8/19.
//  Copyright © 2023 gtc. All rights reserved.
//

#import "QTStudent+KVO.h"
#import <objc/runtime.h>

@implementation QTStudent (KVO)

- (void)setXiaoming:(NSString *)xiaoming {
    [self willChangeValueForKey:xiaoming];
    objc_setAssociatedObject(self, @selector(xiaoming), xiaoming, OBJC_ASSOCIATION_COPY);
    [self didChangeValueForKey:xiaoming];
}

- (NSString *)xiaoming {
    return objc_getAssociatedObject(self, _cmd);
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    if ([key isEqualToString:@"name"]) {
        return YES; // 自动触发
    } else if ([key isEqualToString:@"xiaoming"]) { // 手动触发
        return NO;
    }
    return YES;
}

@end
