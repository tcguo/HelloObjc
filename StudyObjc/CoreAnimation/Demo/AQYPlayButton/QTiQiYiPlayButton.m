//
//  QTiQiYiPlayButton.m
//  StudyObjc
//
//  Created by gtc on 2020/9/7.
//  Copyright © 2020 gtc. All rights reserved.
//

#import "QTiQiYiPlayButton.h"
//三角动画名称
#define TriangleAnimation @"TriangleAnimation"
//右侧直线动画名称
#define RightLineAnimation @"RightLineAnimation"
#define LineColor [UIColor colorWithRed:12/255.0 green:190/255.0 blue:6/255.0 alpha:1]
//位移动画时长
static CGFloat positionDuration = 0.3f;
//其它动画时长
static CGFloat animationDuration = 0.5f;



/// 爱奇艺播放按钮动画解析 -https://www.jianshu.com/p/3546964996ff
@interface QTiQiYiPlayButton ()
@property (nonatomic, strong) CAShapeLayer *leftLineLayer;
@property (nonatomic, strong) CAShapeLayer *rightLineLayer;
@property (nonatomic, strong) CAShapeLayer *triangleLayer;
//画弧layer
@property (nonatomic, strong) CAShapeLayer *circleLayer;

//是否正在执行动画
@property (nonatomic, assign) BOOL isAnimating;

@end

@implementation QTiQiYiPlayButton

- (instancetype)initWithFrame:(CGRect)frame state:(iQiYiPlayButtonState)state{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
        _buttonState = state;
    }
    return self;
}
- (void)buildUI {
    [self setupLeftLayer];
    [self setupRightLayer];
    [self setupTriangleLayer];
    [self setupCircleLayer];
}

- (void)setupTriangleLayer {
    _triangleLayer = [CAShapeLayer layer];
    CGFloat aa = self.bounds.size.width;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.2*aa, 0.2*aa)];
    [path addLineToPoint:CGPointMake(0.2*aa, 0)];
    [path addLineToPoint:CGPointMake(aa, 0.5*aa)];
    [path addLineToPoint:CGPointMake(0.2*aa, aa)];
    [path addLineToPoint:CGPointMake(0.2*aa, 0.2*aa)];
    
    _triangleLayer.path = path.CGPath;
    _triangleLayer.strokeColor = LineColor.CGColor;
    _triangleLayer.fillColor = [UIColor clearColor].CGColor;
    _triangleLayer.fillMode = kCAFillModeForwards;
    _triangleLayer.lineWidth = [self lineWidth];
    _triangleLayer.lineCap = kCALineCapButt;
    _triangleLayer.lineJoin = kCALineJoinRound;
    _triangleLayer.strokeEnd = 0;
    [self.layer addSublayer:_triangleLayer];
}

- (void)setupLeftLayer {
    CGFloat a = self.bounds.size.width;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.2*a, 0)];
    [path addLineToPoint:CGPointMake(0.2*a, a)];
    
    _leftLineLayer = [CAShapeLayer layer];
    _leftLineLayer.path = path.CGPath;
    _leftLineLayer.fillColor = [UIColor clearColor].CGColor;
    _leftLineLayer.lineWidth = [self lineWidth];
    _leftLineLayer.strokeColor = LineColor.CGColor;
    _leftLineLayer.lineCap = kCALineCapRound;
    _leftLineLayer.lineJoin = kCALineJoinRound;
    
    [self.layer addSublayer:self.leftLineLayer];

}

- (void)setupRightLayer {
    CGFloat a = self.bounds.size.width;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.8*a, a)];
    [path addLineToPoint:CGPointMake(0.8*a, 0)];
    
    _rightLineLayer = [CAShapeLayer layer];
    _rightLineLayer.path = path.CGPath;
    _rightLineLayer.fillColor = [UIColor clearColor].CGColor;
    _rightLineLayer.strokeColor = LineColor.CGColor;
    _rightLineLayer.lineWidth = [self lineWidth];
    _rightLineLayer.lineCap = kCALineCapRound;
    _rightLineLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_rightLineLayer];
}

/**
 添加弧线过渡弧线层
 */
- (void)setupCircleLayer {
    CGFloat aa = self.bounds.size.width;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.8*aa, 0.8*aa)];
    
    //clockwise：YES为顺时针，No为逆时针
    [path addArcWithCenter:CGPointMake(0.5*aa, 0.8*aa) radius:0.3*aa startAngle:0 endAngle:M_PI clockwise:YES];
    
    _circleLayer = [CAShapeLayer layer];
    _circleLayer.path = path.CGPath;
    _circleLayer.strokeColor = LineColor.CGColor;
    _circleLayer.fillColor = [UIColor clearColor].CGColor;
    _circleLayer.fillMode = kCAFillModeForwards;
    _circleLayer.lineWidth = [self lineWidth];
    _circleLayer.lineCap = kCALineCapRound;
    _circleLayer.lineJoin = kCALineJoinRound;
    _circleLayer.strokeEnd = 0;
    
    [self.layer addSublayer:self.circleLayer];
}

- (void)setButtonState:(iQiYiPlayButtonState)buttonState {
    if (_isAnimating) {
        return;
    }
    _buttonState = buttonState;
    
    if (_buttonState == iQiYiPlayButtonStatePlay) {
        _isAnimating = YES;
        [self linePositiveAnimation];
        //再执行画弧、画三角动画
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  positionDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            [self actionPositiveAnimation];
        });
    } else if (buttonState == iQiYiPlayButtonStatePause) {//播放-》暂停
        _isAnimating = YES;
        [self acitonReverseAnimation];
    }
    
    //更新动画执行状态
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  (positionDuration + animationDuration) * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        weakSelf.isAnimating = false;
    });
}

#pragma mark 竖线动画
//暂停-》播放竖线动画
- (void)linePositiveAnimation {
    CGFloat a = self.bounds.size.width;
    
    UIBezierPath *leftPath1 = [UIBezierPath bezierPath];
    [leftPath1 moveToPoint:CGPointMake(0.2*a, 0.4*a)];
    [leftPath1 addLineToPoint:CGPointMake(0.2*a, a)];
    _leftLineLayer.path = leftPath1.CGPath;
    [_leftLineLayer addAnimation:[self pathAnimationWithDuration:positionDuration] forKey:nil];
    
    UIBezierPath *rightPath1 = [UIBezierPath bezierPath];
    [rightPath1 moveToPoint:CGPointMake(0.8*a, 0.8*a)];
    [rightPath1 addLineToPoint:CGPointMake(0.8*a, -0.2*a)];
    _rightLineLayer.path = rightPath1.CGPath;
    [_rightLineLayer addAnimation:[self pathAnimationWithDuration:positionDuration] forKey:nil];
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(positionDuration/2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIBezierPath *leftPath2 = [UIBezierPath bezierPath];
        [leftPath2 moveToPoint:CGPointMake(0.2*a, 0.2*a)];
        [leftPath2 addLineToPoint:CGPointMake(0.2*a, 0.8*a)];
        weakSelf.leftLineLayer.path = leftPath2.CGPath;
        [weakSelf.leftLineLayer addAnimation:[self pathAnimationWithDuration:positionDuration/2] forKey:nil];
        
        UIBezierPath *rightPath2 = [UIBezierPath bezierPath];
        [rightPath2 moveToPoint:CGPointMake(0.8*a, 0.8*a)];
        [rightPath2 addLineToPoint:CGPointMake(0.8*a, 0.2*a)];
        weakSelf.rightLineLayer.path = rightPath2.CGPath;
        [weakSelf.rightLineLayer addAnimation:[self pathAnimationWithDuration:positionDuration/2.f] forKey:nil];
    });
}

- (void)lineInverseAnimation {
    
}

- (void)actionPositiveAnimation {
    // 三角形动画
    [self strokeEndAnimationFrom:0 to:1 onLayer:self.triangleLayer name:TriangleAnimation duraiton:animationDuration delegate:self];
    //开始右侧线条动画
    [self strokeEndAnimationFrom:1 to:0 onLayer:self.rightLineLayer name:RightLineAnimation duraiton:animationDuration/4 delegate:self];
    
    // 开始画弧线
    [self strokeEndAnimationFrom:0 to:1 onLayer:self.circleLayer name:nil duraiton:animationDuration/4 delegate:nil];
    
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25*animationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self circleStartAnimationWithFrom:0 to:1];
    });
    
    //开始左侧线条缩短动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  animationDuration*0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        //左侧竖线动画
        [weakSelf strokeEndAnimationFrom:1 to:0 onLayer:self.leftLineLayer name:nil duraiton:positionDuration/4.f delegate:nil];
    });
}

- (void)acitonReverseAnimation {
    // 三角形动画
    [self strokeEndAnimationFrom:1 to:0 onLayer:self.triangleLayer name:TriangleAnimation duraiton:animationDuration delegate:self];
    //开始左侧线条动画
    [self strokeEndAnimationFrom:0 to:1 onLayer:self.leftLineLayer name:nil duraiton:animationDuration/2 delegate:nil];
    
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5*animationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self circleStartAnimationWithFrom:1 to:0];
    });
    
     //执行反向画弧和右侧放大动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  animationDuration*0.75 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        //右侧竖线动画
        [weakSelf strokeEndAnimationFrom:0 to:1 onLayer:self.rightLineLayer name:RightLineAnimation duraiton:positionDuration/4.f delegate:self];
        
        [self strokeEndAnimationFrom:1 to:0 onLayer:self.circleLayer name:TriangleAnimation duraiton:animationDuration/4.f delegate:nil];
       
    });
    
    
    
}

- (void)circleStartAnimationWithFrom:(CGFloat)from to:(CGFloat)to {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    animation.fromValue = @(from);
    animation.toValue = @(to);
    animation.duration = animationDuration/4;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.circleLayer addAnimation:animation forKey:nil];
}

- (void)strokeEndAnimationFrom:(CGFloat)from to:(CGFloat)to onLayer:(CALayer *)layer name:(NSString *)animationName duraiton:(CGFloat)duration delegate:(id)delegate {
    CABasicAnimation *animate = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animate.duration = duration;
    animate.delegate = delegate;
    animate.fromValue = @(from);
    animate.toValue = @(to);
    animate.fillMode = kCAFillModeForwards;
    animate.removedOnCompletion = NO;
    [animate setValue:animationName forKey:@"animationName"];
    [layer addAnimation:animate forKey:animationName];
}


#pragma mark - others


- (CABasicAnimation *)pathAnimationWithDuration:(CGFloat)duration {
    CABasicAnimation *animate = [CABasicAnimation animationWithKeyPath:@"path"];
    animate.removedOnCompletion = NO;
    animate.duration = duration;
    animate.fillMode = kCAFillModeForwards;  //该属性定义了你的动画在开始和结束时的动作
    return animate;
}
//线条宽度，根据按钮的宽度按比例设置
- (CGFloat)lineWidth {
    return self.bounds.size.width * 0.2;
}

#pragma mark - 动画开始、结束代理方法

//为了避免动画结束回到原点后会有一个原点显示在屏幕上需要做一些处理，就是改变layer的lineCap属性
-(void)animationDidStart:(CAAnimation *)anim {
    NSString *name = [anim valueForKey:@"animationName"];
    bool isTriangle = [name isEqualToString:TriangleAnimation];
    bool isRightLine = [name isEqualToString:RightLineAnimation];
    if (isTriangle) {
        _triangleLayer.lineCap = kCALineCapRound;
    }else if (isRightLine){
        _rightLineLayer.lineCap = kCALineCapRound;
    }
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSString *name = [anim valueForKey:@"animationName"];
    bool isTriangle = [name isEqualToString:TriangleAnimation];
    bool isRightLine = [name isEqualToString:RightLineAnimation];
    if (_buttonState == iQiYiPlayButtonStatePlay && isRightLine) {
        _rightLineLayer.lineCap = kCALineCapButt;
    } else if (isTriangle) {
        _triangleLayer.lineCap = kCALineCapButt;
    }
}


@end
