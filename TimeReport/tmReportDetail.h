//
//  tmReportDetail.h
//  TimeReport
//
//  Created by Nils Cronstedt on 2013-08-15.
//  Copyright (c) Nils Cronstedt 2013 All rights reserved.
//

#import <UIKit/UIKit.h>



@interface tmReportDetail : UITableViewController
@property (weak, nonatomic) IBOutlet UITableViewCell *myViewCell;
@property (retain, nonatomic) NSString *mySqlString;
@property (weak, nonatomic) IBOutlet UITableView *myView;
@property (retain, nonatomic) NSMutableArray *myResultView;
@property (retain, nonatomic) NSString * myReportText;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *myAction;
@property (retain, nonatomic) UITextView *myTextView;
- (IBAction) myActionButton;



@end
