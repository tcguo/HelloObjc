//
//  QTiQiYiPlayButton.h
//  StudyObjc
//
//  Created by gtc on 2020/9/7.
//  Copyright © 2020 gtc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,iQiYiPlayButtonState) {
    iQiYiPlayButtonStatePause = 0,
    iQiYiPlayButtonStatePlay
};


@interface QTiQiYiPlayButton : UIButton

@property (nonatomic, assign) iQiYiPlayButtonState buttonState;
- (instancetype)initWithFrame:(CGRect)frame state:(iQiYiPlayButtonState)state;
@end

NS_ASSUME_NONNULL_END
