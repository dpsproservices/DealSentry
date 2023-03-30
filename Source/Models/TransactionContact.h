//
//  TransactionContact.h
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Transaction;

@interface TransactionContact : NSManagedObject

@property (nonatomic, retain) NSString * contactId;
@property (nonatomic) Boolean * crossSellDesignee;
@property (nonatomic, retain) NSString * roleId;
@property (nonatomic, retain) NSString * transactionId;
@property (nonatomic, retain) Transaction *transaction;

@end
