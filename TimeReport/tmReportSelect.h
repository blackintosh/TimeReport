//
//  tmReportSelect.h
//  TimeReport
//
//  Created by Nils Cronstedt on 2013-08-15.
//  Copyright (c) Nils Cronstedt 2013 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tmReportSelect : UITableViewController
@property (weak, nonatomic) IBOutlet UISearchBar *mySelect;
@property (weak, nonatomic) IBOutlet UITableView *myTableView1;
@property (strong, nonatomic) IBOutlet UISearchBar *mySearch;
@property (weak, nonatomic) IBOutlet UISwitch *mySelecteddate;
@property (weak, nonatomic) IBOutlet UISwitch *mySelectedkus;
- (IBAction)myDateSelected:(id)sender;
- (IBAction)myKustselected:(id)sender;

@property (strong, nonatomic) IBOutlet UISegmentedControl *mySelected;
@property (weak, nonatomic) IBOutlet UITableView *MyTableView2;
@end
