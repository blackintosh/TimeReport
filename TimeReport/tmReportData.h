//
//  tmReportData.h
//  TimeReport
//
//  Created by Nils Cronstedt on 2013-08-15.
//  Copyright (c) Nils Cronstedt 2013 All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>

@interface tmReportData : UITableViewController
@property (weak, nonatomic) IBOutlet UITableView *myTabelView;
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *myExport;
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *myReportSelect;
//@property (retain)MFMailComposeViewController *picker;
@property (retain, nonatomic) NSString *mySqlString;
@property (retain, nonatomic) NSMutableArray *myResultView;
@property (retain, nonatomic) NSString * myReportText;
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property int mySortId;
@property int myGrupId;
-(NSMutableArray *)myReportData;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *myAction;
- (IBAction) myActionButton;
//- (IBAction) uppdate;


@end
