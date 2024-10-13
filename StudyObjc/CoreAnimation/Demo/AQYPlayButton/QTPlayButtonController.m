//
//  QTPlayButtonController.m
//  StudyObjc
//
//  Created by gtc on 2020/9/2.
//  Copyright © 2020 gtc. All rights reserved.
//

#import "QTPlayButtonController.h"
#import "QTiQiYiPlayButton.h"

@interface QTPlayButtonController ()

@property (nonatomic, strong) QTiQiYiPlayButton *iQiYiPlayButton;
@end

@implementation QTPlayButtonController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    QTiQiYiPlayButton *iqiyiBtn = [[QTiQiYiPlayButton alloc] initWithFrame:CGRectMake(100, 100, 60, 60) state:iQiYiPlayButtonStatePause];
    [iqiyiBtn addTarget:self action:@selector(iQiYiPlayMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:iqiyiBtn];
    self.iQiYiPlayButton = iqiyiBtn;
    
}

- (void)iQiYiPlayMethod {
    //通过判断当前状态 切换显示状态
    if (_iQiYiPlayButton.buttonState == iQiYiPlayButtonStatePause) {
        _iQiYiPlayButton.buttonState = iQiYiPlayButtonStatePlay;
    }else {
        _iQiYiPlayButton.buttonState = iQiYiPlayButtonStatePause;
    }
}

- (void)testTransform {
    UIView *view = [UIView new];
    CGAffineTransform tf = CGAffineTransformIdentity;
    tf = CGAffineTransformTranslate(tf, 12, 12);
    tf = CGAffineTransformScale(tf, 1.3, 1.3);
    view.transform = tf;
}

@end
