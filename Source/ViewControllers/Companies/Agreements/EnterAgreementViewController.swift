//
//  EnterAgreementsViewController.swift
//

import UIKit

class EnterAgreementViewController: UIViewController {
    
    var debugUtil = DebugUtility(thisClassName: "EnterAgreementViewController",enabled: true)

    let viewStateManager = ViewStateManager.sharedInstance
    var detailViewController: DetailViewController!
    var masterViewController: MasterViewController!
    let appAttributes = AppAttributes()
    var embeddedDateController: DateCalendar!
    let vcCon = VCConnection.sharedInstance

    @IBOutlet weak var calendarImageForEffectiveDate: UIButton!
    @IBOutlet weak var calendarImageForExpirationDate: UIButton!
    @IBOutlet weak var invisibleButtonForPopover: UIButton!

    var viewForDealSummary1:UIView = UIView()
    var agreementDescriptionLabel:UILabel = UILabel()
    var lastSelectedIndexFromTable = 0
    var addAgreementButton:UIButton = UIButton()
    var deleteButton:UIButton = UIButton()

  //  @IBOutlet weak var agreementTItleLabel: UILabel!
    
    var agreementsTableViewController: AgreementsTableViewController! // presenting reference
    //var companiesQuestionsViewController: CompaniesQuestionsViewController!//CompaniesQuestionsViewController! // presenting reference
    
    var editMode = false
    
    @IBOutlet weak var agreementTypeTextField: UITextField!
    var agreementTypePicker: PopTextPicker?
    
    @IBOutlet weak var effectiveDateTextField: UITextField!
    var effectiveDatePicker: PopDatePicker?
    
    
    @IBOutlet weak var expirationDateTextField: UITextField!
    var expirationDatePicker: PopDatePicker?
    
    
    @IBOutlet weak var agreementTermsTextView: UITextView!
    
    @IBOutlet weak var legalReviewByTextField: UITextField!
    
    @IBOutlet weak var exclusivityTextField: UITextField!
    
    @IBOutlet weak var effectiveDateImgWarning: UIImageView!
    
    @IBOutlet weak var effectiveDateTxtWarning: UILabel!

    @IBOutlet weak var expirationDateImgWarning: UIImageView!
    
    @IBOutlet weak var expirationDateTxtWarning: UILabel!
    
    @IBOutlet weak var agreementTermsImgWarning: UIImageView!
    
    @IBOutlet weak var agreementTermsTxtWarning: UILabel!
    
    @IBOutlet weak var legalReviewImgWarning: UIImageView!
    
    @IBOutlet weak var legalReviewTxtWarning: UILabel!
    
    @IBOutlet weak var exclusivelyApprovedImgWarning: UIImageView!
    @IBOutlet weak var exclusivelyApprovedTxtWarning: UILabel!
    @IBOutlet weak var exclusivelyApprovedLabel: UILabel!
    
    @IBOutlet weak var effectiveDateTextCenterX: NSLayoutConstraint!
    @IBOutlet weak var effectiveDateTextCenterY: NSLayoutConstraint!
    @IBOutlet weak var expirationDateTextCenterY: NSLayoutConstraint!
    @IBOutlet weak var expirationDateTextCenterX: NSLayoutConstraint!
    @IBOutlet weak var calendarImageEffectiveDateCenterX: NSLayoutConstraint!
    @IBOutlet weak var calendarImageEffectiveDateCenterY: NSLayoutConstraint!
    @IBOutlet weak var calendarImageExpirationDateCenterY: NSLayoutConstraint!
    @IBOutlet weak var calendarImageExpirationDateCenterX: NSLayoutConstraint!
    @IBOutlet weak var invisibleButtonCenterX: NSLayoutConstraint!
    @IBOutlet weak var invisibleButtonCenterY: NSLayoutConstraint!
    
    
    
    ///this method is invoked only when user wants to choose date. calendar popover come once the user taps the calendar icon.
    /// - invisibleButtonForPopover: this button is invisible and perform a segue based on the selection from pitch or announcement or closing date field
    /// - Parameter sender: this paramater ensures that this method will be invoked only using button
    @IBAction func calendarButtonAction(sender: UIButton) {
        if(sender.tag == 441)
        {
            self.viewStateManager.selectedButtonTextForDate = "EffectiveDate"
            invisibleButtonForPopover.frame = CGRectMake(sender.frame.origin.x + (sender.frame.size.width/2), (sender.frame.origin.y - 2), invisibleButtonForPopover.frame.size.width, invisibleButtonForPopover.frame.size.height)
            invisibleButtonCenterY.constant = calendarImageEffectiveDateCenterY.constant - 15.0
            invisibleButtonCenterX.constant = calendarImageEffectiveDateCenterX.constant
        }
        else if(sender.tag == 442)
        {
            self.viewStateManager.selectedButtonTextForDate = "ExpirationDate"
            invisibleButtonForPopover.frame = CGRectMake(sender.frame.origin.x + (sender.frame.size.width/2), (sender.frame.origin.y - 2), invisibleButtonForPopover.frame.size.width, invisibleButtonForPopover.frame.size.height)
            invisibleButtonCenterY.constant = calendarImageExpirationDateCenterY.constant - 17.0
            invisibleButtonCenterX.constant = calendarImageExpirationDateCenterX.constant
        }

        else
        {
            self.viewStateManager.selectedButtonTextForDate = "EffectiveDate"
        }
        self.performSegueWithIdentifier("dateCalendar", sender: sender)
    }
    
    ///this method is invoked only when user wants to choose date. calendar popover come once the user taps the calendar icon.
    /// - Parameter sender: this paramater ensures that this method will be invoked only using UITextField
    @IBAction func launchDateCalendar(sender: UITextField) {
        if(sender.tag == 331)
        {
            self.viewStateManager.selectedButtonTextForDate = "EffectiveDate"
            invisibleButtonForPopover.frame = CGRectMake(sender.frame.origin.x + (sender.frame.size.width/2), (sender.frame.origin.y - 2), invisibleButtonForPopover.frame.size.width, invisibleButtonForPopover.frame.size.height)
            invisibleButtonCenterY.constant = effectiveDateTextCenterY.constant - 15.0
            invisibleButtonCenterX.constant = effectiveDateTextCenterX.constant
        }
        else if(sender.tag == 332)
        {
            self.viewStateManager.selectedButtonTextForDate = "ExpirationDate"
            invisibleButtonForPopover.frame = CGRectMake(sender.frame.origin.x + (sender.frame.size.width/2), (sender.frame.origin.y - 2), invisibleButtonForPopover.frame.size.width, invisibleButtonForPopover.frame.size.height)
            invisibleButtonCenterY.constant = expirationDateTextCenterY.constant - 15.0
            invisibleButtonCenterX.constant = expirationDateTextCenterX.constant
        }
            
        else
        {
            self.viewStateManager.selectedButtonTextForDate = "EffectiveDate"
        }
        self.performSegueWithIdentifier("dateCalendar", sender: sender)
    }
    
    @IBAction func cancelAction(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("dismissEnterAgreementView", sender: self)
    }
/*
    @IBAction func saveAction(sender: UIButton) {
        self.debugUtil.printLog("saveaction", msg: "BEGIN")
        
        //agreements are part of a company within a transaction
        
        
        if( self.editMode && self.enteredAgreement != nil ){
            
            //update agreement edited record with the new manually entered Agreement
            
            self.debugUtil.printLog("doneAction", msg: "EDITED " + String(currentCompanyIndex) + " " + String(agreementIndex) )
            self.viewStateManager.currentTransaction.transactionCompanies[currentCompanyIndex].editAgreement(agreementIndex, agreement: self.enteredAgreement)
            
        }
        
        agreementsTableViewController.updateLocalVariables()
        agreementsTableViewController.tableView.reloadData()
        agreementsTableViewController.reselectRow()
        self.debugUtil.printLog("saveaction", msg: "END")

    }
*/
    var currentCompanyIndex: Int = -1
    var agreementIndex:Int = -1

    var enteredAgreement: AgreementData!
    
    
    
    func initFields() {
        
        var agreementType = self.viewStateManager.agreementTypesArray.map { (AgreementTypeData) -> String in
            return AgreementTypeData.agreementDesc
        }
        agreementType = agreementType.sort({ $0 < $1 })

        
        self.agreementTypePicker = PopTextPicker(forTextField: agreementTypeTextField, pickerItemsArray: agreementType)
        self.agreementTypePicker?.delegate = self
        self.agreementTypeTextField.delegate = self
        
//        self.effectiveDatePicker = PopDatePicker(forTextField: effectiveDateTextField)
//        self.effectiveDatePicker?.delegate = self
        self.effectiveDateTextField.delegate = self
        
//        self.expirationDatePicker = PopDatePicker(forTextField: expirationDateTextField)
//        self.expirationDatePicker?.delegate = self
        self.expirationDateTextField.delegate = self
        self.agreementTermsTextView.delegate = self
        self.legalReviewByTextField.delegate = self
        self.exclusivityTextField.delegate = self
        agreementDescriptionLabel.attributedText = changeStringToBold("Agreements: ",textBold:self.viewStateManager.currentTransaction.transactionCompanies[self.viewStateManager.currentTransaction.currentTransactionCompanyIndex].company.companyName)
            
            
        
        
        self.currentCompanyIndex = self.viewStateManager.currentTransaction.currentTransactionCompanyIndex
        self.agreementIndex =  self.viewStateManager.currentTransaction.transactionCompanies[currentCompanyIndex].currentTransactionCompanyAgreementIndex


    }
    override func viewWillAppear(animated: Bool) {
        checkOrientation()

        initFields()
        if editMode {
            //self.editAgreement()
        } else {
            // create new agreement
            self.enteredAgreement = self.getManuallyEnteredAgreement()
        }
        self.editAgreement()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "methodOfReceivedNotification:", name:"NotificationIdentifier", object: nil)
        notificationCheck()
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "NotificationIdentifier", object: nil)
        self.viewStateManager.checkForAgreementClicked = "NO"
    }

    
    func checkOrientation()
    {
        if viewStateManager.currentOrientation == "landscape"
        {
            if viewStateManager.checkForCollapseButton == "YES"
            {
                self.agreementDescriptionLabel.frame = CGRectMake(viewForDealSummary1.frame.origin.x , agreementDescriptionLabel.frame.origin.y, agreementDescriptionLabel.frame.size.width, agreementDescriptionLabel.frame.size.height)
                addAgreementButton.frame = CGRectMake( 800,  15,  22, 22)
                self.deleteButton.frame = CGRectMake( 850,  15,  22, 22)
            }
        }
        else
        {
            if viewStateManager.checkForCollapseButton == "YES"
            {
                self.agreementDescriptionLabel.frame = CGRectMake(viewForDealSummary1.frame.origin.x - 150, agreementDescriptionLabel.frame.origin.y, agreementDescriptionLabel.frame.size.width, agreementDescriptionLabel.frame.size.height)
                addAgreementButton.frame = CGRectMake( 650,  15,  22, 22)
                self.deleteButton.frame = CGRectMake( 700,  15,  22, 22)
            }
        }
        
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue
        {
            if viewStateManager.checkForCollapseButton == "YES"
            {
                self.agreementDescriptionLabel.frame = CGRectMake(viewForDealSummary1.frame.origin.x , agreementDescriptionLabel.frame.origin.y, agreementDescriptionLabel.frame.size.width, agreementDescriptionLabel.frame.size.height)
                addAgreementButton.frame = CGRectMake( 800,  15,  22, 22)
                self.deleteButton.frame = CGRectMake( 850,  15,  22, 22)
            }
        }
        else
        {
            if viewStateManager.checkForCollapseButton == "YES"
            {
                self.agreementDescriptionLabel.frame = CGRectMake(viewForDealSummary1.frame.origin.x - 150, agreementDescriptionLabel.frame.origin.y, agreementDescriptionLabel.frame.size.width, agreementDescriptionLabel.frame.size.height)
                addAgreementButton.frame = CGRectMake( 650,  15,  22, 22)
                self.deleteButton.frame = CGRectMake( 700,  15,  22, 22)
            }
        }
        
    }
    
    func addAgreement(sender: UIButton) {
        //Add a new Agreement to the table.
        //then pretend its an EDIT mode
        let newAgmt = AgreementData(
            agreementType: "",
            effectiveDate: "",
            expirationDate: "",
            agreementTerms: "",
            legalReviewBy: "",
            exclusivityApprovedBy: ""
        )
        self.viewStateManager.currentTransaction.transactionCompanies[currentCompanyIndex].addAgreement(newAgmt)
        self.viewStateManager.currentTransaction.transactionCompanies[self.currentCompanyIndex].currentTransactionCompanyAgreementIndex = self.viewStateManager.currentTransaction.transactionCompanies[self.currentCompanyIndex].agreements.count - 1
        self.agreementsTableViewController.updateLocalVariables()
        self.agreementsTableViewController.tableView.reloadData()
        self.agreementsTableViewController.reselectRow()
        
        
        
//        self.detailViewController.embeddedEnterAgreementsViewController.agreementsTableViewController = self
//        self.detailViewController.embeddedEnterAgreementsViewController.editMode = true
        self.agreementIndex = self.viewStateManager.currentTransaction.transactionCompanies[self.currentCompanyIndex].currentTransactionCompanyAgreementIndex 
        self.enteredAgreement = self.agreementsTableViewController.selectedAgreement
        self.detailViewController.changeToAgreementsVC()
        self.detailViewController.selectedIndex = 1
        self.detailViewController.embeddedEnterAgreementsViewController.viewWillAppear(true)
        
    }
    
    
    ///this method is invoked only when user wants to delete a agreement from transaction company. delete button present in ach cell will trigger this method
    /// - Parameter sender: this paramater ensures that this method will be invoked only using UIButton
    func deleteAgreementAction(sender: UIButton) {
        //get the current company first
        var agreementMessage = ""

        if self.agreementTypeTextField.text!.isEmpty
        {
            agreementMessage = "Delete this agreement with " + self.viewStateManager.currentTransaction.transactionCompanies[self.viewStateManager.currentTransaction.currentTransactionCompanyIndex].company.companyName + "?"
        }
        else
        {
            agreementMessage =  "Are you certain you wish to delete " + self.agreementTypeTextField.text!  + " with " + self.viewStateManager.currentTransaction.transactionCompanies[self.viewStateManager.currentTransaction.currentTransactionCompanyIndex].company.companyName + "?"
        }
        
        let alert = UIAlertController(title: "Delete Agreement ", message: agreementMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                self.viewStateManager.checkForDeleteDraftClicked = "YES"
                self.viewStateManager.currentTransaction.transactionCompanies[self.currentCompanyIndex].agreements.removeAtIndex(self.lastSelectedIndexFromTable)
                //update index of sharedModel
                if self.viewStateManager.currentTransaction.transactionCompanies[self.currentCompanyIndex].agreements.count == 0 {
                    self.viewStateManager.currentTransaction.transactionCompanies[self.currentCompanyIndex].currentTransactionCompanyAgreementIndex = -1
                    self.vcCon.masterNavigationController.popViewControllerAnimated(true)

                    //return back to companies if there are no more agreements
                    self.detailViewController.changeToMaterialityVC()
                } else {
                    self.viewStateManager.currentTransaction.transactionCompanies[self.currentCompanyIndex].currentTransactionCompanyAgreementIndex = self.viewStateManager.currentTransaction.transactionCompanies[self.currentCompanyIndex].agreements.count  - 1
                    
                    self.agreementsTableViewController.updateLocalVariables()
                    self.agreementsTableViewController.tableView.reloadData()
                    self.agreementsTableViewController.reselectRow()
                    self.enteredAgreement = self.agreementsTableViewController.selectedAgreement
                }
                
            case .Cancel:
                print("cancel")
                
            case .Destructive:
                print("destructive")
            }
        }))
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    override func viewDidLoad() {
        self.debugUtil.printLog("viewDidLoad", msg: "BEGIN")
        
        
        //var bounds = UIScreen.mainScreen().bounds
        let width  = 1100.0
        
        viewForDealSummary1.frame = CGRectMake( -5,  -9,  CGFloat (width), 45.00)
        viewForDealSummary1.backgroundColor = UIColor(CGColor: appAttributes.colorOcean)
        self.view.addSubview(viewForDealSummary1)
        
        agreementDescriptionLabel.frame = CGRectMake( 250,  10,  CGFloat (width), 30.00)
        
        agreementDescriptionLabel.textColor = UIColor.whiteColor()
        agreementDescriptionLabel.textAlignment = NSTextAlignment.Natural
        agreementDescriptionLabel.font = UIFont(name: agreementDescriptionLabel.font.fontName, size: 15)
        
        
        addAgreementButton = UIButton(type: UIButtonType.System)
        addAgreementButton.frame = CGRectMake( 800,  15,  22, 22)
        let image = UIImage(named: "add_list_filled")
        addAgreementButton.setImage(image, forState: .Normal)
        addAgreementButton.addTarget(self, action: "addAgreement:", forControlEvents: .TouchUpInside)
        viewForDealSummary1.addSubview(addAgreementButton)
        
        
        deleteButton = UIButton(type: UIButtonType.System)
        deleteButton.frame = CGRectMake( 850,  15,  22, 22)
        let image1 = UIImage(named: "cancel_filled")
        deleteButton.setImage(image1, forState: .Normal)
        deleteButton.addTarget(self, action: "deleteAgreementAction:", forControlEvents: .TouchUpInside)
        viewForDealSummary1.addSubview(deleteButton)
        
        
        viewForDealSummary1.addSubview(agreementDescriptionLabel)
        
        
        super.viewDidLoad()

  
        self.appAttributes.setColorAttributesTF(agreementTypeTextField)
        self.appAttributes.setColorAttributesTF(effectiveDateTextField)
        self.appAttributes.setColorAttributesTF(expirationDateTextField)
        self.appAttributes.setColorAttributesTV(agreementTermsTextView)
        self.appAttributes.setColorAttributesTF(legalReviewByTextField)
        self.appAttributes.setColorAttributesTF(exclusivityTextField)

        self.view.backgroundColor = appAttributes.colorBackgroundColor
        
        if viewStateManager.currentTransaction.transactionStatus != "Draft" && viewStateManager.currentTransaction.transactionStatus != "Pending Review" && viewStateManager.currentTransaction.transactionStatus != "Cleared" && viewStateManager.currentTransaction.transactionStatus != "Template"
        {
            self.agreementTypeTextField.userInteractionEnabled = false
            self.agreementTypeTextField.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.effectiveDateTextField.userInteractionEnabled = false
            self.effectiveDateTextField.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.expirationDateTextField.userInteractionEnabled = false
            self.expirationDateTextField.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.agreementTermsTextView.userInteractionEnabled = false
            self.agreementTermsTextView.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.legalReviewByTextField.userInteractionEnabled = false
            self.legalReviewByTextField.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.exclusivityTextField.userInteractionEnabled = false
            self.exclusivityTextField.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.calendarImageForEffectiveDate.userInteractionEnabled = false
            self.calendarImageForExpirationDate.userInteractionEnabled = false
            addAgreementButton.userInteractionEnabled = false
            deleteButton.userInteractionEnabled = false
        }
        
        self.debugUtil.printLog("viewDidLoad", msg: "END")
    }
    
    func changeStringToBold(normalText:String, textBold:String)->NSAttributedString
    {
        let attributedString = NSMutableAttributedString(string:textBold)

        if normalText == "Agreements: "
        {
            let attrs = [NSFontAttributeName : UIFont.boldSystemFontOfSize(15)]
            let boldString = NSMutableAttributedString(string:normalText, attributes:attrs)
            boldString.appendAttributedString(attributedString)
            return boldString
        }
        else
        {
            let attrs = [NSFontAttributeName : UIFont.boldSystemFontOfSize(13)]
            let boldString = NSMutableAttributedString(string:normalText, attributes:attrs)
            boldString.appendAttributedString(attributedString)
            return boldString

        }
    }

    override func didReceiveMemoryWarning() {
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "BEGIN")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "END")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        self.debugUtil.printLog("prepareForSegue", msg: "BEGIN")
        
        if let segueId = segue.identifier {
        
            self.debugUtil.printLog("prepareForSegue", msg: "segueId = " + segueId)
            switch segueId {
                
            case "dateCalendar":
                embeddedDateController =  segue.destinationViewController as! DateCalendar
                embeddedDateController.enterAgreementVC = self
                embeddedDateController.preferredContentSize = CGSize(width: 390, height: 360)
                //  dealSizeWidget.dealSize = self.viewStateManager.currentTransaction.transactionDetail.dealSize
            default :
                break
            }
            
        }
        
        self.debugUtil.printLog("prepareForSegue", msg: "END")
    }
    
    func getManuallyEnteredAgreement() -> AgreementData {
        
        return AgreementData(
      /*      agreementType: self.agreementTypeTextField.text,
            effectiveDate: self.effectiveDateTextField.text,
            expirationDate: self.expirationDateTextField.text,
            agreementTerms: self.agreementTermsTextView.text,
            legalReviewBy: self.legalReviewByTextField.text,
            exclusivityApprovedBy: self.exclusivityTextField.text
         */
            agreementType: "",
            effectiveDate: "",
            expirationDate: "",
            agreementTerms: "",
            legalReviewBy: "",
            exclusivityApprovedBy: ""
        )
        
    }
    
    func editAgreement() {
        self.debugUtil.printLog("editAgreement", msg: "BEGIN")
        
        if (self.enteredAgreement != nil) {
            
            self.debugUtil.printLog("editAgreement", msg: "enteredAgreement not nil")

            self.agreementTypeTextField.text = self.enteredAgreement.agreementType
        
            self.effectiveDateTextField.text = self.enteredAgreement.effectiveDate
            
            self.expirationDateTextField.text = self.enteredAgreement.expirationDate
            
            self.agreementTermsTextView.text = self.enteredAgreement.agreementTerms
            
            self.legalReviewByTextField.text = self.enteredAgreement.legalReviewBy
            
            self.exclusivityTextField.text = self.enteredAgreement.exclusivityApprovedBy
        
     
            if self.enteredAgreement.effectiveDate == "" {
                self.effectiveDateImgWarning.hidden = false
                self.effectiveDateTxtWarning.hidden = false
            } else {
                self.effectiveDateImgWarning.hidden = true
                self.effectiveDateTxtWarning.hidden = true
            }
            if self.enteredAgreement.expirationDate == "" {
                self.expirationDateImgWarning.hidden = false
                self.expirationDateTxtWarning.hidden = false
            } else {
                self.expirationDateImgWarning.hidden = true
                self.expirationDateTxtWarning.hidden = true
            }
           if self.enteredAgreement.agreementTerms == "" {
                self.agreementTermsImgWarning.hidden = false
                self.agreementTermsTxtWarning.hidden = false
           } else {
                self.agreementTermsImgWarning.hidden = true
                self.agreementTermsTxtWarning.hidden = true
            }
           if self.enteredAgreement.legalReviewBy == "" {
                self.legalReviewImgWarning.hidden = false
                self.legalReviewTxtWarning.hidden = false
           } else {
                self.legalReviewImgWarning.hidden = true
                self.legalReviewTxtWarning.hidden = true
            }
            
            if self.agreementTypeTextField.text == "Exclusivity Agreement"
            {
                self.exclusivelyApprovedLabel.hidden = false
                self.exclusivityTextField.hidden = false
                
                if self.enteredAgreement.exclusivityApprovedBy == "" {
                    self.exclusivelyApprovedImgWarning.hidden = false
                    self.exclusivelyApprovedTxtWarning.hidden = false
                } else {
                    self.exclusivelyApprovedImgWarning.hidden = true
                    self.exclusivelyApprovedTxtWarning.hidden = true
                }
            }
            else
            {
                self.exclusivelyApprovedLabel.hidden = true
                self.exclusivityTextField.hidden = true
                self.exclusivelyApprovedImgWarning.hidden = true
                self.exclusivelyApprovedTxtWarning.hidden = true
            }
            
           
           
            
        }
        self.debugUtil.printLog("editAgreement", msg: "END")
    }
    
    func notificationCheck()
    {
        //Take Action on Notification
        
        var widthforScreen:CGFloat = 0.0
        
      //  var bounds = UIScreen.mainScreen().bounds
        let width  = 1100.0
      //  var height = bounds.size.height
        widthforScreen = CGFloat(width)
        
        if viewStateManager.checkForCollapseButton == "YES"
        {
            
            UIView.animateWithDuration(0.1, animations: {
                
                let x = self.viewForDealSummary1.frame.origin.x
                let y = self.detailViewController.viewForDealSummary.frame.origin.y + 45
                let width = widthforScreen
                let height = self.viewForDealSummary1.frame.size.height
                
                let companyX = self.viewForDealSummary1.frame.origin.x
                let companyY = self.agreementDescriptionLabel.frame.origin.y
                let companyWidth =  self.agreementDescriptionLabel.frame.size.width
                let companyHeight = self.agreementDescriptionLabel.frame.size.height
                
                if self.viewStateManager.currentOrientation == "portrait"
                {
                    self.agreementDescriptionLabel.frame = CGRectMake(companyX - 150, companyY, companyWidth, companyHeight)
                    self.addAgreementButton.frame = CGRectMake( 650,  15,  22, 22)
                    self.deleteButton.frame = CGRectMake( 700,  15,  22, 22)

                }
                else
                {
                    self.agreementDescriptionLabel.frame = CGRectMake(companyX, companyY, companyWidth, companyHeight)
                    self.addAgreementButton.frame = CGRectMake( 800,  15,  22, 22)
                    self.deleteButton.frame = CGRectMake( 850,  15,  22, 22)

                }
                self.agreementDescriptionLabel.textAlignment = NSTextAlignment.Center
                
                self.viewForDealSummary1.frame = CGRectMake(x, y, width, height)
                self.viewForDealSummary1.backgroundColor = UIColor(CGColor: self.appAttributes.colorCyan)
                
            })
        }
        else
        {
            
            UIView.animateWithDuration(0.0, animations: {
                let x = self.detailViewController.viewForDealSummary.frame.origin.x
                let y = self.detailViewController.viewForDealSummary.frame.origin.y
                let width = widthforScreen
                let height = self.viewForDealSummary1.frame.size.height
                
                self.viewForDealSummary1.frame = CGRectMake(x, y, width, height)
                self.viewForDealSummary1.backgroundColor = UIColor(CGColor: self.appAttributes.colorOcean)
                self.agreementDescriptionLabel.frame = CGRectMake( 150, 10,  width, 30.00)
                self.agreementDescriptionLabel.textAlignment = NSTextAlignment.Natural
            })
            
        }
    }
    
    func methodOfReceivedNotification(notification: NSNotification){
        notificationCheck()
    }
    


}
extension EnterAgreementViewController: PopTextPickerDelegate {
    func textDelegateCallBack(textField: UITextField) {
        switch textField {
        case agreementTypeTextField:
            self.enteredAgreement.agreementType = agreementTypeTextField.text!
            //update shared data model
            self.viewStateManager.currentTransaction.transactionCompanies[currentCompanyIndex].editAgreement(agreementIndex, agreement: self.enteredAgreement)
            agreementsTableViewController.tableView.reloadData()
            let lastSelectedIndexPath = NSIndexPath(forRow: agreementIndex, inSection: 0)
            agreementsTableViewController.tableView.selectRowAtIndexPath(lastSelectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
            if self.enteredAgreement.agreementType == "Exclusivity Agreement"
            {
                self.exclusivelyApprovedLabel.hidden = false
                self.exclusivityTextField.hidden = false
                
                if self.enteredAgreement.exclusivityApprovedBy == "" {
                    self.exclusivelyApprovedImgWarning.hidden = false
                    self.exclusivelyApprovedTxtWarning.hidden = false
                } else {
                    self.exclusivelyApprovedImgWarning.hidden = true
                    self.exclusivelyApprovedTxtWarning.hidden = true
                }
            }
            else
            {
                self.exclusivelyApprovedLabel.hidden = true
                self.exclusivityTextField.hidden = true
                self.exclusivelyApprovedImgWarning.hidden = true
                self.exclusivelyApprovedTxtWarning.hidden = true
            }
        default:
            break
        }

    }
}
extension EnterAgreementViewController: PopDatePickerDelegate {
    func textDateDelegateCallBack(textField: UITextField) {
        switch textField {
        case effectiveDateTextField:
            self.enteredAgreement.effectiveDate = effectiveDateTextField.text!
            //update shared data model

            self.effectiveDateImgWarning.hidden = true
            self.effectiveDateTxtWarning.hidden = true
            self.viewStateManager.currentTransaction.transactionCompanies[currentCompanyIndex].editAgreement(agreementIndex, agreement: self.enteredAgreement)

        case expirationDateTextField:
            self.enteredAgreement.expirationDate = expirationDateTextField.text!
            //update shared data model
            
            self.expirationDateImgWarning.hidden = true
            self.expirationDateTxtWarning.hidden = true
            self.viewStateManager.currentTransaction.transactionCompanies[currentCompanyIndex].editAgreement(agreementIndex, agreement: self.enteredAgreement)

        default:
            break
        }
        
        
    }
}

extension EnterAgreementViewController: UITextViewDelegate {
    func textViewDidBeginEditing(textView: UITextView) {
        if (textView.textColor != nil && textView.textColor == UIColor.lightGrayColor()) {
            textView.text = nil
            textView.textColor =  UIColor.blackColor()
        }
    }

    func textViewDidChange(textView: UITextView) {
        if (textView === agreementTermsTextView) {
            self.enteredAgreement.agreementTerms = self.agreementTermsTextView.text
            //update shared data model

            self.agreementTermsImgWarning.hidden = true
            self.agreementTermsTxtWarning.hidden = true
            self.viewStateManager.currentTransaction.transactionCompanies[currentCompanyIndex].editAgreement(agreementIndex, agreement: self.enteredAgreement)
            
           
        }
    }
}
extension EnterAgreementViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    }
    func textFieldDidChange(textField: UITextField) {
        switch textField {
            
        case legalReviewByTextField:
            self.legalReviewImgWarning.hidden = true
            self.legalReviewTxtWarning.hidden = true
            self.enteredAgreement.legalReviewBy = legalReviewByTextField.text!
            //update shared data model
            self.viewStateManager.currentTransaction.transactionCompanies[currentCompanyIndex].editAgreement(agreementIndex, agreement: self.enteredAgreement)

        case exclusivityTextField:
            self.exclusivelyApprovedImgWarning.hidden = true
            self.exclusivelyApprovedTxtWarning.hidden = true
            self.enteredAgreement.exclusivityApprovedBy = exclusivityTextField.text!
            //update shared data model
            self.viewStateManager.currentTransaction.transactionCompanies[currentCompanyIndex].editAgreement(agreementIndex, agreement: self.enteredAgreement)

        default:
            break
        }
        
        
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if (textField === agreementTypeTextField) {
            
            self.agreementTypeTextField.resignFirstResponder()
            
            let initText: String? = agreementTypeTextField.text
            
            self.agreementTypePicker!.setSelection(initText!)
            
            let dataChangedCallback: PopTextPicker.PopTextPickerCallback = { (newText: String, forTextField: UITextField) -> () in
                // here we don't use self (no retain cycle)
                forTextField.text = newText as String
            }
            
            self.agreementTypePicker!.pick(self, dataChanged: dataChangedCallback)
            
            return false
            
        } else if (textField === effectiveDateTextField) {
            
            self.effectiveDateTextField.resignFirstResponder()
            
//            let formatter = NSDateFormatter()
//            formatter.dateStyle = .MediumStyle
//            formatter.timeStyle = .NoStyle
//            let initDate : NSDate? = formatter.dateFromString(effectiveDateTextField.text!)
//            
//            let dataChangedCallback : PopDatePicker.PopDatePickerCallback = { (newDate : NSDate, forTextField : UITextField) -> () in
//                
//                // here we don't use self (no retain cycle)
//                forTextField.text = (newDate.ToDateMediumString() ?? "?") as String
//                
//            }
//            
//            self.effectiveDatePicker!.pick(self, initDate: initDate, dataChanged: dataChangedCallback)
            return false
            
        } else if (textField === expirationDateTextField) {
            
            self.expirationDateTextField.resignFirstResponder()
            
//            let formatter = NSDateFormatter()
//            formatter.dateStyle = .MediumStyle
//            formatter.timeStyle = .NoStyle
//            let initDate : NSDate? = formatter.dateFromString(expirationDateTextField.text!)
//            
//            let dataChangedCallback : PopDatePicker.PopDatePickerCallback = { (newDate : NSDate, forTextField : UITextField) -> () in
//                
//                // here we don't use self (no retain cycle)
//                forTextField.text = (newDate.ToDateMediumString() ?? "?") as String
//                
//            }
//            
//            self.expirationDatePicker!.pick(self, initDate: initDate, dataChanged: dataChangedCallback)
            return false
            
        } else {
            return true
        }
    }
    
}


