//
//  CountryData.swift
//

import Foundation

@objc class CountryData: NSObject {
    
    //var id: String = ""
    var countryCode = ""
    var countryName: String = ""
    var countryDescription: String = ""
    var countryFlag: String = ""
    
    
    init(
        //id: String,
        countryCode: String,
        countryName: String,
        countryDescription: String,
        countryFlag: String
        
        
        ){
            //self.id = id
            self.countryCode = countryCode
            self.countryName = countryName
            self.countryDescription = countryDescription
            self.countryFlag = countryFlag
    }
}