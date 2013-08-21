//
//  mySettingsViewController.h
//  myWorkTime
//
//  Created by Nils Cronstedt on 2013-08-15.
//  Copyright (c) Nils Cronstedt 2013 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mySettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *myEditStyle;
@property (retain, nonatomic) UIStepper *stepper;
@property int loop;
-(IBAction)changeSeg;
-(IBAction)mylink;
//- (IBAction) toggleSwitch: (id) sender;
-(IBAction)myDelData;
@end
