//
//  ContactData.swift
//

import Foundation

@objc class ContactData: NSObject {
    
    var firstName:String = ""
    var lastName:String = ""
    var gocDescription:String = ""
    var soeID:String = ""
    var phone:String = ""
    var email:String = ""
    var crossSellDesignee:Bool = false
    var contacts: [ContactData] = []
    var hasContacts:Bool = false
    
    init(firstName: String,
        lastName: String,
        gocDescription: String,
        soeID: String,
        phone: String,
        email: String,
        crossSellDesignee: Bool
        ){
            
            self.firstName = firstName
            self.lastName = lastName
            self.gocDescription = gocDescription
            self.soeID = soeID
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
            self.gocDescription +
            self.soeID +
            self.email +
            self.phone
    }
}

