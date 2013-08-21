//
//  tmKundDetail.m
//  TimeReport
//
//  Created by Nils Cronstedt on 2013-08-15.
//  Copyright (c) Nils Cronstedt 2013 All rights reserved.
//

#import "tmKundDetail.h"
#import "Database.h"
#import "tmKundSelect.h"

@implementation tmKundDetail
@synthesize ToolBar;
@synthesize myScroll;
@synthesize myNavBar;
@synthesize myKundNamn;
@synthesize myKundAdress1;
@synthesize myKundAdress2;
@synthesize myKontaktNamn;
@synthesize myKontaktTel;
@synthesize myKontaktEpost;
@synthesize myExtraInfo;
@synthesize myNavBar2;

@synthesize mySqlString;
@synthesize myResultView;
@synthesize myToolBar;
@synthesize myKundId;
@synthesize nyKund;

@synthesize animatedDistance;
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

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
/*
-(IBAction)myUpadateNykund{

    nyKund = 1;
    myKundNamn.text = @"";
    myKundAdress1.text = @"";
    myKundAdress2.text = @"";
    myKontaktNamn.text = @"";
    myKontaktTel.text = @"";
    myKontaktEpost.text = @"";
    //myExtraInfo.text = @"Notest";
    //myExtraInfo.text = @"rgsfgsdfgsdfgsdhfsfg";
    myExtraInfo.text = [myExtraInfo.text stringByAppendingString:@"lzjfhasfhjahjflajlfjaslkdfjlkasjdf"];
}
*/
#pragma mark - View lifecycle


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //[[self navigationController] setNavigationBarHidden:YES animated:YES];
    //myToolBar.hidden = NO;
    CGRect textFieldRect = [self.myScroll.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.myScroll.window convertRect:self.myScroll.bounds fromView:self.myScroll];
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =  midline - viewRect.origin.y  - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =  (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    CGRect viewFrame = self.myScroll.frame;//.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.myScroll setFrame:viewFrame];
    
    [UIView commitAnimations];

    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.myScroll.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.myScroll setFrame:viewFrame];
     //myToolBar.hidden = YES;
    [UIView commitAnimations];

}

// Text view

- (void)textViewDidBeginEditing:(UITextView *)textField
{
    
    //myToolBar.hidden = NO;
    //[[self navigationController] setNavigationBarHidden:YES animated:YES];
    CGRect textFieldRect = [self.myScroll.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.myScroll.window convertRect:self.myScroll.bounds fromView:self.myScroll];
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =  midline - viewRect.origin.y  - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =  (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    CGRect viewFrame = self.myScroll.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.myScroll setFrame:viewFrame];
    
    [UIView commitAnimations];

}

- (void)textViewDidEndEditing:(UITextView *)textField
{
    CGRect viewFrame = self.myScroll.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.myScroll setFrame:viewFrame];
     //myToolBar.hidden = YES;
    [UIView commitAnimations];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
     //myToolBar.hidden = YES;
    return YES;
}/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [myKundNamn resignFirstResponder];
    [myKundNamn resignFirstResponder];
    [myKundAdress1 resignFirstResponder];
    [myKundAdress2 resignFirstResponder];
    [myKontaktNamn resignFirstResponder];
    [myKontaktEpost resignFirstResponder];
    [myKontaktTel resignFirstResponder];
    [myExtraInfo resignFirstResponder];
    //myToolBar.hidden = YES;
    //[[self navigationController] setNavigationBarHidden:NO animated:YES];
   
    database *mydatabase =[[database alloc] init];
    mySqlString = [NSString stringWithFormat:@"update status set pos = '0'"];
    [mydatabase addData:mySqlString];
    
    if (nyKund == 0){
        mySqlString = [NSString stringWithFormat:@"UPDATE KUND set namn = \"%@\",adress = \"%@\",gata = \"%@\",kontakt = \"%@\",tel = \"%@\",epost = \"%@\",extra = \"%@\" where ID = \"%d\"",myKundNamn.text,myKundAdress1.text,myKundAdress2.text,myKontaktNamn.text,myKontaktTel.text,myKontaktEpost.text,myExtraInfo.text,myKundId];
        [mydatabase addData:mySqlString];
    } else {
        
        mySqlString = [NSString stringWithFormat:@"insert into KUND (namn,adress,gata,kontakt,tel,epost,extra) values (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",myKundNamn.text,myKundAdress1.text,myKundAdress2.text,myKontaktNamn.text,myKontaktTel.text,myKontaktEpost.text,myExtraInfo.text];
        nyKund = 0;
        [mydatabase addData:mySqlString];
        mySqlString = [NSString stringWithFormat:@"select ID from kund where namn = '%@'", myKundNamn.text];
        myKundId = [[mydatabase getData:mySqlString] intValue];
        mySqlString = [NSString stringWithFormat:@"update status set kund = '%d'", myKundId];
        [mydatabase addData:mySqlString];
    }
    
     
     tmKundSelect *mykundselect =[[tmKundSelect alloc] init];
    [mykundselect.myTabelView reloadData];
}
  */
/*
-(IBAction)dismissKeyboard
{
    
    //[myKundNamn resignFirstResponder];
    //[myKundNamn resignFirstResponder];
    //[myKundAdress1 resignFirstResponder];
    //[myKundAdress2 resignFirstResponder];
    //[myKontaktNamn resignFirstResponder];
    //[myKontaktEpost resignFirstResponder];
    //[myKontaktTel resignFirstResponder];
    //[myExtraInfo resignFirstResponder];
    //myToolBar.hidden = YES;
    //[[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    database *mydatabase =[[database alloc] init];
    mySqlString = [NSString stringWithFormat:@"update status set pos = '0'"];
    [mydatabase addData:mySqlString]; 
    NSString *notes = myExtraInfo.text;
    if (nyKund == 0){
            mySqlString = [NSString stringWithFormat:@"UPDATE KUND set namn = \"%@\",adress = \"%@\",gata = \"%@\",kontakt = \"%@\",tel = \"%@\",epost = \"%@\",extra = \"%@\" where ID = \"%d\"",myKundNamn.text,myKundAdress1.text,myKundAdress2.text,myKontaktNamn.text,myKontaktTel.text,myKontaktEpost.text,myExtraInfo.text,myKundId];
            [mydatabase addData:mySqlString];
        } else {
            
            mySqlString = [NSString stringWithFormat:@"insert into KUND (namn,adress,gata,kontakt,tel,epost,extra) values (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",myKundNamn.text,myKundAdress1.text,myKundAdress2.text,myKontaktNamn.text,myKontaktTel.text,myKontaktEpost.text,myExtraInfo.text];
            nyKund = 0;
            [mydatabase addData:mySqlString];
            mySqlString = [NSString stringWithFormat:@"select ID from kund where namn = '%@'", myKundNamn.text];
            myKundId = [[mydatabase getData:mySqlString] intValue];
            mySqlString = [NSString stringWithFormat:@"update status set kund = '%d'", myKundId];
            [mydatabase addData:mySqlString];
        }
        
    tmKundSelect *mykundselect =[[tmKundSelect alloc] init];
    [mykundselect.myTabelView reloadData];
    }
*/
- (IBAction)myUpdate:(id)sender{
    database *mydatabase =[[database alloc] init];
    mySqlString = [NSString stringWithFormat:@"update status set pos = '0'"];
    [mydatabase addData:mySqlString];
  //  NSString *notes = myExtraInfo.text;
    if (nyKund == 0){
        mySqlString = [NSString stringWithFormat:@"UPDATE KUND set namn = \"%@\",adress = \"%@\",gata = \"%@\",kontakt = \"%@\",tel = \"%@\",epost = \"%@\",extra = \"%@\" where ID = \"%d\"",myKundNamn.text,myKundAdress1.text,myKundAdress2.text,myKontaktNamn.text,myKontaktTel.text,myKontaktEpost.text,myExtraInfo.text,myKundId];
        [mydatabase addData:mySqlString];
    } else {
        
        mySqlString = [NSString stringWithFormat:@"insert into KUND (namn,adress,gata,kontakt,tel,epost,extra) values (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",myKundNamn.text,myKundAdress1.text,myKundAdress2.text,myKontaktNamn.text,myKontaktTel.text,myKontaktEpost.text,myExtraInfo.text];
        nyKund = 0;
        [mydatabase addData:mySqlString];
        mySqlString = [NSString stringWithFormat:@"select ID from kund where namn = '%@'", myKundNamn.text];
        myKundId = [[mydatabase getData:mySqlString] intValue];
        mySqlString = [NSString stringWithFormat:@"update status set kund = '%d'", myKundId];
        [mydatabase addData:mySqlString];
    }
    
    tmKundSelect *mykundselect =[[tmKundSelect alloc] init];
    [mykundselect.myTabelView reloadData];
     [self.navigationController popViewControllerAnimated:YES];

}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    nyKund = 0;
    database *mydatabase =[[database alloc] init];

    mySqlString = @"SELECT kund FROM status";
    myKundId = [[mydatabase getData:mySqlString] intValue];
    mySqlString = @"SELECT pos FROM status";
    nyKund = [[mydatabase getData:mySqlString] intValue];
    mySqlString = [NSString stringWithFormat:@"update status set pos = '0'"];
    [mydatabase addData:mySqlString]; 

    if (nyKund == 0 && myKundId != 0){
    mySqlString = [NSString stringWithFormat:@"SELECT * FROM KUND WHERE ID = '%d'", myKundId];
    myResultView = [mydatabase getKundDetail:mySqlString];
    
    myKundNamn.text = [myResultView objectAtIndex:(0)];
    myKundAdress1.text = [myResultView objectAtIndex:(1)];
    myKundAdress2.text = [myResultView objectAtIndex:(2)];
    myKontaktNamn.text = [myResultView objectAtIndex:(3)];
    myKontaktTel.text = [myResultView objectAtIndex:(4)];
    myKontaktEpost.text = [myResultView objectAtIndex:(5)];
    myExtraInfo.text = [myResultView objectAtIndex:(6)];
    } else {
        myKundNamn.text = @"";
        myKundAdress1.text = @"";
        myKundAdress2.text = @"";
        myKontaktNamn.text = @"";
        myKontaktTel.text = @"";
        myKontaktEpost.text = @"";
        myExtraInfo.text = @" ";
        //myExtraInfo.text = [myExtraInfo.text stringByAppendingString:@"lzjfhasfhjahjflajlfjaslkdfjlkasjdf"];
    }
   // myToolBar = [[UIToolbar alloc] init];
   // [myToolBar setFrame:CGRectMake(0,0,320,44)];
   // UIBarButtonItem *BtnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
   // UIBarButtonItem *myCancellItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissKeyboard)];
   // NSArray *buttons = [NSArray arrayWithObjects:  BtnSpace, myCancellItem, nil];
    //[myToolBar setItems: buttons animated:NO];
    //myToolBar.hidden = YES;
    //[self.view addSubview:myToolBar];
}


- (void)viewDidUnload
{
    [self setMyKundNamn:nil];
    [self setMyKundAdress1:nil];
    [self setMyKundAdress2:nil];
    [self setMyKontaktNamn:nil];
    [self setMyKontaktTel:nil];
    [self setMyKontaktEpost:nil];
    [self setMyExtraInfo:nil];
    [self setMyNavBar:nil];
    [self setToolBar:nil];
    [self setMyScroll:nil];
    [self setMyNavBar:nil];
    [self setMyNavBar2:nil];
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
