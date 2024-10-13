//
//  MacroDefine.h
//  StudyObjc
//
//  Created by gtc on 2020/9/10.
//  Copyright © 2020 gtc. All rights reserved.
//

#ifndef MacroDefine_h
#define MacroDefine_h


// screen
#define SCREEN_SCALE [UIScreen mainScreen].scale
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define SCREEN_RATIO_WIDTH  (SCREEN_WIDTH / 375.0)
#define SCREEN_RATIO_HEIGHT (SCREEN_HEIGHT / 667.0)

#define isIPhoneX_Series \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})


#pragma mark - Import
#import "UIColor+Hex.h"
#import <YYKit/YYKit.h>
#endif /* MacroDefine_h */
