//  tmKundDetail.h
//  TimeReport
//
//  Created by Nils Cronstedt on 2013-08-15.
//  Copyright (c) Nils Cronstedt 2013 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tmKundDetail : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationItem *myNavBar;
@property (weak, nonatomic) IBOutlet UITextField *myKundNamn;
@property (weak, nonatomic) IBOutlet UITextField *myKundAdress1;
@property (weak, nonatomic) IBOutlet UITextField *myKundAdress2;
@property (weak, nonatomic) IBOutlet UITextField *myKontaktNamn;
@property (weak, nonatomic) IBOutlet UITextField *myKontaktTel;
@property (weak, nonatomic) IBOutlet UITextField *myKontaktEpost;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *MySave;
@property (weak, nonatomic) IBOutlet UITextView *myExtraInfo;

@property (weak, nonatomic) IBOutlet UINavigationItem *myNavBar2;

@property (retain, nonatomic) NSString *mySqlString;
@property (retain, nonatomic) NSArray *myResultView;
@property (retain, nonatomic) UIToolbar *myToolBar;
@property CGFloat animatedDistance;
//-(IBAction)dismissKeyboard;
- (IBAction)myUpdate:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationItem *ToolBar;

@property (weak, nonatomic) IBOutlet UIScrollView *myScroll;
@property int myKundId;
@property int nyKund;
@end
