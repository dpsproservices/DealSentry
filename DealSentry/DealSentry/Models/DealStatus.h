//
//  DealStatus.h
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DealStatus : NSManagedObject

@property (nonatomic, retain) NSString * dealStatusDescription;
@property (nonatomic, retain) NSString * dealStatusId;

@end
