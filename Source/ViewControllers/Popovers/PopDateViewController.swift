//
//  DatePickerActionSheet.swift
//  iDoctors
//
//  Created by Valerio Ferrucci on 30/09/14.
//  Copyright (c) 2014 Tabasoft. All rights reserved.
//

import UIKit

protocol DataPickerViewControllerDelegate : class {
    
    func datePickerVCDismissed(date : NSDate?)
}

class PopDateViewController : UIViewController {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    weak var delegate : DataPickerViewControllerDelegate?
    var appAttributes = AppAttributes()
    var currentDate : NSDate? {
        didSet {
            updatePickerCurrentDate()
        }
    }

    convenience init() {

        self.init(nibName: "PopDateViewController", bundle: nil)
    }

    private func updatePickerCurrentDate() {
        if self.currentDate == nil {
            self.currentDate = NSDate()
        }
        if let _currentDate = self.currentDate {
            
            if let _datePicker = self.datePicker {
                _datePicker.date = _currentDate
            }
        }
    }

    @IBAction func okAction(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true) {
            
            let nsdate = self.datePicker.date
            self.delegate?.datePickerVCDismissed(nsdate)
            
        }
    }
    
    override func viewDidLoad() {
        
        updatePickerCurrentDate()
        //treat picker with styles
        datePicker.layer.borderWidth = appAttributes.pickerBorder
        datePicker.layer.borderColor = appAttributes.pickerBorderColor
        datePicker.layer.cornerRadius = appAttributes.pickerCornerRadius
        datePicker.backgroundColor = appAttributes.pickerBackgroundColor
   }
    
    override func viewDidDisappear(animated: Bool) {
        
        self.delegate?.datePickerVCDismissed(nil)
    }
}
