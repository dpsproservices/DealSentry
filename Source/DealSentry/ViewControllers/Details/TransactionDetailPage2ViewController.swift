//
//  TransactionDetailPage2ViewController.swift
//

import UIKit

class TransactionDetailPage2ViewController: TransactionDetailPageViewController {
    
    var debugUtil = DebugUtility(thisClassName: "TransactionDetailPage2ViewController", enabled: false)
    var dealSizeWidget: DealSizeWidget!
    let viewStateManager = ViewStateManager.sharedInstance
  
    @IBOutlet weak var forwardImage: UIImageView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var widgetButton: UIButton!
    

    
    @IBOutlet weak var forwardImageCenterX: NSLayoutConstraint!
    @IBOutlet weak var backImageCenterX: NSLayoutConstraint!
    @IBAction func backButtonAction(sender: UIButton) {
        self.transactionDetailViewController.goToPage(1,whichWay: -1)
        NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: nil)

    }
    
    @IBAction func forwardButtonAction(sender: UIButton) {
        self.transactionDetailViewController.goToPage(3,whichWay: 1)
        NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: nil)

    }
    
    @IBOutlet weak var bankRoleTextField: UITextField!
    
    
    @IBOutlet weak var dealSizeTextField: UITextField!
    
    
    @IBOutlet weak var offeringFormatTextField: UITextField!
    var offeringFormatPicker: PopTextPicker?
    
    
    @IBOutlet weak var offeringFormatCommentsTextView: UITextView!
    
    
    @IBOutlet weak var useOfProceedsTextField: UITextField!
    var useOfProceedsPicker: PopTextPicker?
    
    
    @IBOutlet weak var useOfProceedsCommentsTextView: UITextView!
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }

    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue
        {
            if self.viewStateManager.checkForCollapseButton == "YES"
            {
                backImageCenterX.constant = -475.5
                forwardImageCenterX.constant = 475.5
            }
            else
            {
                backImageCenterX.constant = -325.5
                forwardImageCenterX.constant = 325.5
            }
          
        }
        else
        {
            if self.viewStateManager.checkForCollapseButton == "YES"
            {
                backImageCenterX.constant = -365.0
                forwardImageCenterX.constant = 365.0

            }
            else
            {
                backImageCenterX.constant = -215.0
                forwardImageCenterX.constant = 215.0
            }
            
        }
        
    }
    
     override func viewDidLoad() {
        self.debugUtil.printLog("viewDidLoad", msg: "BEGIN")
        
        super.viewDidLoad()
        super.pageNumber = 2
        
        self.bankRoleTextField.delegate = self
        self.appAttributes.setColorAttributesTF(bankRoleTextField)
        
        self.dealSizeTextField.delegate = self
        self.appAttributes.setColorAttributesTF(dealSizeTextField)
        
        
         self.appAttributes.setColorAttributesTF(offeringFormatTextField)
        var offeringFormat = self.viewStateManager.offeringFormatArray.map { (OfferingFormatData) -> String in
            return OfferingFormatData.offeringFormatDescription
        }
        
        offeringFormat = offeringFormat.sort({ $0 < $1 })
        
        self.offeringFormatPicker = PopTextPicker(forTextField: offeringFormatTextField, pickerItemsArray: offeringFormat)
        self.offeringFormatPicker?.delegate = self
        self.offeringFormatTextField.delegate = self

        
        self.offeringFormatCommentsTextView.delegate = self
        self.appAttributes.setColorAttributesTV(offeringFormatCommentsTextView)
        
        self.appAttributes.setColorAttributesTF(useOfProceedsTextField)
        
        
        var useOfProceeds = self.viewStateManager.useOfProceedsArray.map { (UseOfProceedsData) -> String in
            return UseOfProceedsData.useOfProceedsDescription
        }
        useOfProceeds = useOfProceeds.sort({ $0 < $1 })
        
        self.useOfProceedsPicker = PopTextPicker(forTextField: useOfProceedsTextField, pickerItemsArray: useOfProceeds)
        self.useOfProceedsPicker?.delegate = self
        self.useOfProceedsTextField.delegate = self
        
        self.useOfProceedsCommentsTextView.delegate = self
        self.appAttributes.setColorAttributesTV(useOfProceedsCommentsTextView)
        
        self.resetViewsFromModel()
        self.view.layer.backgroundColor = (appAttributes.colorBackgroundColor).CGColor
        self.view.layer.backgroundColor = (appAttributes.colorBackgroundColor).CGColor
        if let image = backImage.image {
            backImage.image = image.imageWithColor(UIColor(CGColor: appAttributes.colorBlue)).imageWithRenderingMode(.AlwaysOriginal)
        }
        if let image = forwardImage.image {
            forwardImage.image = image.imageWithColor(UIColor(CGColor: appAttributes.colorBlue)).imageWithRenderingMode(.AlwaysOriginal)
        }

       
        if viewStateManager.currentTransaction.transactionStatus != "Draft" && viewStateManager.currentTransaction.transactionStatus != "Pending Review" && viewStateManager.currentTransaction.transactionStatus != "Cleared" && viewStateManager.currentTransaction.transactionStatus != "Template"
        {
            self.bankRoleTextField.userInteractionEnabled = false
            self.bankRoleTextField.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.dealSizeTextField.userInteractionEnabled = false
            self.dealSizeTextField.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.offeringFormatTextField.userInteractionEnabled = false
            self.offeringFormatTextField.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.offeringFormatCommentsTextView.userInteractionEnabled = false
            self.offeringFormatCommentsTextView.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.useOfProceedsTextField.userInteractionEnabled = false
            self.useOfProceedsTextField.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.useOfProceedsCommentsTextView.userInteractionEnabled = false
            self.useOfProceedsCommentsTextView.backgroundColor = appAttributes.grayColorForClosedDeals
            widgetButton.userInteractionEnabled = false
        }
        
        self.debugUtil.printLog("viewDidLoad", msg: "END")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.debugUtil.printLog("prepareForSegue", msg: "BEGIN")
        let segueId = segue.identifier
        
        self.debugUtil.printLog("prepareForSegue", msg: "segueId = " + segueId!)
        if let segueId = segue.identifier {
            switch segueId {
                
            case "dealSizeWidget":
                dealSizeWidget =  segue.destinationViewController as! DealSizeWidget
                dealSizeWidget.transDetail2VC = self
                dealSizeWidget.dealSize = self.viewStateManager.currentTransaction.transactionDetail.dealSize
            default :
                break
            }
        }
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.viewStateManager.currentOrientation == "portrait"
        {
            backImageCenterX.constant = -215.0
            forwardImageCenterX.constant = 215.0

        }
        else
        {
            backImageCenterX.constant = -325.5
            forwardImageCenterX.constant = 325.5

        }
        

        self.resetViewsFromModel()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "methodOfReceivedNotification:", name:"NotificationIdentifier", object: nil)
        notificationCheck()
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "NotificationIdentifier", object: nil)
        
    }


    override func didReceiveMemoryWarning() {
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "BEGIN")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "END")
    }
    
    ///this method passses the data from object to the view controllers
    func resetViewsFromModel() {
        self.bankRoleTextField.text = self.viewStateManager.currentTransaction.transactionDetail.bankRole
        if self.viewStateManager.currentTransaction.transactionDetail.dealSize != "" {
            let origPrice = NSString(string: self.viewStateManager.currentTransaction.transactionDetail.dealSize).doubleValue
            
            //price is in millions (MILLIONS)
            //format to k or m or b
//            var unit = " MM"
//            if origPrice == 0 {
//                
//                unit = ""
//            } else if origPrice < 1 {
//                origPrice = origPrice * 1000
//                unit = " K"
//            } else if origPrice > 1000 {
//                origPrice = origPrice / 1000
//                unit = " B"
//            }
            
            let formatter = NSNumberFormatter()
            formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
            formatter.locale = NSLocale(localeIdentifier: "en_US")
            let price = formatter.stringFromNumber(origPrice)
            
            self.dealSizeTextField.text = price! /*+ unit*/
        }
        if(self.viewStateManager.checkForNewDraftOfferingFormat == "YES" && self.viewStateManager.currentTransaction.transactionId == "New" && self.viewStateManager.currentTransaction.transactionDetail.offeringFormat.isEmpty)
        {
            self.offeringFormatTextField.text = "N/A"
            self.viewStateManager.currentTransaction.transactionDetail.offeringFormat = self.offeringFormatTextField.text!

        }
        else
        {
            self.offeringFormatTextField.text = self.viewStateManager.currentTransaction.transactionDetail.offeringFormat
        }
        if (self.viewStateManager.currentTransaction.transactionDetail.offeringFormatComments == "") {
            self.offeringFormatCommentsTextView.text = "enter an Offering Comment"
            self.offeringFormatCommentsTextView.textColor = UIColor.lightGrayColor()
        } else {
            self.offeringFormatCommentsTextView.text = self.viewStateManager.currentTransaction.transactionDetail.offeringFormatComments
        }
        if(self.viewStateManager.checkForNewDraftUseOfProceeds == "YES" && self.viewStateManager.currentTransaction.transactionId == "New" && self.viewStateManager.currentTransaction.transactionDetail.useOfProceeds.isEmpty)
        {
            
            self.useOfProceedsTextField.text = "M&A/Strategic"
            self.viewStateManager.currentTransaction.transactionDetail.useOfProceeds = self.useOfProceedsTextField.text!
        }
        else
        {
            self.useOfProceedsTextField.text = self.viewStateManager.currentTransaction.transactionDetail.useOfProceeds
        }
        
        if (self.viewStateManager.currentTransaction.transactionDetail.useOfProceedsComments == "") {
            self.useOfProceedsCommentsTextView.text = "enter a Use of Proceeds Comment"
            self.useOfProceedsCommentsTextView.textColor = UIColor.lightGrayColor()
        } else {
            self.useOfProceedsCommentsTextView.text = self.viewStateManager.currentTransaction.transactionDetail.useOfProceedsComments
        }
    }
    
    func notificationCheck()
    {
        //Take Action on Notification
        if viewStateManager.checkForCollapseButton == "YES"
        {
            if self.viewStateManager.currentOrientation == "landscape"
            {
                backImageCenterX.constant = -475.5
                forwardImageCenterX.constant = 475.5

            }
            else
            {
                backImageCenterX.constant = -365.0
                forwardImageCenterX.constant = 365.0

            }
         
        }
        else
        {
            if self.viewStateManager.currentOrientation == "landscape"
            {
                backImageCenterX.constant = -325.5
                forwardImageCenterX.constant = 325.5
            }
            else
            {
                backImageCenterX.constant = -215.0
                forwardImageCenterX.constant = 215.0
            }
        }
    }
    
    func methodOfReceivedNotification(notification: NSNotification){
        notificationCheck()
    }


}

extension TransactionDetailPage2ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    }
    func textFieldDidChange(textField: UITextField) {
        
        switch textField {
        case bankRoleTextField:
            self.viewStateManager.currentTransaction.transactionDetail.bankRole = bankRoleTextField.text!
        case dealSizeTextField:
            let aString: String = dealSizeTextField.text!
            var newString = aString.stringByReplacingOccurrencesOfString("M", withString: "")
            newString = newString.stringByReplacingOccurrencesOfString("m", withString: "")
            newString = newString.stringByReplacingOccurrencesOfString("K", withString: "")
            newString = newString.stringByReplacingOccurrencesOfString("k", withString: "")
            newString = newString.stringByReplacingOccurrencesOfString("B", withString: "")
            newString = newString.stringByReplacingOccurrencesOfString("b", withString: "")
            
            newString = newString.stringByReplacingOccurrencesOfString("$", withString: "")
            newString = newString.stringByReplacingOccurrencesOfString(",", withString: "")
            self.viewStateManager.currentTransaction.transactionDetail.dealSize = newString
        case useOfProceedsTextField:
            self.viewStateManager.currentTransaction.transactionDetail.useOfProceeds = useOfProceedsTextField.text!
        default:
            break
            
        }
    }
    
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if (textField === offeringFormatTextField) {
            
            self.viewStateManager.checkForNewDraftOfferingFormat = "NO"
            self.offeringFormatTextField.resignFirstResponder()
            
            let initText: String? = offeringFormatTextField.text
            
            self.offeringFormatPicker!.setSelection(initText!)
            
            let dataChangedCallback: PopTextPicker.PopTextPickerCallback = { (newText: String, forTextField: UITextField) -> () in
                // here we don't use self (no retain cycle)
                forTextField.text = newText as String
            }
            
            self.offeringFormatPicker!.pick(self, dataChanged: dataChangedCallback)
            
            return false
            
        } else if (textField === useOfProceedsTextField) {
            
            self.viewStateManager.checkForNewDraftUseOfProceeds = "NO"

            self.useOfProceedsTextField.resignFirstResponder()
            
            let initText: String? = useOfProceedsTextField.text
            
            self.useOfProceedsPicker!.setSelection(initText!)
            
            let dataChangedCallback: PopTextPicker.PopTextPickerCallback = { (newText: String, forTextField: UITextField) -> () in
                // here we don't use self (no retain cycle)
                forTextField.text = newText as String
            }
            
            self.useOfProceedsPicker!.pick(self, dataChanged: dataChangedCallback)
            
            return false
            
            
        } else {
            return true
        }
    }
    
}
extension TransactionDetailPage2ViewController: PopTextPickerDelegate {
    func textDelegateCallBack(textField: UITextField) {
        
        switch textField {
        case offeringFormatTextField:
            self.viewStateManager.currentTransaction.transactionDetail.offeringFormat = offeringFormatTextField.text!
        case useOfProceedsTextField:
            self.viewStateManager.currentTransaction.transactionDetail.useOfProceeds = useOfProceedsTextField.text!
        default:
            break
            
        }

    }
}
extension TransactionDetailPage2ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(textView: UITextView) {
        if (textView.textColor != nil && textView.textColor == UIColor.lightGrayColor()) {
            textView.text = nil
            textView.textColor =  UIColor.blackColor()
        }
    }
    
    
    func textViewDidChange(textView: UITextView) {
        switch textView {
        case offeringFormatCommentsTextView:
            self.viewStateManager.currentTransaction.transactionDetail.offeringFormatComments = offeringFormatCommentsTextView.text
        case useOfProceedsCommentsTextView:
            self.viewStateManager.currentTransaction.transactionDetail.useOfProceedsComments = useOfProceedsCommentsTextView.text
        default:
            break
        }
    }
}
