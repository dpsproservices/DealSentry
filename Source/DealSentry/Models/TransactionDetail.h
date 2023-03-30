//
//  TransactionDetail.h
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Transaction;

@interface TransactionDetail : NSManagedObject

@property (nonatomic, retain) NSString * backwardsDealStatusExplanation;
@property (nonatomic, retain) NSString * bankRole;
@property (nonatomic, retain) NSString * dealDescription;
@property (nonatomic, retain) NSString * dealSize;
@property (nonatomic, retain) NSString * dealStatusId;
@property (nonatomic, retain) NSString * estimatedPitchDate;
@property (nonatomic, retain) NSString * expectedAnnouncementDate;
@property (nonatomic, retain) NSString * expectedClosingDate;
@property (nonatomic, retain) NSString * isConfidential;
@property (nonatomic, retain) NSString * isSubjectToTakeOver;
@property (nonatomic, retain) NSString * likelyToTakePlace;
@property (nonatomic, retain) NSString * loanTypeId;
@property (nonatomic, retain) NSString * offeringFormatComments;
@property (nonatomic, retain) NSString * offeringFormatId;
@property (nonatomic, retain) NSString * productId;
@property (nonatomic, retain) NSString * productSubId;
@property (nonatomic, retain) NSString * projectName;
@property (nonatomic, retain) NSString * terminatedExplanation;
@property (nonatomic, retain) NSString * transactionId;
@property (nonatomic, retain) NSString * uncollectedFees;
@property (nonatomic, retain) NSString * useOfProceedsComments;
@property (nonatomic, retain) NSString * useOfProceedsId;
@property (nonatomic, retain) Transaction *transaction;

@end
