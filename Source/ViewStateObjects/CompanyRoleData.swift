//
//  CompanyRoleData.swift
//

import Foundation

@objc class CompanyRoleData: NSObject {
    
    var roleId: String = ""
    var roleDescription: String = ""
    
    init(
        roleId: String,
        roleDescription: String
        
        ){
            self.roleId = roleId
            self.roleDescription = roleDescription
            
    }
}