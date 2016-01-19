//
//  AppDelegate.m
//  MyApp
//
//  Created by lrb on 15/12/28.
//  Copyright © 2015年 WanRong. All rights reserved.
//

#import "AppDelegate.h"

CFAbsoluteTime StartTime;

@interface AppDelegate ()<COSTouchVisualizerWindowDelegate>

@end

@implementation AppDelegate

- (COSTouchVisualizerWindow *)window {
    static COSTouchVisualizerWindow *visWindow = nil;
    if (!visWindow) visWindow = [[COSTouchVisualizerWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    visWindow.touchVisualizerWindowDelegate = self;
    [visWindow setFillColor:[UIColor colorWithWhite:1 alpha:0.7]];
    [visWindow setStrokeColor:[UIColor colorWithWhite:1 alpha:1]];
//    [visWindow setTouchAlpha:0.4];
    // Ripple Color
    [visWindow setRippleFillColor:[UIColor colorWithWhite:0 alpha:0.7]];
    [visWindow setRippleStrokeColor:[UIColor colorWithWhite:0 alpha:1]];
    [visWindow setRippleAlpha:0.1];
//    visWindow.stationaryMorphEnabled = NO;
    return visWindow;
}
- (BOOL)touchVisualizerWindowShouldAlwaysShowFingertip:(COSTouchVisualizerWindow *)window
{
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    dispatch_async(dispatch_get_main_queue(), ^{
        GJLog(@"Lauched in %f seconds.", (CFAbsoluteTimeGetCurrent() - StartTime));
    });
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
