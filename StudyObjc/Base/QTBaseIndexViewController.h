//
//  QTBaseIndexViewController.h
//  StudyObjc
//
//  Created by gtc on 2020/5/30.
//  Copyright © 2020 gtc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QTBaseIndexViewController : UIViewController
@property (nonatomic, strong, readonly) NSMutableDictionary *dataDict;

- (void)configDataSource;

@end

NS_ASSUME_NONNULL_END
