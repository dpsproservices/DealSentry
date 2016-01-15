//
// ViewStateManager.swift
//

import Foundation

@objc class ViewStateManager: NSObject {
    
    var debugUtil = DebugUtility(thisClassName: "ViewStateManager", enabled: false)
    
    class var sharedInstance: ViewStateManager {
        
        struct SingletonObject {
            static var instance: ViewStateManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&SingletonObject.token) {
            SingletonObject.instance = ViewStateManager()
        }
        
        return SingletonObject.instance!
    }
    
    //let appDelegate = UIApplication.sharedApplication().delegate! as! AppDelegate
    var appDelegate: AppDelegate!
    
    var window: UIWindow?
    
    var splitViewController: UISplitViewController!
    var masterViewController: MasterViewController!
    var detailViewController: DetailViewController!
    var startViewController: StartViewController!
    
    var masterNavigationController: UINavigationController!
    var detailNavigationController: UINavigationController!
    
    let dataManager: AnyObject! = DataManager.getInstance()
    
    var isLoggedIn = false
    var loggedInUserName = "Eric Wattson"
    var loggedInUserId = "ew57483"
    var userSavedTemplate = true
    
    // sample transaction preloaded during app first launch
    var savedTransactionsArray = [
        
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
                        department: "Sales Department",
                        employeeId: "ew57483",
                        phone: "949-765-7890",
                        email: "Eric.Wattson@dealservices.com",
                        crossSellDesignee: false
                    ),
                    role: "Requestor"
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
                        firstName: "Eric",
                        lastName: "Wattson",
                        department: "Sales Department",
                        employeeId: "ew57483",
                        phone: "949-765-7890",
                        email: "Eric.Wattson@dealservices.com",
                        crossSellDesignee: false
                    ),
                    role: "Requestor"
                ),
                
                               
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Carol",
                        lastName: "Uberman",
                        department: "Sales Department",
                        employeeId: "ew57483",
                        phone: "949-765-7890",
                        email: "Eric.Wattson@dealservices.com",
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
                        firstName: "Eric",
                        lastName: "Wattson",
                        department: "Sales Department",
                        employeeId: "ew57483",
                        phone: "949-765-7890",
                        email: "Eric.Wattson@dealservices.com",
                        crossSellDesignee: false
                    ),
                    role: "Requestor"
                ),
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Bart",
                        lastName: "Thatcher",
                        department: "Sales Department",
                        employeeId: "bt67890",
                        phone: "949-765-5678",
                        email: "bart.thatcher@dealservices.com",
                        crossSellDesignee: false
                    ),
                    role: "Sponsoring MD"
                ),
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Carol",
                        lastName: "Uberman",
                        department: "Sales Department",
                        employeeId: "ew57483",
                        phone: "949-765-7890",
                        email: "Eric.Wattson@dealservices.com",
                        crossSellDesignee: false
                    ),
                    role: "Other"
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
                        firstName: "Eric",
                        lastName: "Wattson",
                        department: "Sales Department",
                        employeeId: "ew57483",
                        phone: "949-765-7890",
                        email: "Eric.Wattson@dealservices.com",
                        crossSellDesignee: false
                    ),
                    role: "Requestor"
                ),
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Bart",
                        lastName: "Thatcher",
                        department: "Sales Department",
                        employeeId: "bt67890",
                        phone: "949-765-5678",
                        email: "bart.thatcher@dealservices.com",
                        crossSellDesignee: false
                    ),
                    role: "Sponsoring MD"
                ),
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Carol",
                        lastName: "Uberman",
                        department: "Sales Department",
                        employeeId: "ew57483",
                        phone: "949-765-7890",
                        email: "Eric.Wattson@dealservices.com",
                        crossSellDesignee: false
                    ),
                    role: "Other"
                )
                
            ]
        ),
        
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
                        firstName: "Eric",
                        lastName: "Wattson",
                        department: "Sales Department",
                        employeeId: "ew57483",
                        phone: "949-765-7890",
                        email: "Eric.Wattson@dealservices.com",
                        crossSellDesignee: false
                    ),
                    role: "Requestor"
                ),
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Bart",
                        lastName: "Thatcher",
                        department: "Sales Department",
                        employeeId: "bt67890",
                        phone: "949-765-5678",
                        email: "bart.thatcher@dealservices.com",
                        crossSellDesignee: false
                    ),
                    role: "Sponsoring MD"
                ),
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Carol",
                        lastName: "Uberman",
                        department: "Sales Department",
                        employeeId: "ew57483",
                        phone: "949-765-7890",
                        email: "Eric.Wattson@dealservices.com",
                        crossSellDesignee: false
                    ),
                    role: "Other"
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
                        firstName: "Eric",
                        lastName: "Wattson",
                        department: "Sales Department",
                        employeeId: "ew57483",
                        phone: "949-765-7890",
                        email: "Eric.Wattson@dealservices.com",
                        crossSellDesignee: false
                    ),
                    role: "Requestor"
                ),
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Bart",
                        lastName: "Thatcher",
                        department: "Sales Department",
                        employeeId: "bt67890",
                        phone: "949-765-5678",
                        email: "bart.thatcher@dealservices.com",
                        crossSellDesignee: false
                    ),
                    role: "Sponsoring MD"
                ),
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Carol",
                        lastName: "Uberman",
                        department: "Sales Department",
                        employeeId: "ew57483",
                        phone: "949-765-7890",
                        email: "Eric.Wattson@dealservices.com",
                        crossSellDesignee: false
                    ),
                    role: "Other"
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
                        firstName: "Eric",
                        lastName: "Wattson",
                        department: "Sales Department",
                        employeeId: "ew57483",
                        phone: "949-765-7890",
                        email: "Eric.Wattson@dealservices.com",
                        crossSellDesignee: false
                    ),
                    role: "Requestor"
                ),
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Bart",
                        lastName: "Thatcher",
                        department: "Sales Department",
                        employeeId: "bt67890",
                        phone: "949-765-5678",
                        email: "bart.thatcher@dealservices.com",
                        crossSellDesignee: false
                    ),
                    role: "Sponsoring MD"
                ),
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Carol",
                        lastName: "Uberman",
                        department: "Sales Department",
                        employeeId: "ew57483",
                        phone: "949-765-7890",
                        email: "Eric.Wattson@dealservices.com",
                        crossSellDesignee: false
                    ),
                    role: "Other"
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
                        firstName: "Eric",
                        lastName: "Wattson",
                        department: "Sales Department",
                        employeeId: "ew57483",
                        phone: "949-765-7890",
                        email: "Eric.Wattson@dealservices.com",
                        crossSellDesignee: false
                    ),
                    role: "Requestor"
                ),
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Bart",
                        lastName: "Thatcher",
                        department: "Sales Department",
                        employeeId: "bt67890",
                        phone: "949-765-5678",
                        email: "bart.thatcher@dealservices.com",
                        crossSellDesignee: false
                    ),
                    role: "Sponsoring MD"
                ),
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Carol",
                        lastName: "Uberman",
                        department: "Sales Department",
                        employeeId: "ew57483",
                        phone: "949-765-7890",
                        email: "Eric.Wattson@dealservices.com",
                        crossSellDesignee: false
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
                        firstName: "Eric",
                        lastName: "Wattson",
                        department: "Sales Department",
                        employeeId: "ew57483",
                        phone: "949-765-7890",
                        email: "Eric.Wattson@dealservices.com",
                        crossSellDesignee: false
                    ),
                    role: "Requestor"
                ),
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Bart",
                        lastName: "Thatcher",
                        department: "Sales Department",
                        employeeId: "bt67890",
                        phone: "949-765-5678",
                        email: "bart.thatcher@dealservices.com",
                        crossSellDesignee: false
                    ),
                    role: "Sponsoring MD"
                ),
                
                TransactionContactData(
                    contact: ContactData (
                        firstName: "Carol",
                        lastName: "Uberman",
                        department: "Sales Department",
                        employeeId: "ew57483",
                        phone: "949-765-7890",
                        email: "Eric.Wattson@dealservices.com",
                        crossSellDesignee: false
                    ),
                    role: "Other"
                )
                
            ]
            
        )
    ]
    
    
    
    var transactionsArray = [TransactionData]()
    
    // dummy template
    var templateTransaction: TransactionData!
    
    // the currently selected transaction updated on txn list view 'didselect' event
    var currentTransaction: TransactionData!
    
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
    var currentOrientation = "portrait"
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
    //create contacts
    var contactsArray = [ContactData]()
    // the currently selected Contact updated on txn list view 'didselect' event
    
    var currentContact: ContactData!
    
    //   var selectedContactsArray = [Contact]()
    
    // contacts filtered from search
    var filteredContactsArray = [ContactData]()
    
    
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
    var productMapArray = [ProductMapData]()
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
    
    // load the static arrays for the pickers and tableviews
    func loadStaticArrays() {
        
        self.companyRolesArray = self.dataManager.arrayForCompanyRoles as NSArray as! [CompanyRoleData]

        self.contactRolesArray = self.dataManager.arrayForContactRoles as NSArray as! [ContactRoleData]
        
        self.agreementTypesArray  = self.dataManager.arrayForAgreementTypes as NSArray as! [AgreementTypeData]
        
        self.dealStatusesArray = self.dataManager.arrayForDealStatuses as NSArray as! [DealStatusData]
        
        self.industriesArray = self.dataManager.arrayForIndustries as NSArray as! [IndustryData]
        
        self.loanTypesArray = self.dataManager.arrayForLoanTypes as NSArray as! [LoanTypeData]
        
        self.offeringFormatArray = self.dataManager.arrayForOfferingFormat as NSArray as! [OfferingFormatData]
        
        self.segmentsArray = self.dataManager.arrayForSegments as NSArray as! [SegmentsData]
        
        self.transactionStatusesArray = self.dataManager.arrayForTransactionStatuses as NSArray as! [TransactionStatusData]
        
        self.useOfProceedsArray = self.dataManager.arrayForUseOfProceeds as NSArray as! [UseOfProceedsData]
        
        self.productArray = self.dataManager.arrayForProduct as NSArray as! [ProductData]
        
        let arrayForProductSub = self.dataManager.arrayForProductSub as NSArray as! [ProductSubData]
        self.productSubArray = arrayForProductSub
        
        self.countriesArray = self.dataManager.arrayForCountries as NSArray as! [CountryData]
        
        self.productMapArray = self.dataManager.arrayForProductmap as NSArray as! [ProductMapData]
    }
    
    func splashScreen() {
        
        let startViewController:StartViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("StartViewController") as! StartViewController
        
        self.window?.rootViewController?.presentViewController(startViewController, animated: false, completion: nil)
        self.window?.rootViewController = startViewController
        self.startViewController = startViewController
        self.startViewController.appDelegate = self.appDelegate
        
        self.masterNavigationController = self.splitViewController.viewControllers[0] as! UINavigationController
        self.masterViewController = masterNavigationController.topViewController as! MasterViewController
        self.masterViewController.appDelegate = self.appDelegate
        
        self.detailNavigationController = self.splitViewController.viewControllers[1] as! UINavigationController
        self.detailViewController = detailNavigationController.topViewController as! DetailViewController
        self.detailViewController.appDelegate = self.appDelegate
        
        // double arrow icon to expand or collapse the master view
        self.detailViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem()
    }
    
    func loadContactsArray() {
        self.contactsArray = self.dataManager.arrayForContact as NSArray as! [ContactData]
        self.contactsArray =  self.contactsArray.sort({ $0.firstName < $1.firstName })
    }
    
    func loadCompaniesArray() {
        self.companiesArray = self.dataManager.arrayForCompanies as NSArray as! [CompanyData]
        self.companiesArray =  self.companiesArray.sort({ $0.companyName < $1.companyName })
    }
    
    func loadPreviousCompaniesArray() {
        //self.previousCompaniesArray = self.companiesArray
    }
    
   
    // checks the current device orientation and sets the global property for use in UI layout logic
    func checkOrientation () {

        if UIDevice.currentDevice().orientation.isPortrait.boolValue {
            currentOrientation = "portrait"
        }
        else {
            currentOrientation = "landscape"
        }
    }
    
    override init () {
        
        super.init()

        if self.dataManager.checkIndependentEntities == "NO"
        {
            self.dataManager.saveTransactionValue(self.savedTransactionsArray)
        }
        
        self.loadStaticArrays()
        
        self.loadContactsArray()
        
        self.loadCompaniesArray()
        
        
        let arrayFortransaction = self.dataManager.transactionArray() as NSArray as! [TransactionData]
        
        self.transactionsArray = arrayFortransaction
        
        self.currentContact = self.contactsArray[0]
        
        
        
        // keep track of last viewed transaction of each status category
        
        lastViewedTransactions["All"] = self.getFirstTransactionBytransactionStatus("All")
        
        self.lastViewedTransactions["Draft"] = self.getFirstTransactionBytransactionStatus("Draft")
        
        self.lastViewedTransactions["Pending Review"] = self.getFirstTransactionBytransactionStatus("Pending Review")
        
        self.lastViewedTransactions["Cleared"] = self.getFirstTransactionBytransactionStatus("Cleared")
        
        self.lastViewedTransactions["Completed"] = self.getFirstTransactionBytransactionStatus("Completed")
        
        self.lastViewedTransactions["Duplicate"] = self.getFirstTransactionBytransactionStatus("Duplicate")
        
        self.lastViewedTransactions["Terminated"] = self.getFirstTransactionBytransactionStatus("Terminated")
        
        self.lastViewedTransactions["Fatal Conflicts"] = self.getFirstTransactionBytransactionStatus("Fatal Conflicts")

        
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

    }
    
}
