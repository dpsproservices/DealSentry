//
// PickerSelection.swift
//

import Foundation

public class PickerSelection: NSObject {
    
    var index: Int = 0
    var value: String = ""
    
    init(
        index: Int,
        value: String
    ){
        self.index = index
        self.value = value
    }
}