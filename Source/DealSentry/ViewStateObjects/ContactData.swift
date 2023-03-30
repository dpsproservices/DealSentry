//
//  ContactData.swift
//

import Foundation

@objc class ContactData: NSObject {
    
    var firstName:String = ""
    var lastName:String = ""
    var department:String = ""
    var employeeId:String = ""
    var phone:String = ""
    var email:String = ""
    var crossSellDesignee:Bool = false
    var contacts: [ContactData] = []
    var hasContacts:Bool = false
    
    init(firstName: String,
        lastName: String,
        department: String,
        employeeId: String,
        phone: String,
        email: String,
        crossSellDesignee: Bool
        ){
            
            self.firstName = firstName
            self.lastName = lastName
            self.department = department
            self.employeeId = employeeId
            self.phone = phone
            self.email = email
            self.crossSellDesignee = crossSellDesignee
    }
    

    
    func addContact(contact: ContactData) {
        self.contacts.append(contact)
        self.hasContacts = true
    }
    func addContacts(contacts: [ContactData]) {
        
        self.contacts.appendContentsOf(contacts)
        
        self.hasContacts = true
    }
    
    
    
    func toString() -> String {
        return self.firstName +
            self.lastName +
            self.department +
            self.employeeId +
            self.email +
            self.phone
    }
}

