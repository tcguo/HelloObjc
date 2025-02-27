//
//  QTHitTestAndGestureController.m
//  StudyObjc
//
//  Created by gtc on 2025/2/24.
//  Copyright © 2025 gtc. All rights reserved.
//

#import "QTHitTestAndGestureController.h"

@interface QTHitTestAndGestureController ()

@property (nonatomic, strong) QTHitTestViewA *aview;
@property (nonatomic, strong) QTTapGestureViewB *bview;

@end

@implementation QTHitTestAndGestureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.bview = [[QTTapGestureViewB alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
    [self.view addSubview:self.bview];
    
    self.aview = [[QTHitTestViewA alloc] initWithFrame:CGRectZero];
    [self.bview addSubview:self.aview];
    [self.aview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bview).offset(10);
        make.left.equalTo(self.bview).offset(10);
        make.width.equalTo(@200);
        make.height.equalTo(@200);
        
    }];
    self.bview.backgroundColor = [UIColor yellowColor];
    self.aview.backgroundColor = [UIColor grayColor];
    
    //输出结果，aview的事件响应被手势响应链取消了。
    /**
     QTHitTestViewA: touchesBegan
     QTTapGestureViewB: didTapAction
     QTHitTestViewA: touchesCancelled
     */
    
    /**
     
     UITouchesEvent 遍历了一个 View 数组，系统通过 Hit-Testing 过程得到了适合响应触摸事件的 View D，随后会根据这个 View 的层级关系得到一个响应链 View 数组 [D_view, C_view, A_view, ..., ZTWindow] 然后遍历这个数组去依次判断每个 View 上的 UIGestureRecognizer 是否要接收触摸事件，没有绑定到这个响应链 View 数组上的 UIGestureRecognizer 不再有机会去处理触摸事件。
     
     UIWindow 会先将触摸事件发送给 Hit-Testing 返回的 View 和它的父 View 上的 UIGestureRecognizer，然后才会发送给这个 View 本身，如果 UIGestureRecognizer 成功识别了这个手势，之后 UIWindow 不会再向 View 发送触摸事件，并且会取消之前发送的触摸事件。
     
     */
}

@end

@implementation QTHitTestViewA


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"QTHitTestViewA: touchesBegan");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"QTHitTestViewA: touchesMoved");
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"QTHitTestViewA: touchesEnded");
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"QTHitTestViewA: touchesCancelled");
}

@end

@implementation QTTapGestureViewB

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAction)];
        [self addGestureRecognizer:tapGR];
    }
    return self;
}

- (void)didTapAction {
    NSLog(@"QTTapGestureViewB: didTapAction");
}

@end

