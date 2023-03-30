//
//  DataManager.h
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

//#import "DealSentry-Swift.h"

@class AppDelegate;

@interface DataManager : NSObject
{
    NSManagedObjectContext *context;
    BOOL isCheckForDelete;
    BOOL isTransactionIdChanged;
    BOOL isSaved;
}

@property(weak,nonatomic) AppDelegate *sharedDelegate;

@property(strong,nonatomic) NSArray *arrayForCompanyRoles;
@property(strong,nonatomic) NSArray *arrayForContactRoles;
@property(strong,nonatomic) NSArray *arrayForAgreementTypes;
@property(strong,nonatomic) NSArray *arrayForDealStatuses;
@property(strong,nonatomic) NSArray *arrayForIndustries;
@property(strong,nonatomic) NSArray *arrayForLoanTypes;
@property(strong,nonatomic) NSArray *arrayForOfferingFormat;
@property(strong,nonatomic) NSArray *arrayForSegments;
@property(strong,nonatomic) NSArray *arrayForTransactionStatuses;
@property(strong,nonatomic) NSArray *arrayForUseOfProceeds;
@property(strong,nonatomic) NSArray *arrayForProduct;
@property(strong,nonatomic) NSArray *arrayForProductSub;
@property(strong,nonatomic) NSArray *arrayForCountries;
@property(strong,nonatomic) NSArray *arrayForProductmap;

@property(strong,nonatomic) NSMutableArray *arrayForContact;
@property(strong,nonatomic) NSMutableArray *arrayForCompanies;
@property(strong,nonatomic) NSMutableArray *arrayForTransaction;

@property(strong,nonatomic) NSString *draftId;
@property(strong,nonatomic) NSString *transactionId;
@property(strong,nonatomic) NSString *companyId;
@property(strong,nonatomic) NSString *deletedTransactionId;
@property(strong,nonatomic) NSString *transactionIdFromTransaction;
@property(strong,nonatomic) NSString *userIdFromLogin;
@property(strong,nonatomic) NSString *checkIndependentEntities;
@property(strong,nonatomic) NSString *currentOrientation;
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
