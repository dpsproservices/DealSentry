//
//  DataManager.m
//

#import "DataManager.h"
#import "CompanyRole.h"
#import "Contact.h"
#import "ContactRole.h"
#import "AgreementType.h"
#import "DealStatus.h"
#import "Industry.h"
#import "LoanType.h"
#import "OfferingFormat.h"
#import "Segment.h"
#import "TransactionStatus.h"
#import "UseOfProceeds.h"
#import "Product.h"
#import "SubProduct.h"
#import "Country.h"
#import "ProductMap.h"
#import "Company.h"
#import "TransactionDetail.h"
#import "BusinessSelection.h"
#import "TransactionCompany.h"
#import "TransactionContact.h"
#import "Agreement.h"
#import "Materiality.h"
#import "DealSentry-Swift.h"

@implementation DataManager
@synthesize arrayForCompanyRoles,sharedDelegate,arrayForContact,arrayForContactRoles;
@synthesize arrayForAgreementTypes,arrayForDealStatuses,arrayForIndustries;
@synthesize arrayForLoanTypes,arrayForOfferingFormat,arrayForSegments;
@synthesize arrayForTransactionStatuses,arrayForUseOfProceeds,arrayForCompanies;
@synthesize arrayForProduct,arrayForProductSub,arrayForCountries,arrayForProductmap,checkIndependentEntities,arrayForTransaction;
@synthesize transactionIdFromTransaction;

static DataManager *singletonInstance;

/// created an instance method for data manager singleton
/// @returns singleton instance
+ (id)getInstance{
    if (singletonInstance == nil) {
        singletonInstance = [[super alloc] init];
    }
    return singletonInstance;
}

-(id)init
{
    
    if (self = [super init]) {
        sharedDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        context =[sharedDelegate managedObjectContext];
        self.checkForOrientationChange = sharedDelegate.currentOrientation;
        NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
        
        checkIndependentEntities = [userdefault objectForKey:@"SAVED"];
        if([checkIndependentEntities isEqualToString:@"YES"])
        {
            isSaved = YES;
        }
        else
        {
            isSaved = NO;
            checkIndependentEntities = @"NO";
        }
        
        if(!isSaved)
        {
            [self saveIndependentEntities];
            self.userIdFromLogin = sharedDelegate.userId;
            if([self.userIdFromLogin length]==0)
            {
                self.userIdFromLogin = @"ew57483";
            }
            [userdefault setObject:@"YES" forKey:@"SAVED"];
            [userdefault synchronize];
        }
        [self fetchIndependentEntities];

    }
    return self;
}


///saving the independent entities into database from csv
/// @return void
-(void)saveIndependentEntities
{
    [self saveCompanyRoleData];
    [self saveContactData];
    [self saveContactRoleData];
    [self saveAgreementTypesData];
    [self saveDealStatusesData];
    [self saveIndustryData];
    [self saveLoanTypesData];
    [self saveOfferingFormatData];
    [self saveSegmentsData];
    [self savetransactionStatusesData];
    [self saveUseOfProceedsData];
    [self saveProductData];
    [self saveProductSubData];
    [self saveCountriesData];
    [self saveProductMapData];
    [self saveCompaniesData];
    
    [self saveContext];

}

/// fetching independent entities from database in an array to pass it on to the view controllers via sharedDataModel
-(void)fetchIndependentEntities
{
    arrayForCompanyRoles = [NSArray arrayWithArray:[self fetchCompanyRoleData]];
    arrayForContact = [NSMutableArray arrayWithArray:[self fetchContactData]];
    arrayForContactRoles = [NSArray arrayWithArray:[self fetchContactRoleData]];
    arrayForAgreementTypes = [NSArray arrayWithArray:[self fetchAgreementTypesData]];
    arrayForDealStatuses = [NSArray arrayWithArray:[self fetchDealStatusesData]];
    arrayForIndustries = [NSArray arrayWithArray:[self fetchIndustryData]];
    arrayForLoanTypes = [NSArray arrayWithArray:[self fetchLoanTypesData]];
    arrayForOfferingFormat = [NSArray arrayWithArray:[self fetchOfferingFormatData]];
    arrayForSegments = [NSArray arrayWithArray:[self fetchSegmentsData]];
    arrayForTransactionStatuses = [NSArray arrayWithArray:[self fetchtransactionStatusesData]];
    arrayForUseOfProceeds = [NSArray arrayWithArray:[self fetchUseOfProceedsData]];
    arrayForProduct = [NSArray arrayWithArray:[self fetchProductData]];
    arrayForProductSub = [NSArray arrayWithArray:[self fetchSubProductData]];
    arrayForCountries = [NSArray arrayWithArray:[self fetchCountriesData]];
    arrayForProductmap = [NSArray arrayWithArray:[self fetchProductMapData]];
    arrayForCompanies = [NSMutableArray arrayWithArray:[self fetchCompaniesData]];
}


//-(void)getArrayFromSharedModel
//{
//    SharedDataModel *sharedData = [SharedDataModel sharedInstance];
//    [self saveTransactionValue:sharedData.transactionSaveArray];
//}

/// this method parses the company role csv and save it in companyRole entity as attributes which in turn present in coredata datamodel
-(void)saveCompanyRoleData
{
    for(NSMutableDictionary *companyRoleDictionary in [self parseCSVData:@"company_role"])
    {

    CompanyRole *newCompanyRole = [NSEntityDescription insertNewObjectForEntityForName:@"CompanyRoleEntity" inManagedObjectContext:context];
    newCompanyRole.roleId =[companyRoleDictionary objectForKey:@"ROLE_ID"];
    newCompanyRole.roleDescription = [companyRoleDictionary objectForKey:@"ROLE_DESCRIPTION"];
    }
    
}

/// this method parses the contact role csv and save it in contactRole entity as attributes which in turn present in coredata datamodel
-(void)saveContactRoleData
{
    for(NSMutableDictionary *contactRoleDictionary in [self parseCSVData:@"contact_role"])
    {
        ContactRole *newContactRole = [NSEntityDescription insertNewObjectForEntityForName:@"ContactRoleEntity" inManagedObjectContext:context];
        newContactRole.roleId = [contactRoleDictionary objectForKey:@"ROLE_ID"];
        newContactRole.roleDescription = [contactRoleDictionary objectForKey:@"ROLEDESCRIPTION"];
    }
   
}

/// this method parses the contact csv and save it in contact entity as attributes which in turn present in coredata datamodel
-(void)saveContactData
{
    for(NSMutableDictionary *contactDictionary in [self parseCSVData:@"contact"])
    {
    
    Contact *newContact = [NSEntityDescription insertNewObjectForEntityForName:@"ContactEntity" inManagedObjectContext:context];
    newContact.contactId = [contactDictionary objectForKey:@"CONTACT_ID"];
    newContact.email = [contactDictionary objectForKey:@"EMAIL"];
    newContact.firstName = [contactDictionary objectForKey:@"FIRST_NAME"];
    newContact.gocDescription = [contactDictionary objectForKey:@"GOC_DESCRIPTION"];
    newContact.lastName = [contactDictionary objectForKey:@"LAST_NAME"];
    newContact.phone = [contactDictionary objectForKey:@"PHONE"];
    newContact.soeId = [contactDictionary objectForKey:@"SOE_ID"];
    }
   }

/// this method parses the agreement type csv and save it in agreementType entity as attributes which in turn present in coredata datamodel
-(void)saveAgreementTypesData
{
    for(NSDictionary *agreementTypeDictionary in [self parseCSVData:@"agreement_type"])
    {
        AgreementType *newAgreementType = [NSEntityDescription insertNewObjectForEntityForName:@"AgreementTypeEntity" inManagedObjectContext:context];
        newAgreementType.agreementTypeId = [agreementTypeDictionary objectForKey:@"AGREEMENT_TYPE_ID"];
        newAgreementType.agreementDesc = [agreementTypeDictionary objectForKey:@"AGREEMENT_DESC"];
    }
   
}

/// this method parses the deal status csv and save it in dealStatuses entity as attributes which in turn present in coredata datamodel
-(void)saveDealStatusesData
{
    for(NSMutableDictionary *dealStatusDictionary in [self parseCSVData:@"deal_status"])
    {
        DealStatus *newDealStatus = [NSEntityDescription insertNewObjectForEntityForName:@"DealStatusEntity" inManagedObjectContext:context];
        newDealStatus.dealStatusId = [dealStatusDictionary objectForKey:@"DEAL_STATUS_ID"];
        newDealStatus.dealStatusDescription = [dealStatusDictionary objectForKey:@"DEAL_STATUS_DESCRIPTION"];
    }
}

/// this method parses the industry csv and save it in industry entity as attributes which in turn present in coredata datamodel
-(void)saveIndustryData
{
    for(NSMutableDictionary *industryDictionary in [self parseCSVData:@"industry"])
    {
        Industry *newIndustry = [NSEntityDescription insertNewObjectForEntityForName:@"IndustryEntity" inManagedObjectContext:context];
        newIndustry.industryId = [industryDictionary objectForKey:@"INDUSTRY_ID"];
        newIndustry.franchiseIndustry = [industryDictionary objectForKey:@"FRANCHISE_INDUSTRY"];
        newIndustry.industryDescription = [industryDictionary objectForKey:@"INDUSTRY_DESCRIPTION"];
    }
   
}

/// this method parses the loan type csv and save it in loanType entity as attributes which in turn present in coredata datamodel
-(void)saveLoanTypesData
{
    for(NSMutableDictionary *loanTypeDictionary in [self parseCSVData:@"loan_type"])
    {
        LoanType *newLoanType = [NSEntityDescription insertNewObjectForEntityForName:@"LoanTypeEntity" inManagedObjectContext:context];
        newLoanType.loanTypeId = [loanTypeDictionary objectForKey:@"LOAN_TYPE_ID"];
        newLoanType.loanTypeDescription = [loanTypeDictionary objectForKey:@"LOAN_TYPE_DESCRIPTION"];
    }
    
}

/// this method parses the offering format csv and save it in offeringFormat entity as attributes which in turn present in coredata datamodel
-(void)saveOfferingFormatData
{
    for(NSMutableDictionary *offeringFormatDictionary in [self parseCSVData:@"offering_format"])
    {
        OfferingFormat *newOfferingFormat = [NSEntityDescription insertNewObjectForEntityForName:@"OfferingFormatEntity" inManagedObjectContext:context];
        newOfferingFormat.offeringFormatId = [offeringFormatDictionary objectForKey:@"OFFERING_FORMAT_ID"];
        newOfferingFormat.offeringFormatDescription = [offeringFormatDictionary objectForKey:@"OFFERING_FORMAT_DESCRIPTION"];
    }
    
}

/// this method parses the segment csv and save it in segment entity as attributes which in turn present in coredata datamodel
-(void)saveSegmentsData
{
    for(NSMutableDictionary *segmentDictionary in [self parseCSVData:@"segment"])
    {
        Segment *newSegment = [NSEntityDescription insertNewObjectForEntityForName:@"SegmentEntity" inManagedObjectContext:context];
        newSegment.segmentId = [segmentDictionary objectForKey:@"SEGMENT_ID"];
        newSegment.segmentDescription = [segmentDictionary objectForKey:@"SEGMENT_DESCRIPTION"];
        newSegment.marketSegment = [segmentDictionary objectForKey:@"MARKET_SEGMENT"];
    }
   
}

/// this method parses the true status csv and save it in transactionStatuses entity as attributes which in turn present in coredata datamodel
-(void)savetransactionStatusesData
{
    for(NSMutableDictionary *transactionStatusDictionary in [self parseCSVData:@"true_status"])
    {
        TransactionStatus *newTransactionStatus = [NSEntityDescription insertNewObjectForEntityForName:@"TransactionStatusEntity" inManagedObjectContext:context];
        newTransactionStatus.transactionStatusId = [transactionStatusDictionary objectForKey:@"transactionStatus_ID"];
        newTransactionStatus.transactionStatusDescription = [transactionStatusDictionary objectForKey:@"TRUE_STATUS_DESCRIPTION"];
    }
}

/// this method parses the use of proceeds csv and save it in useOfProceeds entity as attributes which in turn present in coredata datamodel
-(void)saveUseOfProceedsData
{
    for(NSMutableDictionary *useOfProceedsDictionary in [self parseCSVData:@"use_of_proceeds"])
    {
        UseOfProceeds *newUseOfProceeds = [NSEntityDescription insertNewObjectForEntityForName:@"UseOfProceedsEntity" inManagedObjectContext:context];
        newUseOfProceeds.useOfProceedsId = [useOfProceedsDictionary objectForKey:@"USE_OF_PROCEEDS_ID"];
        newUseOfProceeds.useOfProceedsDescription = [useOfProceedsDictionary objectForKey:@"USE_OF_PROCEEDS_DESCRIPTION"];
    }
   
}

/// this method parses the product csv and save it in product entity as attributes which in turn present in coredata datamodel
-(void)saveProductData
{
    for(NSMutableDictionary *productDictionary in [self parseCSVData:@"product"])
    {
        Product *newProduct = [NSEntityDescription insertNewObjectForEntityForName:@"ProductEntity" inManagedObjectContext:context];
        newProduct.productId = [productDictionary objectForKey:@"PRODUCT_ID"];
        newProduct.productDescription = [productDictionary objectForKey:@"PRODUCT_DESCRIPTION"];
    }
   
}

/// this method parses the sub product csv and save it in productSub entity as attributes which in turn present in coredata datamodel
-(void)saveProductSubData
{
    for(NSMutableDictionary *productSubDictionary in [self parseCSVData:@"product_sub"])
    {
        SubProduct *newProductSub = [NSEntityDescription insertNewObjectForEntityForName:@"SubProductEntity" inManagedObjectContext:context];
        newProductSub.subProductId = [productSubDictionary objectForKey:@"PRODUCT_SUB_ID"];
        newProductSub.subProductDescription = [productSubDictionary objectForKey:@"PRODUCT_SUB_DESCRIPTION"];
    }
   
}

/// this method parses the product map csv and save it in productMap entity as attributes which in turn present in coredata datamodel
-(void)saveProductMapData
{
    for(NSMutableDictionary *productMapDictionary in [self parseCSVData:@"product_map"])
    {
        ProductMap *newProductMap = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMapEntity" inManagedObjectContext:context];
        newProductMap.productId = [productMapDictionary objectForKey:@"PRODUCT_ID"];
        newProductMap.subProductId = [productMapDictionary objectForKey:@"PRODUCT_SUB_ID"];
        newProductMap.productDescription = [productMapDictionary objectForKey:@"PRODUCT_DESCRIPTION"];
        newProductMap.productSubDescription = [productMapDictionary objectForKey:@"PRODUCT_SUB_DESCRIPTION"];

    }
    
}

/// this method parses the country csv and save it in country entity as attributes which in turn present in coredata datamodel
-(void)saveCountriesData
{
    for(NSMutableDictionary *countriesDictionary in [self parseCSVData:@"country"])
    {
        Country *newCountry = [NSEntityDescription insertNewObjectForEntityForName:@"CountryEntity" inManagedObjectContext:context];
        newCountry.countryCode = [countriesDictionary objectForKey:@"COUNTRY_CODE"];
        newCountry.countryDescription = [countriesDictionary objectForKey:@"COUNTRY_DESCRIPTION"];
        newCountry.countryName = [countriesDictionary objectForKey:@"COUNTRY_NAME"];
    }
    
}

/// this method parses the company csv and save it in company entity as attributes which in turn present in coredata datamodel
-(void)saveCompaniesData
{
    for(NSMutableDictionary *companiesDictionary in [self parseCSVData:@"company"])
    {
        Company *newCompany = [NSEntityDescription insertNewObjectForEntityForName:@"CompanyEntity" inManagedObjectContext:context];
        newCompany.companyId = [companiesDictionary objectForKey:@"COMPANY_ID"];
        newCompany.companyName = [companiesDictionary objectForKey:@"COMPANY_NAME"];
        newCompany.ticker = [companiesDictionary objectForKey:@"TICKER"];
        newCompany.countryCode = [companiesDictionary objectForKey:@"COUNTRY_CODE"];
        newCompany.gfcid = [companiesDictionary objectForKey:@"GFCID"];
        newCompany.companyLevel = [companiesDictionary objectForKey:@"COMPANY_LEVEL"];
        newCompany.exchange = [companiesDictionary objectForKey:@"EXCHANGE"];
        newCompany.parentCompany = [companiesDictionary objectForKey:@"PARENT_COMPANY"];
        newCompany.industryId = [companiesDictionary objectForKey:@"INDUSTRY_ID"];
        newCompany.segmentId = [companiesDictionary objectForKey:@"SEGMENT_ID"];
        newCompany.isManuallyDefinedByUser = [companiesDictionary objectForKey:@"IS_MANUALLY_DEFINED_BY_USER"];

    }
    
}

/// this method collects the data from transaction object class to save the deal data in database
/// @param tData this parameter will pass the deal data array comprised of details,company,contacts and M&A
/// @return void
-(void)saveTransactionValue:(NSArray*)tData
{
    for(TransactionData *transactionData in tData)
    {
        [self checkTransactionIdForNewAndExistingTransaction:transactionData.transactionId];
        
        Transaction *newTransaction = [NSEntityDescription insertNewObjectForEntityForName:@"TransactionEntity" inManagedObjectContext:context];
        newTransaction.transactionId = self.transactionId;
        //compare with transactionStatus array and pass the id
        newTransaction.transactionStatusId =  transactionData.transactionStatus;
        newTransaction.dealStatusChangedBackwards = transactionData.dealStatusChangedBackwards;
        newTransaction.savedOnDate =  [self dateFromSavedDateString:transactionData.savedOnDate];
        newTransaction.primaryClient =  transactionData.primaryClient;
        newTransaction.counterparty =  transactionData.counterparty;
        newTransaction.requestorContactId = transactionData.requestorName;
        newTransaction.clearanceApprovedDate = transactionData.clearanceApprovedDate;
        newTransaction.fulfillmentCondition = transactionData.fulfillmentCondition;
        newTransaction.submittedDate = [self dateFromSavedDateString:transactionData.submitDate];
        newTransaction.ddtRestriction = transactionData.ddtRestriction;
        
        [self saveTransactionDetailValue:transactionData.transactionDetail transactionObjectInstance:newTransaction];
        [self saveBusinessSelectionValue:transactionData.businessSelection transactionObjectInstance:newTransaction];
        [self saveTransactionCompanyValue:transactionData.transactionCompanies transactionObjectInstance:newTransaction];
        [self saveTransactionContactValue:transactionData.transactionContacts transactionObjectInstance:newTransaction];

        [self saveContext];

    }
}

/// this method collects the data from transaction detail object class for each deal
/// @param transactionDetailData this object stores the transaction detail data for each deal
/// @param transaction this object passes the transaction id as transaction is the parent of transaction detail and stores this id in transaction detail table
/// @return void

-(void)saveTransactionDetailValue:(TransactionDetailData*)transactionDetailData transactionObjectInstance:(Transaction*)transaction
{
    TransactionDetail *newTransactionDetail = [NSEntityDescription insertNewObjectForEntityForName:@"TransactionDetailEntity" inManagedObjectContext:context];
    
    newTransactionDetail.projectName = transactionDetailData.projectName;
    newTransactionDetail.dealStatusId = transactionDetailData.dealStatus;
    newTransactionDetail.productId = transactionDetailData.product;
    newTransactionDetail.productSubId = transactionDetailData.productSub;
    newTransactionDetail.dealDescription = transactionDetailData.dealDescription;
    newTransactionDetail.bankRole = transactionDetailData.bankRole;
    newTransactionDetail.dealSize = transactionDetailData.dealSize;
    newTransactionDetail.offeringFormatId = transactionDetailData.offeringFormat;
    newTransactionDetail.offeringFormatComments = transactionDetailData.offeringFormatComments;
    newTransactionDetail.useOfProceedsId = transactionDetailData.useOfProceeds;
    newTransactionDetail.useOfProceedsComments = transactionDetailData.useOfProceedsComments;
    newTransactionDetail.loanTypeId = transactionDetailData.loanType;
    newTransactionDetail.isConfidential = transactionDetailData.isConfidential;
    newTransactionDetail.estimatedPitchDate = transactionDetailData.estimatedPitchDate;
    newTransactionDetail.expectedAnnouncementDate = transactionDetailData.expectedAnnouncementDate;
    newTransactionDetail.expectedClosingDate = transactionDetailData.expectedClosingDate;
    newTransactionDetail.isSubjectToTakeOver = transactionDetailData.isSubjectToTakeOver;
    newTransactionDetail.likelyToTakePlace = transactionDetailData.likelyToTakePlace;
    newTransactionDetail.backwardsDealStatusExplanation = transactionDetailData.backwardsDealStatusExplanation;
    newTransactionDetail.terminatedExplanation = transactionDetailData.terminatedExplanation;
    newTransactionDetail.uncollectedFees = transactionDetailData.uncollectedFees;
    newTransactionDetail.transactionId = transaction.transactionId;
    
    newTransactionDetail.transaction = transaction;
}

/// this method collects the data from business selection object class for each deal whose product is M&A
/// @param bsData this object stores the business selection data for each deal whose product is M&A
/// @param transaction this object passes the transaction id as transaction is the parent of transaction detail and stores this id in business selection table
/// @return void

-(void)saveBusinessSelectionValue:(BusinessSelectionData*)bsData transactionObjectInstance:(Transaction*)transaction
{
    BusinessSelection *newBusinessSelection = [NSEntityDescription insertNewObjectForEntityForName:@"BusinessSelectionEntity" inManagedObjectContext:context];
    
    newBusinessSelection.isDifferentCurencies = bsData.isDifferentCurrencies;
    newBusinessSelection.isUKCompanyInvolved = bsData.isUKCompanyInvolved;
    newBusinessSelection.isFriendlyOrHostile = bsData.isFriendlyOrHostile;
    newBusinessSelection.isDownwardRatingsLikely = bsData.isDownwardRatingsLikely;
    newBusinessSelection.isGovernmentAgency = bsData.isGovernmentAgency;
    newBusinessSelection.isConsolidatedBankingOpportunity = bsData.isConsolidatedBankingOpportunity;
    newBusinessSelection.consolidatedBankingOpportunityDescription = bsData.consolidatedBankingOpportunityDescription;
    newBusinessSelection.isInvestmentOpportunity = bsData.isInvestmentOpportunity;
    newBusinessSelection.investmentOpportunityDescription = bsData.investmentOpportunityDescription;
    newBusinessSelection.isServicesOpportunity = bsData.isServicesOpportunity;
    newBusinessSelection.servicesOpportunityDescription = bsData.servicesOpportunityDescription;
    newBusinessSelection.toIncludeCash = bsData.toIncludeCash;
    newBusinessSelection.toIncludeStock = bsData.toIncludeStock;
    newBusinessSelection.toIncludeOther = bsData.toIncludeOther;
    newBusinessSelection.pleaseExplain = bsData.pleaseExplain;
    newBusinessSelection.hasDerivativesExposure = bsData.hasDerivativesExposure;
    newBusinessSelection.hasCommoditiesExposure = bsData.hasCommoditiesExposure;
    newBusinessSelection.hasWealthManagementOpportunity = bsData.hasWealthManagementOpportunity;
    newBusinessSelection.wealthManagementOpportunity = bsData.wealthManagementOpportunity;
    newBusinessSelection.businessSelectionType = bsData.businessSelectionTypeForEither;
    newBusinessSelection.transactionId = transaction.transactionId;
    
    newBusinessSelection.transaction = transaction;

}

/// this method collects the data from transaction company object class for each deal
/// @param tcData this object not only stores the tranasction company but also act as a parent for company,materiality and agreement. there can be more than one transaction company for a deal
/// @param transaction this object passes the transaction id as transaction is the parent of transaction detail and stores this id in business selection table
/// @return void
-(void)saveTransactionCompanyValue:(NSArray*)tcData transactionObjectInstance:(Transaction*)transaction
{
    for(TransactionCompanyData *transactionCompanyData in tcData)
    {
        TransactionCompany *newTransactionCompany = [NSEntityDescription insertNewObjectForEntityForName:@"TransactionCompanyEntity" inManagedObjectContext:context];
        for(CompanyRoleData *CompanyRoleData in arrayForCompanyRoles)
        {
            if([transactionCompanyData.role isEqualToString:CompanyRoleData.roleDescription])
            {
                newTransactionCompany.roleId = CompanyRoleData.roleId;
                break;
            }
        }
        
        newTransactionCompany.transactionId = transaction.transactionId;
        
        newTransactionCompany.transaction = transaction;
        BOOL isManuallyDefined;
        if(transactionCompanyData.isManuallyDefinedByUser)
        {
            isManuallyDefined = YES;
        }
        else
        {
            isManuallyDefined = NO;
        }
        [self saveAgreementValue:transactionCompanyData.agreements transactionCompanyObjectInstance:newTransactionCompany];
        [self saveCompanyValue:transactionCompanyData.company transactionCompanyObjectInstance:newTransactionCompany checkForManuallyDefined:isManuallyDefined];
        [self savematerialityValue:transactionCompanyData.materiality transactionCompanyObjectInstance:newTransactionCompany];
    }
}

/// this method collects the data from agreements data where a transaction company can have more than one agreement
/// @param agData this stores an array of agreement data passed for each transaction company
/// @param transactionCompany this object passes the transactionCompany id as transaction Company is the parent of agreements and stores this id in agreements table
/// @return void
-(void)saveAgreementValue:(NSArray *)agData transactionCompanyObjectInstance:(TransactionCompany *)transactionCompany
{
    for(AgreementData *aData in agData)
    {
            Agreement *newAgreement = [NSEntityDescription insertNewObjectForEntityForName:@"AgreementEntity" inManagedObjectContext:context];
        
        for(AgreementTypeData *aTData in arrayForAgreementTypes)
        {
            if([aData.agreementType isEqualToString:aTData.agreementDesc])
            {
                newAgreement.agreementTypeId = aTData.agreementTypeId;
                break;
            }
        }
            newAgreement.effectiveDate = aData.effectiveDate;
            newAgreement.expirationDate = aData.expirationDate;
            newAgreement.agreementTerms = aData.agreementTerms;
            newAgreement.legalReviewBy = aData.legalReviewBy;
            newAgreement.companyId = transactionCompany.companyId;
            newAgreement.transactionId = transactionCompany.transactionId;
            newAgreement.exclusivityApprovedBy = aData.exclusivityApprovedBy;
            
            newAgreement.transactionCompany = transactionCompany;
        }
        
    }

/// this method collects the data from company object where a transaction company can have only one company
/// @param cData this stores the details of company
/// @param checkForManual this boolean value is passed based on the company defined by the user. usually a company can be selected from the company list or they can also define manually if it is not present in the list
/// @param transactionCompany this object passes the transactionCompany id as transaction Company is the parent of agreements and stores this id in agreements table
/// @return void

-(void)saveCompanyValue:(CompanyData*)cData transactionCompanyObjectInstance:(TransactionCompany *)transactionCompany checkForManuallyDefined:(BOOL)checkForManual
{
    if(!checkForManual)
    {
        transactionCompany.companyId = cData.companyId;
    }
    else
    {
        Company *newCompany= [NSEntityDescription insertNewObjectForEntityForName:@"CompanyEntity" inManagedObjectContext:context];
        transactionCompany.companyId = [NSString stringWithFormat:@"%d",[self.companyId intValue]+1];
        newCompany.companyId =  transactionCompany.companyId;
        newCompany.companyName = cData.companyName;
        newCompany.ticker = cData.ticker;
        newCompany.countryCode = cData.countryFlag;
        newCompany.gfcid = cData.gfcid;
        newCompany.companyLevel = cData.level;
        newCompany.exchange = cData.exchange;
        newCompany.parentCompany = cData.parentCompany;
        newCompany.industryId = cData.franchiseIndustry;
        newCompany.segmentId = cData.marketSegment;
        newCompany.transactionCompany = transactionCompany;
        newCompany.isManuallyDefinedByUser = [NSString stringWithFormat:@"%i",checkForManual];
    }
    
}

/// this method collects the data from materiality object where a transaction company can have only one materiality
/// @param mData this stores the details of materiality
/// @param transactionCompany this object passes the transactionCompany id as transaction Company is the parent of agreements and stores this id in agreements table
/// @return void
-(void)savematerialityValue:(MaterialityData*)mData transactionCompanyObjectInstance:(TransactionCompany *)transactionCompany
{
    
            Materiality *newMateriality = [NSEntityDescription insertNewObjectForEntityForName:@"MaterialityEntity" inManagedObjectContext:context];
            newMateriality.isMaterial = mData.isMaterial;
            newMateriality.isMaterialDescription = mData.isMaterialDescription;
            newMateriality.hasPubliclyTradedSecurities = mData.hasPubliclyTradedSecurities;
            newMateriality.isGovtOwned = mData.isGovtOwned;
            newMateriality.percentOwned = mData.percentOwned;
            newMateriality.hasPRC = mData.hasPRC;
            newMateriality.companyId = transactionCompany.companyId;
            newMateriality.transactionId = transactionCompany.transactionId;
            newMateriality.specialCircumstances = mData.specialCircumstances;
            newMateriality.hasStandardAgreements = mData.hasStandardAgreements;
    
            newMateriality.transactionCompany = transactionCompany;
        
}

/// this method collects the data from transaction contact object class for each deal
/// @param tContactData this object stores the transaction contact of each deal there can be more than one transaction contact for a deal
/// @param transaction this object passes the transaction id as transaction is the parent of transaction detail and stores this id in business selection table
/// @return void
-(void)saveTransactionContactValue:(NSArray*)tContactData transactionObjectInstance:(Transaction*)transaction
{
    for(TransactionContactData *transactionContactData in tContactData)
    {
        TransactionContact *newTransactionContact = [NSEntityDescription insertNewObjectForEntityForName:@"TransactionContactEntity" inManagedObjectContext:context];
        
        
        if([transactionContactData.role isEqualToString:@""])
        {
            transactionContactData.role = @"Other";
        }
        for(ContactRoleData *contactRoleData in arrayForContactRoles)
        {
            if([transactionContactData.role isEqualToString:contactRoleData.roleDescription])
            {
                newTransactionContact.roleId = contactRoleData.roleId;
                break;
            }
        }
        [self saveContactValue:transactionContactData.contact transactionObjectInstance:newTransactionContact];
        newTransactionContact.transactionId = transaction.transactionId;
        
        newTransactionContact.transaction = transaction;
    }
}

/// this method collects the data from  contact object class for each transaction contact
/// @param contactData this object stores the contact details of an user
/// @param transaction this object passes the transactionContact id as transaction contact is the parent of contact and stores this id in contact table
/// @return void
-(void)saveContactValue:(ContactData*)contactData transactionObjectInstance:(TransactionContact*)transactionContact
{
    transactionContact.contactId = contactData.soeID;
    if(contactData.crossSellDesignee)
    {
        transactionContact.crossSellDesignee = @"true";
    }
    else
    {
        transactionContact.crossSellDesignee = @"false";
    }
}

/// this method retrieves the deal list present in database and the list is sorted based on savedOnDate
/// @return returns entire deal list present in database as mutable array
-(NSMutableArray*)fetchTransactionData
{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *ent = [NSEntityDescription entityForName:@"TransactionEntity" inManagedObjectContext:context];
    [request setEntity:ent];
    
    NSSortDescriptor *srt = [NSSortDescriptor sortDescriptorWithKey:@"savedOnDate" ascending:NO selector:@selector(localizedStandardCompare:)];
    
    [request setSortDescriptors:[NSArray arrayWithObject:srt]];
    
    //        NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"transactionId = %@", @"12348"];
    //        [request setPredicate:myPredicate];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    
    
    NSMutableArray *fetchTransactionFromDatabase = [[NSMutableArray alloc]init];

    
    for(Transaction *transaction in objects)
    {

        
        NSString *role,*agreementType,*contactRoleForContact;
        NSMutableArray *transactionCompaniesForFetching = [[NSMutableArray alloc]init];
        
        NSMutableArray *agreementForFetching = [[NSMutableArray alloc]init];
        
        NSMutableArray *transactionContactsForFetching = [[NSMutableArray alloc]init];
        

        for(TransactionCompany *tcCompany in transaction.transactionCompany)
        {
            NSString *companyId,*companyName,*ticker,*countryCode,*gfcid,*companyLevel,*exchange,*segmentId,*industryId,*parentCompany;
            
            arrayForCompanies = [NSMutableArray arrayWithArray:[self fetchCompaniesData]];

            for(CompanyData *companiesData in arrayForCompanies)
            {
                if([tcCompany.companyId isEqualToString:companiesData.companyId])
                {
                    companyId = companiesData.companyId;
                    if([companyId length]== 0)
                    {
                        companyId = @"";
                    }
                    companyName = companiesData.companyName;
                    if([companyName length]== 0)
                    {
                        companyName = @"";
                    }
                    ticker = companiesData.ticker;
                    if([ticker length]== 0)
                    {
                        ticker = @"";
                    }
                    countryCode = companiesData.country;
                    if([countryCode length]== 0)
                    {
                        countryCode = @"";
                    }
                    gfcid = companiesData.gfcid;
                    if([gfcid length]== 0)
                    {
                        gfcid = @"";
                    }
                    companyLevel = companiesData.level;
                    if([companyLevel length]== 0)
                    {
                        companyLevel = @"";
                    }
                    exchange = companiesData.exchange;
                    if([exchange length]== 0)
                    {
                        exchange = @"";
                    }
                    segmentId = companiesData.marketSegment;
                    if([segmentId length]== 0)
                    {
                        segmentId = @"";
                    }
                    industryId = companiesData.franchiseIndustry;
                    if([industryId length]== 0)
                    {
                        industryId = @"";
                    }
                    parentCompany = companiesData.parentCompany;
                    if([parentCompany length]== 0)
                    {
                        parentCompany = @"";
                    }
                    break;
                }
            }
             CompanyData *companyData  = [[CompanyData alloc]initWithCompanyId:companyId companyName: companyName ticker:ticker country:countryCode gfcid:gfcid level:companyLevel exchange:exchange marketSegment:segmentId franchiseIndustry:industryId parentCompany:parentCompany countryFlag:countryCode];
            
            arrayForCompanyRoles = [NSArray arrayWithArray:[self fetchCompanyRoleData]];
            
            for(CompanyRoleData *CompanyRoleData in arrayForCompanyRoles)
            {
                if([tcCompany.roleId isEqualToString:CompanyRoleData.roleId])
                {
                    role = CompanyRoleData.roleDescription;
                    break;
                }
            }
            
            if([role length]==0)
            {
                role = @"";
            }
            
            MaterialityData *materialityData = [[MaterialityData alloc] initWithIsMaterial:tcCompany.materiality.isMaterial isMaterialDescription:tcCompany.materiality.isMaterialDescription hasPubliclyTradedSecurities:tcCompany.materiality.hasPubliclyTradedSecurities isGovtOwned:tcCompany.materiality.isGovtOwned percentOwned:tcCompany.materiality.percentOwned hasPRC:tcCompany.materiality.hasPRC hasStandardAgreements:tcCompany.materiality.hasStandardAgreements specialCircumstances:tcCompany.materiality.specialCircumstances];
            
            arrayForAgreementTypes = [NSArray arrayWithArray:[self fetchAgreementTypesData]];
            
                        for(Agreement *agreement in tcCompany.agreement)
                        {
                            for(AgreementTypeData *aTData in arrayForAgreementTypes)
                            {
                                if([agreement.agreementTypeId isEqualToString:aTData.agreementTypeId])
                                {
                                    agreementType = aTData.agreementDesc;
                                    break;
                                }
                            }
                            if([agreementType length]==0)
                            {
                                agreementType = @"";
                            }
                            
                            AgreementData *agreementData = [[AgreementData alloc] initWithAgreementType:agreementType effectiveDate:agreement.effectiveDate expirationDate:agreement.expirationDate agreementTerms:agreement.agreementTerms legalReviewBy:agreement.legalReviewBy exclusivityApprovedBy:agreement.exclusivityApprovedBy];
                            [agreementForFetching addObject:agreementData];
                        }
            
            NSArray *agreements = [NSArray arrayWithArray:agreementForFetching];

            if([role length]==0)
            {
                role = @"";
            }
            TransactionCompanyData *transactionCompanyData = [[TransactionCompanyData alloc]initWithCompany:companyData role:role materiality:materialityData agreements:agreements isManuallyDefinedByUser:false];
            
            [transactionCompaniesForFetching addObject:transactionCompanyData];
        }
        
        NSArray *transactionCompanies = [NSArray arrayWithArray:transactionCompaniesForFetching];
        
        
         TransactionDetailData *transactionDetailData = [[TransactionDetailData alloc]initWithProjectName:transaction.transactionDetail.projectName dealStatusDB:@"" dealStatus:transaction.transactionDetail.dealStatusId product:transaction.transactionDetail.productId productSub:transaction.transactionDetail.productSubId dealDescription:transaction.transactionDetail.dealDescription bankRole:transaction.transactionDetail.bankRole dealSize:transaction.transactionDetail.dealSize offeringFormat:transaction.transactionDetail.offeringFormatId offeringFormatComments:transaction.transactionDetail.offeringFormatComments useOfProceeds:transaction.transactionDetail.useOfProceedsId useOfProceedsComments:transaction.transactionDetail.useOfProceedsComments loanType:transaction.transactionDetail.loanTypeId isConfidential:transaction.transactionDetail.isConfidential estimatedPitchDate:transaction.transactionDetail.estimatedPitchDate expectedAnnouncementDate:transaction.transactionDetail.expectedAnnouncementDate expectedClosingDate:transaction.transactionDetail.expectedClosingDate isSubjectToTakeOver:transaction.transactionDetail.isSubjectToTakeOver hasFinancialSponsor:@"" hasNonProfitOrganization:@"" hasUSGovtAffiliatedMunicipality:@"" likelyToTakePlace:transaction.transactionDetail.likelyToTakePlace backwardsDealStatusExplanation:transaction.transactionDetail.backwardsDealStatusExplanation terminatedExplanation:transaction.transactionDetail.terminatedExplanation uncollectedFees:transaction.transactionDetail.uncollectedFees requests:@""];
        
        BusinessSelectionData *businessSelectionData = [[BusinessSelectionData alloc]initWithIsDifferentCurrencies:transaction.businessSelection.isDifferentCurencies isUKCompanyInvolved:transaction.businessSelection.isUKCompanyInvolved isFriendlyOrHostile:transaction.businessSelection.isFriendlyOrHostile isDownwardRatingsLikely:transaction.businessSelection.isDownwardRatingsLikely isGovernmentAgency:transaction.businessSelection.isGovernmentAgency isConsolidatedBankingOpportunity:transaction.businessSelection.isConsolidatedBankingOpportunity consolidatedBankingOpportunityDescription:transaction.businessSelection.consolidatedBankingOpportunityDescription isInvestmentOpportunity:transaction.businessSelection.isInvestmentOpportunity investmentOpportunityDescription:transaction.businessSelection.investmentOpportunityDescription isServicesOpportunity:transaction.businessSelection.isServicesOpportunity servicesOpportunityDescription:transaction.businessSelection.servicesOpportunityDescription toIncludeCash:transaction.businessSelection.toIncludeCash toIncludeStock:transaction.businessSelection.toIncludeStock toIncludeOther:transaction.businessSelection.toIncludeOther pleaseExplain:transaction.businessSelection.pleaseExplain businessSelectionTypeForEither:transaction.businessSelection.businessSelectionType hasDerivativesExposure:transaction.businessSelection.hasDerivativesExposure hasCommoditiesExposure:transaction.businessSelection.hasCommoditiesExposure hasWealthManagementOpportunity:transaction.businessSelection.hasWealthManagementOpportunity wealthManagementOpportunity:transaction.businessSelection.wealthManagementOpportunity];
        
        for(TransactionContact *tContact in transaction.transactionContact)
        {
            NSString *firstName;
            NSString *lastName;
            NSString *gocDescription;
            NSString *soeID;
            NSString *phone;
            NSString *email;
            BOOL crossSellDesignee;
            arrayForContactRoles = [NSArray arrayWithArray:[self fetchContactRoleData]];
            
            for(ContactRoleData *contactRoleData in arrayForContactRoles)
            {
                if([tContact.roleId isEqualToString:contactRoleData.roleId])
                {
                    contactRoleForContact = contactRoleData.roleDescription;
                    break;
                }
            }
            
            arrayForContact = [NSMutableArray arrayWithArray:[self fetchContactData]];

            
            for(ContactData *conData in arrayForContact)
            {
                if([tContact.contactId isEqualToString:conData.soeID])
                {
                    firstName = conData.firstName;
                    lastName = conData.lastName;
                    gocDescription = conData.gocDescription;
                    soeID = conData.soeID;
                    phone = conData.phone;
                    email = conData.email;
                    break;
                }
            }
            
            if([tContact.crossSellDesignee isEqualToString:@"true"])
            {
                crossSellDesignee = YES;
            }
            else
            {
                crossSellDesignee = NO;
            }
            
            ContactData *contactDataForTransaction = [[ContactData alloc] initWithFirstName:firstName lastName:lastName gocDescription:gocDescription soeID:soeID phone:phone email:email crossSellDesignee:crossSellDesignee];
            
            if([contactRoleForContact length]==0)
            {
                contactRoleForContact = @"";
            }
            
            TransactionContactData *tContactData = [[TransactionContactData alloc]initWithContact:contactDataForTransaction role:contactRoleForContact];
            [transactionContactsForFetching addObject:tContactData];
           
        }
        NSArray *transactionContacts = [NSArray arrayWithArray:[self rearrangeContactData:transactionContactsForFetching]];
        
        NSString *submittedDateInDataBase;
        NSString *clearanceApprovedDate;
        if(transaction.submittedDate == nil)
        {
            submittedDateInDataBase = @"";
        }
        else
        {
            submittedDateInDataBase = [self stringFromSavedDate:transaction.submittedDate];
        }
        
        if([transaction.clearanceApprovedDate length] == 0 )
        {
            clearanceApprovedDate = @"";
        }
        else
        {
            clearanceApprovedDate = transaction.clearanceApprovedDate;
        }
        
        TransactionData *transactionData = [[TransactionData alloc] initWithTransactionId:transaction.transactionId transactionStatus:transaction.transactionStatusId dealStatus:@"" ddtRestriction:transaction.ddtRestriction savedOnDate:[self stringFromSavedDate:transaction.savedOnDate] submitDate:submittedDateInDataBase requestorName:transaction.requestorContactId primaryClient:transaction.primaryClient counterparty:transaction.counterparty product:@"" productSub:@"" fulfillmentCondition:transaction.fulfillmentCondition clearanceApprovedDate:clearanceApprovedDate transactionCompanies:transactionCompanies transactionDetail:transactionDetailData businessSelection:businessSelectionData transactionContacts:transactionContacts];
        

        [fetchTransactionFromDatabase addObject:transactionData];
    
}
    return fetchTransactionFromDatabase;
}

-(NSArray*)transactionArray
{
    arrayForTransaction = [NSMutableArray arrayWithArray:[self fetchTransactionData]];
    return arrayForTransaction;
}

/// this method retrieves the company list present in database and also provides the maximumCompanyId and the data is passed to CompanyData object
/// @return returns entire company list present in database as mutable array
-(NSMutableArray*)fetchCompaniesData
{
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"CompanyEntity"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    //        NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"transactionId = %@", @"12348"];
    //        [request setPredicate:myPredicate];
    

    
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    //
    
        NSMutableArray *draftIdFromColumn = [[NSMutableArray alloc] init];
        for (NSManagedObject *fetchedObject in objects) {
            [draftIdFromColumn addObject:[fetchedObject valueForKey:@"companyId"]];
        }
    
        NSNumber * maxDraftId = [draftIdFromColumn valueForKeyPath:@"@max.intValue"];
        self.companyId = [maxDraftId stringValue];
    //
    
    
    NSMutableArray *companiesArray = [[NSMutableArray alloc]init];
    
    
    for(Company *company in objects)
    {
        CompanyData *companyData  = [[CompanyData alloc]initWithCompanyId:company.companyId companyName: company.companyName ticker:company.ticker country:company.countryCode gfcid:company.gfcid level:company.companyLevel exchange:company.exchange marketSegment:company.segmentId franchiseIndustry:company.industryId parentCompany:company.parentCompany countryFlag:company.countryCode];
        [companiesArray addObject:companyData];
    }
    return companiesArray;
    
}

/// this method retrieves the mapping of product and subproduct saved as product map from database and the data is passed to ProductMap object
/// @return returns entire mapping of product and sub product present in database as mutable array
-(NSMutableArray*)fetchProductMapData
{
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"ProductMapEntity"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    //        NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"transactionId = %@", @"12348"];
    //        [request setPredicate:myPredicate];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    NSMutableArray *productMapArray = [[NSMutableArray alloc]init];
    
    
    for(ProductMap *productMap in objects)
    {
        // ContactData *contactData =
        // [[NSClassFromString(@"ContactData") alloc] init];
        ProductMapData *productMapData = [[ProductMapData alloc]initWithProduct:productMap.productId productSub:productMap.subProductId productDescription:productMap.productDescription productSubDescription:productMap.productSubDescription];
        [productMapArray addObject:productMapData];
    }
    return productMapArray;
    
}

/// this method retrieves the country list from database and the data is passed to CountryData object
/// @return returns entire countries present in database as mutable array
-(NSMutableArray*)fetchCountriesData
{
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"CountryEntity"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    //        NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"transactionId = %@", @"12348"];
    //        [request setPredicate:myPredicate];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    NSMutableArray *countriesArray = [[NSMutableArray alloc]init];
    
    
    for(Country *country in objects)
    {
        // ContactData *contactData =
        // [[NSClassFromString(@"ContactData") alloc] init];
        CountryData *countryData = [[CountryData alloc]initWithCountryCode:country.countryCode countryName:country.countryName countryDescription:country.countryDescription countryFlag:@""];
        
        [countriesArray addObject:countryData];
    }
    return countriesArray;
    
}

/// this method retrieves the products from database and the data is passed to ProductData object
/// @return returns entire products present in database as mutable array
-(NSMutableArray*)fetchProductData
{
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"ProductEntity"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    //        NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"transactionId = %@", @"12348"];
    //        [request setPredicate:myPredicate];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    NSMutableArray *productArray = [[NSMutableArray alloc]init];
    
    
    for(Product *product in objects)
    {
        // ContactData *contactData =
        // [[NSClassFromString(@"ContactData") alloc] init];
        ProductData *productData = [[ProductData alloc] initWithProductId:product.productId productDescription:product.productDescription];
        [productArray addObject:productData];
    }
    return productArray;
    
}

/// this method retrieves the sub products from database and the data is passed to ProductSubData object
/// @return returns entire sub products present in database as mutable array
-(NSMutableArray*)fetchSubProductData
{
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"SubProductEntity"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    //        NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"transactionId = %@", @"12348"];
    //        [request setPredicate:myPredicate];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    NSMutableArray *productSubArray = [[NSMutableArray alloc]init];
    
    
    for(SubProduct *subProduct in objects)
    {
        ProductSubData *productSubData = [[ProductSubData alloc] initWithProductSubId:subProduct.subProductId productSubDescription:subProduct.subProductDescription];
        [productSubArray addObject:productSubData];
    }
    return productSubArray;
    
}

/// this method retrieves the use of proceeds from database and the data is passed to UseOfProceedsData object
/// @return returns entire use of proceeds present in database as mutable array
-(NSMutableArray*)fetchUseOfProceedsData
{
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"UseOfProceedsEntity"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    //        NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"transactionId = %@", @"12348"];
    //        [request setPredicate:myPredicate];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    
    NSMutableArray *useOfProccedsArray = [[NSMutableArray alloc]init];
    
    
    for(UseOfProceeds *useOfProceeds in objects)
    {
        // ContactData *contactData =
        // [[NSClassFromString(@"ContactData") alloc] init];
        UseOfProceedsData *useOfProceedsData = [[UseOfProceedsData alloc]initWithUseOfProceedsId:useOfProceeds.useOfProceedsId useOfProceedsDescription:useOfProceeds.useOfProceedsDescription];
        [useOfProccedsArray addObject:useOfProceedsData];
    }
    return useOfProccedsArray;
}

/// this method retrieves the true statuses from database and the data is passed to transactionStatusData object
/// @return returns entire true statuses present in database as mutable array
-(NSMutableArray*)fetchtransactionStatusesData
{
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"TransactionStatusEntity"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    //        NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"transactionId = %@", @"12348"];
    //        [request setPredicate:myPredicate];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    
    NSMutableArray *transactionStatusArray = [[NSMutableArray alloc]init];
    
    
    for(TransactionStatus *transactionStatus in objects)
    {
        TransactionStatusData *transactionStatusData = [[TransactionStatusData alloc] initWithTransactionStatusId:transactionStatus.transactionStatusId transactionStatusDescription:transactionStatus.transactionStatusDescription];
        [transactionStatusArray addObject:transactionStatusData];
    }
    return transactionStatusArray;
}

/// this method retrieves the segments from database and the data is passed to SegmentsData object
/// @return returns entire segments present in database as mutable array
-(NSMutableArray*)fetchSegmentsData
{
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"SegmentEntity"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    //        NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"transactionId = %@", @"12348"];
    //        [request setPredicate:myPredicate];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    NSMutableArray *segmentArray = [[NSMutableArray alloc]init];
    
    
    for(Segment *segment in objects)
    {
        // ContactData *contactData =
        // [[NSClassFromString(@"ContactData") alloc] init];
        SegmentsData *segmentsData = [[SegmentsData alloc]initWithId:segment.segmentId name:segment.marketSegment segmentDescription:segment.segmentDescription];
        
        [segmentArray addObject:segmentsData];
    }
    return segmentArray;
    
}

/// this method retrieves the offering formats from database and the data is passed to OfferingformatData object
/// @return returns entire offering formats present in database as mutable array
-(NSMutableArray*)fetchOfferingFormatData
{
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"OfferingFormatEntity"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    //        NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"transactionId = %@", @"12348"];
    //        [request setPredicate:myPredicate];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    
    NSMutableArray *offeringFormatArray = [[NSMutableArray alloc]init];
    
    
    for(OfferingFormat *offeringFormat in objects)
    {
        OfferingFormatData *offeringFormatData = [[OfferingFormatData alloc]initWithOfferingFormatId:offeringFormat.offeringFormatId offeringFormatDescription:offeringFormat.offeringFormatDescription];
        [offeringFormatArray addObject:offeringFormatData];
    }
    return offeringFormatArray;
}

/// this method retrieves the loan types from database and the data is passed to LoanTypeData object
/// @return returns entire loan type present in database as mutable array
-(NSMutableArray*)fetchLoanTypesData
{
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"LoanTypeEntity"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    //        NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"transactionId = %@", @"12348"];
    //        [request setPredicate:myPredicate];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    NSMutableArray *loanTypeArray = [[NSMutableArray alloc]init];
    
    
    for(LoanType *loanType in objects)
    {
        LoanTypeData *loanTypeData = [[LoanTypeData alloc]initWithLoanTypeId:loanType.loanTypeId loanTypeDescription:loanType.loanTypeDescription];
        [loanTypeArray addObject:loanTypeData];
    }
    return loanTypeArray;
}


/// this method retrieves the industry list from database and the data is passed to IndustryData object
/// @return returns entire industry list present in database as mutable array
-(NSMutableArray*)fetchIndustryData
{
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"IndustryEntity"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    //        NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"transactionId = %@", @"12348"];
    //        [request setPredicate:myPredicate];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    NSMutableArray *industryArray = [[NSMutableArray alloc]init];
    
    
    for(Industry *industry in objects)
    {
        // ContactData *contactData =
        // [[NSClassFromString(@"ContactData") alloc] init];
        IndustryData *industryData = [[IndustryData alloc]initWithId:industry.industryId name:industry.franchiseIndustry industryDescription:industry.industryDescription];
        
        [industryArray addObject:industryData];
    }
    return industryArray;
    
}

/// this method retrieves the contact from database and the data is passed to ContactData object
/// @return returns entire contact present in database as mutable array
-(NSMutableArray*)fetchContactData
{
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"ContactEntity"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    //        NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"transactionId = %@", @"12348"];
    //        [request setPredicate:myPredicate];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    NSMutableArray *contactArray = [[NSMutableArray alloc]init];
    
    
    for(Contact *contact in objects)
    {
       // ContactData *contactData =
       // [[NSClassFromString(@"ContactData") alloc] init];
        ContactData *contactData = [[ContactData alloc] initWithFirstName:contact.firstName lastName:contact.lastName gocDescription:contact.gocDescription soeID:contact.soeId phone:contact.phone email:contact.email crossSellDesignee:false];
        
        [contactArray addObject:contactData];
    }
    return contactArray;
    
}

/// this method retrieves the company roles from database and the data is passed to CompanyRoleData object
/// @return returns entire company roles present in database as mutable array
-(NSMutableArray*)fetchCompanyRoleData
{
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"CompanyRoleEntity"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    //        NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"transactionId = %@", @"12348"];
    //        [request setPredicate:myPredicate];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    NSMutableArray *companyRoleArray = [[NSMutableArray alloc]init];
    
    
    for(CompanyRole *companyRole in objects)
    {
        CompanyRoleData *companyRoleData = [[CompanyRoleData alloc]initWithRoleId:companyRole.roleId roleDescription:companyRole.roleDescription];
        [companyRoleArray addObject:companyRoleData];
    }
    return companyRoleArray;

}

/// this method retrieves the contact roles from database and the data is passed to ContactRoleData object
/// @return returns entire contact roles present in database as mutable array
-(NSMutableArray*)fetchContactRoleData
{
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"ContactRoleEntity"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    //        NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"transactionId = %@", @"12348"];
    //        [request setPredicate:myPredicate];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    NSMutableArray *contactRoleArray = [[NSMutableArray alloc]init];
    
    
    for(ContactRole *contactRole in objects)
    {
        ContactRoleData *contactRoleData = [[ContactRoleData alloc] initWithRoleId:contactRole.roleId roleDescription:contactRole.roleDescription];
        [contactRoleArray addObject:contactRoleData];
    }
    return contactRoleArray;
}

/// this method retrieves the agreement types from database and the data is passed to AgreementTypeData object
/// @return returns entire agreement types present in database as mutable array
-(NSMutableArray*)fetchAgreementTypesData
{
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"AgreementTypeEntity"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    //        NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"transactionId = %@", @"12348"];
    //        [request setPredicate:myPredicate];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    NSMutableArray *agreementTypeArray = [[NSMutableArray alloc]init];
    
    
    for(AgreementType *agreementType in objects)
    {
        AgreementTypeData *agreementTypeData = [[AgreementTypeData alloc]initWithAgreementTypeId:agreementType.agreementTypeId agreementDesc:agreementType.agreementDesc];
        [agreementTypeArray addObject:agreementTypeData];
    }
    return agreementTypeArray;

}

/// this method retrieves the deal statuses from database and the data is passed to DealStatusData object
/// @return returns entire deal statuses present in database as mutable array
-(NSMutableArray*)fetchDealStatusesData
{
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"DealStatusEntity"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    //        NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"transactionId = %@", @"12348"];
    //        [request setPredicate:myPredicate];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    NSMutableArray *dealStatusArray = [[NSMutableArray alloc]init];
    
    
    for(DealStatus *dealStatus in objects)
    {
        DealStatusData *dealStatusData = [[DealStatusData alloc]initWithDealStatusId:dealStatus.dealStatusId dealStatusDescription:dealStatus.dealStatusDescription];
        [dealStatusArray addObject:dealStatusData];
    }
    return dealStatusArray;

}

/// this method deletes the entire deal transaction from the database based on the transaction id and it cannot be undone
///@param transactionId transaction id of the particular transaction to be deleted from database
/// @return returns void
-(void)deleteTransaction:(NSString*)transactionId
{
    if(isCheckForDelete)
    {
        if([self.deletedTransactionId length]==0)
        {
            [self getMaximumId];

            self.deletedTransactionId = [NSString stringWithFormat:@"%d",[self.transactionId intValue]+1];

        }
        else
        {
            int transactionIdConversion = [transactionId intValue];
            int deletedIdConversion = [self.deletedTransactionId intValue];
            
            if(transactionIdConversion >= deletedIdConversion)
            {
                self.deletedTransactionId = [NSString stringWithFormat:@"%d",[self.deletedTransactionId intValue]+1];
            }
            else if(transactionIdConversion < deletedIdConversion)
            {
                self.deletedTransactionId = self.deletedTransactionId;
            }
            else
            {
                self.deletedTransactionId = [NSString stringWithFormat:@"%d",[self.deletedTransactionId intValue]+1];
            }
            
        }
        isCheckForDelete = NO;
    }
    
    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"TransactionEntity"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"transactionId = %@", transactionId];
    [request setPredicate:myPredicate];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    for(NSManagedObject *object in objects)
    {
        [context deleteObject:object];
    }
    
    [self saveContext];
    
}

/// this method saves the managedobject context in to the database where attributes are passed to their respective entity
/// @return returns YES if it successfully saves the data else return NO if it fails to save and immediately rollback the data to the previous state
-(BOOL)saveContext
{
    NSError *error;
    if(![context save:&error])
    {
        [context rollback];
        return NO;
    }
    return YES;
}

/// this method parses the csv file in to dictionary for each row and in turn added to a mutable array
/// @param parserFileName this parameter requires the CSV file name passed to it
/// @return returns array of dictionary comprised of CSV data
-(NSMutableArray*)parseCSVData:(NSString*)parserFileName
{
    NSError *error = nil;
    NSURL *rtfUrl = [[NSBundle mainBundle] URLForResource:parserFileName withExtension:@".csv"];
    
    NSString * csv = [NSString stringWithContentsOfURL:rtfUrl encoding:NSASCIIStringEncoding error:&error];
    
    NSArray *allLines = [csv componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSArray *elements;
    NSMutableArray *arrays = [[NSMutableArray alloc]init];
    NSMutableArray *dictionaryArray = [[NSMutableArray alloc]init];
    for (NSString* line in allLines) {
        elements = [line componentsSeparatedByString:@","];
        [arrays addObject:elements];
    }
    NSArray *object1 = [arrays objectAtIndex:0];
    
    for (int j=2; j< [arrays count]-1 ; j=j+2) {
        NSArray *object2 = [arrays objectAtIndex:j];
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
        for(int i=0; i<[object1 count];i++)
        {
            [dictionary setObject:[object2 objectAtIndex:i] forKey:[object1 objectAtIndex:i]];
        }
        [dictionaryArray addObject:dictionary];
    }
    
    return dictionaryArray;
}

/// this method provides the maximum transaction id saved in the database
-(void)getMaximumId
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TransactionEntity" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
    
//    NSMutableArray *draftIdFromColumn = [[NSMutableArray alloc] init];
//    for (NSManagedObject *fetchedObject in fetchedObjects) {
//        [draftIdFromColumn addObject:[fetchedObject valueForKey:@"draftId"]];
//    }
//    
//    NSNumber * maxDraftId = [draftIdFromColumn valueForKeyPath:@"@max.intValue"];
//    self.draftId = [maxDraftId stringValue];
    
    NSMutableArray *transactionIdFromColumn = [[NSMutableArray alloc] init];
    for (NSManagedObject *fetchedObject in fetchedObjects) {
        [transactionIdFromColumn addObject:[fetchedObject valueForKey:@"transactionId"]];
    }
    
    //getting all transaction Id from database
    self.transactionIdArray = [[NSMutableArray alloc]init];
    
    NSArray * sortedArray = [transactionIdFromColumn sortedArrayUsingComparator:^(id tid1, id tid2){
        return [(NSString *)tid1 compare:(NSString *)tid2 options:NSNumericSearch];
    }];
    [self.transactionIdArray addObjectsFromArray:sortedArray];
    
    NSNumber * maxTransactionId = [transactionIdFromColumn valueForKeyPath:@"@max.intValue"];
    self.transactionId = [maxTransactionId stringValue];
    
}

/// setter method for draftId
-(void) setDraftId:(NSString*)draftId
{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setObject:draftId forKey:@"draftId"];
    [userdefault synchronize];
    
}

/// getter method for draftId
-(NSString*)draftId
{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *draftId = [userdefault objectForKey:@"draftId"];
    return draftId;
}

/// setter method for companyId
-(void) setCompanyId:(NSString*)companyId
{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setObject:companyId forKey:@"companyId"];
    [userdefault synchronize];
    
}

/// getter method for companyId
-(NSString*)companyId
{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *companyId = [userdefault objectForKey:@"companyId"];
    return companyId;
}

/// setter method for transactionId
-(void) setTransactionId:(NSString*)transactionId
{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setObject:transactionId forKey:@"transactionId"];
    [userdefault synchronize];
}

/// getter method for transactionId
-(NSString*)transactionId
{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *transactionId = [userdefault objectForKey:@"transactionId"];
    return transactionId;
}

/// setter method for deletedTransactionId
-(void) setDeletedTransactionId:(NSString*)deletedTransactionId
{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setObject:deletedTransactionId forKey:@"deletedTransactionId"];
    [userdefault synchronize];
}

/// getter method for deletedTransactionId
-(NSString*)deletedTransactionId
{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *deletedTransactionId = [userdefault objectForKey:@"deletedTransactionId"];
    return deletedTransactionId;
}

/// setter method for userId extracted while login
-(void) setUserIdFromLogin:(NSString *)userIdFromLogin
{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setObject:userIdFromLogin forKey:@"userIdFromLogin"];
    [userdefault synchronize];
}

/// getter method for userId extracted while login
-(NSString*)userIdFromLogin
{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *userIdFromLogin = [userdefault objectForKey:@"userIdFromLogin"];
    return userIdFromLogin;
}

/// this method provides the new incremented transaction id to a new draft
/// @param transactionId if the transaction id is new then new transaction id will be provided. if it's an already existed transaction id then the related transaction is deleted from database and the transaction is saved again as it may have some value changed
/// @return returns void
-(void)checkTransactionIdForNewAndExistingTransaction:(NSString*)transactionId
{
    if([transactionId isEqualToString:@"New"])
    {
        [self getMaximumId];
        if([self.transactionId length]==0)
        {
            self.transactionId = @"New";
        }
        else
        {
            if([self.deletedTransactionId length] != 0)
            {
                int transactionIdConversion = [transactionId intValue];
                int deletedIdConversion = [self.deletedTransactionId intValue];
                if(transactionIdConversion <= deletedIdConversion)
                {
                    self.transactionId = self.deletedTransactionId ;
                    self.deletedTransactionId = [NSString stringWithFormat:@"%d",[self.transactionId intValue]+1];
                }
                else
                {
                    self.transactionId = self.deletedTransactionId;
                }
            }
            else
            {
                self.transactionId = [NSString stringWithFormat:@"%d",[self.transactionId intValue]+1];
            }

        }
    }
    else
    {
        self.transactionId = transactionId;
        [self deleteTransaction:self.transactionId];
    }

}

/// this method converts the savedOnDate  present in transaction as string to date format
/// @param savedOnDate this parameter contains the savedOnDate present in the transaction
/// @return returns date
-(NSDate*)dateFromSavedDateString:(NSString*)savedOnDate
{
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"MM/dd/yy HH:mm:ss"];
    NSDate *myDate = [dateformat dateFromString:savedOnDate];
    return myDate;
}

/// this method converts the savedOnDate  present in database as date to string format
/// @param savedOnDate this parameter contains the savedOnDate present in the database
/// @return returns date string
-(NSString*)stringFromSavedDate:(NSDate*)savedOnDate
{
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MM/dd/yy HH:mm:ss"];
    NSString *result = [df stringFromDate:savedOnDate];
    return result;
}

/// this method set the boolean isCheckForDelete to YES/NO based on the delete button press and helps to increment the transaction id for new transactions
/// @param checkForDelete this parameter contains either YES or NO based on the delete button pressed
/// @return returns void
-(void)checkForDeletePressed:(NSString*)checkForDelete
{
    if([checkForDelete isEqualToString:@"YES"])
    {
        isCheckForDelete = YES;
    }
    else
    {
        isCheckForDelete = NO;
    }
}

/// this method rearranges the contact data so that the contact whose role is Requestor is always saved as first object in the array
/// @param transactionContactData this parameter contains entire contact data for a particular transaction
/// @return returns rearranged contact data in utable array format
-(NSMutableArray*)rearrangeContactData:(NSMutableArray*)transactionContactData
{
    NSMutableArray *originalContactArray = [[NSMutableArray alloc]init];
    int index = -1;
    for( TransactionContactData *tcData in transactionContactData)
    {
        index = index + 1;
        if ([tcData.role isEqualToString:@"Requestor"])
        {
            [originalContactArray addObject:tcData];
            break;
        }
    }
    [transactionContactData removeObjectAtIndex:index];
    [originalContactArray addObjectsFromArray:transactionContactData];
    
    return originalContactArray;
}


@end
