//
//  AgreementData.swift
//

import Foundation

@objc class AgreementData: NSObject {
    
    var agreementType: String = ""
    var effectiveDate: String = ""
    var expirationDate: String = ""
    var agreementTerms: String = ""
    var legalReviewBy: String = ""
    var exclusivityApprovedBy: String = ""
    
    init(
        agreementType: String,
        effectiveDate: String,
        expirationDate: String,
        agreementTerms: String,
        legalReviewBy: String,
        exclusivityApprovedBy: String
        ){
            self.agreementType = agreementType
            self.effectiveDate = effectiveDate
            self.expirationDate = expirationDate
            self.agreementTerms = agreementTerms
            self.legalReviewBy = legalReviewBy
            self.exclusivityApprovedBy = exclusivityApprovedBy
    }
}
