//
//  tmKundSelect.m
//  TimeReport
//
//  Created by Nils Cronstedt on 2013-08-15.
//  Copyright (c) Nils Cronstedt 2013 All rights reserved.
//

#import "tmKundSelect.h"
#import "Database.h"
#import "tmStampView.h"

@implementation tmKundSelect
@synthesize myTabelView;
@synthesize myAddButton;
@synthesize mySqlString;
@synthesize myResultView;
@synthesize myRowId;
@synthesize myKund,myNewButton;

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
-(void)mySelectedRow:(int)myRow
{
    myRow = myRow;
    myRowId = myRow;
}

*/

#pragma mark - View lifecycle

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //NSString *mySegue = [segue identifier];
    if ([[segue identifier] isEqualToString:@"NyKund"])
 {
     database *mydatabase =[[database alloc] init];
 mySqlString = [NSString stringWithFormat:@"update status set pos = '3'"];
  [mydatabase addData:mySqlString];
 } else {
        database *mydatabase =[[database alloc] init];
       mySqlString = [NSString stringWithFormat:@"update status set pos = '0'"];
        [mydatabase addData:mySqlString];
   }
}


-(NSMutableArray *)myReportData
{
    database *mydatabase =[[database alloc] init];
    mySqlString = [NSString stringWithFormat:@"select namn from kund"];
    myResultView = [mydatabase getKundView:mySqlString];
    return  myResultView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    database *mydatabase =[[database alloc] init];
    
    mySqlString = [NSString stringWithFormat:@"select count(namn) from kund"];        
    
    NSString *antal = [mydatabase getData:mySqlString];
    int i = [antal intValue];
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
                 
    }
    pos = indexRow *1;
    if ([myResultView count] >= (pos +1) ){
        cell.detailTextLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0]; 
      
        NSString *kund  = [myResultView objectAtIndex:(pos)];
        if ([kund isEqualToString:myKund]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.detailTextLabel.text = [NSString stringWithFormat:@"      %@", kund];
        kund =nil;
    }
    return cell;  
}

/*
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    int i=1;
}
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *myCell = [tableView cellForRowAtIndexPath:indexPath];
    myKund = [myCell.detailTextLabel.text substringFromIndex:6];
    //myKund = [myKund substringWithRange: NSMakeRange (2, myKund.length-2)]; 
    database *mydatabase =[[database alloc] init];
    mySqlString = [NSString stringWithFormat:@"select ID from kund where namn = '%@'", myKund];
    myRowId = [[mydatabase getData:mySqlString] intValue];
    mySqlString = [NSString stringWithFormat:@"update status set kund = '%d'", myRowId];
    [mydatabase addData:mySqlString];    
    [myTabelView reloadData]; 
    //[mydatabase addData:mySqlString]; [rad substringWithRange: NSMakeRange (4, 5)];
}
/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //mySelectedRow = indexPath;
        //NSUInteger pos =indexPath.row;// [mySelectedRow  row];
        UITableViewCell *myCell = [tableView cellForRowAtIndexPath:indexPath];
        myKund = [myCell.detailTextLabel.text substringFromIndex:6];
        database *mydatabase =[[database alloc] init];
        mySqlString = [NSString stringWithFormat:@"SELECT ID FROM KUND WHERE NAMN = '%@'",myKund]; 
        NSString *myKundID = [mydatabase getData:mySqlString];
        mySqlString = [NSString stringWithFormat:@"SELECT count() FROM TIME where KUND = '%@'",myKundID]; 
        //int i = [[mydatabase getData:mySqlString] intValue];
        //if (![myKundID isEqualToString:@"1"]) {
            
        if (([[mydatabase getData:mySqlString] intValue] == 0) && (![myKundID isEqualToString:@"1"])){
            mySqlString = [NSString stringWithFormat:@"DELETE FROM KUND WHERE ID = '%@'",myKundID];
            [mydatabase addData:mySqlString];
            [self.myTabelView reloadData];
        } else {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Kan ej ta bort kunden" 
                            message:@"Kunden har kopplade aktiviteter"
                            delegate:nil 
                            cancelButtonTitle:@"OK" 
                            otherButtonTitles: nil];
                        [alert show];        
                    }
        
        mySqlString = [NSString stringWithFormat:@"update status set kund = '%d'", 1];
        [mydatabase addData:mySqlString];
        [myTabelView reloadData];
              //  [tableView selectRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:1] animated:YES scrollPosition: UITableViewScrollPositionNone];
        
    //cellForRowAtIndexPath:(NSIndexPath *)indexPath        //}
        /*
        datum = [datum substringWithRange:NSMakeRange(6, 10)];
        NSString *intid = [rad substringWithRange: NSMakeRange (4, 5)];
        database *mydatabase =[[database alloc] init];
        mySqlString = [NSString stringWithFormat:@"SELECT ID FROM TIME WHERE INTID = '%@' and datum = '%@'",intid,datum]; 
        NSString *myDbID = [mydatabase getData:mySqlString];
        mySqlString = [NSString stringWithFormat:@"DELETE FROM NOTE WHERE TIME = \"%@\"", myDbID];
        [mydatabase addData:mySqlString];
        mySqlString = [NSString stringWithFormat:@"DELETE FROM TIME WHERE ID = \"%@\"", myDbID];
        [mydatabase addData:mySqlString];
       // [self.myView reloadData];
        
        // städa
        rad = nil;
        datum = nil;
        mydatabase = nil;
        myCell = nil;
        intid = nil;
        myDbID = nil;
        */
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated
{
    /*database *mydatabase =[[database alloc] init];
    mySqlString = @"SELECT kund FROM status";
    myRowId = [[mydatabase getData:mySqlString] intValue];
    mySqlString = [NSString stringWithFormat:@"select namn from kund where id = '%d'", myRowId];
    myKund = [mydatabase getData:mySqlString];*/
   [myTabelView reloadData];
}


- (void)viewDidUnload
{
   
    [self setMySqlString:nil];
    [self setMyResultView:nil];
    [self setMyRowId:nil];
    [self setMyKund:nil];
    [self setMyTabelView:nil];
    [self setMyAddButton:nil];
    [self setMyNewButton:nil];
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
