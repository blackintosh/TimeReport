//
//  tmStampView.m
//  TimeReport
//
//  Created by Nils Cronstedt on 2013-08-15.
//  Copyright (c) Nils Cronstedt 2013 All rights reserved.
//

#import "tmStampView.h"
#import "QuartzCore/QuartzCore.h"
#import "Database.h"
#import "tmKundSelect.h"

@implementation tmStampView
@synthesize myText;
@synthesize myDatumText;
@synthesize myButtonText;
@synthesize myTabelView;

@synthesize myDatePicker;
@synthesize myInButton;
@synthesize myTimeText;
@synthesize mySummaText;
@synthesize myTimeButton;
@synthesize myItem1;
@synthesize myItem3;
@synthesize myTabBarItem;
@synthesize MyTabBar;
@synthesize myItem2;
@synthesize myEditBar;
@synthesize myInOut;
@synthesize myDatum;
@synthesize mySqlString;
@synthesize myDbID;
@synthesize myStampTime;
@synthesize mydateFormatter;
@synthesize mytimeFormatter;
@synthesize myResultView;
@synthesize myTextView;
@synthesize mySelectedRow;
@synthesize myTimeBar;
@synthesize myRowId;
@synthesize mydate;
@synthesize mySimpleTime;

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

-(void)mySetTime{
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH"];
    NSString *timmar = [dateFormatter stringFromDate: currentTime];
    [dateFormatter setDateFormat:@"mm"];
    NSString *minuter = [dateFormatter stringFromDate: currentTime];
    int t = [timmar intValue];
    int m = [minuter intValue];    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components =  [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:mySelectedDate]; //[gregorian components: NSUIntegerMax fromDate: date];//
    [components setHour:t];
    [components setMinute:m];
    mySelectedDate =[calendar dateFromComponents:components];
    myDatePicker.date = mySelectedDate;


}

-(void)myTimeAction{
    
    //NSDate *now = [NSDate date];
    [self mySetTime];
    if (myDatePicker.hidden == YES) {
    myDatePicker.hidden = NO;
     //   myTabelView.hidden = YES;
    //myTimeBar.hidden = NO;
    //myTimeText.hidden = YES;
    myStampTime = [mytimeFormatter stringFromDate:[myDatePicker date]]; 
    [myTimeButton setTitle:[self myDisplayTime:myStampTime] forState:UIControlStateNormal];
      myDatumText.text = [mydateFormatter stringFromDate:[myDatePicker date]];    
    //myTimeButton.enabled = NO;
    //myTimeButton.titleLabel.text= myStampTime;
    } else {
        myDatePicker.hidden = YES;
        //myTimeBar.hidden = NO;
        myTimeText.hidden = NO;
       // myTabelView.hidden = NO;
        myDatumText.text = [mydateFormatter stringFromDate:[myDatePicker date]];     }
}
/*
-(void)CancelButton{
    myDatePicker.hidden = YES;
    myTimeBar.hidden = YES;
    myTimeText.hidden = NO;
    myTimeButton.enabled = YES;
    myStampTime = [mytimeFormatter stringFromDate:[myDatePicker date]]; 
    myTimeButton.titleLabel.text= myStampTime;

}
*/
-(void)myInAction
{
    mySelectedDate = myDatePicker.date;
    
    if (myDatePicker.hidden == NO ) {
        [myDatePicker setHidden:TRUE];
        [myTimeBar setHidden:TRUE];
        myTimeText.hidden = NO;
        myTimeButton.enabled = YES;
        myTabelView.hidden = NO;
    }
    if (globalVariable == 0)
    {
         if (myInOut == 0)
    {
        [myInButton setTitle:@"Out" forState:UIControlStateNormal];
        [myInButton setBackgroundColor:[UIColor colorWithRed: 0.0/255.0 green: 206.0/255.0 blue:209.0/255.0 alpha: 1.0]]; 
        myInOut = 1;
        //database *mydatabase =[[database alloc] init];
        //[mydatabase addData:myStampTime];
        [self uppdateTimeDatabase];
               
    }
    else
    {
        [myInButton setTitle:@"In" forState:UIControlStateNormal];
        [myInButton setBackgroundColor:[UIColor colorWithHue:0.58 saturation:0.63 brightness:0.79 alpha:1]];  
        myInOut = 0;
        [self uppdateTimeDatabase];
       
    }
    } else {
        [mySimpleTime resignFirstResponder];
        [self uppdateTimeDatabase];
    }
    //[myDatePicker stringFromDate:now];
    //NSDate *now = [NSDate date];
    [self mySetTime];
    myDatePicker.date = mySelectedDate;
    myStampTime = [mytimeFormatter stringFromDate:mySelectedDate]; // ändrat från now
    [myTimeButton setTitle:[self myDisplayTime:myStampTime] forState:UIControlStateNormal];
    myDatumText.text = [mydateFormatter stringFromDate:[myDatePicker date]];
}

-(void)uppdateTimeDatabase
{
     float i = [mySimpleTime.text floatValue];
    mySimpleTime.text = @"0:00";
    database *mydatabase =[[database alloc] init];
    if (myInOut == 1) {
        mySqlString = [NSString stringWithFormat:@"SELECT DATUM FROM TIME WHERE INTID = '%@'",myStampTime];
        NSString *intid = [mydatabase getData:mySqlString];
        if (intid != NULL) {
            [self myInAction];
        } else {
        myDatum = [mydateFormatter stringFromDate:[myDatePicker date]];
        mySqlString = [NSString stringWithFormat:@"INSERT INTO TIME (INTID, UTTID, KUND, TIMMAR, DATUM, NOTE) VALUES (\"%@\", '0','%d','0',\"%@\",'0')", myStampTime,myRowId, myDatum];
        [mydatabase addData:mySqlString];
        [myTabelView reloadData];
        }
    }
    if (myInOut == 0)
    {
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[[NSLocale alloc] init] ];
        [dateFormatter setDateFormat:@"mm:ss"];
        
        mySqlString = [NSString stringWithFormat:@"SELECT INTID FROM TIME WHERE UTTID = '0'"];        
        NSString *intid = [mydatabase getData:mySqlString];
        
        NSDate* firstDate = [dateFormatter dateFromString:intid];
        NSDate* secondDate = [dateFormatter dateFromString:myStampTime];
        
        //NSTimeInterval 
        int timeDifference = [secondDate timeIntervalSinceDate:firstDate]; 
        // int inttid = [[timeDifference] intValue];
        if (timeDifference > 0){
            mySqlString = [NSString stringWithFormat:@"UPDATE TIME SET TIMMAR = \"%@\" WHERE UTTID = '0'", [NSString stringWithFormat:@"%d",timeDifference]];
            [mydatabase addData:mySqlString];
            mySqlString = [NSString stringWithFormat:@"UPDATE TIME SET UTTID = \"%@\" WHERE UTTID = '0'", myStampTime];
            [mydatabase addData:mySqlString];
            [myTabelView reloadData];
            }
        }
    if (globalVariable == 1)
    {
        if (i != 0) {
            i=i * 60;
            NSDate *newTime =[[myDatePicker date] dateByAddingTimeInterval:-(i * 60)];
            NSString *newDatum = [mytimeFormatter stringFromDate:newTime];
            //NSString *newDatum = [mydateFormatter stringFromDate:[myDatePicker date]];
            myDatum = [mydateFormatter stringFromDate:[myDatePicker date]];
            mySqlString = [NSString stringWithFormat:@"INSERT INTO TIME (INTID, UTTID, KUND, TIMMAR, DATUM, NOTE) VALUES (\"%@\", \"%@\",'%d','%f',\"%@\",'0')", newDatum,myStampTime,myRowId,i, myDatum];
            [mydatabase addData:mySqlString];
            [myTabelView reloadData];
        }
    }
        // Summa text
    NSString *datum = [mydateFormatter stringFromDate:mySelectedDate];
    mySqlString = [NSString stringWithFormat:@"SELECT sum(timmar) FROM time where datum = \"%@\"", datum];
    int decimaltid = [[mydatabase getData:mySqlString] intValue];
    mySummaText.text =  [self myStringTime:decimaltid];
    mydatabase = nil;
}

- (void)makeButtonShiny:(UIButton*)button withBackgroundColor:(UIColor*)backgroundColor
{
    // Get the button layer and give it rounded corners with a semi-transparant button
    CALayer *layer = button.layer;
    layer.cornerRadius = 8.0f;
    layer.masksToBounds = YES;
    layer.borderWidth = 4.0f;
    layer.borderColor = [UIColor colorWithWhite:0.4f alpha:0.2f].CGColor;
    
    // Create a shiny layer that goes on top of the button
    CAGradientLayer *shineLayer = [CAGradientLayer layer];
    shineLayer.frame = button.layer.bounds;
    // Set the gradient colors
    shineLayer.colors = [NSArray arrayWithObjects:
                         (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.75f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.4f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                         nil];
    // Set the relative positions of the gradien stops
    shineLayer.locations = [NSArray arrayWithObjects:
                            [NSNumber numberWithFloat:0.0f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.8f],
                            [NSNumber numberWithFloat:1.0f],
                            nil];
    
    // Add the layer to the button
    [button.layer addSublayer:shineLayer];
    
    [button setBackgroundColor:backgroundColor];
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
} */
    -(IBAction)incdate
{
    int days = 1;
    mydate  = mySelectedDate;
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents = [[NSDateComponents alloc] init];
    [weekdayComponents setDay:days];
    mySelectedDate = [gregorian dateByAddingComponents:weekdayComponents toDate:mydate options:0];
    myDatePicker.date = mySelectedDate;
    myDatumText.text = [mydateFormatter stringFromDate:[myDatePicker date]]; 
    [myTabelView reloadData];
}
-(IBAction)decdate
{
    int days = -1;
    mydate  = mySelectedDate;
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents = [[NSDateComponents alloc] init];
    [weekdayComponents setDay:days];
    mySelectedDate = [gregorian dateByAddingComponents:weekdayComponents toDate:mydate options:0];
    myDatePicker.date = mySelectedDate;
    myDatumText.text = [mydateFormatter stringFromDate:[myDatePicker date]]; 
    [myTabelView reloadData];
}

-(IBAction)getdate  // set date to today
{
    mydate  = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents = [[NSDateComponents alloc] init];
    mySelectedDate = [gregorian dateByAddingComponents:weekdayComponents toDate:mydate options:0];
    myDatePicker.date = mySelectedDate;
    myDatumText.text = [mydateFormatter stringFromDate:[myDatePicker date]];
    [myTabelView reloadData];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLocale *locale = [NSLocale currentLocale];
    NSString *amem =[locale localeIdentifier];
    
    if(![amem hasPrefix:@"en"]) {
        myTimeButton.titleLabel.font = [UIFont systemFontOfSize:35];
    }

     database *mydatabase =[[database alloc] init];
    [mydatabase loadSqDb];
    mySqlString = [NSString stringWithFormat:@"SELECT mode  FROM status"];
    //globalVariable
    // NSString *datum= [mydatabase getData:mySqlString];
    globalVariable  = [[mydatabase getData:mySqlString]intValue];    //myDatePicker.hidden = YES;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    myDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,screenHeight - 265,320,400)];
    //[myDatePicker addTarget:self action:@selector(testAction) forControlEvents:UIControlEventValueChanged];
    myDatePicker.datePickerMode = UIDatePickerModeTime;
    myDatePicker.hidden = YES;
    [self.view addSubview:myDatePicker];
    //screenHeight = (screenHeight - 480) / 2;
    if (globalVariable == 0){
       // myDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,215+screenHeight,320,400)];
    myText.layer.cornerRadius = 8;
    myTabelView.layer.cornerRadius = 8;
    mydateFormatter = [[NSDateFormatter alloc] init]; 
    [mydateFormatter setDateStyle:NSDateFormatterNoStyle]; 
    [mydateFormatter setTimeStyle:NSDateFormatterShortStyle]; 
    [mydateFormatter setDateFormat:(NSString*) @"yyyy-MM-dd"];
    
    // Tids formatering
    mytimeFormatter = [[NSDateFormatter alloc] init]; 
    [mytimeFormatter setDateStyle:NSDateFormatterNoStyle]; 
    [mytimeFormatter setTimeStyle:NSDateFormatterShortStyle];
      
        [mytimeFormatter setDateFormat:(NSString*) @"HH:mm"];
    myStampTime = [mytimeFormatter stringFromDate:[myDatePicker date]]; 
   [myTimeButton setTitle:[self myDisplayTime:myStampTime] forState:UIControlStateNormal];
     myDatumText.text = [mydateFormatter stringFromDate:[myDatePicker date]]; 
    //myTimeButton.titleLabel.text= myStampTime;
    
       
    NSString *datum = [mydateFormatter stringFromDate:mySelectedDate];
    
    mySqlString = [NSString stringWithFormat:@"SELECT UTTID  FROM TIME WHERE UTTID = '0' and DATUM = \"%@\"", datum];
    NSString *innerrerut = [mydatabase getData:mySqlString];
    [self makeButtonShiny:myInButton withBackgroundColor:[UIColor greenColor]];
    if ([@"0" compare:innerrerut]==NSOrderedSame){
        myInOut = 1;
        [myInButton setBackgroundColor:[UIColor colorWithRed: 0.0/255.0 green: 206.0/255.0 blue:209.0/255.0 alpha: 1.0]]; 
        [myInButton setTitle:@"Out" forState:UIControlStateNormal];
    } else {
        myInOut = 0;
        [myInButton setBackgroundColor:[UIColor colorWithHue:0.58 saturation:0.63 brightness:0.79 alpha:1]];
        [UIColor colorWithRed: 180.0/255.0 green: 238.0/255.0 blue:180.0/255.0 alpha: 1.0];
       [myInButton setTitle:@"In" forState:UIControlStateNormal];
    }
    
    [[myInButton layer] setCornerRadius:4.0f];
    [[myInButton layer] setMasksToBounds:YES];
    [[myInButton layer] setBorderWidth:1.0f];

    [myDatePicker addTarget:self action:@selector(dateSelected:) forControlEvents:UIControlEventValueChanged];
    mySqlString = [NSString stringWithFormat:@"SELECT sum(timmar) FROM time where datum = \"%@\"", datum];
    int decimaltid = [[mydatabase getData:mySqlString] intValue];
    mySummaText.text =  [self myStringTime:decimaltid];
    } else {
        myTimeButton.hidden = YES;
        mySimpleTime.hidden = NO;
        
        myText.layer.cornerRadius = 8;
        myTabelView.layer.cornerRadius = 8;
        mydateFormatter = [[NSDateFormatter alloc] init];
        [mydateFormatter setDateStyle:NSDateFormatterNoStyle];
        [mydateFormatter setTimeStyle:NSDateFormatterShortStyle];
        [mydateFormatter setDateFormat:(NSString*) @"yyyy-MM-dd"];
        
        // Tids formatering
        mytimeFormatter = [[NSDateFormatter alloc] init];
        [mytimeFormatter setDateStyle:NSDateFormatterNoStyle];
        [mytimeFormatter setTimeStyle:NSDateFormatterShortStyle];
        [mytimeFormatter setDateFormat:(NSString*) @"HH:mm"];
        myStampTime = [mytimeFormatter stringFromDate:[myDatePicker date]];
        [myTimeButton setTitle:[self myDisplayTime:myStampTime] forState:UIControlStateNormal];
        myDatumText.text = [mydateFormatter stringFromDate:[myDatePicker date]];
        //myTimeButton.titleLabel.text= myStampTime;
        
               
        NSString *datum = [mydateFormatter stringFromDate:mySelectedDate];
        
        //mySqlString = [NSString stringWithFormat:@"SELECT UTTID  FROM TIME WHERE UTTID = '0' and DATUM = \"%@\"", datum];
       //NSString *innerrerut = [mydatabase getData:mySqlString];
        [self makeButtonShiny:myInButton withBackgroundColor:[UIColor greenColor]];
        //if ([@"0" compare:innerrerut]==NSOrderedSame){
           //myInOut = 3;
            [myInButton setBackgroundColor:[UIColor colorWithRed: 0.0/255.0 green: 206.0/255.0 blue:209.0/255.0 alpha: 1.0]];
            [myInButton setTitle:@"Add time" forState:UIControlStateNormal];
       // } else {
        //    myInOut = 0;
       //     [myInButton setBackgroundColor:[UIColor colorWithHue:0.58 saturation:0.63 brightness:0.79 alpha:1]];
        //    //[UIColor colorWithRed: 180.0/255.0 green: 238.0/255.0 blue:180.0/255.0 alpha: 1.0]];
         //   [myInButton setTitle:@"In" forState:UIControlStateNormal];
        //}
        
        [[myInButton layer] setCornerRadius:4.0f];
        [[myInButton layer] setMasksToBounds:YES];
        [[myInButton layer] setBorderWidth:1.0f];
               
        [myDatePicker addTarget:self action:@selector(dateSelected:) forControlEvents:UIControlEventValueChanged];
        mySqlString = [NSString stringWithFormat:@"SELECT sum(timmar) FROM time where datum = \"%@\"", datum];
        int decimaltid = [[mydatabase getData:mySqlString] intValue];
        mySummaText.text =  [self myStringTime:decimaltid];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
    {

    // Tap outsade time picker
    /*
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] 
                                   initWithTarget:self
                                   action:@selector(dismissDatePicker)];
    
    [self.view addGestureRecognizer:tap];
    */
    
    
    
    //_myTopToolbar = [[UIToolbar alloc] init];
   
    [_myTopToolbar setFrame:CGRectMake(0,20,320,44)];
    //UIBarButtonItem *mySaveItem = [[UIBarButtonItem alloc] initWithTitle:@"Save"style:UIBarButtonItemStyleBordered target:self action:@selector(SaveButton)];
    //UIBarButtonItem *BtnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    //UIBarButtonItem *myCancellItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(CancelButton)];
    //NSArray *buttons = [NSArray arrayWithObjects:  BtnSpace, myCancellItem, nil];
    //[myTimeBar setItems: buttons animated:NO];
    //myTimeBar.hidden = YES;
    //[self.view addSubview:myTimeBar];
    //*/
    
    
    /*// Klockan
    myStampTime = [mytimeFormatter stringFromDate:[myDatePicker date]]; 
    myTimeButton = [[UIButton alloc]initWithFrame:CGRectMake(180,97,120,38)];
    [myTimeButton addTarget:self action:@selector(myTimeAction) forControlEvents:UIControlEventTouchDown];
    [myTimeButton setTitle:myStampTime forState:UIControlStateNormal];
    //[myTimeButton setBackgroundColor:[UIColor whiteColor]];
    [myTimeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //) setBackgroundColor:[UIColor blackColor]];
    //myTimeButton.titleLabel.text=@"tid";
    myTimeButton.titleLabel.font = [UIFont systemFontOfSize:40];
    
        myTimeButton.hidden = NO;
    [self.view addSubview:myTimeButton];
     */
    
        
    // Summa text
        if (globalVariable == 0){
            myTimeButton.hidden = NO;
            mySimpleTime.hidden = YES;

            //mySqlString = [NSString stringWithFormat:@"SELECT UTTID  FROM TIME WHERE UTTID = '0' and DATUM = \"%@\"", datum];
           // NSString *innerrerut = [mydatabase getData:mySqlString];
            
            if (myInOut == 1){
                
                [myInButton setBackgroundColor:[UIColor colorWithRed: 0.0/255.0 green: 206.0/255.0 blue:209.0/255.0 alpha: 1.0]];
                [myInButton setTitle:@"Out" forState:UIControlStateNormal];
            } else {
                
                [myInButton setBackgroundColor:[UIColor colorWithHue:0.58 saturation:0.63 brightness:0.79 alpha:1]];
                [UIColor colorWithRed: 180.0/255.0 green: 238.0/255.0 blue:180.0/255.0 alpha: 1.0];
                [myInButton setTitle:@"In" forState:UIControlStateNormal];
            }

            
            
        }
        if (globalVariable == 1){
            myTimeButton.hidden = YES;
            mySimpleTime.hidden = NO;
            [myInButton setBackgroundColor:[UIColor colorWithRed: 0.0/255.0 green: 206.0/255.0 blue:209.0/255.0 alpha: 1.0]];
            [myInButton setTitle:@"Add time" forState:UIControlStateNormal];
        }
    // Kund Text
        myDatePicker.date = mySelectedDate;
        myDatumText.text = [mydateFormatter stringFromDate:[myDatePicker date]]; 
        database *mydatabase =[[database alloc] init];
        [mydatabase loadSqDb];

        
    mySqlString = @"SELECT kund FROM status";
    myRowId = [[mydatabase getData:mySqlString] intValue];
    //if (myRowId == 0 ){myRowId = 1;}
    mySqlString = [NSString stringWithFormat:@"select namn from kund where id = \"%d\"", myRowId];
   // NSString *test4 = [mydatabase getData:mySqlString];
    myText.text = [NSString stringWithFormat:@"   %@", [mydatabase getData:mySqlString]];
        [myTabelView reloadData];
   }

- (NSString *)myDisplayTime:(NSString*)TimeText {
    NSLocale *locale = [NSLocale currentLocale];
    NSString *amem =[locale localeIdentifier];
    
    if([amem hasPrefix:@"en"]) {
        // US-Time
            int result = [[TimeText substringWithRange:NSMakeRange(0, 2)] intValue];
            if (result > 12) {// Kolla om större än 12
                result = result -12;
                int lengd = [TimeText length] -2;
                NSString *test = [TimeText substringWithRange:NSMakeRange(2,lengd)];
                TimeText = [NSString stringWithFormat:@"%i%@%@", result,test,@" PM"];
            } else {
                //int lengd = [TimeText length] -2;
                //NSString *test = [TimeText substringWithRange:NSMakeRange(2,lengd)];
                TimeText = [NSString stringWithFormat:@"%@%@", TimeText,@" AM"];
        }
       if ([TimeText hasPrefix:@"0"] & [TimeText hasSuffix:@"M"] )
        {
            // ta bort inledande nolla
           int lengd = [TimeText length] -1;
            TimeText = [NSString stringWithFormat:@"%@%@",@" ",[TimeText substringWithRange:NSMakeRange(1,lengd)]];
       }
       }
     return TimeText;
}

- (void)dateSelected:(id)sender{
   // NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //[dateFormat setDateFormat:@"MM/dd/yyyy h:mm a"];
    //NSDate *date = [dateFormat dateFromString:dateStr];
   // NSString *test = [self myDisplayTime:myStampTime];
    myStampTime = [mytimeFormatter stringFromDate:[myDatePicker date]];
  //NSString *tid = [self myDisplayTime:myStampTime];
//NSString *tid = myStampTime;
   // [myTimeButton setTitle:@"123:56 AM" forState:UIControlStateNormal];
    [myTimeButton setTitle:[self myDisplayTime:myStampTime] forState:UIControlStateNormal];
    //myTimeButton.titleLabel.text=myStampTime;
    myDatumText.text = [mydateFormatter stringFromDate:[myDatePicker date]];
}

- (void)mySumma {
    NSString *datum = [mydateFormatter stringFromDate:mySelectedDate];
    database *mydatabase =[[database alloc] init];
    mySqlString = [NSString stringWithFormat:@"SELECT sum(timmar) FROM time where datum = \"%@\"", datum];
    int decimaltid = [[mydatabase getData:mySqlString] intValue];
    mySummaText.text =  [self myStringTime:decimaltid];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
	//UITouch	*touch = [[event allTouches] anyObject];
	//CGPoint location = [touch locationInView:touch.view];
	if (myDatePicker.hidden == NO) 
    {
        myDatePicker.hidden = YES;
        myTimeText.hidden = NO; 
	}
    if (mySimpleTime.hidden == NO)
    {
        mySimpleTime.text = @"0:00";
        [mySimpleTime resignFirstResponder];
	}

}

-(void)dismissDatePicker {
    //[aTextField resignFirstResponder];
    myDatePicker.hidden = YES;
}

// Data 

-(NSMutableArray *)myFillView
{
    NSString *datum = [mydateFormatter stringFromDate:mySelectedDate];
    database *mydatabase =[[database alloc] init];
    mySqlString = [NSString stringWithFormat:@"select intid, uttid, timmar, datum, note, (select namn from kund where id = t.kund) from time t WHERE DATUM = \"%@\"", datum];
    myResultView = [mydatabase getDataView:mySqlString];
    return  myResultView;
}


// Tabel View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    database *mydatabase =[[database alloc] init];
    NSString *datum = [mydateFormatter stringFromDate:mySelectedDate];
    mySqlString = [NSString stringWithFormat:@"SELECT COUNT(*) FROM TIME WHERE DATUM = \"%@\"", datum];        
    NSString *antal = [mydatabase getData:mySqlString];
    int i = [antal intValue];
    return i;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    [self mySumma];
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger indexRow = [indexPath row];
    int pos;
    myResultView = [self myFillView];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.accessoryView = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        //cell.accessoryType =  UITableViewCellAccessoryDetailDisclosureButton;
       // UIView *bg =[[UIView alloc] initWithFrame:cell.frame];
        //if (indexRow % 2) {
        //    bg.backgroundColor = [UIColor colorWithRed: 1 green: 0.890 blue:0.769 alpha: 1.0];
        //} else {
        //    bg.backgroundColor = [UIColor whiteColor];
        //}
        cell.selectionStyle = UITableViewCellSelectionStyleNone; 
        //cell.backgroundView = bg;
        //cell.textLabel.backgroundColor  = bg.backgroundColor;
        //cell.detailTextLabel.backgroundColor  = bg.backgroundColor; 
        //bg = nil;
    }
    UIImage *image = [UIImage   imageNamed:@"note1.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(44.0, 44.0, image.size.width, image.size.height);
    button.frame = frame;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(accessoryButtonTapped:event:)  forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor clearColor];
    cell.accessoryView = button;
    
    pos = indexRow *6;
    if ([myResultView count] >= (pos +2) ){
         //cell.accessoryView = nil;
        cell.detailTextLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0]; 
        cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        cell.textLabel.text = [myResultView objectAtIndex:(pos +5)];
        int decimaltid = [[myResultView objectAtIndex:(pos +2)] intValue];
        NSString *utTid = [NSString stringWithFormat:@"%@",[myResultView objectAtIndex:(pos +1)]];
        if ([@"0" compare:utTid]==NSOrderedSame){
            utTid = @" --:-- ";
        } else {
            utTid =[self myDisplayTime:utTid];        }
        int temp = [[myResultView objectAtIndex:(pos+4)] intValue];
        if (temp == 2 ) {
            UIImage *image = [UIImage   imageNamed:@"note2.png"];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            CGRect frame = CGRectMake(44.0, 44.0, image.size.width, image.size.height);
            button.frame = frame;
            [button setBackgroundImage:image forState:UIControlStateNormal];
            [button addTarget:self action:@selector(accessoryButtonTapped:event:)  forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor = [UIColor clearColor];
            cell.accessoryView = button;
            button = nil;
            image = nil;
            
            //[[cell imageView] setImage:[UIImage imageNamed:@"note2.png"]];
        } else {
            //[[cell imageView] setImage:[UIImage imageNamed:@"note1.png"]];
            UIImage *image = [UIImage   imageNamed:@"note1.png"];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            CGRect frame = CGRectMake(44.0, 44.0, image.size.width, image.size.height);
            button.frame = frame;
            [button setBackgroundImage:image forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(accessoryButtonTapped:event:)  forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor = [UIColor clearColor];
            cell.accessoryView = button;
            button = nil;
            image = nil;
        }
       // NSString *temp1 = [myResultView objectAtIndex:(pos)];
       // NSString *temp2 = [self myStringTime :decimaltid];
       // NSString *temp3 = [NSString stringWithFormat:@"In  %@ Ut %@ abetad tid %@",[myResultView objectAtIndex:(pos)],utTid,[self myStringTime :decimaltid]];
         //if (globalVariable == 0){
        //[self myDisplayTime:[myResultView objectAtIndex:(pos)]]
        
        [[cell detailTextLabel] setText:[NSString stringWithFormat:@"In %@  Out %@  time %@",[self myDisplayTime:[myResultView objectAtIndex:(pos)]],utTid,[self myStringTime :decimaltid]]];
        // } else {
        // [[cell detailTextLabel] setText:[NSString stringWithFormat:@"Abetad tid %@",[self myStringTime :decimaltid]]];
         //}
        
    }
    
    return cell;  
}

- (void)MyEditView:(NSIndexPath *)indexPath
{
    
    // mySelectedRow = myTableView.indexPathForSelectedRow;
    // NSUInteger pos = [mySelectedRow  row];
    // UITableViewCell *myCell = [myTableView cellForRowAtIndexPath:myIndex];
    UITableViewCell *myCell = [myTabelView cellForRowAtIndexPath:indexPath];
    NSString *rad = myCell.detailTextLabel.text;
    if (rad == nil){
        return;
    }
    NSString *intid = [rad substringWithRange: NSMakeRange (3, 5)];
    if ([intid hasPrefix:@" "]){
        intid = [NSString stringWithFormat:@"%@%@",@"0",[rad substringWithRange: NSMakeRange (4, 4)]];
    }
    database *mydatabase =[[database alloc] init];
    mySqlString = [NSString stringWithFormat:@"SELECT ID FROM TIME WHERE INTID = \"%@\"",intid]; 
    myDbID = [mydatabase getData:mySqlString];
    mySqlString = [NSString stringWithFormat:@"SELECT NOTES FROM NOTE WHERE TIME = \"%@\"",myDbID]; 
    NSString *myTextString = [mydatabase getData:mySqlString];
    myEditBar = [[UIToolbar alloc] init];
    [myEditBar setFrame:CGRectMake(0,20,320,44)];
    UIBarButtonItem *mySaveItem = [[UIBarButtonItem alloc] initWithTitle:@"Save"style:UIBarButtonItemStyleBordered target:self action:@selector(SaveButton)];
    UIBarButtonItem *BtnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *myCancellItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(CancelEditButton)];
    NSArray *buttons = [NSArray arrayWithObjects: mySaveItem, BtnSpace, myCancellItem, nil];
    [myEditBar setItems: buttons animated:NO];
    myEditBar.hidden = NO;
    [self.view addSubview:myEditBar];
    // Find size
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    myTextView = [[UITextView alloc] initWithFrame:CGRectMake(0,65,320,screenHeight)];
    myTextView.text = myTextString;
    myTextView.font = [UIFont fontWithName:@"Helvetica" size:20.0]; 
    myTextView.hidden = NO;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
    [self.view addSubview:myTextView];
    [UIView commitAnimations]; 
    
}

- (void)accessoryButtonTapped:(id)sender event:(id)event
{
	NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self.myTabelView];
	NSIndexPath *indexPath = [self.myTabelView indexPathForRowAtPoint: currentTouchPosition];
	if (indexPath != nil)
		
	{
        //myIndex = indexPath;
        [self MyEditView:indexPath];
	}
}

-(IBAction)SaveButton{
    NSString *myString = myTextView.text;
    myTextView.text = nil;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
    [self.view sendSubviewToBack:myTextView];
    
    myEditBar.hidden = YES;
   
    myTextView.editable = NO;
     myTextView.hidden = YES;
    
    [UIView commitAnimations];
    
    database *mydatabase =[[database alloc] init];
    mySqlString = [NSString stringWithFormat:@"UPDATE TIME SET NOTE = '2' WHERE ID = \"%@\"", myDbID];
    [mydatabase addData:mySqlString];
    mySqlString = [NSString stringWithFormat:@"DELETE FROM NOTE WHERE TIME = \"%@\"", myDbID];
    [mydatabase addData:mySqlString];
    mySqlString = [NSString stringWithFormat:@"INSERT INTO NOTE (TIME, NOTES) VALUES (\"%@\",\"%@\")", myDbID, myString];
    [mydatabase addData:mySqlString];
    
    
    
    //UITableViewCell *myCell = [myTabelView cellForRowAtIndexPath:mySelectedRow];
    
    //myCell.imageView.image = [UIImage imageNamed:@"note2.png"];
    
    [myTabelView reloadData]; 
}
-(IBAction)CancelEditButton{
    myTextView.text = nil;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
    [self.view sendSubviewToBack:myTextView];
    myEditBar.hidden = YES;
    myTextView.editable = NO;
     myTextView.hidden = YES;
    [UIView commitAnimations];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == myTabelView)
    {
        
        // If row is deleted, remove it from the list.
        if (editingStyle == UITableViewCellEditingStyleDelete)
        {
            mySelectedRow = indexPath;
            UITableViewCell *myCell = [myTabelView cellForRowAtIndexPath:mySelectedRow];
            NSString *rad = myCell.detailTextLabel.text;
            NSString *intid = [rad substringWithRange: NSMakeRange (3, 5)];
            if ([intid hasPrefix:@" "]){
                intid = [NSString stringWithFormat:@"%@%@",@"0",[rad substringWithRange: NSMakeRange (4, 4)]];
            }
            database *mydatabase =[[database alloc] init];
            mySqlString = [NSString stringWithFormat:@"SELECT ID FROM TIME WHERE INTID = \"%@\"",intid]; 
            myDbID = [mydatabase getData:mySqlString];
            mySqlString = [NSString stringWithFormat:@"DELETE FROM NOTE WHERE TIME = \"%@\"", myDbID];
            [mydatabase addData:mySqlString];
            mySqlString = [NSString stringWithFormat:@"DELETE FROM TIME WHERE ID = \"%@\"", myDbID];
            [mydatabase addData:mySqlString];
            [myTabelView reloadData];
            intid = [rad substringWithRange: NSMakeRange (17, 5)];
            if ([intid isEqualToString:@"--:--"]) {
                [myInButton setTitle:@"In" forState:UIControlStateNormal];
                [myInButton setBackgroundColor:[UIColor colorWithHue:0.58 saturation:0.63 brightness:0.79 alpha:1]];  
                myInOut = 0;
                [self uppdateTimeDatabase];
            }
        }
    }
}
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ToKundSelect"]) {
        [segue.destinationViewController mySelectedRow:myRowId];
    } 
}
*/

- (void)viewDidUnload
{
    [self setMyText:nil];
    [self setMyButtonText:nil];
    [self setMyTabelView:nil];
    [self setMyDatePicker:nil];
    [self setMyInButton:nil];
    [self setMyTimeText:nil];
    [self setMySummaText:nil];
    [self setMyTimeButton:nil];
    [self setMyItem1:nil];
    [self setMyItem2:nil];
    [self setMyItem3:nil];
    [self setMyDbID:nil];
    [self setMyDatum:nil];
    [self setMyResultView:nil];
    [self setMyEditBar:nil];
    [self setMyTimeBar:nil];
   
    [self setMySqlString:nil];
    [self setMyStampTime:nil];
    [self setMydateFormatter:nil];
    [self setMytimeFormatter:nil];
    [self setMyTextView:nil];
    [self setMySelectedRow:nil];
    
    [self setMyTabBarItem:nil];
    [self setMyTabBar:nil];
    [self setMyDatumText:nil];
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
