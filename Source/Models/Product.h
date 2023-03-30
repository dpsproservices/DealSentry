//
//  Product.h
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Product : NSManagedObject

@property (nonatomic, retain) NSString * productDescription;
@property (nonatomic, retain) NSString * productId;

@end
