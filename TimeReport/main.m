//
//  main.m
//  TimeReport
//
//  Created by svp on 2012-01-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "tmAppDelegate.h"
NSInteger globalVariable;
NSDate *mySelectedDate;
NSInteger globalTime;
int main(int argc, char *argv[])
{
    globalVariable = 0;
    mySelectedDate = [NSDate date];
    globalTime=1;
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([tmAppDelegate class]));
    }
}
