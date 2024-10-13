//
//  QTBaseViewController.h
//  StudyObjc
//
//  Created by gtc on 2020/5/30.
//  Copyright © 2020 gtc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QTBaseViewController : UIViewController


- (UIView *)createViewWithFrame:(CGRect)frame;
 
- (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title target:(id)target selector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
