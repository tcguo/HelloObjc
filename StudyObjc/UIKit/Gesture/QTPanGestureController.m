//
//  QTPanGestureController.m
//  StudyObjc
//
//  Created by gtc on 2021/3/31.
//  Copyright © 2021 gtc. All rights reserved.
//

#import "QTPanGestureController.h"

@interface QTPanGestureController ()
{
    BOOL _rotateAndScale;
}
@property (nonatomic, strong) UIView *aview;
@property (nonatomic, strong) UIView *bview;
@end

@implementation QTPanGestureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    
    UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(40, 180, 200, 200)];
    aview.backgroundColor = [UIColor grayColor];
    [self.view addSubview:aview];
    self.aview = aview;
    
    UIView *bview = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    bview.backgroundColor = [UIColor redColor];
    [aview addSubview:bview];
    self.bview = bview;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(test:)];
    [self.aview addGestureRecognizer:pan];
//    self.aview.autoresizesSubviews = YES;
//    self.bview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)test:(UIPanGestureRecognizer *)pan {
    CGPoint p = [pan locationInView:self.aview];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            CGRect rect = self.bview.bounds;
            rect = CGRectInset(rect, -8, -8);
            if (CGRectContainsPoint(rect, [pan locationInView:self.bview])) {
                _rotateAndScale = YES;
            } else {
                _rotateAndScale = NO;
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if (!_rotateAndScale) {
                return;
            }
            CGPoint movePoint = [pan translationInView:self.aview];
            [pan setTranslation:CGPointMake(0, 0) inView:self.aview];
            CGFloat selfX = self.bview.frame.origin.x;
            CGFloat selfY = self.bview.frame.origin.y;
            CGFloat selfWidth = self.bview.frame.size.width;
            CGFloat selfHeight = self.bview.frame.size.height;
//            CGFloat newWidth2 = selfWidth - movePoint.x;
            CGRect newFrame2 = CGRectMake(selfX+movePoint.x, selfY, selfWidth+movePoint.x, selfHeight+movePoint.x);
            
            
            CGFloat selfaX = self.aview.frame.origin.x;
            CGFloat selfaY = self.aview.frame.origin.y;
            CGFloat selfaWidth = self.aview.frame.size.width;
            CGFloat selfaHeight = self.aview.frame.size.height;
            CGRect newFrame3 = CGRectMake(selfaX+movePoint.x, selfaY, selfaWidth+movePoint.x, selfaHeight+movePoint.x);
            self.bview.bounds = newFrame2;
//            self.bview.frame = self.aview.bounds;
        }
        default:
            break;
    }
}


@end
