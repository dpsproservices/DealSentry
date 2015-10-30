//
//  SubProduct.h
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SubProduct : NSManagedObject

@property (nonatomic, retain) NSString * subProductDescription;
@property (nonatomic, retain) NSString * subProductId;

@end
