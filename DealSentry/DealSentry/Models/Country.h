//
//  Country.h
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Country : NSManagedObject

@property (nonatomic, retain) NSString * countryCode;
@property (nonatomic, retain) NSString * countryDescription;
@property (nonatomic, retain) NSString * countryName;

@end
