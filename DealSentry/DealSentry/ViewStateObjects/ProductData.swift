//
//  ProductData.swift
//

import Foundation

@objc class ProductData: NSObject {
    
    var productId: String = ""
    var productDescription: String = ""
    
    init(
        productId: String,
        productDescription: String
        
        ){
            self.productId = productId
            self.productDescription = productDescription
            
    }
}