//
//  mySettingsViewController.m
//  myWorkTime
//
//  Created by Nils Cronstedt on 2013-08-15.
//  Copyright (c) Nils Cronstedt 2013 All rights reserved.
//

#import "mySettingsViewController.h"
#import "Database.h"
#import "tmStampView.h"
#import "CustomAlert.h"

@interface mySettingsViewController ()

@end

@implementation mySettingsViewController

@synthesize myEditStyle,stepper, loop;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction) mylink{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.cronstedt.nu"]];
}


-(IBAction)changeSeg{
		globalVariable = 1;
        NSString *mySqlString = [NSString stringWithFormat:@"update status set mode = 1"];
	
	if(myEditStyle.selectedSegmentIndex == 1){
        globalVariable = 0;
        mySqlString = [NSString stringWithFormat:@"update status set mode = 0"];
	}
    
    database *mydatabase =[[database alloc] init];
        
    [mydatabase addData:mySqlString];
    
    //tmStampView *myStamp = [[tmStampView alloc]init];
    
        
    UINavigationController *navController = self.navigationController;
    [navController popViewControllerAnimated:NO];
    tmStampView *viewC = [[tmStampView alloc]init];
    [navController pushViewController:viewC animated:TRUE];
}

- (void) showConfirmationAlert
{
    // A quick and dirty popup, displayed only once
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"HasSeenPopup"])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Are You realy shure?"
                                                       message:@"This acction whill erase the database"
                                                      delegate:self
                                             cancelButtonTitle:@"No"
                                             otherButtonTitles:@"Yes",nil];
        [alert show];
       
        [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"HasSeenPopup"];
    }
}


- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// 0 = Tapped yes
	if (buttonIndex == 1)
	{
        if (loop==0)
        {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Your last chanse"
                                                       message:@"Are you realy realy shure?"
                                                      delegate:self
                                             cancelButtonTitle:@"NO"
                                             otherButtonTitles:@"yes",nil];
        [alert show];
        
        [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:@"HasSeenPopup"];
            loop = 1;
        } else {
        NSString *docsDir;
        NSArray *dirPaths;
        
        // Get the documents directory
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        docsDir = [dirPaths objectAtIndex:0];
        //NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"contacts.db"]];
        
        NSFileManager *filemgr = [NSFileManager defaultManager];
        [filemgr removeItemAtPath:[docsDir stringByAppendingPathComponent:@"contacts.db"] error:NULL];
        //if ([filemgr fileExistsAtPath: databasePath ] == NO)}
        database *mydatabase =[[database alloc] init];
        [mydatabase loadSqDb];
        }
        
	} else {
        loop = 0;
    }
}


-(IBAction)myDelData{
    //if (![[NSUserDefaults standardUserDefaults] objectForKey:@"HasSeenPopup"])
    //{
    loop = 0;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Are You Realy shure?"
                                                       message:@"This acction whill erase the database and there is no way to un do it!"
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:@"Proceed",nil];
        [alert show];
        
        [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:@"HasSeenPopup"];
    //}
 }
- (void)viewDidLoad
{
    [super viewDidLoad];
   
	// Do any additional setup after loading the view.
    //CGRect screenRect = [[UIScreen mainScreen] bounds];
    //CGFloat screenHeight = screenRect.size.height;
   // stepper = [[UIStepper alloc] initWithFrame:CGRectMake(198, 312, 0, 0)];
    //[stepper addTarget:self action:@selector(stepperPressed:) forControlEvents:UIControlEventValueChanged];
    //myStepper = [[UIStepper alloc] initWithFrame:CGRectMake(100,screenHeight - 265,200,40)];screenHeight - 168
    //[[self view] addSubview:stepper];
    if (globalVariable == 0){
        myEditStyle.selectedSegmentIndex = 1 ;
    } else {
        myEditStyle.selectedSegmentIndex = 0;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
