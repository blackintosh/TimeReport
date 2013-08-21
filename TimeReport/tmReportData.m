//
//  tmReportData.m
//  TimeReport
//
//  Created by Nils Cronstedt on 2013-08-15.
//  Copyright (c) Nils Cronstedt 2013 All rights reserved.
//

#import "tmReportData.h"
#import "Database.h"


@implementation tmReportData
@synthesize myAction;
@synthesize myTabelView;


//@synthesize myExport;
//@synthesize myReportSelect;
@synthesize myResultView;
@synthesize mySqlString;
@synthesize myReportText;
@synthesize myTable;
@synthesize myGrupId, mySortId;

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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *dag = @"";
    NSString *vecka = @"";
    NSString *manad = @"";
    NSString *ar = @"";
    NSString *kund = @"";
    NSString *result = @"";
    NSString *cellText = @"";
    database *mydatabase =[[database alloc] init];
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    kund = selectedCell.textLabel.text;
    cellText = selectedCell.detailTextLabel.text; 
    if (mySortId == 1) {
        dag = [cellText substringWithRange:NSMakeRange(10, 10)];
    }
    if (mySortId == 2) {
        ar = [cellText substringWithRange:NSMakeRange(12, 4)];
        vecka = [cellText substringWithRange:NSMakeRange(18, 2)];
        vecka = [vecka stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if (mySortId == 3) {
        ar = [cellText substringWithRange:NSMakeRange(12, 4)];
        manad = [cellText substringWithRange:NSMakeRange(17, 2)];
    }
    if (mySortId == 4) {
        ar = [cellText substringWithRange:NSMakeRange(9, 4)];
    }
    // Per dag
    if (mySortId ==1 ) {
                mySqlString = [NSString stringWithFormat:@"SELECT intid,uttid,timmar,datum,(select notes from note where time = t.id) as note, (select namn from kund where id = t.kund ) as kund FROM time t where datum = '%@'",dag];
    }
    
    if (mySortId ==2 && myGrupId == 0 ) {
        mySqlString = [NSString stringWithFormat:@"SELECT intid,uttid,timmar,datum,(select notes from note where time = t.id) as note, (select namn from kund where id = t.kund ) as kund FROM time t where strftime('%%Y %%W',DATUM)  = '%@ %@'",ar,vecka];
    }
    if (mySortId ==2 && myGrupId == 1 ) {
        mySqlString = [NSString stringWithFormat:@"SELECT intid,uttid,timmar,datum,(select notes from note where time = t.id) as note, (select namn from kund where id = t.kund ) as kundnamn FROM time t where strftime('%%Y %%W',DATUM)  = '%@ %@'  and kundnamn ='%@'",ar, vecka ,kund];
    }
    // Per månad
    if (mySortId == 3 && myGrupId == 0 ) {
        mySqlString = [NSString stringWithFormat:@"SELECT intid,uttid,timmar,datum,(select notes from note where time = t.id) as note, (select namn from kund where id = t.kund ) as kund FROM time t where strftime('%%Y %%m',DATUM)  = '%@ %@'",ar, manad];
    }
    
    if (mySortId == 3 && myGrupId == 1 ) {
        mySqlString = [NSString stringWithFormat:@"SELECT intid,uttid,timmar,datum,(select notes from note where time = t.id) as note, (select namn from kund where id = t.kund ) as kundnamn FROM time t where strftime('%%Y %%m',DATUM)  = '%@ %@'  and kundnamn ='%@'",ar, manad ,kund];

    }
    if (mySortId == 4 ) {
        mySqlString = [NSString stringWithFormat:@"SELECT intid,uttid,timmar,datum,(select notes from note where time = t.id) as note, (select namn from kund where id = t.kund ) as kund FROM time t where strftime('%%Y %%m',DATUM)  = '%@ %@'",ar, manad];    }

    mySqlString = [NSString stringWithFormat:@"update status set sql = \"%@\"",mySqlString];
    [mydatabase addData:mySqlString];
    
    // Städa
    dag = nil;
    vecka = nil;
    manad = nil;
    ar = nil;
    kund = nil;
    result = nil;
    cellText = nil;
}

-(NSMutableArray *)myReportData
{
    database *mydatabase =[[database alloc] init];
    mySqlString = @"SELECT sort FROM status";
    mySortId = [[mydatabase getData:mySqlString] intValue];
    mySqlString = @"SELECT grup FROM status";
    myGrupId = [[mydatabase getData:mySqlString] intValue];
    // Bygga SQL frågor
    mySqlString = @" ";
    
    // osorterad
    if ( myGrupId == 2 ) {
        myReportText = @"date:";
        mySqlString = [NSString stringWithFormat:@"select timmar,(select namn from kund where id = t.kund),datum from time t order by datum"];
    
    }
    // Per dag
    if (mySortId ==1 && myGrupId == 0 ) {
        myReportText = @"day:";
    mySqlString = [NSString stringWithFormat:@"select sum(timmar),' ',datum from time t group by datum order by datum"];
    }
    
    if (mySortId ==1 && myGrupId == 1 ) {
        myReportText = @"day:";
        mySqlString = [NSString stringWithFormat:@"select sum(timmar),(select namn from kund where id = t.kund),datum from time t group by datum,kund order by datum"];
    }
    // Per vecka
    if (mySortId == 2 && myGrupId == 0 ) {
        myReportText = @"week:";
        mySqlString = @"SELECT  Sum(TIMMAR) As Tid,' ',strftime('\%Y v\%W',DATUM) AS Date FROM TIME t Group By 3";
    }
    
    if (mySortId == 2 && myGrupId == 1 ) {
        myReportText = @"week:";
        mySqlString = @"SELECT  Sum(TIMMAR) As Tid,(select namn from kund where id = t.kund),strftime('\%Y v\%W',DATUM) AS Date FROM TIME t Group By 3,  2";
    }

    
    // Per månad
    if (mySortId == 3 && myGrupId == 0 ) {
        myReportText = @"month:";
        mySqlString = @"SELECT  Sum(TIMMAR) As Tid,' ',strftime('\%Y-\%m',DATUM) AS Date FROM TIME t Group By 3";
    }

    if (mySortId == 3 && myGrupId == 1 ) {
        myReportText = @"month:";
        mySqlString = @"SELECT  Sum(TIMMAR) As Tid,(select namn from kund where id = t.kund),strftime('\%Y-\%m',DATUM) AS Date FROM TIME t Group By 3,  2";
    }
    
    // Per år
    if (mySortId == 4 && myGrupId == 0 ) {
        myReportText = @"year:";
        mySqlString = @"SELECT  Sum(TIMMAR) As Tid,' ',strftime('\%Y',DATUM) AS Date FROM TIME t Group By 3";
    }
    
    if (mySortId == 4 && myGrupId == 1 ) {
        myReportText = @"year:";
        mySqlString = @"SELECT  Sum(TIMMAR) As Tid,(select namn from kund where id = t.kund),strftime('\%Y',DATUM) AS Date FROM TIME t Group By 3,  2";
    }


    
    if ([mySqlString isEqualToString:@" "] == FALSE) {
    myResultView = [mydatabase getReportView:mySqlString];
    }
    return  myResultView;
}





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
    
    int i = myResultView.count / 3;
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
        //cell.accessoryType =  UITableViewCellAccessoryDetailDisclosureButton;
        UIView *bg =[[UIView alloc] initWithFrame:cell.frame];
        if (indexRow % 2) {
            bg.backgroundColor = [UIColor colorWithRed: 1 green: 0.890 blue:0.769 alpha: 1.0];
        } else {
            bg.backgroundColor = [UIColor whiteColor];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone; 
        cell.backgroundView = bg;
        cell.textLabel.backgroundColor  = bg.backgroundColor;
        cell.detailTextLabel.backgroundColor  = bg.backgroundColor; 
        bg = nil;
    }
    pos = indexRow *3;
    if ([myResultView count] >= (pos +3) ){
        if (mySortId ==4) {
            cell.accessoryType =  UITableViewCellAccessoryNone ;
            [cell setUserInteractionEnabled:NO];
            }
        cell.detailTextLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0]; 
        cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:16.0];
        
        int decimaltid = [[myResultView objectAtIndex:(pos)] intValue];
        NSMutableString *datum = [myResultView objectAtIndex:(pos +2)];
        NSString *mydatum = [self myStringDate:datum ];
        NSString *kund  = [myResultView objectAtIndex:(pos +1)];
        cell.textLabel.text = kund;
        //cell.detailTextLabel.text = [NSString stringWithFormat:@"In  %@ Ut %@ abetad tid %@",[myResultView objectAtIndex:(pos)],utTid,[self myStringTime :decimaltid]]; 
        [[cell detailTextLabel] setText:[NSString stringWithFormat:@"    %@  %@  tid %@ ",myReportText,mydatum,[self myStringTime :decimaltid] ]];
        
        kund =nil;
        datum = nil;
    }
    
    
    return cell;  
}

- (IBAction) myActionButton{
    if (myResultView.count > 0) {
        [self writeToTextFile];
    [self showEmailModalView];
    }
}

-(void) writeToTextFile{
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/timereport.csv", documentsDirectory];
    NSString *type  = [myResultView objectAtIndex:(1)];
    NSString *content = @"";    
    if ([type isEqualToString:@" "])
    {
        content = @"Period,Tid\n";
    } else {
        content = @"Kund,Period,Tid\n";
    } 
    int pos = 0;
    while ((pos+3) <= (myResultView.count)) {
        NSMutableString *datum = [myResultView objectAtIndex:(pos +2)];
       // NSString *mydatum = [self myStringDate:datum ];
        int decimaltid = [[myResultView objectAtIndex:(pos)] intValue];
        NSString *workTime = [self myStringTime :decimaltid];  
        NSString *kund  = [myResultView objectAtIndex:(pos +1)];
        if ( [kund isEqualToString:@" "]){
        content = [NSString stringWithFormat:@"%@%@,%@\n",content,datum,workTime];
        } else {
            content = [NSString stringWithFormat:@"%@%@,%@,%@\n",content,kund,datum,workTime];
        }
        pos = pos +3;
    }
    //content = @"test";
    [content writeToFile:fileName 
              atomically:NO 
               encoding:NSUTF8StringEncoding //NSStringEncodingConversionAllowLossy 
                   error:nil];
}


-(void) showEmailModalView {
    
    //MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    //[controller setMailComposeDelegate:controller];
    //[controller setSubject:@"TimeReport"];
    //[controller setMessageBody:@"TimeReport" isHTML:NO];
    //[self presentViewController:controller animated:YES completion:nil];
    
    //MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    //self.mail.mailComposeDelegate = self;
    //picker.mailComposeDelegate = self;
    
   MFMailComposeViewController* email = [[MFMailComposeViewController alloc] init];
    email.mailComposeDelegate = (id)self;
    [email setSubject:@"TimeReport"];
    
    //ATTACH FILE
    
    NSString *path;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    path = [paths objectAtIndex:0]; // stringByAppendingPathComponent:@"MediaFiles"];
    path = [path stringByAppendingPathComponent:@"timereport.csv"];
    
    NSLog(@"Attaching file: %@", path);
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])		//Does file exist?
    {
        //NSLog(@"File exists to attach");
        
        NSData *myData = [NSData dataWithContentsOfFile:path];
        
        [email addAttachmentData:myData mimeType:@"text/plain"
                         fileName:@"timereport.csv"];
        
    }
    
    
    
    // Fill out the email body text
    NSString *emailBody = [NSString stringWithFormat:@"TimeReport data based on %@%@",myReportText,@" in CSV format. Save the file and open it in your favorite spreadsheet application. Fore more information look at www.cronstedt.nu"];
    
    [email setMessageBody:emailBody isHTML:YES]; // depends. Mostly YES, unless you want to send it as plain text (boring)
    //[picker addAttachmentData:reportData mimeType:@"application/TimeReport" fileName:myfileName];
    //picker.navigationBar.barStyle = UIBarStyleBlack; // choose your style, unfortunately, Translucent colors behave quirky.
    
    [self presentViewController:email animated:YES completion:nil];
    
    
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
   // [self setMyTabelView:nil];

    
    //[self setMyExport:nil];
    //[self setMyReportSelect:nil];
    [self setMyTable:nil];
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
