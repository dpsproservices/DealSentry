//
//  LoanType.h
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LoanType : NSManagedObject

@property (nonatomic, retain) NSString * loanTypeDescription;
@property (nonatomic, retain) NSString * loanTypeId;

@end
