//
//  tmAppDelegate.h
//  TimeReport
//
//  Created by Nils Cronstedt on 2013-08-15.
//  Copyright (c) Nils Cronstedt 2013 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tmStampView.h"

@interface tmAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property int *mySelectedPos;

@property (strong, nonatomic) tmStampView *viewController;

@end
