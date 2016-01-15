//
//  LoanTypeData.swift
//

import Foundation

@objc class LoanTypeData: NSObject {
    
    var loanTypeId: String = ""
    var loanTypeDescription: String = ""
    
    init(
        loanTypeId: String,
        loanTypeDescription: String
        
        ){
            self.loanTypeId = loanTypeId
            self.loanTypeDescription = loanTypeDescription
            
    }
}