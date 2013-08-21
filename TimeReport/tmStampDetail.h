//
//  tmStampDetail.h
//  TimeReport
//
//  Created by Nils Cronstedt on 2013-08-15.
//  Copyright (c) Nils Cronstedt 2013 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tmStampDetail : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *myInTime;
@property (weak, nonatomic) IBOutlet UITextField *myOutTime;
@property (weak, nonatomic) IBOutlet UITextField *myKund;
@property (weak, nonatomic) IBOutlet UITextView *myNote;

@property (retain, nonatomic) NSString *mySqlString;
@property (retain, nonatomic) NSArray *myResultView;
@end
