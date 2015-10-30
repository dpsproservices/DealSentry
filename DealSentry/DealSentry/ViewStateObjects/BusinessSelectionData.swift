//
//  BusinessSelectionData.swift
//

import Foundation

class BusinessSelectionData: NSObject {
    
    var isDifferentCurrencies: String = "No" // Yes or No
    
    var isUKCompanyInvolved: String = "No" // Yes or No
    
    var isFriendlyOrHostile: String = "Friendly" // Friendly or Hostile
    
    var isDownwardRatingsLikely: String = "No" // Yes or No
    
    var isGovernmentAgency: String = "No" // Yes or No
    
    var isConsolidatedBankingOpportunity: String = "No" // Yes or No
    var consolidatedBankingOpportunityDescription: String = ""
    // required if isConsolidatedBankingOpportunity is Yes
    
    var isInvestmentOpportunity: String = "No" // Yes or No
    // required only if isInvestmentOpportunity
    var investmentOpportunityDescription: String = ""
    
    var isServicesOpportunity: String = "No" // Yes or No
    var servicesOpportunityDescription: String = ""
    
    var toIncludeCash: String = "No" // Yes or No
    
    var toIncludeStock: String = "No" // Yes or No
    
    var toIncludeOther: String = "No" // Yes or No
    // required only if toIncludeOther is Yes
    var pleaseExplain: String = ""
    
    var businessSelectionTypeForEither: String = ""
    
    var hasDerivativesExposure: String = "No" // Yes or No
    
    var hasCommoditiesExposure: String = "No" // Yes or No
    
    var hasWealthManagementOpportunity: String = "No" // Yes or No
    // required only if hasWealthManagementOpportunity is Yes
    var wealthManagementOpportunity: String = ""
    
    init(
        isDifferentCurrencies: String,
        
        isUKCompanyInvolved: String,
        
        isFriendlyOrHostile: String,
        
        isDownwardRatingsLikely: String,
        
        isGovernmentAgency: String,
        
        isConsolidatedBankingOpportunity: String,
        consolidatedBankingOpportunityDescription: String,
        
        isInvestmentOpportunity: String,
        investmentOpportunityDescription: String,
        
        isServicesOpportunity: String,
        servicesOpportunityDescription: String,
        
        toIncludeCash: String,
        
        toIncludeStock: String,
        
        toIncludeOther: String,
        pleaseExplain: String,
        
        businessSelectionTypeForEither:String,
        
        hasDerivativesExposure: String,
        
        hasCommoditiesExposure: String,
        
        hasWealthManagementOpportunity: String,
        wealthManagementOpportunity: String
        ){
            self.isDifferentCurrencies = isDifferentCurrencies
            
            self.isUKCompanyInvolved = isUKCompanyInvolved
            
            self.isFriendlyOrHostile = isFriendlyOrHostile
            
            self.isDownwardRatingsLikely = isDownwardRatingsLikely
            
            self.isGovernmentAgency = isGovernmentAgency
            
            self.isConsolidatedBankingOpportunity = isConsolidatedBankingOpportunity
            self.consolidatedBankingOpportunityDescription = consolidatedBankingOpportunityDescription
            
            self.isInvestmentOpportunity = isInvestmentOpportunity
            self.investmentOpportunityDescription = investmentOpportunityDescription
            
            self.isServicesOpportunity = isServicesOpportunity
            self.servicesOpportunityDescription = servicesOpportunityDescription
            
            self.toIncludeCash = toIncludeCash
            
            self.toIncludeStock = toIncludeStock
            
            self.toIncludeOther = toIncludeOther
            self.pleaseExplain = pleaseExplain
            self.businessSelectionTypeForEither = businessSelectionTypeForEither
            
            self.hasDerivativesExposure = hasDerivativesExposure
            
            self.hasCommoditiesExposure = hasCommoditiesExposure
            
            self.hasWealthManagementOpportunity = hasWealthManagementOpportunity
            self.wealthManagementOpportunity = wealthManagementOpportunity
    }
}
