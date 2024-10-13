//
//  QTOperationViewController.m
//  StudyObjc
//
//  Created by gtc on 2023/8/20.
//  Copyright © 2023 gtc. All rights reserved.
//

#import "QTOperationViewController.h"
#import "QTDownloadOperation.h"

@interface QTOperationViewController ()
@property (nonatomic, strong) NSOperationQueue *operaQueue;
@property (nonatomic, strong) dispatch_queue_t conqueue;
@end

@implementation QTOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)testOperation {
    self.operaQueue = [[NSOperationQueue alloc] init];
    self.operaQueue.maxConcurrentOperationCount = 5;
    
    for (int i = 0; i < 10; i++) {
        QTDownloadOperation *oper = [[QTDownloadOperation alloc] init];
        oper.num = i;
        [self.operaQueue addOperation:oper];
        if (oper.ready && !oper.isExecuting) {
            [oper cancel];
        }
    }
    
    QTDownloadOperation *download1 = [[QTDownloadOperation alloc] init];
    QTDownloadOperation *download2 = [[QTDownloadOperation alloc] init];
    [download1 addDependency:download2];
    
    [self.operaQueue addOperation:download2];
    [self.operaQueue addOperation:download1];
}

@end
