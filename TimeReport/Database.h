#import <Foundation/Foundation.h>
#import "sqlite3.h"


@interface database : NSObject {

        UILabel *status;
        NSString        *databasePath;
        sqlite3 *contactDB;
        NSString *insertSQL; 
    NSString *InTid;
	NSString *UtTid;
	NSString *Timmar;
    NSMutableArray *resultView;
    NSMutableArray *rad;
    
}


@property (retain, nonatomic) IBOutlet UILabel *status;
//@property (retain, nonatomic)NSString *insertSQL;
@property (retain, nonatomic)NSMutableArray *resultView;
@property (retain, nonatomic)NSMutableArray *rad;
@property (retain, nonatomic)NSString *InTid;
@property (retain, nonatomic)NSString *UtTid;
@property (retain, nonatomic)NSString *Timmar;

- (void) saveData;
- (void) loadSqDb;
- (void)addData:(NSString *)tid;
- (void)addNote:(NSString *)querySQL;
- (NSString *) getData:(NSString *)querySQL;
- (NSMutableArray *) getDataView:(NSString *)querySQL;
- (NSMutableArray *) getReportView:(NSString *)querySQL;
- (NSMutableArray *) getKundView:(NSString *)querySQL;
- (NSArray *) getKundDetail:(NSString *)querySQL;
- (NSArray *) getCalView:(NSString *)querySQL;
@end