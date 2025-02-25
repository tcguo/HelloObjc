//
//  QTAffineTransformController.m
//  StudyObjc
//
//  Created by Darius Guo on 2025/2/21.
//  Copyright © 2025 gtc. All rights reserved.
//

#import "QTAffineTransformController.h"

@interface QTAffineTransformController ()

@property (nonatomic, strong) UIView *layerView;
@end

/**
 https://zsisme.gitbooks.io/ios-/content/chapter5/affine-fransforms.html
 CGAffineTransform中的“仿射”的意思是无论变换矩阵用什么值，图层中平行的两条线在变换之后任然保持平行，CGAffineTransform可以做出任意符合上述标注的变换，图5.2显示了一些仿射的和非仿射的变换：
 如下几个函数都创建了一个CGAffineTransform实例：

 CGAffineTransformMakeRotation(CGFloat angle)
 CGAffineTransformMakeScale(CGFloat sx, CGFloat sy)
 CGAffineTransformMakeTranslation(CGFloat tx, CGFloat ty
 
 
 CoreGraphics提供了一系列的函数可以在一个变换的基础上做更深层次的变换，如果做一个既要缩放又要旋转的变换，这就会非常有用了。例如下面几个函数：
 CGAffineTransformRotate(CGAffineTransform t, CGFloat angle)
 CGAffineTransformScale(CGAffineTransform t, CGFloat sx, CGFloat sy)
 CGAffineTransformTranslate(CGAffineTransform t, CGFloat tx, CGFloat ty)
 
 当操纵一个变换的时候，初始生成一个什么都不做的变换很重要--也就是创建一个CGAffineTransform类型的空值，矩阵论中称作单位矩阵，Core Graphics同样也提供了一个方便的常量：
 CGAffineTransformIdentity
 
 最后，如果需要混合两个已经存在的变换矩阵，就可以使用如下方法，在两个变换的基础上创建一个新的变换：
 CGAffineTransformConcat(CGAffineTransform t1, CGAffineTransform t2);
 
 */
@implementation QTAffineTransformController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.layerView = [[UIView alloc] init];
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    //scale by 50%
    transform = CGAffineTransformScale(transform, 0.5, 0.5);
    //rotate by 30 degrees
    transform = CGAffineTransformRotate(transform, M_PI / 180.0 * 30.0);
    //translate by 200 points
    transform = CGAffineTransformTranslate(transform, 200, 0);
    //apply transform to layer
    self.layerView.layer.affineTransform = transform;
}

@end
