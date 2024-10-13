//
//  YTMakeupItemCell.h
//  StudyObjc
//
//  Created by gtc on 2020/9/9.
//  Copyright © 2020 gtc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YTMakeupItemCell : UICollectionViewCell

@property (nonatomic, assign) BOOL clearBackground;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *label;

@end

NS_ASSUME_NONNULL_END
