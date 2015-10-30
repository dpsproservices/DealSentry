//
//  ProductMapData.swift
//


import Foundation

class ProductMapData: NSObject {
    
    var product: String = ""
    var productSub: String = ""
    var productDescription: String = ""
    var productSubDescription: String = ""
    
    init(
        product: String,
        productSub: String,
        productDescription: String,
        productSubDescription: String
        ){
            self.product = product
            self.productSub = productSub
            self.productDescription = productDescription
            self.productSubDescription = productSubDescription
    }
}
