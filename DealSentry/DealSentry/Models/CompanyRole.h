//
//  CompanyRole.h
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CompanyRole : NSManagedObject

@property (nonatomic, retain) NSString * roleDescription;
@property (nonatomic, retain) NSString * roleId;

@end
