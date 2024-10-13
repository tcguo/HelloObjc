//
//  QTGCDIndexController.m
//  StudyObjc
//
//  Created by gtc on 2020/5/30.
//  Copyright © 2020 gtc. All rights reserved.
//

#import "QTGCDIndexController.h"
#import "SSTestManager.h"

@interface QTGCDIndexController ()

@end

@implementation QTGCDIndexController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"GCD 测试" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 150, 50);
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 4;
    btn.layer.borderColor = UIColor.redColor.CGColor;
    btn.layer.borderWidth = 1;
    [btn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)test:(id)sender {
//    [self sendABCDRequest];
    [self sendABCDRequest2];
    
    // 如何改成所有异步任务完成之后呢？？
    // 核心：异步变同步。 1. group_enter/group_leave 2. semphore
   
//    [self mockMutiRequestsByGroupEnterLeave];
//    [self mockMutiRequestsBySemaphore];
    
//    [self xiaohongshu];
    
}

- (void)testBarriar {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.seail", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(serialQueue, ^{
        NSLog(@"1, = %@", [NSThread currentThread]);
    });
    
    // dispatch_barrier_sync // 在主线程, 不开辟新线程
    // dispatch_barrier_async // 开辟新线程
    dispatch_barrier_async(serialQueue, ^{
        sleep(2);
        NSLog(@"2, = %@", [NSThread currentThread]);
    });
    
    dispatch_async(serialQueue, ^{
        NSLog(@"3, = %@", [NSThread currentThread]);
    });
}


#pragma - 请求同步

//------

// ------ABC请求完再执行D
// 信号量的考察
// dispatch_semaphore_create，
// dispatch_semaphore_signal，
// dispatch_semaphore_wait。

// https://blog.csdn.net/Deft_MKJing/article/details/51518556

// 最先想到的方法： 1、添加标识的解决方法
//方法是网络请求结束的回调代理方法，完成后_finishedCount计数加1，然后和保存网络请求实例的数组元素个数进行比较如果相等说明所有的请求都已经完成，调用回调的代理方法及block请求结束。


// 第一种： dispatch_group_enter dispatch_group_leave
- (void)sendABCDRequest {
    // A+B并行执行，执行完成再执行C, 最后执行D
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t conQueue = dispatch_queue_create("com.conqu", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_enter(group);
    dispatch_group_async(group, conQueue, ^{
        [self requestA:^{
            dispatch_group_leave(group);
        }];
    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, conQueue, ^{
        [self requestB:^{
            sleep(3);
            dispatch_group_leave(group);
        }];
    });
    
    //等待上面的任务全部完成后，会往下继续执行（会阻塞当前线程）
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    dispatch_group_enter(group);
    dispatch_group_async(group, conQueue, ^{
        [self requestC:^{
            dispatch_group_leave(group);
        }];
    });
    
    dispatch_group_notify(group, conQueue, ^{
        NSLog(@"---执行ALL任务结束---");
    });
}

// 第二个办法 group + semaphore
- (void)sendABCDRequest2 {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t conQueue = dispatch_queue_create("com.conqu", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_async(group, conQueue, ^{
        dispatch_semaphore_t semap = dispatch_semaphore_create(0);
        [self requestA:^{
            dispatch_semaphore_signal(semap);
        }];
        
        dispatch_semaphore_wait(semap, DISPATCH_TIME_FOREVER);
    });
    
    dispatch_group_async(group, conQueue, ^{
        dispatch_semaphore_t semap = dispatch_semaphore_create(0);
        [self requestB:^{
            dispatch_semaphore_signal(semap);
        }];
        
        dispatch_semaphore_wait(semap, DISPATCH_TIME_FOREVER);
    });
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    dispatch_group_async(group, conQueue, ^{
        dispatch_semaphore_t semap = dispatch_semaphore_create(0);
        [self requestC:^{
            dispatch_semaphore_signal(semap);
        }];
        
        dispatch_semaphore_wait(semap, DISPATCH_TIME_FOREVER);
    });
    
    dispatch_group_notify(group, conQueue, ^{
        NSLog(@"---执行ALL任务结束---");
    });
}

- (void)requestA:(void(^)(void))block{
    NSLog(@"---执行A任务开始---");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        block();
        NSLog(@"---执行A任务结束---");
    });
}
- (void)requestB:(void(^)(void))block{
    NSLog(@"---执行B任务开始---");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        block();
        NSLog(@"---执行B任务结束---");
    });
}
- (void)requestC:(void(^)(void))block{
    NSLog(@"---执行C任务开始---");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        block();
        NSLog(@"---执行C任务结束---");
    });
}

- (void)requestD:(void(^)(void))block{
    NSLog(@"---执行D任务开始---");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        block();
        NSLog(@"---执行D任务结束---");
    });
}


#pragma - 面试题

- (void)xiaohongshu {
    // 有5个任务，要求前三个任务顺序执行，4、5两个任务并行执行，并在5个任务都执行结束后执行其他
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("queue.concurrent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_async(group, queue, ^{
        dispatch_sync(queue, ^{
            NSLog(@"任务1");
        });
        dispatch_sync(queue, ^{
            NSLog(@"任务2");
        });
        dispatch_sync(queue, ^{
            NSLog(@"任务3");
        });
        
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"任务4");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"任务5");
    });
    dispatch_group_notify(group, queue, ^{
        NSLog(@"完成啦");
    });
}

/// <#Description#>
- (void)testGroup {
    // 3个并行任务，完成之后，最后做一件事
    // 但是这种不适合网络请求，如果3个任务是异步的，则没有等3个任务完成，已经通知结束
    dispatch_queue_t queue = dispatch_queue_create("com.test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"任务1");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"任务2");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"任务3");
    });
    dispatch_group_notify(group, queue, ^{
        NSLog(@"任务完成：1-2-3");
    });
    
    // 第二种方案
    dispatch_async(queue, ^{
        NSLog(@"任务11");
    });
    dispatch_async(queue, ^{
        NSLog(@"任务22");
    });
    dispatch_async(queue, ^{
        NSLog(@"任务33");
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"任务完成：11-22-33");
    });
}

- (void)testGroupToSync1 {
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [self requestOneWithSuccessBlock:^{
        NSLog(@"任务111");
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [self requestOneWithSuccessBlock:^{
        NSLog(@"任务222");
        dispatch_group_leave(group);
    }];
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    dispatch_group_enter(group);
    [self requestOneWithSuccessBlock:^{
        NSLog(@"任务333");
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"任务完成:111-222-333");
    });
}

- (void)requestOneWithSuccessBlock:(dispatch_block_t)block {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        block();
    });
}

- (void)mockMutiRequestsByGroupEnterLeave {
    // 模拟循环网络请求 同时进行 统一回调 (GCD + enter/leave)
    dispatch_group_t group = dispatch_group_create();
    for (int i = 0; i < 5; i++) {
        dispatch_group_enter(group);
        [self requestOneWithSuccessBlock:^{
            NSLog(@"任务2--%i", i);
            dispatch_group_leave(group);
        }];
    }
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"任务完成2！！");
    });
    
    
    // 模拟循环网络请求 【顺序进行】 (GCD + enter/leave方式)
    dispatch_group_t group2 = dispatch_group_create();
    for (int i = 0; i < 5 ; i++) {
        dispatch_group_enter(group2);
        [self requestOneWithSuccessBlock:^{
            NSLog(@"任务2-%i", i);
            dispatch_group_leave(group2);
        }];
        dispatch_group_wait(group2, DISPATCH_TIME_FOREVER);
    }
    dispatch_group_notify(group2, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"任务完成2！！");
    });
}

- (void)mockMutiRequestsBySemaphore {
    // 模拟循环网络请求 【同时进行】 统一回调 (GCD + 信号量方式)
    dispatch_group_t group = dispatch_group_create();
    for (int i = 0; i < 5; i++) {
        dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
            dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
            [self requestOneWithSuccessBlock:^{
                NSLog(@"任务%i", i);
                dispatch_semaphore_signal(semaphore);
            }];
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        });
    }
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"任务完成1！！");
    });
    
    
    // 模拟循环网络请求 【顺序进行】 (GCD + 信号量方式)
    dispatch_group_t group2 = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_group_async(group2, dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 5; i++) {
            [self requestOneWithSuccessBlock:^{
                NSLog(@"任务%i", i);
                dispatch_semaphore_signal(semaphore);
            }];
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        }
    });
    dispatch_group_notify(group2, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"任务完成1！！");
    });
}



- (void)testSemaphore {
    // 信号量可以把异步变同步, wait和signal必须成对出现，否则crash
    dispatch_queue_t queue = dispatch_queue_create("com.test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    dispatch_async(queue, ^{
        NSLog(@"任务111");
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"ddd");
    dispatch_semaphore_signal(semaphore);
}

@end
