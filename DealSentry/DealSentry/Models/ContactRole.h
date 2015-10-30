//
//  ContactRole.h
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ContactRole : NSManagedObject

@property (nonatomic, retain) NSString * roleDescription;
@property (nonatomic, retain) NSString * roleId;

@end
