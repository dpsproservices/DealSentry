//
//  Agreement.h
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TransactionCompany;

@interface Agreement : NSManagedObject

@property (nonatomic, retain) NSString * agreementId;
@property (nonatomic, retain) NSString * agreementTerms;
@property (nonatomic, retain) NSString * agreementTypeId;
@property (nonatomic, retain) NSString * companyId;
@property (nonatomic, retain) NSString * effectiveDate;
@property (nonatomic, retain) NSString * exclusivityApprovedBy;
@property (nonatomic, retain) NSString * expirationDate;
@property (nonatomic, retain) NSString * legalReviewBy;
@property (nonatomic, retain) NSString * transactionId;
@property (nonatomic, retain) TransactionCompany *transactionCompany;

@end
