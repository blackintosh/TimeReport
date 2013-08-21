//
//  tmKundSelect.h
//  TimeReport
//
//  Created by Nils Cronstedt on 2013-08-15.
//  Copyright (c) Nils Cronstedt 2013 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tmKundSelect : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *myTabelView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *myAddButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *myNewButton;

@property (retain, nonatomic) NSString *mySqlString;
@property (retain, nonatomic) NSMutableArray *myResultView;
@property int myRowId;
@property (retain, nonatomic) NSString *myKund;

-(NSMutableArray *)myReportData;

//- (IBAction) uppdate;
//-(void)mySelectedRow:(int)myRow;
//-(IBAction) myNew;
@end
