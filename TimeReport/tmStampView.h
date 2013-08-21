//
//  tmStampView.h
//  TimeReport
//
//  Created by Nils Cronstedt on 2013-08-15.
//  Copyright (c) Nils Cronstedt 2013 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tmStampView : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *myText;
@property (weak, nonatomic) IBOutlet UILabel *myDatumText;
@property (weak, nonatomic) IBOutlet UITextField *myButtonText;
@property (weak, nonatomic) IBOutlet UITableView *myTabelView;
@property (strong, nonatomic) IBOutlet UIDatePicker *myDatePicker;
@property (weak, nonatomic) IBOutlet UIButton *myInButton;
@property (weak, nonatomic) IBOutlet UILabel *myTimeText;
@property (weak, nonatomic) IBOutlet UILabel *mySummaText;
@property (strong, nonatomic) IBOutlet UIButton *myTimeButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *myItem1;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *myItem2;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *myItem3;
@property (weak, nonatomic) IBOutlet UITabBarItem *myTabBarItem;
@property (weak, nonatomic) IBOutlet UITabBarItem *MyTabBar;
@property (weak, nonatomic) IBOutlet UIToolbar *myTopToolbar;
@property (weak, nonatomic) IBOutlet UITextField *mySimpleTime;

// Egna rader
@property (nonatomic,retain)  NSIndexPath *mySelectedRow;
@property(nonatomic,retain) UITextView *myTextView;
@property (nonatomic,retain)  NSString *myDbID;
@property(nonatomic,retain) NSDateFormatter *mydateFormatter;
@property(nonatomic,retain) NSDateFormatter *mytimeFormatter;
@property(nonatomic,retain) NSString *myStampTime;
@property(nonatomic,retain)  NSString *myDatum;
@property (retain, nonatomic) NSString *mySqlString;
@property(nonatomic,retain) UIToolbar *myEditBar;
@property(nonatomic,retain) UIToolbar *myTimeBar;
@property int myInOut;
@property (retain, nonatomic) NSMutableArray *myResultView;
@property int myRowId;
-(IBAction)myTimeAction;
-(IBAction)myInAction;
-(IBAction)incdate;
-(IBAction)decdate;
-(IBAction)getdate;

@property(nonatomic,retain) NSDate *mydate;

-(NSMutableArray *)myFillView;
- (IBAction) uppdateTimeDatabase;
- (void)makeButtonShiny:(UIButton*)button withBackgroundColor:(UIColor*)backgroundColor;
- (NSString *)myStringTime:(int)decimaltid;
- (NSString *)myDisplayTime:(NSString*)TimeText;

@end
