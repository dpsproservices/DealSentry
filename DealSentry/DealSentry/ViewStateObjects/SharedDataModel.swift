//
// SharedDataModel.swift
//

import Foundation

 class SharedDataModel{
    
    class var sharedInstance: SharedDataModel {
        
        struct StaticObject {
            static var instance: SharedDataModel?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&StaticObject.token) {
            StaticObject.instance = SharedDataModel()
        }
        
        
        return StaticObject.instance!
    }
    
    let coreDataManager: AnyObject! = DataManager.getInstance()
    
    var isLoggedIn = false
    var loggedInUserName = "Eric Wattson"
    var loggedInUserId = "ew57483"
    var userSavedTemplate = true
    
    // sample transaction preloaded during app first launch
    var transactionSaveArray = [
        
        TransactionData(
            transactionId: "12349",
            transactionStatus: "Draft",
            dealStatus: "Pitch",
            ddtRestriction: "No",
            savedOnDate: "1/5/15 00:00:00",
            submitDate: "1/8/15 00:00:00",
            requestorName: "Eric Wattson",
            primaryClient: "Energy Innovations LLC",
            counterparty: "",
            product: "Bank Loan",
            productSub: "Acquisitions Finance",
            fulfillmentCondition: "N/A",
            clearanceApprovedDate: "",
            
            transactionCompanies: [
                TransactionCompanyData(
                    
                    company: CompanyData (
                        companyId: "2",
                        companyName: "Energy Innovations LLC",
                        ticker: "NRGY",
                        country: "US",
                        gfcid: "1000123457",
                        level: "L1",
                        exchange: "CBOT",
                        marketSegment: "LATAM Latam",
                        franchiseIndustry: "FIN ENTREP",
                        parentCompany: "",
                        countryFlag: "usa.png"
                        
                    ),
                    
                    role: "Primary Client",
                    
                    materiality: MaterialityData(
                        isMaterial: "No",
                        isMaterialDescription: "",
                        hasPubliclyTradedSecurities: "No",
                        isGovtOwned: "No",
                        percentOwned: "0",
                        hasPRC: "No",
                        hasStandardAgreements: "Yes",
                        specialCircumstances: ""
                    ),
                    
                    agreements: []
                )
            ],
            
            transactionDetail: TransactionDetailData (
                projectName: "Energy Innovations Loan",
                dealStatusDB: "",
                dealStatus: "Pitch",
                product: "Bank Loan",
                productSub: "Bank Loan",
                dealDescription: "Loan to primary client",
                bankRole: "Lender",
                dealSize: "10.00",
                offeringFormat: "N/A",
                offeringFormatComments: "",
                useOfProceeds: "N/A",
                useOfProceedsComments: "",
                loanType: "N/A",
                isConfidential: "Confidential",
                estimatedPitchDate: "02/04/2015",
                expectedAnnouncementDate: "06/04/2015",
                expectedClosingDate: "07/04/2015",
                isSubjectToTakeOver: "No",
                hasFinancialSponsor: "No",
                hasNonProfitOrganization: "No",
                hasUSGovtAffiliatedMunicipality: "No",
                likelyToTakePlace: "Yes",
                backwardsDealStatusExplanation: "",
                terminatedExplanation: "",
                uncollectedFees: "",
                requests: "No"
            ),
            
            transactionContacts: [
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Eric",
                        lastName: "Wattson",
                        gocDescription: "Sales Department",
                        soeID: "ew57483",
                        phone: "716-995-2319",
                        email: "mike.henderson@bank.com",
                        crossSellDesignee: false
                    ),
                    role: "Requestor"
                ),
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "John",
                        lastName: "Barkley",
                        gocDescription: "Sales Department",
                        soeID: "jb02201",
                        phone: "777-712-2779",
                        email: "john.barkley@bank.com",
                        crossSellDesignee: false
                    ),
                    role: "Other"
                )
            ]
        ),
        
        TransactionData(
            transactionId: "12348",
            transactionStatus: "Pending Review",
            dealStatus: "Pitch",
            ddtRestriction: "No",
            savedOnDate: "07/12/14 00:00:00",
            submitDate: "08/12/14 00:00:00",
            requestorName: "Mike Henderson",
            primaryClient: "Sears Roebuck Inc",
            counterparty: "Sylvania Corporation",
            product: "M&A",
            productSub: "Joint Venture",
            fulfillmentCondition: "Yes",
            clearanceApprovedDate: "",
            
            transactionCompanies: [
                
                TransactionCompanyData(
                    
                    company: CompanyData (
                        companyId: "3",
                        companyName: "Sears Roebuck Inc",
                        ticker: "SERS",
                        country: "US",
                        gfcid: "1000123458",
                        level: "L1",
                        exchange: "NASD",
                        marketSegment: "ANDEAN",
                        franchiseIndustry: "ON& HCARE",
                        parentCompany: "",
                        countryFlag: "usa.png"
                    ),
                    
                    role: "Primary Client",
                    
                    materiality: MaterialityData(
                        isMaterial: "No",
                        isMaterialDescription: "",
                        hasPubliclyTradedSecurities: "No",
                        isGovtOwned: "Yes",
                        percentOwned: "0",
                        hasPRC: "No",
                        hasStandardAgreements: "No",
                        specialCircumstances: ""
                    ),
                    
                    agreements: [
                        AgreementData(
                            agreementType: "Other",
                            effectiveDate: "02/14/2015",
                            expirationDate: "12/31/2015",
                            agreementTerms: "Refer to documentation.",
                            legalReviewBy: "Legal Dept.",
                            exclusivityApprovedBy: ""
                        )
                    ]
                ),
                
                TransactionCompanyData(
                    
                    company: CompanyData (
                        companyId: "18",
                        companyName: "Sylvania",
                        ticker: "",
                        country: "US",
                        gfcid: "143525498",
                        level: "L1",
                        exchange: "",
                        marketSegment: "N AMERICA",
                        franchiseIndustry: "TECHMEDCOM",
                        parentCompany: "",
                        countryFlag: "usa.png"
                    ),
                    
                    role: "Counterparty",
                    
                    materiality:  MaterialityData(
                        isMaterial: "No",
                        isMaterialDescription: "",
                        hasPubliclyTradedSecurities: "No",
                        isGovtOwned: "No",
                        percentOwned: "",
                        hasPRC: "No",
                        hasStandardAgreements: "Yes",
                        specialCircumstances: ""
                    ),
                    
                    agreements: []
                )
            ],
            
            transactionDetail: TransactionDetailData (
                projectName: "SEARS / Sylvania merger deal",
                dealStatusDB: "Pitch",
                dealStatus: "Pitch",
                product: "M&A",
                productSub: "M&A Other",
                dealDescription: "SEARS / Sylvania merger",
                bankRole: "Advisory",
                dealSize: "124.73",
                offeringFormat: "N/A",
                offeringFormatComments: "",
                useOfProceeds: "M&A",
                useOfProceedsComments: "",
                loanType: "N/A",
                isConfidential: "Confidential",
                estimatedPitchDate: "02/04/2015",
                expectedAnnouncementDate: "06/04/2015",
                expectedClosingDate: "07/04/2015",
                isSubjectToTakeOver: "No",
                hasFinancialSponsor: "No",
                hasNonProfitOrganization: "No",
                hasUSGovtAffiliatedMunicipality: "No",
                likelyToTakePlace: "Yes",
                backwardsDealStatusExplanation: "",
                terminatedExplanation: "",
                uncollectedFees: "",
                requests: "No"
            ),
            
            businessSelection: BusinessSelectionData(
                isDifferentCurrencies: "No",
                isUKCompanyInvolved: "No",
                isFriendlyOrHostile: "Friendly",
                isDownwardRatingsLikely: "No",
                isGovernmentAgency: "No",
                isConsolidatedBankingOpportunity: "Yes",
                consolidatedBankingOpportunityDescription: "Potential opportunity for new accounts.",
                isInvestmentOpportunity: "Yes",
                investmentOpportunityDescription: "Lending",
                isServicesOpportunity: "Yes",
                servicesOpportunityDescription: "Potential opportunity for additional services.",
                toIncludeCash: "No",
                toIncludeStock: "No",
                toIncludeOther: "Yes",
                pleaseExplain: "Opening new accounts.",
                businessSelectionTypeForEither: "Buy",
                hasDerivativesExposure: "No",
                hasCommoditiesExposure: "No",
                hasWealthManagementOpportunity: "Yes",
                wealthManagementOpportunity: "Investment management."
            ),
            
            transactionContacts: [
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Mike",
                        lastName: "Henderson",
                        gocDescription: "Sales Department",
                        soeID: "mh90210",
                        phone: "716-995-2319",
                        email: "Mike.Henderson@bank.com",
                        crossSellDesignee: false
                    ),
                    role: "Requestor"
                ),
                
                TransactionContactData(
                    
                    contact: ContactData (
                        firstName: "Thomas",
                        lastName: "Daniels",
                        gocDescription: "Sales Department",
                        soeID: "td15930",
                        phone: "616-367-6321",
                        email: "Thomas.Daniels@bank.com",
                        crossSellDesignee: true
                    ),
                    
                    role: "Other"
                ),
                
                TransactionContactData(
                    
                    contact: ContactData (
                        firstName: "Kreg",
                        lastName: "Rutherford",
                        gocDescription: "Sales Department",
                        soeID: "kr11765",
                        phone: "616-367-3999",
                        email: "kreg.rutherford@bank.com",
                        crossSellDesignee: false
                    ),
                    
                    role: "Sponsoring MD"
                ),
                
                TransactionContactData(
                    
                    contact: ContactData (
                        firstName: "Alice",
                        lastName: "Mathews",
                        gocDescription: "Sales Department",
                        soeID: "am34567",
                        phone: "616-367-4576",
                        email: "alice.mathews@bank.com",
                        crossSellDesignee: false
                    ),
                    
                    role: "Other"
                )
            ]
        ),
        
        TransactionData(
            transactionId: "12347",
            transactionStatus: "Pending Review",
            dealStatus: "Active Discussions",
            ddtRestriction: "Yes",
            savedOnDate: "08/20/14 00:00:00",
            submitDate: "09/20/14 00:00:00",
            requestorName: "Mike Henderson",
            primaryClient: "Betamax",
            counterparty: "",
            product: "Securitization",
            productSub: "Real Estate",
            fulfillmentCondition: "No",
            clearanceApprovedDate: "",
            
            transactionCompanies: [
                TransactionCompanyData(
                    
                    company: CompanyData (
                        companyId: "4",
                        companyName: "Betamax",
                        ticker: "",
                        country: "US",
                        gfcid: "1000123459",
                        level: "L1",
                        exchange: "OTC",
                        marketSegment: "POLAND",
                        franchiseIndustry: "POWENGCHEM",
                        parentCompany: "",
                        countryFlag: "usa.png"
                    ),
                    
                    role: "Primary Client",
                    
                    materiality: MaterialityData(
                        isMaterial: "No",
                        isMaterialDescription: "",
                        hasPubliclyTradedSecurities: "No",
                        isGovtOwned: "No",
                        percentOwned: "",
                        hasPRC: "No",
                        hasStandardAgreements: "Yes",
                        specialCircumstances: ""
                    ),
                    
                    agreements: []
                )
                
            ],
            
            transactionDetail: TransactionDetailData (
                projectName: "Betamax Deal",
                dealStatusDB: "Active Discussions",
                dealStatus: "Active Discussions",
                product: "Securitization",
                productSub: "Real Estate",
                dealDescription: "real estate assets",
                bankRole: "Advisory",
                dealSize: "10.00",
                offeringFormat: "N/A",
                offeringFormatComments: "",
                useOfProceeds: "N/A",
                useOfProceedsComments: "",
                loanType: "N/A",
                isConfidential: "Confidential",
                estimatedPitchDate: "02/04/2015",
                expectedAnnouncementDate: "06/04/2015",
                expectedClosingDate: "07/04/2015",
                isSubjectToTakeOver: "No",
                hasFinancialSponsor: "No",
                hasNonProfitOrganization: "No",
                hasUSGovtAffiliatedMunicipality: "No",
                
                likelyToTakePlace: "Yes",
                backwardsDealStatusExplanation: "",
                terminatedExplanation: "",
                uncollectedFees: "No",
                requests: "No"
            ),
            
            transactionContacts: [
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Mike",
                        lastName: "Henderson",
                        gocDescription: "Sales Department",
                        soeID: "mh90210",
                        phone: "716-995-2319",
                        email: "Mike.Henderson@bank.com",
                        crossSellDesignee: false
                    ),
                    role: "Requestor"
                ),
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Alice",
                        lastName: "Mathews",
                        gocDescription: "Sales Department",
                        soeID: "am34567",
                        phone: "616-367-4576",
                        email: "alice.mathews@bank.com",
                        crossSellDesignee: false
                    ),
                    role: "Sponsoring MD"
                )
            ]
        ),
        
        TransactionData(
            transactionId: "12346",
            transactionStatus: "Cleared",
            dealStatus: "Announced",
            ddtRestriction: "No",
            savedOnDate: "10/02/14 00:00:00",
            submitDate: "11/02/14 00:00:00",
            requestorName: "Mike Henderson",
            primaryClient: "Delta Kraft",
            counterparty: "Mega Imports LTD",
            product: "Derivatives",
            productSub: "Hedging",
            fulfillmentCondition: "N/A",
            clearanceApprovedDate: "11/19/2014",
            
            transactionCompanies: [
                
                TransactionCompanyData(
                    
                    company: CompanyData (
                        companyId: "5",
                        companyName: "Delta Kraft",
                        ticker: "DK",
                        country: "US",
                        gfcid: "1000123460",
                        level: "L1",
                        exchange: "NASD",
                        marketSegment: "MEXICO",
                        franchiseIndustry: "GOVT& AGEN",
                        parentCompany: "",
                        countryFlag: "usa.png"
                    ),
                    
                    role: "Primary Client",
                    
                    materiality: MaterialityData(
                        isMaterial: "No",
                        isMaterialDescription: "",
                        hasPubliclyTradedSecurities: "No",
                        isGovtOwned: "No",
                        percentOwned: "",
                        hasPRC: "No",
                        hasStandardAgreements: "Yes",
                        specialCircumstances: ""
                    ),
                    
                    agreements: []
                    
                ),
                
                TransactionCompanyData(
                    
                    company: CompanyData (
                        companyId: "16",
                        companyName: "Mega Imports LTD",
                        ticker: "DK",
                        country: "US",
                        gfcid: "1000773467",
                        level: "L1",
                        exchange: "NASD",
                        marketSegment: "MEXICO",
                        franchiseIndustry: "GOVT& AGEN",
                        parentCompany: "",
                        countryFlag: "usa.png"
                    ),
                    
                    role: "Client",
                    
                    materiality: MaterialityData(
                        isMaterial: "No",
                        isMaterialDescription: "",
                        hasPubliclyTradedSecurities: "No",
                        isGovtOwned: "No",
                        percentOwned: "",
                        hasPRC: "No",
                        hasStandardAgreements: "Yes",
                        specialCircumstances: ""
                    ),
                    
                    agreements: []
                    
                )
            ],
            
            transactionDetail: TransactionDetailData (
                projectName: "Mega Imports",
                dealStatusDB: "Announced",
                dealStatus: "Announced",
                product: "Bank Loan",
                productSub: "Bank Loan",
                dealDescription: "Mega Imports Financing",
                bankRole: "Lender",
                dealSize: "250.00",
                offeringFormat: "N/A",
                offeringFormatComments: "",
                useOfProceeds: "N/A",
                useOfProceedsComments: "",
                loanType: "New Structure",
                isConfidential: "Confidential",
                estimatedPitchDate: "02/04/2015",
                expectedAnnouncementDate: "06/04/2015",
                expectedClosingDate: "07/04/2015",
                isSubjectToTakeOver: "No",
                hasFinancialSponsor: "No",
                hasNonProfitOrganization: "No",
                hasUSGovtAffiliatedMunicipality: "No",
                likelyToTakePlace: "Yes",
                backwardsDealStatusExplanation: "",
                terminatedExplanation: "",
                uncollectedFees: "",
                requests: "No"
            ),
            
            transactionContacts: [
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Mike",
                        lastName: "Henderson",
                        gocDescription: "Sales Department",
                        soeID: "mh90210",
                        phone: "716-995-2319",
                        email: "Mike.Henderson@bank.com",
                        crossSellDesignee: false
                    ),
                    role: "Requestor"
                ),
                
                TransactionContactData(
                    
                    contact: ContactData (
                        firstName: "Alice",
                        lastName: "Mathews",
                        gocDescription: "Sales Department",
                        soeID: "am34567",
                        phone: "616-367-4576",
                        email: "alice.mathews@bank.com",
                        crossSellDesignee: false
                    ),
                    
                    role: "Other"
                ),
                
                TransactionContactData(
                    
                    contact: ContactData (
                        firstName: "Ronald",
                        lastName: "Mackintosh",
                        gocDescription: "Sales Department",
                        soeID: "rm84444",
                        phone: "616-663-2947",
                        email: "ronald.mackintosh@bank.com",
                        crossSellDesignee: false
                    ),
                    
                    role: "Sponsoring MD"
                ),
                
                TransactionContactData(
                    
                    contact: ContactData (
                        firstName: "Edward",
                        lastName: "Kepler",
                        gocDescription: "Sales Department",
                        soeID: "ek78945",
                        phone: "616-667-8923",
                        email: "edward.kepler@bank.com",
                        crossSellDesignee: false
                    ),
                    
                    role: "Other"
                )
            ]        ),
        
        TransactionData(
            transactionId: "12345",
            transactionStatus: "Completed",
            dealStatus: "Completed",
            ddtRestriction: "No",
            savedOnDate: "3/10/10 00:00:00",
            submitDate: "03/23/10 00:00:00",
            requestorName: "Mike Henderson",
            primaryClient: "TIME WARNER CABLE INC",
            counterparty: "TWENTY-FIRST CENTURY FOX INC",
            product: "M&A",
            productSub: "Sell Side Other",
            fulfillmentCondition: "N/A",
            clearanceApprovedDate: "4/23/2010",
            
            transactionCompanies: [
                
                TransactionCompanyData(
                    
                    company: CompanyData (
                        companyId: "6",
                        companyName: "TIME WARNER CABLE INC",
                        ticker: "TWX.N",
                        country: "US",
                        gfcid: "1003008882",
                        level: "L2",
                        exchange: "NYSE",
                        marketSegment: "N AMERICA",
                        franchiseIndustry: "TECHMEDCOM",
                        parentCompany: "",
                        countryFlag: "usa.png"
                        
                    ),
                    
                    role: "Primary Client",
                    
                    materiality: MaterialityData(
                        isMaterial: "No",
                        isMaterialDescription: "",
                        hasPubliclyTradedSecurities: "No",
                        isGovtOwned: "No",
                        percentOwned: "",
                        hasPRC: "No",
                        hasStandardAgreements: "Yes",
                        specialCircumstances: ""
                    ),
                    
                    agreements: []
                ),
                
                TransactionCompanyData(
                    
                    company: CompanyData (
                        companyId: "7",
                        companyName: "TWENTY-FIRST CENTURY FOX INC",
                        ticker: "FOXA.OQ",
                        country: "US",
                        gfcid: "1000740957",
                        level: "L2",
                        exchange: "NYSE",
                        marketSegment: "N AMERICA",
                        franchiseIndustry: "TECHMEDCOM",
                        parentCompany: "",
                        countryFlag: "usa.png"
                    ),
                    
                    role: "Client",
                    
                    materiality: MaterialityData(
                        isMaterial: "No",
                        isMaterialDescription: "",
                        hasPubliclyTradedSecurities: "No",
                        isGovtOwned: "No",
                        percentOwned: "",
                        hasPRC: "No",
                        hasStandardAgreements: "Yes",
                        specialCircumstances: ""
                    ),
                    
                    agreements: []
                )
            ],
            transactionDetail: TransactionDetailData (
                projectName: "TIME/FOX",
                dealStatusDB: "Completed",
                dealStatus: "Completed",
                product: "M&A",
                productSub: "Sell Side Other",
                dealDescription: "TIME/FOX DEAL",
                bankRole: "Advisory",
                dealSize: "1,547.52",
                offeringFormat: "N/A",
                offeringFormatComments: "",
                useOfProceeds: "M&A",
                useOfProceedsComments: "",
                loanType: "N/A",
                isConfidential: "Public",
                estimatedPitchDate: "02/04/2015",
                expectedAnnouncementDate: "06/04/2015",
                expectedClosingDate: "07/04/2015",
                isSubjectToTakeOver: "No",
                hasFinancialSponsor: "No",
                hasNonProfitOrganization: "No",
                hasUSGovtAffiliatedMunicipality: "No",
                likelyToTakePlace: "Yes",
                backwardsDealStatusExplanation: "",
                terminatedExplanation: "",
                uncollectedFees: "",
                requests: "No"
                
            ),
            
            businessSelection: BusinessSelectionData(
                isDifferentCurrencies: "No",
                isUKCompanyInvolved: "No",
                isFriendlyOrHostile: "Friendly",
                isDownwardRatingsLikely: "No",
                isGovernmentAgency: "No",
                isConsolidatedBankingOpportunity: "Yes",
                consolidatedBankingOpportunityDescription: "Potential opportunity for new accounts.",
                isInvestmentOpportunity: "Yes",
                investmentOpportunityDescription: "Lending",
                isServicesOpportunity: "Yes",
                servicesOpportunityDescription: "Potential opportunity for additional services.",
                toIncludeCash: "No",
                toIncludeStock: "No",
                toIncludeOther: "Yes",
                pleaseExplain: "Opening new accounts.",
                businessSelectionTypeForEither: "Buy",
                hasDerivativesExposure: "No",
                hasCommoditiesExposure: "No",
                hasWealthManagementOpportunity: "Yes",
                wealthManagementOpportunity: "Investment management."
            ),
            
            transactionContacts: [
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Mike",
                        lastName: "Henderson",
                        gocDescription: "Sales Department",
                        soeID: "mh90210",
                        phone: "716-995-2319",
                        email: "Mike.Henderson@bank.com",
                        crossSellDesignee: true
                    ),
                    role: "Requestor"
                ),
                
                TransactionContactData(
                    
                    contact: ContactData (
                        firstName: "Grace",
                        lastName: "Landor",
                        gocDescription: "Sales Department",
                        soeID: "gl92201",
                        phone: "(201) 763-1772",
                        email: "gl92201@bank.com",
                        crossSellDesignee: false
                    ),
                    
                    role: "Sponsoring MD"
                )
            ]
        ),
        
        TransactionData(
            transactionId: "12344",
            transactionStatus: "Completed",
            dealStatus: "Completed",
            ddtRestriction: "No",
            savedOnDate: "5/10/11 00:00:00",
            submitDate: "05/11/11 00:00:00",
            requestorName: "Mike Henderson",
            primaryClient: "OMNICOMM SYSTEMS INCORPORATED",
            counterparty: "PUBLICIS GROUPE SA",
            product: "M&A",
            productSub: "Restructuring",
            fulfillmentCondition: "N/A",
            clearanceApprovedDate: "11/23/2012",
            
            transactionCompanies: [
                
                TransactionCompanyData(
                    
                    company: CompanyData (
                        companyId: "9",
                        companyName: "OMNICOMM SYSTEMS INCORPORATED",
                        ticker: "OMC.N",
                        country: "US",
                        gfcid: "1000288329",
                        level: "L2",
                        exchange: "",
                        marketSegment: "N AMERICA",
                        franchiseIndustry: "TECHMEDCOM",
                        parentCompany: "",
                        countryFlag: "usa.png"
                    ),
                    
                    role: "Primary Client",
                    
                    materiality: MaterialityData(
                        isMaterial: "No",
                        isMaterialDescription: "",
                        hasPubliclyTradedSecurities: "No",
                        isGovtOwned: "No",
                        percentOwned: "",
                        hasPRC: "No",
                        hasStandardAgreements: "Yes",
                        specialCircumstances: ""
                    ),
                    
                    agreements: []
                ),
                
                TransactionCompanyData(
                    
                    company: CompanyData (
                        companyId: "10",
                        companyName: "PUBLICIS GROUPE SA",
                        ticker: "",
                        country: "US",
                        gfcid: "1001124788",
                        level: "L2",
                        exchange: "",
                        marketSegment: "N AMERICA",
                        franchiseIndustry: "TECHMEDCOM",
                        parentCompany: "",
                        countryFlag: "usa.png"
                    ),
                    
                    role: "Client",
                    
                    materiality: MaterialityData(
                        isMaterial: "No",
                        isMaterialDescription: "",
                        hasPubliclyTradedSecurities: "No",
                        isGovtOwned: "No",
                        percentOwned: "",
                        hasPRC: "No",
                        hasStandardAgreements: "Yes",
                        specialCircumstances: ""
                    ),
                    
                    agreements: []
                )
            ],
            
            transactionDetail: TransactionDetailData (
                projectName: "Omnicom/Publicis Groupe",
                dealStatusDB: "Completed",
                dealStatus: "Completed",
                product: "M&A",
                productSub: "Restructuring",
                dealDescription: "Restructuring deal",
                bankRole: "Advisory",
                dealSize: "8,345.78",
                offeringFormat: "N/A",
                offeringFormatComments: "",
                useOfProceeds: "M&A",
                useOfProceedsComments: "",
                loanType: "N/A",
                isConfidential: "Confidential",
                estimatedPitchDate: "02/04/2015",
                expectedAnnouncementDate: "06/04/2015",
                expectedClosingDate: "07/04/2015",
                isSubjectToTakeOver: "No",
                hasFinancialSponsor: "No",
                hasNonProfitOrganization: "No",
                hasUSGovtAffiliatedMunicipality: "No",
                likelyToTakePlace: "Yes",
                backwardsDealStatusExplanation: "",
                terminatedExplanation: "",
                uncollectedFees: "",
                requests: "No"
            ),
            
            businessSelection: BusinessSelectionData(
                isDifferentCurrencies: "No",
                isUKCompanyInvolved: "No",
                isFriendlyOrHostile: "Friendly",
                isDownwardRatingsLikely: "No",
                isGovernmentAgency: "No",
                isConsolidatedBankingOpportunity: "Yes",
                consolidatedBankingOpportunityDescription: "Potential opportunity for new accounts.",
                isInvestmentOpportunity: "Yes",
                investmentOpportunityDescription: "Lending",
                isServicesOpportunity: "Yes",
                servicesOpportunityDescription: "Potential opportunity for additional services.",
                toIncludeCash: "No",
                toIncludeStock: "No",
                toIncludeOther: "Yes",
                pleaseExplain: "Opening new accounts.",
                businessSelectionTypeForEither: "Buy",
                hasDerivativesExposure: "No",
                hasCommoditiesExposure: "No",
                hasWealthManagementOpportunity: "Yes",
                wealthManagementOpportunity: "Investment management."
            ),
            
            transactionContacts: [
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Mike",
                        lastName: "Henderson",
                        gocDescription: "Sales Department",
                        soeID: "mh90210",
                        phone: "716-995-2319",
                        email: "Mike.Henderson@bank.com",
                        crossSellDesignee: true
                    ),
                    role: "Requestor"
                ),
                
                TransactionContactData(
                    
                    contact: ContactData (
                        firstName: "Grace",
                        lastName: "Landor",
                        gocDescription: "Sales Department",
                        soeID: "gl92201",
                        phone: "(201) 763-1772",
                        email: "gl92201@bank.com",
                        crossSellDesignee: false
                    ),
                    
                    role: "Sponsoring MD"
                )
            ]
        ),
        
        TransactionData(
            transactionId: "12343",
            transactionStatus: "Completed",
            dealStatus: "Completed",
            ddtRestriction: "No",
            savedOnDate: "09/10/13 00:00:00",
            submitDate: "09/11/13 00:00:00",
            requestorName: "Mike Henderson",
            primaryClient: "ACME Corp",
            counterparty: "",
            product: "Equity",
            productSub: "Common Stk - IPO",
            fulfillmentCondition: "N/A",
            clearanceApprovedDate: "11/23/2014",
            
            transactionCompanies: [
                
                TransactionCompanyData(
                    
                    company: CompanyData (
                        companyId: "6",
                        companyName: "ACME Corp",
                        ticker: "ACME",
                        country: "US",
                        gfcid: "1000123461",
                        level: "L1",
                        exchange: "NYSE",
                        marketSegment: "N AMERICA",
                        franchiseIndustry: "INDUSTRIAL",
                        parentCompany: "",
                        countryFlag: "usa.png"
                        
                    ),
                    
                    role: "Primary Client",
                    
                    materiality: MaterialityData(
                        isMaterial: "No",
                        isMaterialDescription: "",
                        hasPubliclyTradedSecurities: "No",
                        isGovtOwned: "No",
                        percentOwned: "",
                        hasPRC: "No",
                        hasStandardAgreements: "Yes",
                        specialCircumstances: ""
                    ),
                    
                    agreements: []
                )
            ],
            
            transactionDetail: TransactionDetailData (
                projectName: "ACME Corp financing",
                dealStatusDB: "Completed",
                dealStatus: "Completed",
                product: "Bank Loan",
                productSub: "Bank Loan",
                dealDescription: "ACME Corp financing",
                bankRole: "Lender",
                dealSize: "336.25",
                offeringFormat: "N/A",
                offeringFormatComments: "",
                useOfProceeds: "N/A",
                useOfProceedsComments: "",
                loanType: "New Structure",
                isConfidential: "Confidential",
                estimatedPitchDate: "02/04/2015",
                expectedAnnouncementDate: "06/04/2015",
                expectedClosingDate: "07/04/2015",
                isSubjectToTakeOver: "No",
                hasFinancialSponsor: "No",
                hasNonProfitOrganization: "No",
                hasUSGovtAffiliatedMunicipality: "No",
                likelyToTakePlace: "Yes",
                backwardsDealStatusExplanation: "",
                terminatedExplanation: "",
                uncollectedFees: "",
                requests: "No"
            ),
            
            transactionContacts: [
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Mike",
                        lastName: "Henderson",
                        gocDescription: "Sales Department",
                        soeID: "mh90210",
                        phone: "716-995-2319",
                        email: "Mike.Henderson@bank.com",
                        crossSellDesignee: true
                    ),
                    role: "Requestor"
                ),
                
                TransactionContactData(
                    
                    contact: ContactData (
                        firstName: "Grace",
                        lastName: "Landor",
                        gocDescription: "Sales Department",
                        soeID: "gl92201",
                        phone: "(201) 763-1772",
                        email: "gl92201@bank.com",
                        crossSellDesignee: false
                    ),
                    
                    role: "Other"
                ),
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Joe",
                        lastName: "Skarulis",
                        gocDescription: "Sales Department",
                        soeID: "js33237",
                        phone: "212-657-1898",
                        email: "joe.skarulis@bank.com",
                        crossSellDesignee: false
                    ),
                    
                    role: "Other"
                ),
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Derek",
                        lastName: "Armstrong",
                        gocDescription: "BELFAST PROJECT",
                        soeID: "da42560",
                        phone: "(777) 777-7777",
                        email: "da42560@imceu.eu.ssmb.com",
                        crossSellDesignee: true
                    ),
                    
                    role: "Other"
                ),
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Adam",
                        lastName: "Taub",
                        gocDescription: "Sales Department",
                        soeID: "at42928",
                        phone: "(908) 563-5327",
                        email: "at42928@bank.com",
                        crossSellDesignee: false
                    ),
                    
                    role: "Sponsoring MD"
                )
            ]
        ),
        
        TransactionData(
            transactionId: "12342",
            transactionStatus: "Fatal Conflicts",
            dealStatus: "Dormant",
            ddtRestriction: "No",
            savedOnDate: "09/10/13 00:00:00",
            submitDate: "09/15/13 00:00:00",
            requestorName: "Mike Henderson",
            primaryClient: "ASTRAZENECA PLC",
            counterparty: "PFIZER INC",
            product: "M&A",
            productSub: "Advisory",
            fulfillmentCondition: "Yes",
            clearanceApprovedDate: "11/23/2014",
            
            transactionCompanies: [
                
                TransactionCompanyData(
                    
                    company: CompanyData (
                        companyId: "4",
                        companyName: "ASTRAZENECA PLC",
                        ticker: "AZN.L",
                        country: "UK",
                        gfcid: "1000610778",
                        level: "L3",
                        exchange: "NYSE",
                        marketSegment: "N. AMERICA",
                        franchiseIndustry: "CON& HCARE",
                        parentCompany: "",
                        countryFlag: "uk.png"
                        
                    ),
                    
                    role: "Primary Client",
                    
                    materiality: MaterialityData(
                        isMaterial: "No",
                        isMaterialDescription: "",
                        hasPubliclyTradedSecurities: "No",
                        isGovtOwned: "No",
                        percentOwned: "",
                        hasPRC: "No",
                        hasStandardAgreements: "Yes",
                        specialCircumstances: ""
                    ),
                    
                    agreements: []
                ),
                
                TransactionCompanyData(
                    
                    company: CompanyData (
                        companyId: "5",
                        companyName: "PFIZER INC",
                        ticker: "PFE.N",
                        country: "UK",
                        gfcid: "0000208817",
                        level: "L2",
                        exchange: "NYSE",
                        marketSegment: "N. AMERICA",
                        franchiseIndustry: "CON& HCARE",
                        parentCompany: "",
                        countryFlag: "uk.png"
                        
                    ),
                    
                    role: "Client",
                    
                    materiality: MaterialityData(
                        isMaterial: "No",
                        isMaterialDescription: "",
                        hasPubliclyTradedSecurities: "No",
                        isGovtOwned: "No",
                        percentOwned: "",
                        hasPRC: "No",
                        hasStandardAgreements: "Yes",
                        specialCircumstances: ""
                    ),
                    
                    agreements: []
                )
            ],
            
            transactionDetail: TransactionDetailData (
                projectName: "M&A Buy Side Deal",
                dealStatusDB: "Fatal Conflicts",
                dealStatus: "Dormant",
                product: "M&A",
                productSub: "Buy Side Other",
                dealDescription: "AstraZeneca/Pfizer",
                bankRole: "Advisory",
                dealSize: "8,546.17",
                offeringFormat: "N/A",
                offeringFormatComments: "",
                useOfProceeds: "M&A",
                useOfProceedsComments: "",
                loanType: "N/A",
                isConfidential: "Confidential",
                estimatedPitchDate: "02/04/2015",
                expectedAnnouncementDate: "06/04/2015",
                expectedClosingDate: "07/04/2015",
                isSubjectToTakeOver: "No",
                hasFinancialSponsor: "No",
                hasNonProfitOrganization: "No",
                hasUSGovtAffiliatedMunicipality: "No",
                likelyToTakePlace: "No",
                backwardsDealStatusExplanation: "",
                terminatedExplanation: "",
                uncollectedFees: "No",
                requests: "No"
            ),
            
            businessSelection: BusinessSelectionData(
                isDifferentCurrencies: "No",
                isUKCompanyInvolved: "No",
                isFriendlyOrHostile: "Friendly",
                isDownwardRatingsLikely: "No",
                isGovernmentAgency: "No",
                isConsolidatedBankingOpportunity: "Yes",
                consolidatedBankingOpportunityDescription: "Potential opportunity for new accounts.",
                isInvestmentOpportunity: "Yes",
                investmentOpportunityDescription: "Lending",
                isServicesOpportunity: "Yes",
                servicesOpportunityDescription: "Potential opportunity for additional services.",
                toIncludeCash: "No",
                toIncludeStock: "No",
                toIncludeOther: "Yes",
                pleaseExplain: "Opening new accounts.",
                businessSelectionTypeForEither: "Buy",
                hasDerivativesExposure: "No",
                hasCommoditiesExposure: "No",
                hasWealthManagementOpportunity: "Yes",
                wealthManagementOpportunity: "Investment management."
            ),
            
            transactionContacts: [
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Mike",
                        lastName: "Henderson",
                        gocDescription: "Sales Department",
                        soeID: "mh90210",
                        phone: "716-995-2319",
                        email: "Mike.Henderson@bank.com",
                        crossSellDesignee: true
                    ),
                    role: "Requestor"
                ),
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Konstantinos",
                        lastName: "Rizakos",
                        gocDescription: "Sales Department",
                        soeID: "kr17986",
                        phone: "212-657-1899",
                        email: "konstantinos.rizakos@bank.com",
                        crossSellDesignee: false
                    ),
                    role: "Sponsoring MD"
                ),
                
                TransactionContactData(
                    
                    contact: ContactData (
                        firstName: "Alice",
                        lastName: "Mathews",
                        gocDescription: "Sales Department",
                        soeID: "aa08467",
                        phone: "212-657-6776",
                        email: "alice.mathews@bank.com",
                        crossSellDesignee: true
                    ),
                    
                    role: "Other"
                )
            ]
        ),
        
        TransactionData(
            transactionId: "12341",
            transactionStatus: "Terminated",
            dealStatus: "Terminated",
            ddtRestriction: "No",
            savedOnDate: "9/10/13 00:00:00",
            submitDate: "09/25/13 00:00:00",
            requestorName: "Mike Henderson",
            primaryClient: "KRAFT INCORPORATED",
            counterparty: "HEINZ FOOD AS",
            product: "M&A",
            productSub: "M&A Other",
            fulfillmentCondition: "Yes",
            clearanceApprovedDate: "11/23/2014",
            
            transactionCompanies: [
                
                TransactionCompanyData(
                    
                    company: CompanyData (
                        companyId: "11",
                        companyName: "KRAFT INCORPORATED",
                        ticker: "KRFT.OQ",
                        country: "US",
                        gfcid: "1006701155",
                        level: "L2",
                        exchange: "NASD",
                        marketSegment: "N.AMERICA",
                        franchiseIndustry: "TECHMEDCOM",
                        parentCompany: "KRAFT GLOBAL",
                        countryFlag: "usa.png"
                        
                    ),
                    
                    role: "Primary Client",
                    
                    materiality: MaterialityData(
                        isMaterial: "No",
                        isMaterialDescription: "",
                        hasPubliclyTradedSecurities: "Yes",
                        isGovtOwned: "No",
                        percentOwned: "",
                        hasPRC: "No",
                        hasStandardAgreements: "Yes",
                        specialCircumstances: ""
                    ),
                    
                    agreements: []
                ),
                
                TransactionCompanyData(
                    
                    company: CompanyData (
                        companyId: "12",
                        companyName: "HEINZ FOOD AS",
                        ticker: "HNZ",
                        country: "US",
                        gfcid: "1005572955",
                        level: "L2",
                        exchange: "",
                        marketSegment: "N. AMERICA",
                        franchiseIndustry: "TECHMEDCOM",
                        parentCompany: "BERKSHIRE HATHAWAY",
                        countryFlag: "usa.png"
                        
                    ),
                    
                    role: "Counterparty",
                    
                    materiality: MaterialityData(
                        isMaterial: "No",
                        isMaterialDescription: "",
                        hasPubliclyTradedSecurities: "No",
                        isGovtOwned: "No",
                        percentOwned: "",
                        hasPRC: "No",
                        hasStandardAgreements: "Yes",
                        specialCircumstances: ""
                    ),
                    
                    agreements: []
                )
            ],
            
            transactionDetail: TransactionDetailData (
                projectName: "KRAFT HEINZ MERGER",
                dealStatusDB: "Terminated",
                dealStatus: "Terminated",
                product: "M&A",
                productSub: "M&A Other",
                dealDescription: "KRAFT HEINZ MERGER",
                bankRole: "Advisory",
                dealSize: "364.38",
                offeringFormat: "N/A",
                offeringFormatComments: "",
                useOfProceeds: "M&A",
                useOfProceedsComments: "",
                loanType: "N/A",
                isConfidential: "Public",
                estimatedPitchDate: "02/04/2015",
                expectedAnnouncementDate: "06/04/2015",
                expectedClosingDate: "07/04/2015",
                isSubjectToTakeOver: "No",
                hasFinancialSponsor: "No",
                hasNonProfitOrganization: "No",
                hasUSGovtAffiliatedMunicipality: "No",
                likelyToTakePlace: "No",
                backwardsDealStatusExplanation: "",
                terminatedExplanation: "Valuation analysis",
                uncollectedFees: "No",
                requests: "No"
            ),
            
            businessSelection: BusinessSelectionData(
                isDifferentCurrencies: "No",
                isUKCompanyInvolved: "No",
                isFriendlyOrHostile: "Friendly",
                isDownwardRatingsLikely: "No",
                isGovernmentAgency: "No",
                isConsolidatedBankingOpportunity: "Yes",
                consolidatedBankingOpportunityDescription: "Potential opportunity for new accounts.",
                isInvestmentOpportunity: "Yes",
                investmentOpportunityDescription: "Lending",
                isServicesOpportunity: "Yes",
                servicesOpportunityDescription: "Potential opportunity for additional services.",
                toIncludeCash: "No",
                toIncludeStock: "No",
                toIncludeOther: "Yes",
                pleaseExplain: "Opening new accounts.",
                businessSelectionTypeForEither: "Buy",
                hasDerivativesExposure: "No",
                hasCommoditiesExposure: "No",
                hasWealthManagementOpportunity: "Yes",
                wealthManagementOpportunity: "Investment management."
            ),
            
            transactionContacts: [
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Mike",
                        lastName: "Henderson",
                        gocDescription: "Sales Department",
                        soeID: "mh90210",
                        phone: "716-995-2319",
                        email: "Mike.Henderson@bank.com",
                        crossSellDesignee: false
                    ),
                    role: "Requestor"
                ),
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Konstantinos",
                        lastName: "Rizakos",
                        gocDescription: "Sales Department",
                        soeID: "kr17986",
                        phone: "212-657-1899",
                        email: "konstantinos.rizakos@bank.com",
                        crossSellDesignee: false
                    ),
                    role: "Sponsoring MD"
                ),
                
                TransactionContactData(
                    
                    contact: ContactData (
                        firstName: "Alice",
                        lastName: "Mathews",
                        gocDescription: "Sales Department",
                        soeID: "aa08467",
                        phone: "212-657-6776",
                        email: "alice.mathews@bank.com",
                        crossSellDesignee: true
                    ),
                    
                    role: "Other"
                )
            ]
            
        )
    ]
    
    
    
    var transactionsArray = [TransactionData]()
    
    // dummy template
    var templateTransaction = TransactionData(
        transactionId: "Template",
        transactionStatus: "Template",
        dealStatus: "Pitch",
        ddtRestriction: "No",
        savedOnDate: "07/07/2007",
        submitDate: "",
        requestorName: "Mike Henderson",
        primaryClient: "ACME Corp",
        counterparty: "",
        product: "Equity",
        productSub: "Common Stk - IPO",
        fulfillmentCondition: "N/A",
        clearanceApprovedDate: "",
        transactionCompanies: [
            
            TransactionCompanyData(
                
                company: CompanyData (
                    companyId: "6",
                    companyName: "ACME Corp",
                    ticker: "ACME",
                    country: "US",
                    gfcid: "1000123461",
                    level: "",
                    exchange: "NYSE",
                    marketSegment: "GREECE",
                    franchiseIndustry: "TECHMEDCOM",
                    parentCompany: "",
                    countryFlag: "usa.png"
                    
                ),
                
                role: "Primary Client",
                
                materiality: MaterialityData(
                    isMaterial: "No",
                    isMaterialDescription: "",
                    hasPubliclyTradedSecurities: "No",
                    isGovtOwned: "No",
                    percentOwned: "",
                    hasPRC: "No",
                    hasStandardAgreements: "Yes",
                    specialCircumstances: ""
                ),
                
                agreements: []
            )
        ],
        
        transactionDetail: TransactionDetailData (
            projectName: "Template Loan",
            dealStatusDB: "Pitch",
            dealStatus: "Pitch",
            product: "Bank Loan",
            productSub: "Bank Loan",
            dealDescription: "Loan to primary client",
            bankRole: "Lender",
            dealSize: "1.00",
            offeringFormat: "N/A",
            offeringFormatComments: "",
            useOfProceeds: "N/A",
            useOfProceedsComments: "",
            loanType: "N/A",
            isConfidential: "Confidential",
            estimatedPitchDate: "02/04/2015",
            expectedAnnouncementDate: "06/04/2015",
            expectedClosingDate: "07/04/2015",
            isSubjectToTakeOver: "No",
            hasFinancialSponsor: "No",
            hasNonProfitOrganization: "No",
            hasUSGovtAffiliatedMunicipality: "No",
            likelyToTakePlace: "Yes",
            backwardsDealStatusExplanation: "",
            terminatedExplanation: "",
            uncollectedFees: "",
            requests: "No"
        ),
        
        transactionContacts: [
            
            TransactionContactData(
                contact: ContactData (
                    firstName: "Mike",
                    lastName: "Henderson",
                    gocDescription: "Sales Department",
                    soeID: "mh90210",
                    phone: "716-995-2319",
                    email: "Mike.Henderson@bank.com",
                    crossSellDesignee: false
                ),
                role: "Requestor"
            ),
            
            TransactionContactData(
                contact: ContactData (
                    firstName: "Jake",
                    lastName: "Barayev",
                    gocDescription: "Sales Department",
                    soeID: "jb02201",
                    phone: "212-723-2876",
                    email: "jake.barayev@bank.com",
                    crossSellDesignee: false
                ),
                role: "Sponsoring MD"
            ),
            
            TransactionContactData(
                
                contact: ContactData (
                    firstName: "Boris",
                    lastName: "Rabinovich",
                    gocDescription: "Sales Department",
                    soeID: "br91708",
                    phone: "212-657-6732",
                    email: "boris.rabinovich@bank.com",
                    crossSellDesignee: false
                ),
                
                role: "Other"
            )
        ]
    )
    
    // the currently selected transaction updated on txn list view 'didselect' event
    
    var currentTransaction = TransactionData(
        transactionId: "New",
        transactionStatus: "Draft",
        dealStatus: "Pitch",
        ddtRestriction: "No",
        savedOnDate: "Not Saved",
        submitDate: "",
        requestorName: "Mike Henderson",
        primaryClient: "",
        counterparty: "",
        product: "",
        productSub: "",
        fulfillmentCondition: "N/A",
        clearanceApprovedDate: "",
        
        transactionCompanies: [],
        
        transactionDetail: TransactionDetailData (
            projectName: "",
            dealStatusDB: "",
            dealStatus: "",
            product: "",
            productSub: "",
            dealDescription: "",
            bankRole: "",
            dealSize: "",
            offeringFormat: "",
            offeringFormatComments: "",
            useOfProceeds: "",
            useOfProceedsComments: "",
            loanType: "",
            isConfidential: "Confidential",
            estimatedPitchDate: "",
            expectedAnnouncementDate: "",
            expectedClosingDate: "",
            isSubjectToTakeOver: "",
            hasFinancialSponsor: "",
            hasNonProfitOrganization: "",
            hasUSGovtAffiliatedMunicipality: "",
            likelyToTakePlace: "",
            backwardsDealStatusExplanation: "",
            terminatedExplanation: "",
            uncollectedFees: "",
            requests: ""
        ),
        transactionContacts: [
            TransactionContactData(
                contact: ContactData (
                    firstName: "Mike",
                    lastName: "Henderson",
                    gocDescription: "Sales Department",
                    soeID: "mh90210",
                    phone: "716-995-2319",
                    email: "Mike.Henderson@bank.com",
                    crossSellDesignee: false
                ),
                role: "Requestor"
            ),
            
            TransactionContactData(
                contact: ContactData (
                    firstName: "Ella",
                    lastName: "Fisher",
                    gocDescription: "Sales Department",
                    soeID: "ef67892",
                    phone: "(973) 464-3325",
                    email: "ef67892@bank.com",
                    crossSellDesignee: false
                ),
                role: "Sponsoring MD"
            ),
            
            TransactionContactData(
                contact: ContactData (
                    firstName: "Alex",
                    lastName: "Boguslavsky",
                    gocDescription: "ICG Compliance PMO",
                    soeID: "ab61532",
                    phone: "(201) 763-1362",
                    email: "ab61532@bank.com",
                    crossSellDesignee: false
                ),
                role: "Other"
            )
        ]
    )
    
    //  TRue status category selected from My Transactions Home view
    var selectedCategory: String!
    
    // Dictionary of transaction for every status category
    var lastViewedTransactions = [String:TransactionData]()
    
    var currentTransactionIndex: Int!
    // string used for checking various functionalities
    var checkForNewDraft = "YES"
    var checkForCollapseButton = "NO"
    var checkForNewDraftProduct = "NO"
    var checkForNewDraftSubProduct = "NO"
    var checkForNewDraftOfferingFormat = "NO"
    var checkForNewDraftUseOfProceeds = "NO"
    var checkForNewDraftLoanType = "NO"
    var checkForNewDealStatus = "NO"
    var checkForCountryPicker = "NO"
    var checkForExistingDraft = "NO"
    var selectedButtonTextForDate = "PitchDate"
    var checkForOrientationChange = "portrait"
    var checkForDeleteDraftClicked = "NO"
    var checkForAgreementClicked = "NO"
    var preserveDrafttransaction = [TransactionData]()
    
    //  var currentTransactionCompanyIndex : Int!
    
    // var currentTransactionCompanyAgreementIndex : Int!
    
    // array index of the last viewed transaction by caetgory
    var lastViewedTransactionsIndexes = [String:Int]()
    
    // transactions subset based on the status category
    var selectedTransactionArray = [TransactionData]()
    
    // filtered subset of transactions to display search results
    var filteredTransactionArray = [TransactionData]()
    
    func separateStringFromTime(normalText:String)-> String
    {
        var name = normalText
        var splitString = name.componentsSeparatedByString(" ")
        name = splitString[0]
        return name
    }
    
    func convertStringToDate(savedOnDate:String)-> NSDate
    {
        if(savedOnDate == "Not Saved")
        {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM/dd/yy HH:mm:ss"
            let dateString = NSDate()
            return dateString
        }
        else
        {
            let dateString = savedOnDate
            let dateFormatter = NSDateFormatter()
            // dateFormatter.locale = NSLocale(localeIdentifier: "US_en")
            dateFormatter.dateFormat = "MM/dd/yy HH:mm:ss"
            //dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
            return  dateFormatter.dateFromString(dateString)!
        }
    }
    
    
    // this will come from persistent store and updated via web service fetch eventually..
    func getTransactionsBytransactionStatus(transactionStatus : String) -> [TransactionData] {
        
        if ( transactionStatus == "All" ) {
            return self.transactionsArray
        } else {
            return self.transactionsArray.filter({
                (transaction: TransactionData) -> Bool in
                if (transaction.transactionStatus == transactionStatus) {
                    return true
                } else {
                    return false
                }
                }
            )
        }
    }
    
    // get the first transaction in a subset based on status
    func getFirstTransactionBytransactionStatus(transactionStatus : String) -> TransactionData? {
        
        return self.getTransactionsBytransactionStatus(transactionStatus).first
    }
    
    // set the currently selected transaction
    /*
    func setCurrentTransaction(selectedTransaction : Transaction) {
    self.currentTransaction = selectedTransaction
    }
    */
    
    // this will be called during seque from transaction list view to questionaire view
    func prepareQuestionaireModel(index: Int, filtered: Bool){
        
        if ( filtered ) {
            self.currentTransaction = self.filteredTransactionArray[index]
            
        } else {
            self.currentTransaction = self.selectedTransactionArray[index]
        }
        
        self.currentTransactionIndex = index
        
        self.setLastViewedTransaction()
    }
    
    // this will be called during seque from transaction list view to template view
    func prepareTemplateModel(){
        self.currentTransaction = self.templateTransaction
        self.currentTransactionIndex = 0
        self.setLastViewedTransaction()
    }
    
    // set the currently selected transaction dictionary with the currently selected status as key
    func setLastViewedTransaction() {
        self.lastViewedTransactions[self.selectedCategory] = self.currentTransaction
        self.lastViewedTransactionsIndexes[self.selectedCategory] = self.currentTransactionIndex
    }
    
    // get the currently selected transaction from the dictionary with the currently selected category
    func getLastViewedTransactionByCategory() -> TransactionData {
        return self.lastViewedTransactions[self.selectedCategory]!
    }
    
    
    // get the currently selected transaction from the dictionary with the currently selected category
    func getLastViewedTransactionIndexByCategory() -> Int {
        
        if ( self.selectedCategory == "Template") {
            return 0
        } else {
            return self.lastViewedTransactionsIndexes[self.selectedCategory]! + 1 // skip first cell
        }
    }
    
    // get the currently selected status caegoruy from the dictionary with the currently selected category
    func getLastViewedStatusCategoryIndexByCategory() -> Int {
        
        switch  self.selectedCategory {
        case "All":
            return 0
        case "Draft":
            return 1
        case "Pending Review":
            return 2
        case "Cleared":
            return 3
        case "Completed":
            return 4
        case "Terminated":
            return 5
        case "Fatal Conflicts":
            return 6
        case "Duplicate":
            return 7
        case "Template":
            return 8
        default:
            return 0
        }
    }
    
    // get the transaction count based on category
    func getTransactionCountByCategory(statusCategory: String) -> Int {
        
        if ( self.transactionsArray.isEmpty ) {
            return 0
        } else if ( statusCategory == "All" ) {
            return self.transactionsArray.count
        } else if ( statusCategory == "Template" ) {
            if ( self.userSavedTemplate ) {
                return 1
            } else {
                return 0
            }
        } else {
            let subSetArray = self.getTransactionsBytransactionStatus(statusCategory)
            
            if ( subSetArray.isEmpty) {
                return 0
            } else {
                return subSetArray.count
            }
        }
    }
    
    // this will be called during master view segue to transaction list view
    // set the currently selected transaction list for the currently selected status category
    // the txn list table view should then show the corresponding subset of the array or the template txn
    func prepareTransactionListModel(selectedCategory: String) {
        
        
        if (selectedCategory == "Template" ) {
            self.selectedCategory = selectedCategory
            
            self.selectedTransactionArray = [TransactionData]() // reset to an empty array
            self.selectedTransactionArray.append(self.templateTransaction) // only one template
            self.currentTransaction = self.templateTransaction
            self.currentTransactionIndex = 0
            
        } else {
            if self.getTransactionsBytransactionStatus(selectedCategory).count > 0 {
                self.selectedCategory = selectedCategory

                self.selectedTransactionArray = getTransactionsBytransactionStatus(self.selectedCategory)

                // reset the current transaction since a new status has been chosen
                // commented out by Joseph
             //   self.currentTransaction = self.getLastViewedTransactionByCategory()
               // self.currentTransactionIndex = self.getLastViewedTransactionIndexByCategory()
                
            }
        }
        
        // reset the filtered search array to be the selected array
        self.filteredTransactionArray = self.selectedTransactionArray
    }
    
    func returnCountryFlag(countryName: String) -> String{
        return ""
    }
    
    func getBusinessType(transaction: TransactionData) -> String {
        switch transaction.transactionDetail.productSub {
        case  "Acquisition of Divestiture", "Acquisition of Private Company","Acquisition of Public Company","Buy Side Other","Public Company Merger-Buy":
           return "Buy"
            //reset all screens that dont apply to Buy
        case  "Divestiture","Public Company Merger-Sell","Sale Of Assets","Sale of Ownership Stake","Sale of Private Company",
        "Sale of Public Company","Sell Side Other","Spin Off/Split Off","Strategic Alternatives Review","Takeover Defense","Dual Track Process - Trade Sale or IPO":
            return "Sell"
            //reset all screens that dont apply to Sell
        case "Advisory", "Infrastructure Advisory","Joint Venture","M&A Other","M&A/Infrastructure Advisory",  "Privatization"      :
            return "Either"
            //reset all screens that dont apply to Either
        case "Equity Advisory", "Fairness Opinion Only","Recapitalization", "Restructuring":
            return "N/A"
            //reset all screens that dont apply to N/A
        default:
            return "N/A"
        }
    }
    
    //create contacts
    var contactsArray = [ContactData]()
    // the currently selected Contact updated on txn list view 'didselect' event
    
    var currentContact:ContactData
    
    //   var selectedContactsArray = [Contact]()
    
    // contacts filtered from search
    var filteredContactsArray = [ContactData]()
//    func initContacts() {
//        var newC = contactsArray[0]
//    }
    
    
    /// MARK Companies model
    var companiesArray = [CompanyData]()
    
    var previousCompaniesArray = [CompanyData]()
    
    // updated when user touches one of the Company based table views
    //var currentCompany: Company!
    
    // companies filtered from search
    var filteredCompaniesArray = [CompanyData]()
    
    // companies selected from Search or Previous
    
    
    var definedCompany: TransactionCompanyData!
    
    // company Industry picker values
    var industriesArray = [IndustryData]()
    var countriesArray = [CountryData]()
    var segmentsArray = [SegmentsData]()
    var productArray = [ProductData]()
    var productSubArray = [ProductSubData]()
    
    //new change
    var transactionStatusesArray = [TransactionStatusData]()
    var dealStatusesArray = [DealStatusData]()
    var companyRolesArray = [CompanyRoleData]()
    var offeringFormatArray = [OfferingFormatData]()
    var useOfProceedsArray = [UseOfProceedsData]()
    var loanTypesArray = [LoanTypeData]()
    var agreementTypesArray = [AgreementTypeData]()
    var contactRolesArray = [ContactRoleData]()
    var userContactData: ContactData!
    var companynameArrayForManuallyDefined = [String]()
    // new change
    
    var productMapArray = [ProductMapData]()
    
    
    
     init () {
        // default user contact will be the user who activates the app. if the user name is not present in the CSV then default will be shown
        
        let arrayForContactData = self.coreDataManager.arrayForContact as NSArray as! [ContactData]
        
        self.contactsArray = arrayForContactData

        loggedInUserId = self.coreDataManager.userIdFromLogin as String
        checkForOrientationChange = self.coreDataManager.checkForOrientationChange as String
        for contactdataForUserName in arrayForContactData
        {
            if contactdataForUserName.soeID == loggedInUserId
            {
                loggedInUserName = contactdataForUserName.firstName
                    + " " + contactdataForUserName.lastName
                userContactData = contactdataForUserName
                break
            }
        }
        
        //
        //set current contacts
        let arrayForCompaniesData = self.coreDataManager.arrayForCompanies as NSArray as! [CompanyData]
        self.companiesArray = arrayForCompaniesData
        self.previousCompaniesArray = arrayForCompaniesData
        
        if self.coreDataManager.checkIndependentEntities == "NO"
        {
            self.coreDataManager.saveTransactionValue(self.transactionSaveArray)
        }
        
        let arrayFortransaction = self.coreDataManager.transactionArray() as NSArray as! [TransactionData]
        self.transactionsArray = arrayFortransaction
        
        self.currentContact = self.contactsArray[0]
        self.companiesArray =  self.companiesArray.sort({ $0.companyName < $1.companyName })
        self.contactsArray =  self.contactsArray.sort({ $0.firstName < $1.firstName })
        
        // keep track of last viewed transaction of each status category
        
        lastViewedTransactions["All"] = self.getFirstTransactionBytransactionStatus("All")
        
        self.lastViewedTransactions["Draft"] = self.getFirstTransactionBytransactionStatus("Draft")
        
        self.lastViewedTransactions["Pending Review"] = self.getFirstTransactionBytransactionStatus("Pending Review")
        
        self.lastViewedTransactions["Cleared"] = self.getFirstTransactionBytransactionStatus("Cleared")
        
        self.lastViewedTransactions["Completed"] = self.getFirstTransactionBytransactionStatus("Completed")
        
        self.lastViewedTransactions["Duplicate"] = self.getFirstTransactionBytransactionStatus("Duplicate")
        
        self.lastViewedTransactions["Terminated"] = self.getFirstTransactionBytransactionStatus("Terminated")
        
        self.lastViewedTransactions["Fatal Conflicts"] = self.getFirstTransactionBytransactionStatus("Fatal Conflicts")
        
        //defaults
        
        /*
        self.lastViewedTransactions = [
        "All":transactionsArray[0],
        "Draft":transactionsArray[1],
        "Pending Review":transactionsArray[3],
        "Cleared":transactionsArray[5],
        "Completed":transactionsArray[6],
        "Template":templateTransaction
        ]
        */
        
        // last viewed
        // index path row indexes
        // of table view of each status category
        self.lastViewedTransactionsIndexes = [
            "All":0,
            "Draft":0,
            "Pending Review":0,
            "Cleared":0,
            "Completed":0,
            "Duplicate":0,
            "Terminated":0,
            "Fatal Conflicts":0,
            "Template":0
        ]
        
        // defaults for transactions model
        self.selectedCategory = "All"
        
        // initially All of them at first
        self.selectedTransactionArray = self.transactionsArray
        
        // filtered list all of them at first
        self.filteredTransactionArray = self.transactionsArray
        
        self.currentTransaction = self.transactionsArray[0]
        self.currentTransactionIndex = 0
        
        //hard code own user as contact initially
        //create new Transaction contact from contact
        //Change Done 08-07-2015
       // self.currentTransaction.transactionContacts.append(TransactionContactData(contact: self.contactsArray[0], role: "Requestor"))
        
        // defaults for companies model
    }
    
}
