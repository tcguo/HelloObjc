//
//  QTThreadIndexController.m
//  StudyObjc
//
//  Created by gtc on 2020/5/30.
//  Copyright © 2020 gtc. All rights reserved.
//

#import "QTThreadIndexController.h"
#import "QTDownloadOperation.h"
#import "QTStudent.h"
#import "QTStudent+KVO.h"
#import <pthread.h>

@interface QTThreadIndexController ()
@property (nonatomic, strong) NSOperationQueue *operaQueue;
@property (nonatomic, strong) dispatch_queue_t conqueue;
@property (nonatomic, strong) dispatch_queue_t conqueue2;
@property (nonatomic, assign) QTStudent *innerStu;
@property (nonatomic, assign) NSInteger num;

@property (nonatomic, strong) QTStudent *kvoStu;

@property (assign, nonatomic) pthread_rwlock_t rwlock;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *safeArray;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIView *testView;
@end

static void *xiaomingNameContext = &xiaomingNameContext;
static void *teacherNameContext = &teacherNameContext;

@implementation QTThreadIndexController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"测试Button" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 150, 50);
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 4;
    btn.layer.borderColor = UIColor.redColor.CGColor;
    btn.layer.borderWidth = 1;
    [btn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.testView = [UIView new];
    self.testView.backgroundColor = UIColor.redColor;
    [self.view addSubview:self.testView];
    self.testView.frame = CGRectMake(100, 180, 80, 80);
    
    self.innerStu = [[QTStudent alloc] initWithName:@"gtc"];
//    self.num = 12;
//    [self testABCD2];
    
    // 初始化读写锁
//    self.safeArray = [NSMutableArray array];
    pthread_rwlock_init(&_rwlock, NULL);
    [self readWriteLock];
    
    NSLog(@"alpha = %f", self.testView.alpha);
    self.timer = [NSTimer timerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
        NSLog(@"alpha = %f, timer", self.testView.alpha);
    } repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
//    [self testPthreadReadWriteLock];
    
    
//    [self testNilCrash];
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // self.innerStu变成野指针了
//    NSLog(@"QTStudent nam is %@", self.innerStu.name);
//
//    NSLog(@"num is %ld", self.num);
}

// 销毁锁
- (void)dealloc {
    pthread_rwlock_destroy(&_rwlock);
}

- (void)test:(id)sender {
    [UIView animateWithDuration:5 animations:^{
        self.testView.alpha = 0.5;
        NSLog(@"alpha = %f, done", self.testView.alpha);
    }];
    
//    NSLog(@"alpha = %f, clicked", self.view.alpha);
}


#pragma - 野指针

- (void)testNilCrash {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    self.kvoStu = [[QTStudent alloc] initWithName:@"gtc"];
    
    dispatch_async(queue, ^{
        self.kvoStu = [[QTStudent alloc] initWithName:@"gtc"];
    });
    
    dispatch_async(queue, ^{
        sleep(2);
        self.kvoStu = nil;
        NSString *name = self.kvoStu.name;
    });
    
    dispatch_async(queue, ^{
//        self.kvoStu = nil;
    });
}

#pragma - Lock

// 读写锁 
// 1. 读写互斥， 2. 写写互斥 3. 读读不互斥

/*1、pthread_rwlock：
 pthread_rwlock经常用于文件等数据的读写操作，需要导入头文件#import <pthread.h>
 
 //初始化锁
 pthread_rwlock_t lock;
 pthread_rwlock_init(&_lock, NULL);

 //读加锁
 pthread_rwlock_rdlock(&_lock);
 //读尝试加锁
 pthread_rwlock_trywrlock(&_lock)

 //写加锁
 pthread_rwlock_wrlock(&_lock);
 //写尝试加锁
 pthread_rwlock_trywrlock(&_lock)

 //解锁
 pthread_rwlock_unlock(&_lock);
 //销毁
 pthread_rwlock_destroy(&_lock);
 */

- (void)read {
    pthread_rwlock_rdlock(&_rwlock);
    NSLog(@"Read Thread = %@", [NSThread currentThread]);
    if (self.safeArray.count < 10) {
        NSLog(@"safeArray.count = %ld", self.safeArray.count);
    }
    pthread_rwlock_unlock(&_rwlock);
}

- (void)write22:(NSInteger)idx {
    pthread_rwlock_wrlock(&_rwlock);
    NSLog(@"Write Thread = %@", [NSThread currentThread]);
    [self.safeArray addObject:@(idx)];
    pthread_rwlock_unlock(&_rwlock);
}


/*2、dispatch_barrier_async*/
- (void)readWriteLock {
    // 用dispatch_barriar_aync 对并行队列进行
    self.conqueue = dispatch_queue_create("com.com", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i = 0; i < 4; i++) {
        dispatch_async(self.conqueue, ^{
            NSLog(@"Current Thread = %@", [NSThread currentThread]);
            for(int i = 0; i < 100; i++) {
                [self write22:i];
                [self read];
            }
        });
        
    }
}

- (void)readFile {
    dispatch_async(self.conqueue, ^{
        NSLog(@"读文件 %@", [NSThread currentThread]);
    });
}

- (void)writeFile {
    dispatch_barrier_async(self.conqueue, ^{
        sleep(0.2);
        NSLog(@"写文件 %@", [NSThread currentThread]);
    });
}

- (void)readFileTest {
    dispatch_async(self.conqueue, ^{
        NSLog(@"Read  Thread = %@", [NSThread currentThread]);
        if (self.safeArray.count < 10) {
            NSLog(@"self.safeArray.count = %ld", self.safeArray.count);
        }
    });
}

- (void)writeFileWithId:(NSInteger)idx {
    dispatch_barrier_async(self.conqueue, ^{
        NSLog(@"Write Thread = %@", [NSThread currentThread]);
        [self.safeArray addObject:@(idx)];
    });
}

@end
