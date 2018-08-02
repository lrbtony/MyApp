//
//  main.m
//  MyApp
//
//  Created by lrb on 18/07/20.
//  Copyright © 2018年 liangruibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

extern CFAbsoluteTime StartTime;

int main(int argc, char * argv[]) {
    @autoreleasepool {
        StartTime = CFAbsoluteTimeGetCurrent();
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
