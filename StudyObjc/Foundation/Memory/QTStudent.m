//
//  QTStudent.m
//  StudyObjc
//
//  Created by gtc on 2023/8/10.
//  Copyright © 2023 gtc. All rights reserved.
//

#import "QTStudent.h"

@interface QTStudent ()
@end

@implementation QTStudent

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        self.name = name;
        [self.marray insertObject:@"" atIndex:0];
        [self.marray addObject:@""];
        [self.marray removeObjectAtIndex:3];
        // [self.arrList objectAtIndex:1];
    }
    return self;
    
}

- (void)test {
    int res = add(12, 4);
    QTStudent *stu = [self.arrList objectAtIndex:1];
    [self.marray addObject: @"12"];
}

@end
