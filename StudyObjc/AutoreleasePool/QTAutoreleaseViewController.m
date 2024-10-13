//
//  QTAutoreleaseViewController.m
//  StudyObjc
//
//  Created by gtc on 2023/8/19.
//  Copyright © 2023 gtc. All rights reserved.
//

#import "QTAutoreleaseViewController.h"

@interface QTAutoreleaseViewController ()

@end

@implementation QTAutoreleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)test {
    for (int i = 0; i < 100; i++) {
        @autoreleasepool {
            
        }
    }
}

@end
