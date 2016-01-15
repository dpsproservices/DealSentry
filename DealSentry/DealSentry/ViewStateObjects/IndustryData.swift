//
//  IndustryData.swift
//

import Foundation

@objc class IndustryData: NSObject {
    
    var id: String = ""
    var name: String = ""
    var industryDescription: String = ""
    
    init(id: String,
        name: String,
        industryDescription: String
        
        ){
            self.id = id
            self.name = name
            self.industryDescription = industryDescription
    }
}
