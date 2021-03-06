#import "Database.h"
//#import "TimeManagerFirstViewController.h"

@implementation database
@synthesize resultView, rad, status ;



@synthesize InTid, UtTid, Timmar;



- (void)saveData
{
        sqlite3_stmt    *statement;

        const char *dbpath = [databasePath UTF8String];

        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
                //insertSQL = [NSString stringWithFormat: @"INSERT INTO CONTACTS (name, address, phone) VALUES (\"%@\", \"%@\", \"%@\")", name.text, address.text, phone.text];

                const char *insert_stmt = [insertSQL UTF8String];

                sqlite3_prepare_v2(contactDB, insert_stmt, -1, &statement, NULL);
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                        //status.text = @"Contact added";
                        //name.text = @"";
                        //address.text = @"";
                        //phone.text = @"";
                } else {
                        //status.text = @"Failed to add contact";
                }
                sqlite3_finalize(statement);
                sqlite3_close(contactDB);
        }
    
}


- (void)loadSqDb {
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"contacts.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
		const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS TIME (ID INTEGER PRIMARY KEY AUTOINCREMENT,INTID TEXT,UTTID TEXT,KUND INTEGER,TIMMAR TEXT,DATUM TEXT,NOTE INTEGER);";
            
            sqlite3_exec(contactDB, sql_stmt, NULL, NULL, &errMsg);
            sql_stmt = "CREATE TABLE IF NOT EXISTS NOTE (serial integer  PRIMARY KEY AUTOINCREMENT,TIME INTEGER,NOTES TEXT(512) DEFAULT NULL);";
            sqlite3_exec(contactDB, sql_stmt, NULL, NULL, &errMsg);
            sql_stmt = "CREATE TABLE IF NOT EXISTS KUND (ID integer  PRIMARY KEY AUTOINCREMENT DEFAULT NULL,NAMN TEXT(25) DEFAULT NULL,ADRESS TEXT(25) DEFAULT NULL,GATA TEXT(25) DEFAULT NULL,KONTAKT TEXT(25) DEFAULT NULL,TEL TEXT(25) DEFAULT NULL,EPOST TEXT(25) DEFAULT NULL,EXTRA TEXT(250) DEFAULT NULL);";
            sqlite3_exec(contactDB, sql_stmt, NULL, NULL, &errMsg);
            sql_stmt = "insert into kund(namn) values ('Demo');";
            sqlite3_exec(contactDB, sql_stmt, NULL, NULL, &errMsg);
            sql_stmt = "CREATE VIEW IF NOT EXISTS antal as select distinct datum from time;";
            sqlite3_exec(contactDB, sql_stmt, NULL, NULL, &errMsg);            
            sql_stmt = "CREATE TABLE IF NOT EXISTS STATUS (ID INTEGER PRIMARY KEY AUTOINCREMENT,KUND INTEGER,POS INTEGER,SORT INTEGER, GRUP INTEGER, SQL TEXT(250),MODE INTEGER,ROUND INTEGER,CAL INTEGER,RUPP INTEGER);";
            sqlite3_exec(contactDB, sql_stmt, NULL, NULL, &errMsg);
            sql_stmt = "insert into status(kund,pos,mode,round,cal,rupp) values (1,1,0,0,0,15);";
            sqlite3_exec(contactDB, sql_stmt, NULL, NULL, &errMsg);
            sqlite3_close(contactDB);
            
        
    }
    }
    //[filemgr release];
    //[super viewDidLoad];
}

- (void)addData:(NSString *)addSql
{
    NSString *docsDir;
    NSArray *dirPaths;
    sqlite3_stmt    *statement;    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"contacts.db"]];
    
    //NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //if ([filemgr fileExistsAtPath: databasePath ] == NO)
    
		const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
            //char *errMsg;
    
   
        //insertSQL = @"Detta är en lång sträng som testas";
        //insertSQL = [NSString stringWithFormat: @"INSERT INTO TIME (INTID, UTTID, KUND, TIMMAR, DATUM) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", tid, @"13:10", @"1", @"5.5",@"20120120"];
        
        const char *insert_stmt = [addSql UTF8String];
            sqlite3_prepare_v2(contactDB, insert_stmt, -1, &statement, NULL);
            if (sqlite3_step(statement) == SQLITE_DONE)
        //if (sqlite3_exec(contactDB, insert_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            status.text = @"Contact added";
        } else {
            status.text = @"Failed to add contact";
        }
        
        sqlite3_close(contactDB);
    }
}    

- (void)addNote:(NSString *)addSql
{
    NSString *docsDir;
    NSArray *dirPaths;
    sqlite3_stmt    *statement;    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"contacts.db"]];
    
    //NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //if ([filemgr fileExistsAtPath: databasePath ] == NO)
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        char *errMsg;
        
        
        //insertSQL = @"Detta är en lång sträng som testas";
        //insertSQL = [NSString stringWithFormat: @"INSERT INTO TIME (INTID, UTTID, KUND, TIMMAR, DATUM) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", tid, @"13:10", @"1", @"5.5",@"20120120"];
        
        const char *insert_stmt = [addSql UTF8String];
        sqlite3_prepare_v2(contactDB, insert_stmt, -1, &statement, NULL);
        //if (sqlite3_step(statement) == SQLITE_DONE)
        if (sqlite3_exec(contactDB, insert_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            status.text = @"Contact added";
        } else {
            status.text = @"Failed to add contact";
        }
        
        sqlite3_close(contactDB);
    }
}    

- (NSString *) getData:(NSString *)querySQL
{
    NSString *docsDir;
    NSArray *dirPaths;
    NSString *result;
    sqlite3_stmt *statement; 
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"contacts.db"]];
    
    //NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //if ([filemgr fileExistsAtPath: databasePath ] == NO)
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        //NSString *querySQL = [NSString stringWithFormat: @"SELECT address, phone FROM contacts WHERE name=\"%@\"", name.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                if (sqlite3_column_text(statement, 0) == NULL)
                {
                result = @"0";
                } else {
                result = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                status.text = @"Match found";
                }
                //  [addressField release];
                //  [phoneField release];
            } else {
                status.text = @"Match not found";
               
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    return result;
}

- (NSArray *) getDataView:(NSString *)querySQL
{
    NSString *docsDir;
    NSArray *dirPaths;
    NSString *kund;
    NSString *intid;
    NSString *uttid;
    NSString *totaltid;
    NSString *datum;
    NSString *note;
    sqlite3_stmt *statement; 
   
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"contacts.db"]];
    
    //NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //if ([filemgr fileExistsAtPath: databasePath ] == NO)
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        //NSString *querySQL = [NSString stringWithFormat: @"SELECT address, phone FROM contacts WHERE name=\"%@\"", name.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
             
             resultView = [NSMutableArray array];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                if (sqlite3_column_bytes(statement, 5) != 0) {
                    
                    kund  = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                } else {
                kund =@" ";
                }
                intid = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                uttid = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                totaltid = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                datum = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)]; 
                 note = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 4)]; 
                // Add the animal object to the animals Array
                //rad = [NSMutableArray array];
                //int i = [intid length];
                //if ([intid length] > 0) {
                [resultView addObject:intid];
                [resultView addObject:uttid];
                [resultView addObject:totaltid];
                [resultView addObject:datum];
                 [resultView addObject:note];
                [resultView addObject:kund];
				//[resultView addObjectsFromArray:rad];
                //}
               
               // test =  [resultView objectAtIndex:1];
                //test =  [resultView objectAtIndex:2];
                //rad = nil;             
				//[resultView release];            
            }
         
           
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    docsDir = nil;
    dirPaths = nil;
    intid = nil;
    uttid = nil;
    totaltid = nil;
    datum = nil;    
    return resultView ;
}




- (NSArray *) getReportView:(NSString *)querySQL
{
    NSString *docsDir;
    NSArray *dirPaths;
    //NSString *test;
    NSString *kund;
    NSString *minuter;
    NSString *datum;
    sqlite3_stmt *statement; 
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"contacts.db"]];
    
    //NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //if ([filemgr fileExistsAtPath: databasePath ] == NO)
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        //NSString *querySQL = [NSString stringWithFormat: @"SELECT address, phone FROM contacts WHERE name=\"%@\"", name.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            resultView = [NSMutableArray array];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                minuter = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                kund = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                datum = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                
                // Add the animal object to the animals Array
                //rad = [NSMutableArray array];
                
                [resultView addObject:minuter];
                [resultView addObject:kund];
                [resultView addObject:datum];
				//[resultView addObjectsFromArray:rad];
                
                
                //test =  [resultView objectAtIndex:1];
                //test =  [resultView objectAtIndex:2];
                //rad = nil;             
				//[resultView release];            
            }
            
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    return resultView ;
}

- (NSArray *) getKundView:(NSString *)querySQL
{
    NSString *docsDir;
    NSArray *dirPaths;
    //NSString *test;
    NSString *kund;
  
    sqlite3_stmt *statement; 
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"contacts.db"]];
    
    //NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //if ([filemgr fileExistsAtPath: databasePath ] == NO)
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        //NSString *querySQL = [NSString stringWithFormat: @"SELECT address, phone FROM contacts WHERE name=\"%@\"", name.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            resultView = [NSMutableArray array];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                kund = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                //if (kund.length > 2){
                // Add the animal object to the animals Array
                //rad = [NSMutableArray array];
                //kund =[kund substringFromIndex:[kund length]-2];
                [resultView addObject:kund];
                //}
            }
            
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    return resultView ;
}

- (NSArray *) getKundDetail:(NSString *)querySQL
{
    NSString *docsDir;
    NSArray *dirPaths;
    NSString *namn;
    NSString *adress;
    NSString *gata;
    NSString *kontakt;
    NSString *tel;
    NSString *epost;
    NSString *extra;
    sqlite3_stmt *statement; 
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"contacts.db"]];
    
    //NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //if ([filemgr fileExistsAtPath: databasePath ] == NO)
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        //NSString *querySQL = [NSString stringWithFormat: @"SELECT address, phone FROM contacts WHERE name=\"%@\"", name.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            resultView = [NSMutableArray array];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                namn = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                adress = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 2)];
                gata = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 3)];
                kontakt = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 4)];
                tel = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 5)];
                epost = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 6)];
                extra = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 7)];

                // Add the animal object to the animals Array
                //rad = [NSMutableArray array];
                
                [resultView addObject:namn];
                [resultView addObject:adress];
                [resultView addObject:gata];
                [resultView addObject:kontakt];
                [resultView addObject:tel];
                [resultView addObject:epost];
                [resultView addObject:extra];
				         
            }
            
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    return resultView ;
}
- (NSArray *) getCalView:(NSString *)querySQL
{
    NSString *docsDir;
    NSArray *dirPaths;
    //NSString *test;
    NSString *kund;
    
    sqlite3_stmt *statement;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"contacts.db"]];
    
    //NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //if ([filemgr fileExistsAtPath: databasePath ] == NO)
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        //NSString *querySQL = [NSString stringWithFormat: @"SELECT address, phone FROM contacts WHERE name=\"%@\"", name.text];
        
        const char *query_stmt = [querySQL UTF8String];
       
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            resultView = [NSMutableArray array];
            while (sqlite3_step(statement) == SQLITE_ROW) {
               
                kund = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                // Add the animal object to the animals Array
                //rad = [NSMutableArray array];
                 kund =[kund substringFromIndex:[kund length]-2];
                int i = [kund intValue];                //[NSNumber numberWithInt:kund];
                  //NSArray *dates = [NSArray arrayWithObjects:[NSNumber numberWithInt:9],[NSNumber numberWithInt:5], nil];
                [resultView addObject:[NSNumber numberWithInt:i]];
                
            }
           // [resultView addObject:nil];
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
        //if (i==1){
        //    [resultView addObject:nil];
        //}
    }
    return resultView ;
}

@end