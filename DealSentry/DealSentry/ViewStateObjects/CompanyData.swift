//
//  CompanyData.swift
//


import Foundation


@objc class CompanyData: NSObject {
    var companyId: String = ""
    var companyName: String = ""
    var ticker: String = ""
    var country: String = ""
    var gfcid: String = ""
    var level: String = ""
    var exchange: String = ""
    var marketSegment: String = ""
    var franchiseIndustry: String = ""
    var parentCompany: String = ""
    var countryFlag: String = ""
    
    init(
        companyId: String,
        companyName: String,
        ticker: String,
        country: String,
        gfcid: String,
        level: String,
        exchange: String,
        marketSegment: String,
        franchiseIndustry: String,
        parentCompany: String,
        countryFlag: String
        ){
            self.companyId = companyId
            self.companyName = companyName
            self.ticker = ticker
            self.country = country
            self.gfcid = gfcid
            self.level = level
            self.exchange = exchange
            self.marketSegment = marketSegment
            self.franchiseIndustry = franchiseIndustry
            self.parentCompany = parentCompany
            self.countryFlag = countryFlag
    }
    
    func toString() -> String {
        return self.companyId +
            self.companyName +
            self.ticker +
            self.country +
            self.gfcid +
            self.level +
            self.exchange +
            self.marketSegment +
            self.franchiseIndustry +
            self.parentCompany    }
}