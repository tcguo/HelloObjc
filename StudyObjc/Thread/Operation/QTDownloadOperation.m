//
//  QTDownloadOperation.m
//  StudyObjc
//
//  Created by gtc on 2021/10/22.
//  Copyright © 2021 gtc. All rights reserved.
//

#import "QTDownloadOperation.h"

@implementation QTDownloadOperation

- (void)main {
    NSLog(@"thread = %@, num = %i", [NSThread currentThread], self.num);
}

@end
