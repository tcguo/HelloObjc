//
//  QTStudent.h
//  StudyObjc
//
//  Created by gtc on 2023/8/10.
//  Copyright © 2023 gtc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 内联函数
/* 内联函数（又被称为在线函数或编译时期展开函数）是指在用inline修饰的函数（这里指的是C++或者C语言的函数）。
 
  相较于普通函数：
  1、普通函数（没有inline修饰）汇编时会出现Call指令，而调用Call指令需要
  2、函数之间的调用实则内存地址之间的调用，当函数调用执行完毕后会返回到原来执行函数的地址，所有函数调用有一定的时间开销。
     内联函数减少了调用开销，提高了效率（执行速度较普通函数快一些）
  3、集成了宏的优点（函数支持用宏代码替换）
  
  相较于宏：
  1、避免了宏需要的预编译，inline修饰的函数也是函数，不需要预编译
  2、可以使用当前类的私有成员@private及保护成员@protected
  3、在调用一个内联函数时会对参数进行校验，保证调用正确。

 */
static inline int add(int a, int b) {
    return a + b;
}


@protocol QTStudentDelegate <NSObject>
- (void)run;
- (NSString *)printWithlog:(NSString *)log;
@end

@interface QTStudent : NSObject

@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int male;
@property (nonatomic, weak) id<QTStudentDelegate> delegate; // weak修饰
@property (nonatomic, strong) NSMutableArray<NSString *> *marray;
@property (nonatomic, copy) NSArray<QTStudent *> *arrList;

- (instancetype)initWithName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
