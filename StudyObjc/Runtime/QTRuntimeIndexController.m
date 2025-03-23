//
//  QTRuntimeIndexController.m
//  StudyObjc
//
//  Created by gtc on 2020/5/30.
//  Copyright © 2020 gtc. All rights reserved.
//

#import "QTRuntimeIndexController.h"

@interface QTRuntimeIndexController ()

@end


@implementation QTRuntimeIndexController

BOOL best_Swizzle(Class aClass, SEL originalSel, SEL swizzleSel)
{
     // 如果originalSel没有实现过，class_getInstanceMethod无法找到该方法，所以originalMethod为nil
     Method originalMethod = class_getInstanceMethod(aClass, originalSel);
     Method swizzleMethod = class_getInstanceMethod(aClass, swizzleSel);
     BOOL didAddMethod = class_addMethod(aClass, originalSel, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
     if (didAddMethod) {
         //  当originalMethod为nil时，这里的class_replaceMethod将不做替换，所以swizzleSel方法里的实现还是自己原来的实现
         class_replaceMethod(aClass, swizzleSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
     } else {
         method_exchangeImplementations(originalMethod, swizzleMethod);
     }
     return YES;
}

+ (void)load {
    best_Swizzle([self class], @selector(viewDidAppear:), @selector(qt_viewDidAppear:));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)qt_viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}
@end
