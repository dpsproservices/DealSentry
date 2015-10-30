//
//  ProductSubData.swift
//

import Foundation

class ProductSubData: NSObject {
    
    var productSubId: String = ""
    var productSubDescription: String = ""
    
    init(
        productSubId: String,
        productSubDescription: String
        
        ){
            self.productSubId = productSubId
            self.productSubDescription = productSubDescription
            
    }
}