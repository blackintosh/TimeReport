//
//  tmReportDetail.m
//  TimeReport
//
//  Created by Nils Cronstedt on 2013-08-15.
//  Copyright (c) Nils Cronstedt 2013 All rights reserved.
//

#import "tmReportDetail.h"
#import "Database.h"
#import "CustomAlert.h"
#import "QuartzCore/QuartzCore.h"
#import <MessageUI/MFMailComposeViewController.h>

@implementation tmReportDetail
@synthesize myView;
@synthesize myViewCell;
@synthesize mySqlString, myReportText, myResultView;
@synthesize myAction;
@synthesize myTextView;



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
-(NSMutableArray *)myReportData
{
    database *mydatabase =[[database alloc] init];
    // Bygga SQL frågor
    mySqlString = @"SELECT sql FROM status";
    mySqlString = [mydatabase getData:mySqlString];
    myResultView = [mydatabase getDataView:mySqlString];
    return  myResultView;
}

- (void)MyEditView:(NSIndexPath *)indexPath
{
    
    // mySelectedRow = myTableView.indexPathForSelectedRow;
    // NSUInteger pos = [mySelectedRow  row];
    // UITableViewCell *myCell = [myTableView cellForRowAtIndexPath:myIndex];
    UITableViewCell *myCell = [myView cellForRowAtIndexPath:indexPath];
    NSString *rad = myCell.detailTextLabel.text;
    if (rad == nil){
        return;
    }
    NSString *intid = [rad substringWithRange: NSMakeRange (4, 5)];
    NSString *datum = [myCell.textLabel.text substringWithRange: NSMakeRange (6, 10)];    database *mydatabase =[[database alloc] init];
    mySqlString = [NSString stringWithFormat:@"SELECT ID FROM TIME WHERE INTID = '%@' and datum = '%@'",intid,datum]; 
    NSString *myDbID = [mydatabase getData:mySqlString];
    mySqlString = [NSString stringWithFormat:@"SELECT NOTES FROM NOTE WHERE TIME = \"%@\"",myDbID]; 
    NSString *myTextString = [mydatabase getData:mySqlString];
    /*
    int i = myTextString.length;
    i = i/20;
    myTextView = [[UITextView alloc] initWithFrame:CGRectMake(100,45,200,30)];
    myTextView.backgroundColor = [UIColor colorWithHue:0.58 saturation:0.63 brightness:0.79 alpha:1];
    [[myTextView layer] setBorderColor:[[UIColor darkGrayColor] CGColor]];
    [[myTextView layer] setBorderWidth:1.0];
    [[myTextView layer] setCornerRadius:15];
    [myTextView setClipsToBounds: YES];
    myTextView.text = myTextString;
    myTextView.font = [UIFont fontWithName:@"Helvetica" size:20.0]; 
    myTextView.hidden = NO;
    //[UIView beginAnimations:nil context:nil];
    //[UIView setAnimationDuration:0.5];
    //[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
    [self.view addSubview:myTextView];
    //[UIView commitAnimations]; 
*/
    [CustomAlert setBackgroundColor:[UIColor whiteColor] 
                    withStrokeColor:[UIColor greenColor]]; 
    CustomAlert *alert = [[CustomAlert alloc] initWithTitle:myTextString 
    message:@""
        delegate:nil 
        cancelButtonTitle:@"OK" 
        otherButtonTitles: nil];
    
    
      
    [alert show];
    
/*
    myEditBar = [[UIToolbar alloc] init];
    [myEditBar setFrame:CGRectMake(0,0,320,44)];
    UIBarButtonItem *mySaveItem = [[UIBarButtonItem alloc] initWithTitle:@"Save"style:UIBarButtonItemStyleBordered target:self action:@selector(SaveButton)];
    UIBarButtonItem *BtnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *myCancellItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(CancelEditButton)];
    NSArray *buttons = [NSArray arrayWithObjects: mySaveItem, BtnSpace, myCancellItem, nil];
    [myEditBar setItems: buttons animated:NO];
    myEditBar.hidden = NO;
    [self.view addSubview:myEditBar];
    
    myTextView = [[UITextView alloc] initWithFrame:CGRectMake(0,45,320,420)];
    myTextView.text = myTextString;
    myTextView.font = [UIFont fontWithName:@"Helvetica" size:20.0]; 
    myTextView.hidden = NO;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
    [self.view addSubview:myTextView];
    [UIView commitAnimations]; 
     */
    
}
- (void)accessoryButtonTapped:(id)sender event:(id)event
{
	NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self.myView];
	NSIndexPath *indexPath = [self.myView indexPathForRowAtPoint: currentTouchPosition];
	if (indexPath != nil)
	{
        //int i = 1;
        //myIndex = indexPath;
        [self MyEditView:indexPath];
	}
}/*
    mySqlString = @"SELECT sort FROM status";
    int mySortId = [[mydatabase getData:mySqlString] intValue];
    mySqlString = @"SELECT grup FROM status";
    int myGrupId = [[mydatabase getData:mySqlString] intValue];
    mySqlString = @"SELECT pos FROM status";
    int myOrderId = [[mydatabase getData:mySqlString] intValue];
        
    // osorterad
    if ( myGrupId == 2 ) {
        myReportText = @"Datum:";
        mySqlString = [NSString stringWithFormat:@"select timmar,(select namn from kund where id = t.kund),datum from time t order by datum limit %d", myOrderId];
        myResultView = [mydatabase getReportView:mySqlString];
        
    }
    // Per dag
    if (mySortId ==1 && myGrupId == 0 ) {
        myReportText = @"Dag:";
        mySqlString = [NSString stringWithFormat:@"select sum(timmar),' ',datum from time t group by datum order by datum limit %d", myOrderId];
        myResultView = [mydatabase getReportView:mySqlString];
    }
    
    if (mySortId ==1 && myGrupId == 1 ) {
        myReportText = @"Dag:";
        mySqlString = [NSString stringWithFormat:@"select sum(timmar),(select namn from kund where id = t.kund),datum from time t group by datum,kund order by datum limit %d", myOrderId];
        myResultView = [mydatabase getReportView:mySqlString];
    }
    // Per vecka
    if (mySortId == 2 && myGrupId == 0 ) {
        myReportText = @"Vecka:";
        mySqlString = [NSString stringWithFormat:@"SELECT  Sum(TIMMAR) As Tid,' ',strftime('\%Y v\%w',DATUM) AS Date FROM TIME t Group By 3 limit %d", myOrderId];
        myResultView = [mydatabase getReportView:mySqlString];
        int pos = 3 * (myOrderId - 1);
        NSMutableString *datum = [myResultView objectAtIndex:(pos +2)];
        NSString *kund  = [myResultView objectAtIndex:(pos +1)];
        
    }
    
    if (mySortId == 2 && myGrupId == 1 ) {
        myReportText = @"Vecka:";
        mySqlString = [NSString stringWithFormat:@"SELECT  Sum(TIMMAR) As Tid,(select namn from kund where id = t.kund),strftime('\%Y v\%w',DATUM) AS Date FROM TIME t Group By 3,  2 limit %d", myOrderId];
        myResultView = [mydatabase getReportView:mySqlString];
        int pos = 3 * myOrderId;
        NSMutableString *datum = [myResultView objectAtIndex:(pos +2)];
        NSString *kund  = [myResultView objectAtIndex:(pos +1)];
    }
    
    
    // Per månad
    if (mySortId == 3 && myGrupId == 0 ) {
        myReportText = @"Månad:";
        mySqlString = [NSString stringWithFormat:@"SELECT  Sum(TIMMAR) As Tid,' ',strftime('\%Y-\%m',DATUM) AS Date FROM TIME t Group By 3 limit %d", myOrderId];
        myResultView = [mydatabase getReportView:mySqlString];
    }
    
    if (mySortId == 3 && myGrupId == 1 ) {
        myReportText = @"Månad:";
        mySqlString = [NSString stringWithFormat:@"SELECT  Sum(TIMMAR) As Tid,(select namn from kund where id = t.kund),strftime('\%Y-\%m',DATUM) AS Date FROM TIME t Group By 3,  2 limit %d", myOrderId];
        myResultView = [mydatabase getReportView:mySqlString];
    }
    
    // Per år
    if (mySortId == 4 && myGrupId == 0 ) {
        myReportText = @"År:";
        mySqlString = [NSString stringWithFormat:@"SELECT  Sum(TIMMAR) As Tid,' ',strftime('\%Y',DATUM) AS Date FROM TIME t Group By 3 limit %d", myOrderId];
        myResultView = [mydatabase getReportView:mySqlString];
    }
    
    if (mySortId == 4 && myGrupId == 1 ) {
        myReportText = @"År:";
        mySqlString = [NSString stringWithFormat:@"SELECT  Sum(TIMMAR) As Tid,(select namn from kund where id = t.kund),strftime('\%Y',DATUM) AS Date FROM TIME t Group By 3,  2 limit %d", myOrderId];
        myResultView = [mydatabase getReportView:mySqlString];
    }
    
    
    
    if ([mySqlString isEqualToString:@" "] == FALSE) {
        myResultView = [mydatabase getReportView:mySqlString];
    }
     */





- (NSString *)myStringTime:(int)decimaltid
{
    int timmar;
    int minuter;
    NSString *tTid;
    NSString *tMinuter;
    timmar = floor(decimaltid/60);
    minuter = round(decimaltid - timmar * 60);
    //NSString *tTimmar = [NSString stringWithFormat:@"%d", timmar];
    if (minuter < 10 ) {
        tMinuter = [NSString stringWithFormat:@"0%d", minuter];
    } else {
        tMinuter = [NSString stringWithFormat:@"%d", minuter];
    }
    if (timmar < 10 ) {
        tTid = [NSString stringWithFormat:@"0%d:%@", timmar,tMinuter];        
    } else {
        tTid = [NSString stringWithFormat:@"%d:%@", timmar,tMinuter];
    }
    return tTid;
}

- (NSString *)myStringDate:(NSString *)datum
{
    
    NSMutableString *nystring = [NSMutableString stringWithString:datum];
    
    
    
    //[nystring insertString: @"-" atIndex: 4];
    //[nystring insertString: @"-" atIndex: 7];
    datum = nystring;
    return datum;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //database *mydatabase =[[database alloc] init];
    
    //mySqlString = [NSString stringWithFormat:@"select count(datum) from antal"];        
    
    //NSString *antal = [mydatabase getData:mySqlString];
    myResultView = [self myReportData];
    
    int i = myResultView.count / 6;
    return i;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger indexRow = [indexPath row];
    int pos;
    myResultView = [self myReportData];
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    pos = indexRow *6;
    if ([myResultView count] >= (pos +5) ){
        cell.detailTextLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0]; 
        cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:16.0];
        
        //int decimaltid = [[myResultView objectAtIndex:(pos +2)] intValue];
        NSMutableString *datum = [myResultView objectAtIndex:(pos +3)];
        //NSString *mydatum = [self myStringDate:datum ];
        NSString *kund  = [myResultView objectAtIndex:(pos +5)];
        NSString *note = [myResultView objectAtIndex:(pos+4)];
        //int temp = note.length;
        if ( [note isEqualToString:@"(null)"] ) 
        {
            UIImage *image = [UIImage   imageNamed:@"note1.png"];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            CGRect frame = CGRectMake(44.0, 44.0, image.size.width, image.size.height);
            button.frame = frame;
            [button setBackgroundImage:image forState:UIControlStateNormal];
            //[button addTarget:self action:@selector(accessoryButtonTapped:event:)  forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor = [UIColor clearColor];
            cell.accessoryView = button;

        } else
        {
            UIImage *image = [UIImage   imageNamed:@"note2.png"];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            CGRect frame = CGRectMake(44.0, 44.0, image.size.width, image.size.height);
            button.frame = frame;
            [button setBackgroundImage:image forState:UIControlStateNormal];
            [button addTarget:self action:@selector(accessoryButtonTapped:event:)  forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor = [UIColor clearColor];
            cell.accessoryView = button;
        }
        
        
        cell.textLabel.text = [NSString stringWithFormat:@"Datum %@   Kund: %@   ",datum,kund];
        //cell.detailTextLabel.text = [NSString stringWithFormat:@"In  %@ Ut %@ abetad tid %@",[myResultView objectAtIndex:(pos)],utTid,[self myStringTime :decimaltid]]; 
        //[[cell detailTextLabel] setText:[NSString stringWithFormat:@"    %@  %@  tid %@ ",myReportText,mydatum,[self myStringTime :decimaltid] ]];
        cell.detailTextLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0]; 
        cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        //cell.textLabel.text = [myResultView objectAtIndex:(pos +5)];
        int decimaltid = [[myResultView objectAtIndex:(pos +2)] intValue];
        NSString *utTid = [NSString stringWithFormat:@"%@",[myResultView objectAtIndex:(pos +1)]];
        if ([@"0" compare:utTid]==NSOrderedSame){utTid = @" --:-- ";}
       cell.detailTextLabel.text = [NSString stringWithFormat:@"In  %@ Ut %@ abetad tid %@",[myResultView objectAtIndex:(pos)],utTid,[self myStringTime :decimaltid]]; 
        kund =nil;
        datum = nil;
    }
    }
    
    return cell;  
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        
        // If row is deleted, remove it from the list.
        if (editingStyle == UITableViewCellEditingStyleDelete)
        {
            //mySelectedRow = indexPath;
            //NSUInteger pos =indexPath.row;// [mySelectedRow  row];
            UITableViewCell *myCell = [tableView cellForRowAtIndexPath:indexPath];
            NSString *rad = myCell.detailTextLabel.text;
            NSString *datum = myCell.textLabel.text;
            datum = [datum substringWithRange:NSMakeRange(6, 10)];
                     NSString *intid = [rad substringWithRange: NSMakeRange (4, 5)];
            database *mydatabase =[[database alloc] init];
            mySqlString = [NSString stringWithFormat:@"SELECT ID FROM TIME WHERE INTID = '%@' and datum = '%@'",intid,datum]; 
            NSString *myDbID = [mydatabase getData:mySqlString];
            mySqlString = [NSString stringWithFormat:@"DELETE FROM NOTE WHERE TIME = \"%@\"", myDbID];
            [mydatabase addData:mySqlString];
            mySqlString = [NSString stringWithFormat:@"DELETE FROM TIME WHERE ID = \"%@\"", myDbID];
            [mydatabase addData:mySqlString];
            [self.myView reloadData];
            
            // städa
            rad = nil;
            datum = nil;
            mydatabase = nil;
            myCell = nil;
            intid = nil;
            myDbID = nil;
       
    }
}

- (IBAction) myActionButton{
    [self writeToTextFile];
    [self showEmailModalView];
}

-(void) writeToTextFile{
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/timereport.csv", documentsDirectory];
    NSString *content = @"Datum,Kund,Intid,Uttid,timmar,note\n";    
    
   int pos = 0;
    while ((pos+6) <= (myResultView.count)) {
        NSMutableString *datum = [myResultView objectAtIndex:(pos +3)];
        NSString *kund  = [myResultView objectAtIndex:(pos +5)];
        NSString *note = [myResultView objectAtIndex:(pos+4)];
        NSString *inTid = [myResultView objectAtIndex:(pos)];
        NSString *utTid = [myResultView objectAtIndex:(pos +1)];
        int decimaltid = [[myResultView objectAtIndex:(pos +2)] intValue];
        NSString *workTime = [self myStringTime :decimaltid];               
        content = [NSString stringWithFormat:@"%@%@,%@,%@,%@,%@,%@\n",content,datum,kund,inTid,utTid,workTime,note];
        pos = pos +6;
        }
    [content writeToFile:fileName 
              atomically:NO 
                encoding:NSUTF8StringEncoding //NSStringEncodingConversionAllowLossy 
                   error:nil];
}



-(void) showEmailModalView {
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = (id)self;
    [picker setSubject:@"TimeReport"];
    
        //ATTACH FILE
    
    NSString *path;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    path = [paths objectAtIndex:0]; // stringByAppendingPathComponent:@"MediaFiles"];
    path = [path stringByAppendingPathComponent:@"timereport.csv"];
    
    NSLog(@"Attaching file: %@", path);
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])		//Does file exist?
    {
        NSLog(@"File exists to attach");
        
        NSData *myData = [NSData dataWithContentsOfFile:path];
        
        [picker addAttachmentData:myData mimeType:@"text/plain"
                         fileName:@"timereport.csv"];
        
    }

    
    
     // Fill out the email body text
    NSString *emailBody = [NSString stringWithFormat:@"Time Report detailed list in CSV format. Save the file and open it in your favorite spreadsheet application. Fore more information look at www.cronstedt.nu"];
    
    [picker setMessageBody:emailBody isHTML:YES]; // depends. Mostly YES, unless you want to send it as plain text (boring)
    //[picker addAttachmentData:reportData mimeType:@"application/TimeReport" fileName:myfileName];
    //picker.navigationBar.barStyle = UIBarStyleBlack; // choose your style, unfortunately, Translucent colors behave quirky.
    
    [self presentViewController:picker animated:YES completion:nil];
   
    
}

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{ 
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
            break;
        case MFMailComposeResultFailed:
            break;
            
        default:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Sending Failed - Unknown Error :-("
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
        }
            
            break;
    }
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
     
     }


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [self setMyViewCell:nil];
    [self setMyView:nil];
    [self setMyAction:nil];
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
