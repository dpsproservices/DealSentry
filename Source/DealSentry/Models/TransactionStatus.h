//
//  TransactionStatus.h
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TransactionStatus : NSManagedObject

@property (nonatomic, retain) NSString * transactionStatusDescription;
@property (nonatomic, retain) NSString * transactionStatusId;

@end
