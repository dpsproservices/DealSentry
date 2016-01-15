//
//  TransactionData.swift
//

import Foundation

@objc class TransactionData: NSObject {
    
    var transactionId: String = ""
    var transactionStatus: String = ""
    var ddtRestriction: String = ""
    var savedOnDate: String = ""
    var submitDate: String = ""
    var primaryClient: String = ""
    var counterparty: String = ""
    var requestorName: String = ""
    var clearanceApprovedDate: String = ""
    var fulfillmentCondition: String = ""
    var currentTransactionCompanyIndex : Int = 0
    var currentTransactionContactIndex : Int = 0
    
    var hasTransactionCompanies = false
    var hasTransactionContacts = false
    
    // contains 1 Company, role, 1 Materiality and Agreements array
    var transactionCompanies: [TransactionCompanyData] = []
    
    var transactionDetail: TransactionDetailData
    
    var businessSelection: BusinessSelectionData
    
    var transactionContacts: [TransactionContactData] = []

    var dealStatusChangedBackwards: String = "false"
    
    var businessSelectionDraft = BusinessSelectionData(
        isDifferentCurrencies: "",
        isUKCompanyInvolved: "",
        isFriendlyOrHostile: "",
        isDownwardRatingsLikely: "",
        isGovernmentAgency: "",
        isConsolidatedBankingOpportunity: "",
        consolidatedBankingOpportunityDescription: "",
        isInvestmentOpportunity: "",
        investmentOpportunityDescription: "",
        isServicesOpportunity: "",
        servicesOpportunityDescription: "",
        toIncludeCash: "",
        toIncludeStock: "",
        toIncludeOther: "",
        pleaseExplain: "",
        businessSelectionTypeForEither: "",
        hasDerivativesExposure: "",
        hasCommoditiesExposure: "",
        hasWealthManagementOpportunity: "",
        wealthManagementOpportunity: ""
    )
    init(
        
        transactionId: String,
        transactionStatus: String,
        dealStatus: String,
        ddtRestriction:String,
        savedOnDate: String,
        submitDate: String,
        primaryClient: String,
        counterparty: String,
        product: String,
        productSub: String,
        transactionCompanies: [TransactionCompanyData],
        transactionDetail: TransactionDetailData,
        transactionContacts: [TransactionContactData]
        ) {
            self.submitDate = submitDate
            self.transactionId = transactionId
            self.transactionStatus = transactionStatus
            self.ddtRestriction = ddtRestriction
            self.savedOnDate = savedOnDate
            self.primaryClient = primaryClient
            self.counterparty = counterparty
            self.transactionCompanies = transactionCompanies
            self.transactionDetail = transactionDetail
            self.businessSelection = self.businessSelectionDraft
            self.transactionContacts = transactionContacts
            self.hasTransactionContacts = !transactionContacts.isEmpty
            self.hasTransactionCompanies = !transactionCompanies.isEmpty
            
    }
    
    init(
        
        transactionId: String,
        transactionStatus: String,
        dealStatus: String,
        ddtRestriction: String,
        savedOnDate: String,
        submitDate: String,
        requestorName: String,
        primaryClient: String,
        counterparty: String,
        product: String,
        productSub: String,
        transactionCompanies: [TransactionCompanyData],
        transactionDetail: TransactionDetailData,
        transactionContacts: [TransactionContactData]
    ) {
            self.submitDate = submitDate
            self.requestorName = requestorName
            self.transactionId = transactionId
            self.transactionStatus = transactionStatus
            self.ddtRestriction = ddtRestriction
            self.savedOnDate = savedOnDate
            self.primaryClient = primaryClient
            self.counterparty = counterparty
            self.transactionCompanies = transactionCompanies
            self.transactionDetail = transactionDetail
            self.businessSelection = self.businessSelectionDraft
            self.transactionContacts = transactionContacts
            self.hasTransactionContacts = !transactionContacts.isEmpty
            self.hasTransactionCompanies = !transactionCompanies.isEmpty

    }
    
    init(
        
        transactionId: String,
        transactionStatus: String,
        dealStatus: String,
        ddtRestriction: String,
        savedOnDate: String,
        submitDate: String,
        requestorName: String,
        primaryClient: String,
        counterparty: String,
        product: String,
        productSub: String,
        fulfillmentCondition: String,
        clearanceApprovedDate: String,
        transactionCompanies: [TransactionCompanyData],
        transactionDetail: TransactionDetailData,
        transactionContacts: [TransactionContactData]
    ) {
            
            self.submitDate = submitDate
            self.requestorName = requestorName
            self.fulfillmentCondition = fulfillmentCondition
            self.clearanceApprovedDate = clearanceApprovedDate
            self.transactionId = transactionId
            self.transactionStatus = transactionStatus
            self.ddtRestriction = ddtRestriction
            self.savedOnDate = savedOnDate
            self.primaryClient = primaryClient
            self.counterparty = counterparty
            self.transactionCompanies = transactionCompanies
            self.transactionDetail = transactionDetail
            self.businessSelection = self.businessSelectionDraft
            self.transactionContacts = transactionContacts
            self.hasTransactionContacts = !transactionContacts.isEmpty
            self.hasTransactionCompanies = !transactionCompanies.isEmpty

    }
    init(
        transactionId: String,
        transactionStatus: String,
        dealStatus: String,
        ddtRestriction: String,
        savedOnDate: String,
        submitDate: String,
        requestorName: String,
        primaryClient: String,
        counterparty: String,
        product: String,
        productSub: String,
        fulfillmentCondition: String,
        clearanceApprovedDate: String,
        transactionCompanies: [TransactionCompanyData],
        transactionDetail: TransactionDetailData,
        businessSelection: BusinessSelectionData,
        transactionContacts: [TransactionContactData]

    ) {
            self.submitDate = submitDate
            self.requestorName = requestorName
            self.fulfillmentCondition = fulfillmentCondition
            self.clearanceApprovedDate = clearanceApprovedDate
            self.transactionId = transactionId
            self.transactionStatus = transactionStatus
            self.ddtRestriction = ddtRestriction
            self.savedOnDate = savedOnDate
            self.primaryClient = primaryClient
            self.counterparty = counterparty
            self.transactionCompanies = transactionCompanies
            self.transactionDetail = transactionDetail
            self.businessSelection = businessSelection
            self.transactionContacts = transactionContacts
            self.hasTransactionContacts = !transactionContacts.isEmpty
            self.hasTransactionCompanies = !transactionCompanies.isEmpty

    }
    
    func addCompany(transactionCompany: TransactionCompanyData) {
        
        self.transactionCompanies.append(transactionCompany)
        self.hasTransactionCompanies = true
    }
    
    
    func removeCompanyAtIndex(index: Int) {
        
        self.transactionCompanies.removeAtIndex(index)
        
        if(self.transactionCompanies.isEmpty) {
            self.hasTransactionCompanies = false
        }
    }
    
    func editCompanyAtIndex(index:Int, transactionCompany: TransactionCompanyData) {
        self.transactionCompanies[index] = transactionCompany
        
    }
    
    func removeAllCompanies() {
        self.transactionCompanies = [TransactionCompanyData]()
        self.hasTransactionCompanies = false
    }
    
    func addContact(transactionContact: TransactionContactData) {
        
        self.transactionContacts.append(transactionContact)
        self.hasTransactionContacts = true
    }
    
    
    func addContacts(transactionContacts: [TransactionContactData]) {
        
        self.transactionContacts.appendContentsOf(transactionContacts)
        self.hasTransactionContacts = true
    }
    
    func removeContactAtIndex(index: Int) {
        
        self.transactionContacts.removeAtIndex(index)
        
        if(self.transactionContacts.isEmpty) {
            self.hasTransactionContacts = false
        }
    }
    
    func removeAllContacts() {
        self.transactionContacts = [TransactionContactData]()
        self.hasTransactionContacts = false
    }
    
    
    // return a text searchable string
    // of the header fields shown in the
    func toString() -> String {
        return self.transactionId
            + self.transactionStatus
            + self.ddtRestriction
            + self.savedOnDate
            + self.primaryClient
            + self.counterparty
    }
}
