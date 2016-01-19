//
//  main.m
//  MyApp
//
//  Created by lrb on 15/12/28.
//  Copyright © 2015年 WanRong. All rights reserved.
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
