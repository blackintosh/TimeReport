//
//  tmStartView.h
//  TimeReport
//
//  Created by svp on 2012-01-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
@class DynamicTableView;
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface tmStartView : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
   // tmEditView *tmeditView;
    
    IBOutlet UIButton *myNote;
    IBOutlet UIButton *myButton;
    IBOutlet UIButton *myDoneButton;
    IBOutlet UIButton *myInButton;
    IBOutlet UIDatePicker *myDatePicker;
    IBOutlet UIToolbar *myToolBar;
    IBOutlet UIToolbar *myViewBar;
    IBOutlet UIToolbar *myEditBar;
    //IBOutlet UITextField *myStamptTime;
    NSString *myStampTime;
    int myInOut;
    IBOutlet UILabel *myTimeField;
    //IBOutlet UITextField *myTextField;
    NSDateFormatter *mydateFormatter;
    NSDateFormatter *mytimeFormatter;
    NSManagedObjectContext *managedObjectContext;
	NSMutableArray *eventArray;
    NSMutableArray *myResultView;
    //DB
    NSString *mySqlString;
    NSString *myDatum;
    Boolean *dbstatus;
    //DynamicTableView *myTableView;
    UITableView *myTabelView;
    UITableView *myKundView;
    UIToolbar *myTableBar;
    IBOutlet UILabel *myInfo;
    UIView *inputAccessoryView;
    UITextView *myText;
    NSIndexPath *mySelectedRow; 
    NSString *myDbID;
    UILabel *labelTid;
   // NSIndexPath *myIndex;
}
//-(IBAction)pushMyButton;
-(IBAction)myInButton;
//@property(nonatomic,retain)  NSString *myDatum;
//@property(nonatomic,retain) tmEditView *tmeditView;
@property(nonatomic,retain) UIDatePicker *myDatePicker;
@property(nonatomic,retain) UITextView *myText;
@property(nonatomic,retain) UIToolbar *myToolBar;
@property(nonatomic,retain) UIToolbar *myViewBar;
@property(nonatomic,retain) UIToolbar *myEditBar;
@property(nonatomic,retain) NSString *myStampTime;
@property int myInOut;
@property(nonatomic,retain) NSDateFormatter *mydateFormatter;
@property(nonatomic,retain) NSDateFormatter *mytimeFormatter;
@property(nonatomic,retain) UIButton *myButton;
@property (retain, nonatomic) NSString *mySqlString;
@property (retain, nonatomic) NSMutableArray *myResultView;
@property (retain, nonatomic) IBOutlet UILabel *myInfo;
@property(nonatomic,retain) UIToolbar *myTableBar;
@property (readonly, retain) UIView *inputAccessoryView;
@property (nonatomic,retain)  NSIndexPath *mySelectedRow;
@property (nonatomic,retain) UITableView *myTableView;
@property (nonatomic,retain) UITableView *myKundView;
@property (nonatomic,retain)  NSString *myDbID;
@property (nonatomic, retain) UILabel *labelTid;
//@property (nonatomic,retain) NSIndexPath *myIndex;
-(NSMutableArray *)myFillView;
//- (IBAction) saveData;

- (IBAction) uppdateTimeDatabase;
- (void)makeButtonShiny:(UIButton*)button withBackgroundColor:(UIColor*)backgroundColor;
-(void)makeLabelShiny:(UILabel*)button withBackgroundColor:(UIColor*)backgroundColor;
- (NSString *)myStringTime:(int)decimaltid;
- (void)customizeAppearance;
@end
