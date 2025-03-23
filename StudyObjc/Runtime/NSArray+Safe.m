//
//  NSArray+Safe.m
//  StudyObjc
//
//  Created by Darius Guo on 2025/3/9.
//  Copyright © 2025 gtc. All rights reserved.
//

#import "NSArray+Safe.h"
#import "NSObject+Swizze.h"

@implementation NSArray (Safe)

+(void) load
{
    [self methodSwizzleWithOrigTarget:NSClassFromString(@"__NSArrayI") OrigSel:@selector(objectAtIndex:) newSel:@selector(myObjectAtIndex:)];
}
- (id)myObjectAtIndex:(NSUInteger)index
{
    if (index > [self count] - 1) {
        NSLog(@"数组越界了");
        return nil;
    }
   return  [self myObjectAtIndex:index];
}

@end
