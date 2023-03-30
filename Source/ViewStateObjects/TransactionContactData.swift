//
//  TransactionContactData.swift
//


import Foundation

@objc class TransactionContactData: NSObject {
    var contact: ContactData
    var role: String = ""
    var currentTransactionContactIndex:Int = 0
    
    init(
        contact: ContactData,
        role: String
        ){
            self.contact = contact
            self.role = role
    }
}
