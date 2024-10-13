//
//  ViewController.h
//  StudyObjc
//
//  Created by gtc on 2020/5/30.
//  Copyright © 2020 gtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTBaseIndexViewController.h"

@interface Person : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *addr;
//@property (nonatomic, assign) NSInteger age;
//@property (nonatomic, copy) NSArray *ages;
@end

@interface ViewController :QTBaseIndexViewController

@end

