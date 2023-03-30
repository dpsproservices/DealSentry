//
// PopTextViewController.swift
//

import UIKit

protocol TextPickerViewControllerDelegate: class {
    func textPickerVCDismissed(newText: String?)
 
}


class PopTextViewController: UIViewController {
    
    @IBOutlet weak var picker: UIPickerView!
    var appAttributes = AppAttributes()
    var pickerItemsArray = [String]()

    weak var delegate: TextPickerViewControllerDelegate?

    var currentSelection: PickerSelection? {
        didSet {
            updatePickerCurrentSelection()
        }
    }

    convenience init() {

        self.init(nibName: "PopTextViewController", bundle: nil)
    }

    private func updatePickerCurrentSelection() {
        
//        if let _ = self.currentSelection {
//            if let _picker = self.picker {
//                
//                var test = 0
//                //_picker.selectRow(self.currentSelection!.index, inComponent: 0, animated: true)
//            }
//        }
    }

    @IBAction func okAction(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true) {
            
            //let selectedIndex = self.picker.selectedRowInComponent(0)
            
            
            //let newText = self.pickerItemsArray[selectedIndex]
            
            let newText = self.currentSelection!.value
            
            
            self.delegate?.textPickerVCDismissed(newText)
                 }
    }
    
    func reset(){
    
        self.currentSelection = PickerSelection(index: 0, value: self.pickerItemsArray[0])
        
    }
    
    //set the current
    func setSelection(selectedValue: String)  {
        
        //var selectedIndex = self.picker.selectedRowInComponent(0)
        
        //var selectedValue = self.pickerItemsArray[selectedIndex]
        
        var selectedIndex = 0
        for stringValue in self.pickerItemsArray {
        
            if ( stringValue == selectedValue ) {
                self.currentSelection = PickerSelection(index: selectedIndex, value: selectedValue)
            } else {
                selectedIndex++
            }
        }
        
        self.currentSelection = PickerSelection(index: 0, value: self.pickerItemsArray[0])
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Connect data
        self.picker.dataSource = self;
        self.picker.delegate = self;
        
        //var test = 0
        
        //treat picker with styles
        picker.layer.borderWidth = appAttributes.pickerBorder
        picker.layer.borderColor = appAttributes.pickerBorderColor
        picker.layer.cornerRadius = appAttributes.pickerCornerRadius
        picker.backgroundColor = appAttributes.pickerBackgroundColor
        
        //updatePickerCurrentSelection()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.delegate?.textPickerVCDismissed(nil)
    }
}

extension PopTextViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerItemsArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerItemsArray[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currentSelection = PickerSelection(index: row, value: self.pickerItemsArray[row])
    }
    
}
