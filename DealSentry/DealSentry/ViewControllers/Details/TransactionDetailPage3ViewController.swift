//
//  TransactionDetailPage3ViewController.swift
//

import UIKit

class TransactionDetailPage3ViewController: TransactionDetailPageViewController {
    
    var debugUtil = DebugUtility(thisClassName: "TransactionDetailPage3ViewController", enabled: false)
    let sharedDataModel = SharedDataModel.sharedInstance
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var forwardImage: UIImageView!
    var embeddedDateController: DateCalendar!
    @IBOutlet weak var calendarImageForPitchDate: UIButton!
    @IBOutlet weak var calendarImageForAnnouncementDate: UIButton!
    @IBOutlet weak var calendarImageForClosingDate: UIButton!
    @IBOutlet weak var invisibleButtonForPopover: UIButton!
    

    @IBOutlet weak var forwardImageCenterX: NSLayoutConstraint!
    @IBOutlet weak var backImageCenterX: NSLayoutConstraint!
    
    @IBAction func backButtonAction(sender: UIButton) {
        self.transactionDetailViewController.goToPage(2,whichWay: -1)
        NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: nil)

    }
    
    @IBAction func forwardButtonAction(sender: UIButton) {
        self.transactionDetailViewController.goToPage(4,whichWay: 1)
        NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: nil)

    }
    
   
    
    
    @IBOutlet weak var loanTypeTextField: UITextField!
    
    var loanTypePicker: PopTextPicker?
    
    
    @IBOutlet weak var confidentialitySegmentedControl: UISegmentedControl!
    
    
    @IBAction func confidentialityValueChanged(sender: UISegmentedControl) {
        
        if  self.confidentialitySegmentedControl.selectedSegmentIndex == 1 {
            
            self.sharedDataModel.currentTransaction.transactionDetail.isConfidential = "Confidential"
            
        } else {
            self.sharedDataModel.currentTransaction.transactionDetail.isConfidential = "Public"
            
        }
    }
    
    @IBOutlet weak var estimatedPitchDateTextField: UITextField!
    var estimatedPitchDatePicker: PopDatePicker?
    
    @IBOutlet weak var estimatedPitchDateLabelCentreY: NSLayoutConstraint!
    @IBOutlet weak var announcementErrorImgCenterY: NSLayoutConstraint!
    
    @IBOutlet weak var invisibleButtonCenterYConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var invisibleButtonCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var calendarImageForPitchDateYConstraint: NSLayoutConstraint!
    @IBOutlet weak var calendarImageForPitchDateXConstraint: NSLayoutConstraint!
    @IBOutlet weak var pitchTxtCenterY: NSLayoutConstraint!
    @IBOutlet weak var estimatedAnnouncementDateLabelCenterY: NSLayoutConstraint!
    @IBOutlet weak var pitchErrorImgCenterY: NSLayoutConstraint!
    
    @IBOutlet weak var estimatedClosingDateTextCenterY: NSLayoutConstraint!
    @IBOutlet weak var estimatedAnnouncementTextCenterY: NSLayoutConstraint!
    @IBOutlet weak var estimatedPitchDateTextCenterY: NSLayoutConstraint!
    @IBOutlet weak var estimatedPitchTextCenterX: NSLayoutConstraint!
    @IBOutlet weak var estiamtedAnnouncementTextX: NSLayoutConstraint!
    @IBOutlet weak var estimatedClosingTextX: NSLayoutConstraint!
    @IBOutlet weak var calendarImageAnnouncementX: NSLayoutConstraint!
    @IBOutlet weak var calendarImageClosingDateX: NSLayoutConstraint!
    
    @IBOutlet weak var estimatedClosingDateLabelCenterY: NSLayoutConstraint!
    @IBOutlet weak var announcementTextCenterY: NSLayoutConstraint!
    @IBOutlet weak var announcementDateTextField: UITextField!
    var announcementDatePicker: PopDatePicker?
    
    
    @IBOutlet weak var estimatedPitchDateLabel: UILabel!
    @IBOutlet weak var estimatedAnnouncementDateLabel: UILabel!
    @IBOutlet weak var estimatedClosingDateLabel: UILabel!

    @IBOutlet weak var calendarImageForAnnouncementDateCenterY: NSLayoutConstraint!
    
    @IBOutlet weak var calendarImageForClosingDateCenterY: NSLayoutConstraint!
    @IBOutlet weak var announcementDateImgWarning: UIImageView!
    @IBOutlet weak var announcementDateTxtWarning: UILabel!
    
    @IBOutlet weak var pitchDateImgWarning: UIImageView!
    @IBOutlet weak var pitchDateTxtWarning: UILabel!
    @IBOutlet weak var closingDateTextField: UITextField!
    var closingDatePicker: PopDatePicker?
    
    ///this method is invoked only when user wants to choose date. calendar popover come once the user taps the calendar icon.
    /// - invisibleButtonForPopover: this button is invisible and perform a segue based on the selection from pitch or announcement or closing date field
    /// - Parameter sender: this paramater ensures that this method will be invoked only using button
    @IBAction func calendarButtonAction(sender: UIButton) {
        if(sender.tag == 221)
        {
            self.sharedDataModel.selectedButtonTextForDate = "PitchDate"
            invisibleButtonForPopover.frame = CGRectMake(sender.frame.origin.x + (sender.frame.size.width/2), (sender.frame.origin.y - 2), invisibleButtonForPopover.frame.size.width, invisibleButtonForPopover.frame.size.height)
            invisibleButtonCenterYConstraint.constant = calendarImageForPitchDateYConstraint.constant - 15.0
            invisibleButtonCenterXConstraint.constant = calendarImageForPitchDateXConstraint.constant

        }
        else if(sender.tag == 222)
        {
            self.sharedDataModel.selectedButtonTextForDate = "AnnouncementDate"
            invisibleButtonForPopover.frame = CGRectMake(sender.frame.origin.x + (sender.frame.size.width/2), (sender.frame.origin.y - 2), invisibleButtonForPopover.frame.size.width, invisibleButtonForPopover.frame.size.height)
            invisibleButtonCenterYConstraint.constant = calendarImageForAnnouncementDateCenterY.constant - 15.0
            invisibleButtonCenterXConstraint.constant = calendarImageAnnouncementX.constant
        }
        else if(sender.tag == 223)
        {
            self.sharedDataModel.selectedButtonTextForDate = "ClosingDate"
            invisibleButtonForPopover.frame = CGRectMake(sender.frame.origin.x + (sender.frame.size.width/2), (sender.frame.origin.y - 2), invisibleButtonForPopover.frame.size.width, invisibleButtonForPopover.frame.size.height)
            invisibleButtonCenterYConstraint.constant = calendarImageForClosingDateCenterY.constant - 15.0
            invisibleButtonCenterXConstraint.constant = calendarImageClosingDateX.constant
        }
        else
        {
            self.sharedDataModel.selectedButtonTextForDate = "PitchDate"
            invisibleButtonCenterYConstraint.constant = calendarImageForPitchDateYConstraint.constant - 15.0
            invisibleButtonCenterXConstraint.constant = calendarImageForPitchDateXConstraint.constant
        }
        self.performSegueWithIdentifier("dateCalendar", sender: sender)
    }
    
    ///this method is invoked only when user wants to choose date. calendar popover come once the user taps the respective text field.
    /// - Parameter sender: this paramater ensures that this method will be invoked only using UITextField
    @IBAction func launchDateCalendar(sender: UITextField) {
        if(sender.tag == 111)
        {
            self.sharedDataModel.selectedButtonTextForDate = "PitchDate"
            invisibleButtonForPopover.frame = CGRectMake(sender.frame.origin.x + (sender.frame.size.width/2), (sender.frame.origin.y - 2), invisibleButtonForPopover.frame.size.width, invisibleButtonForPopover.frame.size.height)
            invisibleButtonCenterYConstraint.constant = estimatedPitchDateTextCenterY.constant - 15.0
            invisibleButtonCenterXConstraint.constant = estimatedPitchTextCenterX.constant
        }
        else if(sender.tag == 112)
        {
            self.sharedDataModel.selectedButtonTextForDate = "AnnouncementDate"
            invisibleButtonForPopover.frame = CGRectMake(sender.frame.origin.x + (sender.frame.size.width/2), (sender.frame.origin.y - 2), invisibleButtonForPopover.frame.size.width, invisibleButtonForPopover.frame.size.height)
            invisibleButtonCenterYConstraint.constant = estimatedAnnouncementTextCenterY.constant - 15.0
            invisibleButtonCenterXConstraint.constant = estiamtedAnnouncementTextX.constant
        }
        else if(sender.tag == 113)
        {
            self.sharedDataModel.selectedButtonTextForDate = "ClosingDate"
            invisibleButtonForPopover.frame = CGRectMake(sender.frame.origin.x + (sender.frame.size.width/2), (sender.frame.origin.y - 2), invisibleButtonForPopover.frame.size.width, invisibleButtonForPopover.frame.size.height)
            invisibleButtonCenterYConstraint.constant = estimatedClosingDateTextCenterY.constant - 15.0
            invisibleButtonCenterXConstraint.constant = estimatedClosingTextX.constant
        }
        else
        {
            self.sharedDataModel.selectedButtonTextForDate = "PitchDate"
        }
        self.performSegueWithIdentifier("dateCalendar", sender: sender)
    }

    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue
        {
            if self.sharedDataModel.checkForCollapseButton == "YES"
            {
                backImageCenterX.constant = -477.5
                forwardImageCenterX.constant = 475.5
            }
            else
            {
                backImageCenterX.constant = -327.5
                forwardImageCenterX.constant = 325.5
            }
         
        }
        else
        {
            if self.sharedDataModel.checkForCollapseButton == "YES"
            {
                backImageCenterX.constant = -367.0
                forwardImageCenterX.constant = 365.0
                
            }
            else
            {
                backImageCenterX.constant = -217.0
                forwardImageCenterX.constant = 215.0
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        self.debugUtil.printLog("viewDidLoad", msg: "BEGIN")
        
        super.viewDidLoad()
        super.pageNumber=3
        
        var loanType = self.sharedDataModel.loanTypesArray.map { (LoanTypeData) -> String in
            return LoanTypeData.loanTypeDescription
        }
        
        loanType = loanType.sort({ $0 < $1 })
        
        self.loanTypePicker = PopTextPicker(forTextField: loanTypeTextField, pickerItemsArray: loanType)
        self.loanTypePicker?.delegate = self
        self.loanTypeTextField.delegate = self
        self.appAttributes.setColorAttributesTF(loanTypeTextField)
        
//        self.estimatedPitchDatePicker = PopDatePicker(forTextField: estimatedPitchDateTextField)
//        self.estimatedPitchDatePicker?.delegate = self
        self.estimatedPitchDateTextField.delegate = self
        self.appAttributes.setColorAttributesTF(estimatedPitchDateTextField)
        //self.appAttributes.setColorAttributesButton(calendarImageForPitchDate)
        
//        self.announcementDatePicker = PopDatePicker(forTextField: announcementDateTextField)
//        self.announcementDatePicker?.delegate = self
        self.announcementDateTextField.delegate = self
        self.appAttributes.setColorAttributesTF(announcementDateTextField)
        
//        self.closingDatePicker = PopDatePicker(forTextField: closingDateTextField)
//        self.closingDatePicker?.delegate = self
        self.closingDateTextField.delegate = self
        self.appAttributes.setColorAttributesTF(closingDateTextField)
        self.view.layer.backgroundColor = (appAttributes.colorBackgroundColor).CGColor
        appAttributes.setColorAttributesSegmentControl(confidentialitySegmentedControl)
        if let image = backImage.image {
            backImage.image = image.imageWithColor(UIColor(CGColor: appAttributes.colorBlue)).imageWithRenderingMode(.AlwaysOriginal)
        }
        if let image = forwardImage.image {
            forwardImage.image = image.imageWithColor(UIColor(CGColor: appAttributes.colorBlue)).imageWithRenderingMode(.AlwaysOriginal)
        }
        
        
       if sharedDataModel.currentTransaction.transactionStatus != "Draft" && sharedDataModel.currentTransaction.transactionStatus != "Pending Review" && sharedDataModel.currentTransaction.transactionStatus != "Cleared" && sharedDataModel.currentTransaction.transactionStatus != "Template"
        {
            self.loanTypeTextField.userInteractionEnabled = false
            self.loanTypeTextField.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.confidentialitySegmentedControl.userInteractionEnabled = false
            self.confidentialitySegmentedControl.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.estimatedPitchDateTextField.userInteractionEnabled = false
            self.estimatedPitchDateTextField.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.announcementDateTextField.userInteractionEnabled = false
            self.announcementDateTextField.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.closingDateTextField.userInteractionEnabled = false
            self.closingDateTextField.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.calendarImageForPitchDate.userInteractionEnabled = false
            self.calendarImageForAnnouncementDate.userInteractionEnabled = false
            self.calendarImageForClosingDate.userInteractionEnabled = false
        }
        
        self.debugUtil.printLog("viewDidLoad", msg: "END")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.debugUtil.printLog("prepareForSegue", msg: "BEGIN")
        let segueId = segue.identifier
        
        self.debugUtil.printLog("prepareForSegue", msg: "segueId = " + segueId!)
        if let segueId = segue.identifier {
            switch segueId {
                
            case "dateCalendar":
                embeddedDateController =  segue.destinationViewController as! DateCalendar
                embeddedDateController.transDetail3VC = self
                embeddedDateController.preferredContentSize = CGSize(width: 390, height: 360)
                //  dealSizeWidget.dealSize = self.sharedDataModel.currentTransaction.transactionDetail.dealSize
            default :
                break
            }
        }
        
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.sharedDataModel.checkForOrientationChange == "portrait"
        {
            backImageCenterX.constant = -217.0
            forwardImageCenterX.constant = 215.0
            
        }
        else
        {
            backImageCenterX.constant = -327.5
            forwardImageCenterX.constant = 325.5
            
        }


        self.resetViewsFromModel()
        self.methodForViewArrange()
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
        
        if(self.sharedDataModel.checkForNewDraftLoanType == "YES" && self.sharedDataModel.currentTransaction.transactionId == "New" && self.sharedDataModel.currentTransaction.transactionDetail.loanType.isEmpty)
        {
            self.loanTypeTextField.text = "New Structure"
            self.sharedDataModel.currentTransaction.transactionDetail.loanType = self.loanTypeTextField.text!        }
        else
        {
            self.loanTypeTextField.text = self.sharedDataModel.currentTransaction.transactionDetail.loanType
        }
        
        if self.sharedDataModel.currentTransaction.transactionDetail.isConfidential == "Confidential" {
            
            self.confidentialitySegmentedControl.selectedSegmentIndex = 0
            
        } else if self.sharedDataModel.currentTransaction.transactionDetail.isConfidential == "Public" {
            self.confidentialitySegmentedControl.selectedSegmentIndex = 1
            
        } else {
            self.confidentialitySegmentedControl.selectedSegmentIndex = -1
        }
        
        self.estimatedPitchDateTextField.text = self.sharedDataModel.currentTransaction.transactionDetail.estimatedPitchDate
        if self.sharedDataModel.currentTransaction.transactionDetail.product != "M&A" {
            self.estimatedPitchDateTextField.enabled = false
            self.pitchDateImgWarning.hidden = true
            self.pitchDateTxtWarning.hidden = true

        } else {
            self.estimatedPitchDateTextField.enabled = true
            if self.estimatedPitchDateTextField.text == "" {
                self.pitchDateImgWarning.hidden = false
                self.pitchDateTxtWarning.hidden = false
            } else {
                self.pitchDateImgWarning.hidden = true
                self.pitchDateTxtWarning.hidden = true
            }

        }
        
        self.announcementDateTextField.text = self.sharedDataModel.currentTransaction.transactionDetail.expectedAnnouncementDate
        if (self.sharedDataModel.currentTransaction.transactionDetail.expectedAnnouncementDate == "") {
            self.announcementDateTxtWarning.hidden = false
            self.announcementDateImgWarning.hidden = false
        } else {
            self.announcementDateTxtWarning.hidden = true
            self.announcementDateImgWarning.hidden = true
        }
        
        self.closingDateTextField.text = self.sharedDataModel.currentTransaction.transactionDetail.expectedClosingDate
    }
    
    func notificationCheck()
    {
        //Take Action on Notification
        if sharedDataModel.checkForCollapseButton == "YES"
        {
            if self.sharedDataModel.checkForOrientationChange == "landscape"
            {
                backImageCenterX.constant = -477.5
                forwardImageCenterX.constant = 475.5
                
            }
            else
            {
                backImageCenterX.constant = -367.0
                forwardImageCenterX.constant = 365.0
                
            }
        }
        else
        {
            if self.sharedDataModel.checkForOrientationChange == "landscape"
            {
                backImageCenterX.constant = -327.5
                forwardImageCenterX.constant = 325.5
            }
            else
            {
                backImageCenterX.constant = -217.0
                forwardImageCenterX.constant = 215.0
            }

        }
    }
    
    func methodOfReceivedNotification(notification: NSNotification){
        notificationCheck()
    }
    
    
    ///this method hide/show the pitch date label textfield and calendar icon based on product. 
    /// - product M&A: pitch date will be shown
    /// - other products: pitch date will be hidden
    /// - Based on the above product center y constraint value of pitch date is used. if it is hidden then the same constraint is used for the next view and simlilarly for the views coming after
    func methodForViewArrange()
    {
        if self.sharedDataModel.currentTransaction.transactionDetail.product != "M&A"
        {
            estimatedPitchDateLabel.hidden = true
            estimatedPitchDateTextField.hidden = true
            pitchDateImgWarning.hidden = true
            pitchDateTxtWarning.hidden = true
            calendarImageForPitchDate.hidden = true
            
            let yPitchLabel = estimatedPitchDateLabel.frame.origin.y
            let yPitchText = estimatedPitchDateTextField.frame.origin.y
            let yPitchImg = pitchDateImgWarning.frame.origin.y
            let yPitchTextWng = pitchDateTxtWarning.frame.origin.y
            let yPitchCalendar = calendarImageForPitchDate.frame.origin.y
            
            estimatedAnnouncementDateLabel.frame = CGRectMake(estimatedAnnouncementDateLabel.frame.origin.x, yPitchLabel, estimatedAnnouncementDateLabel.frame.size.width, estimatedAnnouncementDateLabel.frame.size.height)
            estimatedAnnouncementDateLabelCenterY.constant = -8.5
            
            announcementDateTextField.frame = CGRectMake(announcementDateTextField.frame.origin.x, yPitchText, announcementDateTextField.frame.size.width, announcementDateTextField.frame.size.height)
            estimatedAnnouncementTextCenterY.constant = 6.0
            
            calendarImageForAnnouncementDate.frame = CGRectMake(calendarImageForAnnouncementDate.frame.origin.x, yPitchCalendar, calendarImageForAnnouncementDate.frame.size.width, calendarImageForAnnouncementDate.frame.size.height)
            calendarImageForAnnouncementDateCenterY.constant = 8.0
            
            announcementDateImgWarning.frame = CGRectMake(announcementDateImgWarning.frame.origin.x, yPitchImg, announcementDateImgWarning.frame.size.width, announcementDateImgWarning.frame.size.height)
            announcementErrorImgCenterY.constant = -39.0
            
            announcementDateTxtWarning.frame = CGRectMake(announcementDateTxtWarning.frame.origin.x, yPitchTextWng, announcementDateTxtWarning.frame.size.width, announcementDateTxtWarning.frame.size.height)
            announcementTextCenterY.constant = -38.5
            
            estimatedClosingDateLabel.frame = CGRectMake(estimatedClosingDateLabel.frame.origin.x, yPitchLabel + 123.0, estimatedClosingDateLabel.frame.size.width, estimatedClosingDateLabel.frame.size.height)
            estimatedClosingDateLabelCenterY.constant = -128.5
            
            closingDateTextField.frame = CGRectMake(closingDateTextField.frame.origin.x, yPitchText + 125.0, closingDateTextField.frame.size.width, closingDateTextField.frame.size.height)
            estimatedClosingDateTextCenterY.constant = 126.0
            
            calendarImageForClosingDate.frame = CGRectMake(calendarImageForClosingDate.frame.origin.x, yPitchCalendar + 125.0, calendarImageForClosingDate.frame.size.width, calendarImageForClosingDate.frame.size.height)
            calendarImageForClosingDateCenterY.constant = 126.0
            
            
        }
        
        else
        {
            estimatedPitchDateLabel.hidden = false
            estimatedPitchDateTextField.hidden = false
            calendarImageForPitchDate.hidden = false
            if(self.sharedDataModel.currentTransaction.transactionDetail.estimatedPitchDate.isEmpty)
            {
                pitchDateImgWarning.hidden = false
                pitchDateTxtWarning.hidden = false
            }
            else
            {
                pitchDateImgWarning.hidden = true
                pitchDateTxtWarning.hidden = true
            }
            
            
            let yPitchLabel = 408.0
            let yPitchText = 411.0
            let yPitchImg = 450.0
            let yPitchTextWng = 450.0
            
            estimatedAnnouncementDateLabel.frame = CGRectMake(estimatedAnnouncementDateLabel.frame.origin.x, CGFloat(yPitchLabel) , estimatedAnnouncementDateLabel.frame.size.width, estimatedAnnouncementDateLabel.frame.size.height)
            estimatedAnnouncementDateLabelCenterY.constant = -128.5
            
            announcementDateTextField.frame = CGRectMake(announcementDateTextField.frame.origin.x, CGFloat(yPitchText), announcementDateTextField.frame.size.width, announcementDateTextField.frame.size.height)
            estimatedAnnouncementTextCenterY.constant = 126.0
            
            calendarImageForAnnouncementDate.frame = CGRectMake(calendarImageForAnnouncementDate.frame.origin.x, 414.0, calendarImageForAnnouncementDate.frame.size.width, calendarImageForAnnouncementDate.frame.size.height)
            calendarImageForAnnouncementDateCenterY.constant = 126
            
            announcementDateImgWarning.frame = CGRectMake(announcementDateImgWarning.frame.origin.x, CGFloat(yPitchImg), announcementDateImgWarning.frame.size.width, announcementDateImgWarning.frame.size.height)
            announcementErrorImgCenterY.constant = -161.0
            
            announcementDateTxtWarning.frame = CGRectMake(announcementDateTxtWarning.frame.origin.x, CGFloat(yPitchTextWng), announcementDateTxtWarning.frame.size.width, announcementDateTxtWarning.frame.size.height)
            announcementTextCenterY.constant = -160.5
            
            estimatedClosingDateLabel.frame = CGRectMake(estimatedClosingDateLabel.frame.origin.x, CGFloat(yPitchLabel + 123.0), estimatedClosingDateLabel.frame.size.width, estimatedClosingDateLabel.frame.size.height)
            estimatedClosingDateLabelCenterY.constant = -251.5
            
            closingDateTextField.frame = CGRectMake(closingDateTextField.frame.origin.x, CGFloat(yPitchText + 125.0), closingDateTextField.frame.size.width, closingDateTextField.frame.size.height)
            estimatedClosingDateTextCenterY.constant = 251.0
            
            calendarImageForClosingDate.frame = CGRectMake(calendarImageForClosingDate.frame.origin.x, 539.0, calendarImageForClosingDate.frame.size.width, calendarImageForClosingDate.frame.size.height)
            calendarImageForClosingDateCenterY.constant = 251.0
        }
    }
    
}

extension TransactionDetailPage3ViewController: PopTextPickerDelegate {
    func textDelegateCallBack(textField: UITextField) {
        switch textField {
        case loanTypeTextField:
            self.sharedDataModel.currentTransaction.transactionDetail.loanType = self.loanTypeTextField.text!
        default:
            break
        }
        
    }
}

extension TransactionDetailPage3ViewController: PopDatePickerDelegate {
    func textDateDelegateCallBack(textField: UITextField) {
        switch textField {
        case estimatedPitchDateTextField:
            self.sharedDataModel.currentTransaction.transactionDetail.estimatedPitchDate = self.estimatedPitchDateTextField.text!
            if estimatedPitchDateTextField.text == "" {
                self.pitchDateImgWarning.hidden = false
                self.pitchDateTxtWarning.hidden = false
            } else {
                self.pitchDateImgWarning.hidden = true
                self.pitchDateTxtWarning.hidden = true
            }
        case announcementDateTextField:
            self.sharedDataModel.currentTransaction.transactionDetail.expectedAnnouncementDate = self.announcementDateTextField.text!
            self.announcementDateImgWarning.hidden = true
            self.announcementDateTxtWarning.hidden = true
        case closingDateTextField:
            self.sharedDataModel.currentTransaction.transactionDetail.expectedClosingDate = self.closingDateTextField.text!
        default:
            break
        }
        
    }
}


extension TransactionDetailPage3ViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if (textField === loanTypeTextField) {
            
            self.sharedDataModel.checkForNewDraftLoanType = "NO"
            self.loanTypeTextField.resignFirstResponder()
            
            let initText: String? = loanTypeTextField.text
            
            self.loanTypePicker!.setSelection(initText!)
            
            let dataChangedCallback: PopTextPicker.PopTextPickerCallback = { (newText: String, forTextField: UITextField) -> () in
                // here we don't use self (no retain cycle)
                forTextField.text = newText as String
            }
            
            self.loanTypePicker!.pick(self, dataChanged: dataChangedCallback)
            
            return false
            
        } else if (textField === estimatedPitchDateTextField) {
            
            self.estimatedPitchDateTextField.resignFirstResponder()
            
//            let formatter = NSDateFormatter()
//            formatter.dateStyle = .MediumStyle
//            formatter.timeStyle = .NoStyle
//            let initDate : NSDate? = formatter.dateFromString(estimatedPitchDateTextField.text!)
//            
//            let dataChangedCallback : PopDatePicker.PopDatePickerCallback = { (newDate : NSDate, forTextField : UITextField) -> () in
//                
//                // here we don't use self (no retain cycle)
//                forTextField.text = (newDate.ToDateMediumString() ?? "?") as String
//                
//            }
//            
//            self.estimatedPitchDatePicker!.pick(self, initDate: initDate, dataChanged: dataChangedCallback)
            return false
            
        } else if (textField === announcementDateTextField) {
            
            self.announcementDateTextField.resignFirstResponder()
            
//            let formatter = NSDateFormatter()
//            formatter.dateStyle = .MediumStyle
//            formatter.timeStyle = .NoStyle
//            let initDate : NSDate? = formatter.dateFromString(announcementDateTextField.text!)
//            
//            let dataChangedCallback : PopDatePicker.PopDatePickerCallback = { (newDate : NSDate, forTextField : UITextField) -> () in
//                
//                // here we don't use self (no retain cycle)
//                forTextField.text = (newDate.ToDateMediumString() ?? "?") as String
//                
//            }
//            
//            self.announcementDatePicker!.pick(self, initDate: initDate, dataChanged: dataChangedCallback)
            return false
            
        } else if (textField === closingDateTextField) {
            
            self.closingDateTextField.resignFirstResponder()
            
//            let formatter = NSDateFormatter()
//            formatter.dateStyle = .MediumStyle
//            formatter.timeStyle = .NoStyle
//            let initDate : NSDate? = formatter.dateFromString(closingDateTextField.text!)
//            
//            let dataChangedCallback : PopDatePicker.PopDatePickerCallback = { (newDate : NSDate, forTextField : UITextField) -> () in
//                
//                // here we don't use self (no retain cycle)
//                forTextField.text = (newDate.ToDateMediumString() ?? "?") as String
//            }
//            
//            self.closingDatePicker!.pick(self, initDate: initDate, dataChanged: dataChangedCallback)
            return false
            
        } else {
            return true
        }
    }
    
}

