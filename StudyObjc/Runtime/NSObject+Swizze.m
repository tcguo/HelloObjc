//
//  NSObject+Swizze.m
//  StudyObjc
//
//  Created by Darius Guo on 2025/3/9.
//  Copyright © 2025 gtc. All rights reserved.
//

#import "NSObject+Swizze.h"

@implementation NSObject (Swizze)

/**
 方法交换
 @param origTarget 被交换方法的类
 @param origSel 原方法名
 @param newSel 新方法名
 */
+(void) methodSwizzleWithOrigTarget:(Class)origTarget OrigSel:(SEL)origSel newSel:(SEL)newSel
{
   //类对象（实例方法存储在类对象中）
    Class origClass = origTarget;
    if ([origTarget isKindOfClass:[origTarget class]]) {//成立则origTarget为实例对象
        origClass = object_getClass(origTarget);
    }
    //方法
    Method origMethod = class_getInstanceMethod(origClass, origSel);
    Method newMethod = class_getInstanceMethod(origClass, newSel);
    if (!origMethod) {//原方法没实现
        class_addMethod(origClass, origSel, imp_implementationWithBlock(^(id self, SEL _cmd){}), "v16@0:8");
        origMethod = class_getInstanceMethod(origClass, origSel);
    }
    
    //imp
    IMP origIMP = method_getImplementation(origMethod);
    IMP newIMP = method_getImplementation(newMethod);
    
    //方法添加成功代表target中不包含原方法，可能是其父类包含(交换父类方法可能有意想不到的问题)
    if(class_addMethod(origClass, origSel, origIMP, method_getTypeEncoding(origMethod))){
        //直接替换新添加的方法
        class_replaceMethod(origClass, origSel, newIMP, method_getTypeEncoding(newMethod));
    }else{
        method_setImplementation(origMethod, newIMP);
        method_setImplementation(newMethod, origIMP);
    }
}

@end
