//
//  Segment.h
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Segment : NSManagedObject

@property (nonatomic, retain) NSString * marketSegment;
@property (nonatomic, retain) NSString * segmentDescription;
@property (nonatomic, retain) NSString * segmentId;

@end
