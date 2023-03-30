//
//  Industry.h
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Industry : NSManagedObject

@property (nonatomic, retain) NSString * franchiseIndustry;
@property (nonatomic, retain) NSString * industryDescription;
@property (nonatomic, retain) NSString * industryId;

@end
