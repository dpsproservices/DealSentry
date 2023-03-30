//
//  TransactionCompany.h
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Agreement, Company, Materiality, Transaction;

@interface TransactionCompany : NSManagedObject

@property (nonatomic, retain) NSString * companyId;
@property (nonatomic, retain) NSString * roleId;
@property (nonatomic, retain) NSString * transactionId;
@property (nonatomic) Boolean * isUserDefined;
@property (nonatomic, retain) NSSet *agreement;
@property (nonatomic, retain) Company *company;
@property (nonatomic, retain) Materiality *materiality;
@property (nonatomic, retain) Transaction *transaction;
@end

@interface TransactionCompany (CoreDataGeneratedAccessors)

- (void) addAgreementObject:(Agreement *)value;
- (void) removeAgreementObject:(Agreement *)value;
- (void) addAgreement:(NSSet *)values;
- (void) removeAgreement:(NSSet *)values;

@end
