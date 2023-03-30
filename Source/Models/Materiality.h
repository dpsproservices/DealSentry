//
//  Materiality.h
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TransactionCompany;

@interface Materiality : NSManagedObject

@property (nonatomic, retain) NSString * companyId;
@property (nonatomic, retain) NSString * hasFinancialSponsor;
@property (nonatomic, retain) NSString * hasNonProfitOrganization;
@property (nonatomic, retain) NSString * hasPRC;
@property (nonatomic, retain) NSString * hasPubliclyTradedSecurities;
@property (nonatomic, retain) NSString * hasStandardAgreements;
@property (nonatomic, retain) NSString * hasUSGovtAffiliatedMunicipality;
@property (nonatomic, retain) NSString * isGovtOwned;
@property (nonatomic, retain) NSString * isMaterial;
@property (nonatomic, retain) NSString * isMaterialDescription;
@property (nonatomic, retain) NSString * percentOwned;
@property (nonatomic, retain) NSString * specialCircumstances;
@property (nonatomic, retain) NSString * transactionId;
@property (nonatomic, retain) TransactionCompany *transactionCompany;

@end
