//
//  NSObject+Swizze.h
//  StudyObjc
//
//  Created by Darius Guo on 2025/3/9.
//  Copyright © 2025 gtc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizze)

+(void) methodSwizzleWithOrigTarget:(Class)origTarget OrigSel:(SEL)origSel newSel:(SEL)newSel;
@end

NS_ASSUME_NONNULL_END
