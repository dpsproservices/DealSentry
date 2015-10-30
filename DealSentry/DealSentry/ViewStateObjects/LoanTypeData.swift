//
//  LoanTypeData.swift
//

import Foundation



class LoanTypeData: NSObject {
    
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