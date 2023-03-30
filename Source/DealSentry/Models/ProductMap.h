//
//  ProductMap.h
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ProductMap : NSManagedObject

@property (nonatomic, retain) NSString * productId;
@property (nonatomic, retain) NSString * subProductId;
@property (nonatomic, retain) NSString * productDescription;
@property (nonatomic, retain) NSString * productSubDescription;

@end
