//
//  TransactionStatusData.swift
//

import Foundation

class TransactionStatusData: NSObject {
    
    var transactionStatusId: String = ""
    var transactionStatusDescription: String = ""
    
    init(
        transactionStatusId: String,
        transactionStatusDescription: String
        
        ){
            self.transactionStatusId = transactionStatusId
            self.transactionStatusDescription = transactionStatusDescription
            
    }
}
