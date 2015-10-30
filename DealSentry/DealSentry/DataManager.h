//
//  DataManager.h
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "Transaction.h"

@interface DataManager : NSObject
{
    NSManagedObjectContext *context;
    BOOL isCheckForDelete;
    BOOL isTransactionIdChanged;
    BOOL isSaved;
}
@property(weak,nonatomic) AppDelegate *sharedDelegate;

@property(nonatomic,strong) NSArray *arrayForCompanyRoles;

@property(nonatomic,strong) NSMutableArray *arrayForContact;
@property(nonatomic,strong) NSArray *arrayForContactRoles;
@property(nonatomic,strong) NSArray *arrayForAgreementTypes;
@property(nonatomic,strong) NSArray *arrayForDealStatuses;
@property(nonatomic,strong) NSArray *arrayForIndustries;
@property(nonatomic,strong) NSArray *arrayForLoanTypes;
@property(nonatomic,strong) NSArray *arrayForOfferingFormat;
@property(nonatomic,strong) NSArray *arrayForSegments;
@property(nonatomic,strong) NSArray *arrayForTransactionStatuses;
@property(nonatomic,strong) NSArray *arrayForUseOfProceeds;
@property(nonatomic,strong) NSArray *arrayForProduct;
@property(nonatomic,strong) NSArray *arrayForProductSub;
@property(nonatomic,strong) NSArray *arrayForCountries;
@property(nonatomic,strong) NSArray *arrayForProductmap;
@property(nonatomic,strong) NSMutableArray *arrayForCompanies;
@property(nonatomic,strong) NSMutableArray *arrayForTransaction;

@property(nonatomic,strong) NSString *checkIndependentEntities;
@property(strong,nonatomic) NSString *draftId;
@property(strong,nonatomic) NSString *transactionId;
@property(strong,nonatomic) NSString *companyId;
@property(strong,nonatomic) NSString *deletedTransactionId;
@property(strong,nonatomic) NSString *transactionIdFromTransaction;
@property(strong,nonatomic) NSString *userIdFromLogin;
@property(strong,nonatomic) NSString *checkForOrientationChange;
@property(strong,nonatomic) NSMutableArray *transactionIdArray;

+(id) getInstance;
-(NSMutableArray*)rearrangeContactData:(NSMutableArray*)transactionContactData;
-(void)saveTransactionValue:(NSArray*)tData;
-(NSMutableArray*)fetchTransactionData;
-(NSMutableArray*)transactionArray;
-(NSDate*)dateFromSavedDateString:(NSString*)savedOnDate;
-(NSString*)stringFromSavedDate:(NSDate*)savedOnDate;
-(void)checkForDeletePressed:(NSString*)checkForDelete;

// Max Draft/Transaction id/ transaction Id array
-(void)getMaximumId;
-(void)deleteTransaction:(NSString*)transactionId;

@end
