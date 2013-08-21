//
//  tmStampDetail.m
//  TimeReport
//
//  Created by Nils Cronstedt on 2013-08-15.
//  Copyright (c) Nils Cronstedt 2013 All rights reserved.
//

#import "tmStampDetail.h"
#import "Database.h"

@implementation tmStampDetail
@synthesize myInTime;
@synthesize myOutTime;
@synthesize myKund;
@synthesize myNote;
@synthesize mySqlString;
@synthesize myResultView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    database *mydatabase =[[database alloc] init];
    
    mySqlString = @"SELECT kund FROM status";
    int myKundId = [[mydatabase getData:mySqlString] intValue];
    mySqlString = @"SELECT pos FROM status";
    int nyKund = 0;
    if (nyKund == 0 ){
        mySqlString = [NSString stringWithFormat:@"SELECT * FROM KUND WHERE ID = \"%d\"", myKundId];
        myResultView = [mydatabase getKundDetail:mySqlString];
    }
    
}


- (void)viewDidUnload
{
    //[self setMyInTime:nil];
    //[self setMyOutTime:nil];
    //[self setMyKund:nil];
    //[self setMyNote:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
