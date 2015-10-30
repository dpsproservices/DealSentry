//
//  TransactionDetailData.swift
//

import Foundation

class TransactionDetailData: NSObject { // one per Transaction
    
    var projectName: String = ""
    var dealStatusDB: String = "" //this will be the value read from DB
    var dealStatus: String = "" // required
    var product: String = "" // required
    var productSub: String = "" // required
    var dealDescription: String = "" // required
    var bankRole: String = "" // required
    var dealSize: String = ""
    var offeringFormat: String = ""
    var offeringFormatComments: String = ""
    var useOfProceeds: String = "" // required
    var useOfProceedsComments: String = ""
    var loanType: String = "" // required
    var isConfidential: String = "Confidential" // Confidential or Public
    var estimatedPitchDate: String = "" // required only if product == M&A
    var expectedAnnouncementDate: String = "" // required
    var expectedClosingDate: String = ""
    var isSubjectToTakeOver: String = "No" // required Yes or No
    var hasFinancialSponsor: String = "No"   // Yes or No
    var hasNonProfitOrganization: String = ""  // Yes or No
    var hasUSGovtAffiliatedMunicipality: String = ""   // Yes or No
    var likelyToTakePlace: String = "Yes" // Yes or No
    var backwardsDealStatusExplanation: String = ""
    var terminatedExplanation: String = "" // required only if deal status == Terminated
    var uncollectedFees: String = "" // required only if deal status == Terminated
    var requests: String = ""
    
    init (
        projectName: String,
        dealStatusDB: String,
        dealStatus: String, // required
        product: String, // required
        productSub: String, // required
        dealDescription: String, // required
        bankRole: String, // required
        dealSize: String,
        offeringFormat: String,
        offeringFormatComments: String,
        useOfProceeds: String, // required
        useOfProceedsComments: String,
        loanType: String, // required
        isConfidential: String,
        estimatedPitchDate: String, // required only if product == M&A
        expectedAnnouncementDate: String, // required
        expectedClosingDate: String,
        isSubjectToTakeOver: String, // required
        hasFinancialSponsor: String,
        hasNonProfitOrganization: String,
        hasUSGovtAffiliatedMunicipality: String,
        likelyToTakePlace: String,
        backwardsDealStatusExplanation: String,
        terminatedExplanation: String, // required only if deal status == Terminated
        uncollectedFees: String, // required only if deal status == Terminated
        requests: String
        ) {
            self.projectName = projectName
            self.dealStatusDB = dealStatusDB
            self.dealStatus = dealStatus
            self.product = product
            self.productSub = productSub
            self.dealDescription = dealDescription
            self.bankRole = bankRole
            self.dealSize = dealSize
            self.offeringFormat = offeringFormat
            self.offeringFormatComments = offeringFormatComments
            self.useOfProceeds = useOfProceeds
            self.useOfProceedsComments = useOfProceedsComments
            self.loanType = loanType
            self.isConfidential = isConfidential
            self.estimatedPitchDate = estimatedPitchDate
            self.expectedAnnouncementDate = expectedAnnouncementDate
            self.expectedClosingDate = expectedClosingDate
            self.isSubjectToTakeOver = isSubjectToTakeOver
            self.hasFinancialSponsor = hasFinancialSponsor
            self.hasNonProfitOrganization = hasNonProfitOrganization
            self.hasUSGovtAffiliatedMunicipality = hasUSGovtAffiliatedMunicipality
            self.likelyToTakePlace = likelyToTakePlace
            self.backwardsDealStatusExplanation = backwardsDealStatusExplanation
            self.terminatedExplanation = terminatedExplanation
            self.uncollectedFees = uncollectedFees
            self.requests = requests
    }
}
