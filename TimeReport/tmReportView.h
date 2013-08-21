//
//  tmReportView.h
//  TimeReport
//
//  Created by Nils Cronstedt on 2013-08-15.
//  Copyright (c) Nils Cronstedt 2013 All rights reserved.
//  

#import <UIKit/UIKit.h>


@interface tmReportView : UIViewController<UITableViewDelegate, UITableViewDataSource>{

NSMutableArray *myResultView;
//DB
NSString *mySqlString;

UITableView *myTabelView;


    
}


@property (retain, nonatomic) NSString *mySqlString;
@property (retain, nonatomic) NSMutableArray *myResultView;
//@property (retain, nonatomic) NSMutableArray *myReportData;
@property (nonatomic,retain) UITableView *myTableView;



//-(NSMutableArray *)myReportData;

//- (IBAction) uppdate;
@end
