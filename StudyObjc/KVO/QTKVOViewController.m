//
//  QTKVOViewController.m
//  StudyObjc
//
//  Created by gtc on 2023/8/19.
//  Copyright © 2023 gtc. All rights reserved.
//

#import "QTKVOViewController.h"
#import "QTStudent+KVO.h"
#import "QTStudent.h"

@interface QTKVOViewController ()
@property (nonatomic, strong) QTStudent *kvoStu;
@end

static void *xiaomingNameContext = &xiaomingNameContext;
static void *teacherNameContext = &teacherNameContext;

@implementation QTKVOViewController

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
    
    
    self.kvoStu = [[QTStudent alloc] initWithName:@"gtc"];
    [self.kvoStu addObserver:self forKeyPath:@"xiaoming" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:xiaomingNameContext]; //context和属性一一对应，这样就更简洁也更安全，也提高了判断的效率
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context {
    NSLog(@"ddd");
    
    // 区分不同对象不同path，给他们一个唯一的值
    if (context == xiaomingNameContext) {
        
    } else if (context == teacherNameContext) {
        
    }
}

- (void)test:(id)sender {
    self.kvoStu.xiaoming = @"dd";
}

- (void)dealloc {
    [self.kvoStu removeObserver:self forKeyPath:@"xiaoming"];
}

@end
