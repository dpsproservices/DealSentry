//
//  TransactionSummaryModel.swift
//

import Foundation

class TransactionSummary: NSObject {
    var label: String = ""
    var value: String = ""
    var error: Bool = false
    var errorText: String = ""
    var specialRow: Int = 1
    var errorType: Int = 0
    var companyIndex: Int = 0
    var agreementIndex: Int = 0
    var errorRowIndex: Int = -1
    init(
        label: String,
        value: String,
        error: Bool,
        errorText: String,
        specialRow: Int
        ){
            self.label = label
            self.value = value
            self.error = error
            self.errorText = errorText
            self.specialRow = specialRow
        }
    init(
        label: String,
        value: String,
        error: Bool,
        errorText: String,
        specialRow: Int,
        errorType: Int,
        errorRowIndex: Int
        ){
            self.label = label
            self.value = value
            self.error = error
            self.errorText = errorText
            self.specialRow = specialRow
            self.errorType = errorType
            self.errorRowIndex = errorRowIndex
    }

    init(
        label: String,
        value: String,
        error: Bool,
        errorText: String,
        specialRow: Int,
        errorType: Int,
        errorRowIndex: Int,
        companyIndex: Int,
        agreementIndex: Int
        ){
            self.label = label
            self.value = value
            self.error = error
            self.errorText = errorText
            self.specialRow = specialRow
            self.errorType = errorType
            self.errorRowIndex = errorRowIndex
            self.companyIndex = companyIndex
            self.agreementIndex = agreementIndex
    }
   
}
