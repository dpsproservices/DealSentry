//
//  SegmentsData.swift
//

import Foundation

@objc class SegmentsData: NSObject {
    
    var id: String = ""
    var name: String = ""
    var segmentDescription: String = ""
    
    init(id: String,
        name: String,
        segmentDescription: String
        
        ){
            self.id = id
            self.name = name
            self.segmentDescription = segmentDescription
    }
}