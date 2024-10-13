//
//  AppDelegate.m
//  StudyObjc
//
//  Created by gtc on 2020/5/30.
//  Copyright © 2020 gtc. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "QTBaseNavigtiaonController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UIViewController *rootVC = [[ViewController alloc] init];
    QTBaseNavigtiaonController *navVC = [[QTBaseNavigtiaonController alloc] initWithRootViewController:rootVC];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = navVC;
    
    [self.window makeKeyAndVisible];
    return YES;
}


#pragma mark - UISceneSession lifecycle


@end
