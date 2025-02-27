//
//  QTUIKitsIndexController.m
//  StudyObjc
//
//  Created by gtc on 2020/5/30.
//  Copyright © 2020 gtc. All rights reserved.
//

#import "QTUIKitsIndexController.h"

@interface QTUIKitsIndexController ()

@end

@implementation QTUIKitsIndexController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configDataSource];
}

- (void)configDataSource {
    [super configDataSource];
    
    [self.dataDict setObject:@"QTCollectionViewController" forKey:@"Collection"];
    [self.dataDict setObject:@"QTPanGestureController" forKey:@"Pan"];
    [self.dataDict setObject:@"QTHitTestAndGestureController" forKey:@"HitTest"];
}

@end
