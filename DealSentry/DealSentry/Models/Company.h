//
//  Company.h
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TransactionCompany;

@interface Company : NSManagedObject

@property (nonatomic, retain) NSString * companyId;
@property (nonatomic, retain) NSString * companyLevel;
@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSString * countryCode;
@property (nonatomic, retain) NSString * exchange;
@property (nonatomic, retain) NSString * gfcid;
@property (nonatomic, retain) NSString * industryId;
@property (nonatomic, retain) NSString * isManuallyDefinedByUser;
@property (nonatomic, retain) NSString * parentCompany;
@property (nonatomic, retain) NSString * segmentId;
@property (nonatomic, retain) NSString * ticker;
@property (nonatomic, retain) TransactionCompany *transactionCompany;

@end
