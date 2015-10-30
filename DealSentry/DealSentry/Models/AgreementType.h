//
//  AgreementType.h
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AgreementType : NSManagedObject

@property (nonatomic, retain) NSString * agreementDesc;
@property (nonatomic, retain) NSString * agreementTypeId;

@end
