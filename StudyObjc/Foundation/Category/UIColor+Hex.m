//
//  UIColor+Hex.m
//  StudyObjc
//
//  Created by gtc on 2020/9/10.
//  Copyright © 2020 gtc. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIColor *)colorFromHex:(UInt32)colorHex {
    return [UIColor colorWithRed:((float)((colorHex & 0xFF0000) >> 16))/255.0 green:((float)((colorHex & 0xFF00) >> 8))/255.0 blue:((float)(colorHex & 0xFF))/255.0 alpha:1.];
}

+ (instancetype)colorFromHex:(UInt32)colorHex withAlpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((colorHex & 0xFF0000) >> 16))/255.0 green:((float)((colorHex & 0xFF00) >> 8))/255.0 blue:((float)(colorHex & 0xFF))/255.0 alpha:alpha];
}

+ (instancetype)colorFromRGB:(CGFloat)R G:(CGFloat)G B:(CGFloat)B
{
    return [self colorFromRGB:R G:G B:B alpha:1.0];
}
+ (instancetype)colorFromRGB:(CGFloat)R G:(CGFloat)G B:(CGFloat)B alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:alpha];
}

+ (UIColor *)colorWithHexString: (NSString *)color{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (instancetype)randomColor {
    CGFloat r = arc4random() % 256 / 255.0;
    CGFloat g = arc4random() % 256 / 255.0;
    CGFloat b = arc4random() % 256 / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}



@end
