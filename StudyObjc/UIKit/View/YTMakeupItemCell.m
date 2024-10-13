//
//  YTMakeupItemCell.m
//  StudyObjc
//
//  Created by gtc on 2020/9/9.
//  Copyright © 2020 gtc. All rights reserved.
//

#import "YTMakeupItemCell.h"
//#import <Masonry/Masonry.h>

@implementation YTMakeupItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.label];
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(self.mas_width);
        }];
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.centerX.mas_equalTo(0);
        }];
        self.label.text = @"桃花";
    }
    
    return self;
}
- (UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.cornerRadius = 6;
        _iconView.layer.borderWidth = 1.5;
        _iconView.userInteractionEnabled = YES;
    }
    return _iconView;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:14];
        _label.textColor = [UIColor redColor];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}


@end
