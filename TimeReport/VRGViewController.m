//
//  VRGViewController.m
//  Vurig Calendar
//
//  Created by in 't Veen Tjeerd on 5/29/12.
//  Copyright (c) 2012 Vurig. All rights reserved.
//

#import "VRGViewController.h"
#import "Database.h"

@interface VRGViewController ()

@end

@implementation VRGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
    calendar.delegate=self;
    [self.view addSubview:calendar];
    
    
    
}

-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    // SQL fråga  SELECT distinct datum,note FROM time where datum like '2012-01%'
    
    //if (month==[[NSDate date] month]) {
        NSString *myString = [NSString stringWithFormat:@"%d",month];
   // NSString *myYear =  stringFromDate:[selectedDate date];
           NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger year = [components year];
    if ([myString length] < 2) {
        myString = [NSString stringWithFormat:@"SELECT distinct datum,note FROM time where datum like \'%d-0%@%%\'",year, myString];
        } else {
         myString = [NSString stringWithFormat:@"SELECT distinct datum,note FROM time where datum like \'%d-%@%%\'",year, myString];
        }
        database *mydatabase =[[database alloc] init];
                NSArray *dates = [mydatabase getCalView:myString];
        
        //NSArray *dates = [NSArray arrayWithObjects:[NSNumber numberWithInt:9],[NSNumber numberWithInt:5], nil]markDates:(NSArray *)dates withColors:(NSArray *)colors;
        [calendarView markDates:dates];
   // }
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
    //NSLog(@"Selected date = %@",date);
    mySelectedDate = date;
   }



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
