//
//  DealStatusData.swift
//

import Foundation

class DealStatusData: NSObject {
    
    var dealStatusId: String = ""
    var dealStatusDescription: String = ""
    
    init(
        dealStatusId: String,
        dealStatusDescription: String
        
        ){
            self.dealStatusId = dealStatusId
            self.dealStatusDescription = dealStatusDescription
            
    }
}