//
//  QTToViewController.h
//  StudyObjc
//
//  Created by gtc on 2020/9/10.
//  Copyright © 2020 gtc. All rights reserved.
//

#import "QTBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QTToViewController : QTBaseViewController

- (instancetype)initWithImage:(UIImage *)image;
@property (nonatomic, assign) CGRect fromRect;

@end

NS_ASSUME_NONNULL_END
