//
//  TransactionCompanyData.swift
//

import Foundation

@objc class TransactionCompanyData: NSObject {
    var company: CompanyData
    var role: String = ""
    var materiality : MaterialityData
    var agreements : [AgreementData] = []
    
    var hasAgreements = false
    
    var isManuallyDefinedByUser: Bool = false
    var currentTransactionCompanyAgreementIndex:Int = 0
    
    
    // Draft defaults
    init(
        company: CompanyData,
        role: String
        ){
            self.company = company
            self.role = role
            self.materiality = MaterialityData(
                isMaterial: "No",
                isMaterialDescription: "",
                hasPubliclyTradedSecurities: "No",
                isGovtOwned: "No",
                percentOwned: "",
                // hasFinancialSponsor: "No",
                // hasNonProfitOrganization: "No",
                // hasUSGovtAffiliatedMunicipality: "No",
                hasPRC: "No",
                hasStandardAgreements: "Yes",
                specialCircumstances: ""
            )
            self.agreements = []
            self.hasAgreements = false
            self.isManuallyDefinedByUser = false
    }
    
    init(
        company: CompanyData,
        role: String,
        materiality: MaterialityData
        ){
            self.company = company
            self.role = role
            self.materiality = materiality
            self.hasAgreements = false
            self.isManuallyDefinedByUser = false
    }
    
    init(
        company: CompanyData,
        role: String,
        materiality: MaterialityData,
        agreements: [AgreementData]
        ){
            self.company = company
            self.role = role
            self.materiality = materiality
            self.agreements = agreements
            self.hasAgreements = !agreements.isEmpty
            self.isManuallyDefinedByUser = false
    }
    
    init(
        company: CompanyData,
        role: String,
        materiality: MaterialityData,
        agreements: [AgreementData],
        isManuallyDefinedByUser: Bool
        ){
            self.company = company
            self.role = role
            self.materiality = materiality
            self.agreements = agreements
            self.hasAgreements = !agreements.isEmpty
            self.isManuallyDefinedByUser = isManuallyDefinedByUser
    }
    
    
    
    func addAgreement(agreement: AgreementData) {
        self.agreements.append(agreement)
    }
    func removeAgreement(index: Int) {
        self.agreements.removeAtIndex(index)
    }
    func editAgreement(index: Int, agreement: AgreementData) {
        self.agreements[index] = agreement
    }
    func removeAllAgreements() {
        self.agreements = [AgreementData]()
    }
    
}
