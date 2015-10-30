//
//  SliderController.swift
//  DealSentry
//
//  Created by Skarulis, Joseph    on 8/25/15.
//  Copyright © 2015 Skarulis, Joseph   . All rights reserved.
//

import UIKit
import WebKit
class SliderController: UIViewController
{
    
    let sharedDataModel = SharedDataModel.sharedInstance
    var materialityPage1Controller: MaterialityPage1ViewController!
    @IBOutlet weak var percentSlider: UISlider!
    @IBOutlet weak var percentMinusButton: UIButton!
    @IBOutlet weak var percentPlusButton: UIButton!
    
    
    @IBAction func percentSliderValueChangedAction(sender: UISlider) {
        var newMat : MaterialityData
        materialityPage1Controller.percentTextField.text = NSString(format: "%.1f", sender.value) as String + "%"
        
        materialityPage1Controller.selectedCompany.materiality.percentOwned = NSString(format: "%.1f", sender.value) as String
        
        newMat = materialityPage1Controller.selectedCompany.materiality
        self.sharedDataModel.currentTransaction.transactionCompanies[self.sharedDataModel.currentTransaction.currentTransactionCompanyIndex].materiality = newMat
        materialityPage1Controller.percentOwnedImgWarning.hidden = true
        materialityPage1Controller.percentOwnedTxtWarning.hidden = true
    }
    
    @IBAction func percentPlusRepeatAction(sender: UIButton) {
        var doubleValue : Double = NSString(string: materialityPage1Controller.percentTextField.text!).doubleValue
        doubleValue = doubleValue + 0.1
        if doubleValue > 100 {
            doubleValue = 100
        }
        materialityPage1Controller.percentTextField.text = String(stringInterpolationSegment: doubleValue) + "%"
        self.percentSlider.value = Float(doubleValue)
        var newMat : MaterialityData
        
        materialityPage1Controller.selectedCompany.materiality.percentOwned = String(stringInterpolationSegment: doubleValue)
        
        newMat = materialityPage1Controller.selectedCompany.materiality
        self.sharedDataModel.currentTransaction.transactionCompanies[self.sharedDataModel.currentTransaction.currentTransactionCompanyIndex].materiality = newMat
        materialityPage1Controller.percentOwnedImgWarning.hidden = true
        materialityPage1Controller.percentOwnedTxtWarning.hidden = true
        
    }
    @IBAction func percentMinusRepeatAction(sender: UIButton) {
        var doubleValue : Double = NSString(string: materialityPage1Controller.percentTextField.text!).doubleValue
        doubleValue = doubleValue - 0.1
        if doubleValue < 0 {
            doubleValue = 0.0
        }
        
        materialityPage1Controller.percentTextField.text = String(stringInterpolationSegment: doubleValue) + "%"
        self.percentSlider.value = Float(doubleValue)
        var newMat : MaterialityData
        
        materialityPage1Controller.selectedCompany.materiality.percentOwned = String(stringInterpolationSegment: doubleValue)
        
        newMat = materialityPage1Controller.selectedCompany.materiality
        self.sharedDataModel.currentTransaction.transactionCompanies[self.sharedDataModel.currentTransaction.currentTransactionCompanyIndex].materiality = newMat
        
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if materialityPage1Controller.selectedCompany.materiality.percentOwned != "" {
            let numberFormatter = NSNumberFormatter()
            let number = numberFormatter.numberFromString(materialityPage1Controller.selectedCompany.materiality.percentOwned)
            self.percentSlider.value = number!.floatValue
        } else {
            self.percentSlider.value = 0
        }
        
     
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

