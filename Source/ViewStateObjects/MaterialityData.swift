//
//  MaterialityData.swift
//

import Foundation

@objc class MaterialityData: NSObject {
    
    // one set of materiality questions per Company added to the Transaction
    
    var isMaterial: String = "No" // Yes or No
    var isMaterialDescription: String = "" // required only if isMaterial is Yes
    
    var hasPubliclyTradedSecurities: String = "" // Yes or No
    
    var isGovtOwned: String = "No" // Yes or No
    var percentOwned: String = "" // required only if isGovtOwned is Yes
    
    //   var hasFinancialSponsor: String = "No" // Yes or No
    
    // var hasNonProfitOrganization: String = "No" //Yes or No
    
    // var hasUSGovtAffiliatedMunicipality: String = "No" // Yes or No
    
    var hasPRC: String = "No" // Yes or No,  required only if isMaterial is Yes
    
    // last page
    var hasStandardAgreements: String = "Yes" // Yes or No or N/A
    var specialCircumstances: String = "" // required only if hasStandardAgreements == No
    
    /*
    override init () {
    self.isMaterial = "No"
    self.isMaterialDescription = ""
    
    self.hasPubliclyTradedSecurities = "No"
    
    self.isGovtOwned = "No"
    self.percentOwned = ""
    
    //    self.hasFinancialSponsor = "No"
    
    //  self.hasNonProfitOrganization = "No"
    
    //self.hasUSGovtAffiliatedMunicipality = "No"
    
    self.hasPRC = "No"
    
    self.hasStandardAgreements = "Yes"
    self.specialCircumstances = ""
    
    }
    */
    
    init (
        isMaterial: String,
        isMaterialDescription: String,
        
        hasPubliclyTradedSecurities: String,
        
        isGovtOwned: String,
        percentOwned: String,
        
        // hasFinancialSponsor: String,
        
        //hasNonProfitOrganization: String,
        
        //hasUSGovtAffiliatedMunicipality: String,
        
        hasPRC: String,
        
        hasStandardAgreements: String,
        specialCircumstances: String
        
        ) {
            self.isMaterial = isMaterial
            self.isMaterialDescription = isMaterialDescription
            
            self.hasPubliclyTradedSecurities = hasPubliclyTradedSecurities
            
            self.isGovtOwned = isGovtOwned
            self.percentOwned = percentOwned
            
            //self.hasFinancialSponsor = hasFinancialSponsor
            
            // self.hasNonProfitOrganization = hasNonProfitOrganization
            
            // self.hasUSGovtAffiliatedMunicipality = hasUSGovtAffiliatedMunicipality
            
            self.hasPRC = hasPRC
            
            self.hasStandardAgreements = hasStandardAgreements
            self.specialCircumstances = specialCircumstances
    }
    
    
}