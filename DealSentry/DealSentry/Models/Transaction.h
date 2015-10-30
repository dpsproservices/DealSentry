//
//  Transaction.h
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BusinessSelection, TransactionCompany, TransactionContact, TransactionDetail;

@interface Transaction : NSManagedObject

@property (nonatomic, retain) NSString * cgsDraftId;
@property (nonatomic, retain) NSString * cgsTransactionId;
@property (nonatomic, retain) NSString * clearanceApprovedDate;
@property (nonatomic, retain) NSString * counterparty;
@property (nonatomic, retain) NSString * ddtRestriction;
@property (nonatomic, retain) NSString * dealStatus;
@property (nonatomic, retain) NSString * dealStatusChangedBackwards;
@property (nonatomic, retain) NSString * draftId;
@property (nonatomic, retain) NSString * fulfillmentCondition;
@property (nonatomic, retain) NSString * isQueued;
@property (nonatomic, retain) NSString * primaryClient;
@property (nonatomic, retain) NSString * product;
@property (nonatomic, retain) NSString * productSub;
@property (nonatomic, retain) NSString * queueEvent;
@property (nonatomic, retain) NSString * requestorContactId;
@property (nonatomic, retain) NSDate * savedOnDate;
@property (nonatomic, retain) NSString * sponsoringMDContactId;
@property (nonatomic, retain) NSDate * submittedDate;
@property (nonatomic, retain) NSString * transactionId;
@property (nonatomic, retain) NSString * transactionStatusId;
@property (nonatomic, retain) NSString * updatedDate;
@property (nonatomic, retain) BusinessSelection *businessSelection;
@property (nonatomic, retain) NSSet *transactionCompany;
@property (nonatomic, retain) NSSet *transactionContact;
@property (nonatomic, retain) TransactionDetail *transactionDetail;
@end

@interface Transaction (CoreDataGeneratedAccessors)

- (void)addTransactionCompanyObject:(TransactionCompany *)value;
- (void)removeTransactionCompanyObject:(TransactionCompany *)value;
- (void)addTransactionCompany:(NSSet *)values;
- (void)removeTransactionCompany:(NSSet *)values;

- (void)addTransactionContactObject:(TransactionContact *)value;
- (void)removeTransactionContactObject:(TransactionContact *)value;
- (void)addTransactionContact:(NSSet *)values;
- (void)removeTransactionContact:(NSSet *)values;

@end
