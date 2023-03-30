//
//  BusinessSelection.h
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Transaction;

@interface BusinessSelection : NSManagedObject

@property (nonatomic, retain) NSString * consolidatedBankingOpportunityDescription;
@property (nonatomic, retain) NSString * hasCommoditiesExposure;
@property (nonatomic, retain) NSString * hasDerivativesExposure;
@property (nonatomic, retain) NSString * hasWealthManagementOpportunity;
@property (nonatomic, retain) NSString * investmentOpportunityDescription;
@property (nonatomic, retain) NSString * isConsolidatedBankingOpportunity;
@property (nonatomic, retain) NSString * isDifferentCurencies;
@property (nonatomic, retain) NSString * isDownwardRatingsLikely;
@property (nonatomic, retain) NSString * isFriendlyOrHostile;
@property (nonatomic, retain) NSString * isGovernmentAgency;
@property (nonatomic, retain) NSString * isInvestmentOpportunity;
@property (nonatomic, retain) NSString * isServicesOpportunity;
@property (nonatomic, retain) NSString * isUKCompanyInvolved;
@property (nonatomic, retain) NSString * pleaseExplain;
@property (nonatomic, retain) NSString * servicesOpportunityDescription;
@property (nonatomic, retain) NSString * toIncludeCash;
@property (nonatomic, retain) NSString * toIncludeOther;
@property (nonatomic, retain) NSString * toIncludeStock;
@property (nonatomic, retain) NSString * transactionId;
@property (nonatomic, retain) NSString * wealthManagementOpportunity;
@property (nonatomic, retain) NSString * businessSelectionType;
@property (nonatomic, retain) Transaction *transaction;

@end
