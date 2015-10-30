//
// PopTextPicker.swift
//

import UIKit
protocol PopTextPickerDelegate: class {
    func textDelegateCallBack(textField: UITextField)
}

public class PopTextPicker:
    NSObject,
    UIPopoverPresentationControllerDelegate,
    TextPickerViewControllerDelegate {
    
    public typealias PopTextPickerCallback = ( newText : String, forTextField : UITextField )->()
    
    var textPickerVC: PopTextViewController
    var popover: UIPopoverPresentationController?
    var textField: UITextField!
    var dataChanged: PopTextPickerCallback?
    var presented = false
    var offset: CGFloat = 8.0
    
    weak var delegate: PopTextPickerDelegate?
    
    
    public init(forTextField: UITextField, pickerItemsArray: [String]) {
        
        textPickerVC = PopTextViewController()
        self.textField = forTextField
        self.textPickerVC.pickerItemsArray = pickerItemsArray
        self.textPickerVC.reset()
        super.init()
    }
    
    public func pick(inViewController: UIViewController, dataChanged: PopTextPickerCallback) {
        
        if presented {
            return  // we are busy
        }
        
        self.textPickerVC.delegate = self
        self.textPickerVC.modalPresentationStyle = UIModalPresentationStyle.Popover
        self.textPickerVC.preferredContentSize = CGSizeMake(320,200)
        //self.textPickerVC.currentSelection = pickerSelection
        
        self.popover = textPickerVC.popoverPresentationController
        if let _popover = popover {
            
            _popover.sourceView = textField
            _popover.sourceRect = CGRectMake(self.offset,textField.bounds.size.height,0,0)
            _popover.delegate = self
            self.dataChanged = dataChanged
            inViewController.presentViewController(textPickerVC, animated: true, completion: nil)
            presented = true
        }
    }
    
    
    public func setSelection(selectedValue: String) {
    
        return self.textPickerVC.setSelection(selectedValue)
    
    }
    
    public func adaptivePresentationStyleForPresentationController(PC: UIPresentationController) -> UIModalPresentationStyle {
        
        return .None
    }
    
    func textPickerVCDismissed(newText: String?) {
        
        if let _dataChanged = dataChanged {
            
            if let _newText = newText {
            
                _dataChanged(newText: _newText, forTextField: textField)
                
            }
        }
        presented = false
        self.delegate?.textDelegateCallBack(textField)
    }
    }
