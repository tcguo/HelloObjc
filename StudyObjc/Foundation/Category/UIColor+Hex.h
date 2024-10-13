//
//  UIColor+Hex.h
//  StudyObjc
//
//  Created by gtc on 2020/9/10.
//  Copyright © 2020 gtc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)

+ (UIImage *)createImageWithColor:(UIColor *)color;
+ (UIColor *)colorFromHex:(UInt32)colorHex;

+ (UIColor *)colorWithHexString:(NSString *)color;

+ (instancetype)colorFromHex:(UInt32)colorHex withAlpha:(CGFloat)alpha;

+ (instancetype)colorFromRGB:(CGFloat)R G:(CGFloat)G B:(CGFloat)B;
+ (instancetype)colorFromRGB:(CGFloat)R G:(CGFloat)G B:(CGFloat)B alpha:(CGFloat)alpha;

- (UIColor *)hightlightedColor;

+ (instancetype)randomColor;


@end

NS_ASSUME_NONNULL_END
