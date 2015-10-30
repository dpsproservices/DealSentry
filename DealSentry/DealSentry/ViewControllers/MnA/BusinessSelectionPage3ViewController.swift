//
//  BusinessSelectionPage3ViewController
//

import UIKit

class BusinessSelectionPage3ViewController: BusinessSelectionPageViewController {
    
    var debugUtil = DebugUtility(thisClassName: "BusinessSelectionPage3ViewController", enabled: false)
    let sharedDataModel = SharedDataModel.sharedInstance
    let appAttributes = AppAttributes()

    @IBOutlet weak var servicesSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var includeCashSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var includeStockSegmentedControl: UISegmentedControl!
    @IBOutlet weak var includeOtherSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var servicesOpportunityTextView: UITextView!
    @IBOutlet weak var considerationExplainTextView: UITextView!
    @IBOutlet weak var backImageCenterX: NSLayoutConstraint!
    @IBOutlet weak var forwardImageCenterX: NSLayoutConstraint!
    
    
    @IBOutlet weak var escrowImgWarning: UIImageView!
    @IBOutlet weak var escrowTxtWarning: UILabel!
    @IBOutlet weak var oppImgWarning: UIImageView!
    @IBOutlet weak var oppTxtWarning: UILabel!
    @IBOutlet weak var cashImgWarning: UIImageView!
    @IBOutlet weak var cashTxtWarning: UILabel!
    @IBOutlet weak var stockImgWarning: UIImageView!
    @IBOutlet weak var stockTxtWarning: UILabel!
    @IBOutlet weak var otherImgWarning: UIImageView!
    @IBOutlet weak var otherTxtWarning: UILabel!

    @IBOutlet weak var otherQImgWarning: UIImageView!
    @IBOutlet weak var otherQTxtWarning: UILabel!
    
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var forwardImage: UIImageView!
    
    @IBOutlet weak var forwardButton: UIButton!
    
    /// this method will set the index for servicesSegmentedControl and update the corresponding object of the transaction
    @IBAction func servicesValueChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            self.servicesOpportunityTextView.editable = true
            self.sharedDataModel.currentTransaction.businessSelection.isServicesOpportunity = "Yes"
            self.oppImgWarning.hidden = false
            self.oppTxtWarning.hidden = false
        } else {
            self.sharedDataModel.currentTransaction.businessSelection.isServicesOpportunity = "No"
            self.sharedDataModel.currentTransaction.businessSelection.servicesOpportunityDescription = ""
            self.servicesOpportunityTextView.text = ""
            self.servicesOpportunityTextView.editable = false
            self.oppImgWarning.hidden = true
            self.oppTxtWarning.hidden = true
        }
        self.escrowImgWarning.hidden = true
        self.escrowTxtWarning.hidden = true
    }
    
    /// this method will set the index for includeCashSegmentedControl and update the corresponding object of the transaction
    @IBAction func includeCashValueChangeAction(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            self.sharedDataModel.currentTransaction.businessSelection.toIncludeCash = "Yes"
        } else {
            self.sharedDataModel.currentTransaction.businessSelection.toIncludeCash = "No"
        }
        self.cashImgWarning.hidden = true
        self.cashTxtWarning.hidden = true
    }
    
    /// this method will set the index for includeStockSegmentedControl and update the corresponding object of the transaction
    @IBAction func includeStockValueChangeAction(sender: AnyObject) {
        if sender.selectedSegmentIndex == 1 {
            self.sharedDataModel.currentTransaction.businessSelection.toIncludeStock = "Yes"
        } else {
            self.sharedDataModel.currentTransaction.businessSelection.toIncludeStock = "No"
        }
        self.stockImgWarning.hidden = true
        self.stockTxtWarning.hidden = true
    }
    
    /// this method will set the index for includeOtherSegmentedControl and update the corresponding object of the transaction
    @IBAction func includeOtherValueChangeAction(sender: AnyObject) {
        if sender.selectedSegmentIndex == 1 {
            self.considerationExplainTextView.editable = true
            self.sharedDataModel.currentTransaction.businessSelection.toIncludeOther = "Yes"
            self.otherQImgWarning.hidden = false
            self.otherQTxtWarning.hidden = false
        } else {
            self.sharedDataModel.currentTransaction.businessSelection.toIncludeOther = "No"
            self.sharedDataModel.currentTransaction.businessSelection.pleaseExplain = ""
            self.considerationExplainTextView.text = ""
            self.considerationExplainTextView.editable = false
            self.otherQImgWarning.hidden = true
            self.otherQTxtWarning.hidden = true
        }
        self.otherImgWarning.hidden = true
        self.otherTxtWarning.hidden = true
    }
    
    
    /// this method will push the user to previous page
    @IBAction func backButtonAction(sender: UIButton) {
        //self.businessSelectionViewController.goToPreviousContentViewController()
        self.businessSelectionViewController.goToPage(2,whichWay: -1)
        NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: nil)

    }
    
    /// this method will push the user to next page
    @IBAction func forwardButtonAction(sender: UIButton) {
        //self.businessSelectionViewController.goToNextContentViewController()
        self.businessSelectionViewController.goToPage(4,whichWay: 1)
        NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: nil)

    }
    
    ///this method provides data from the object to the view controller
    func resetViewsFromModel() {
        if (self.sharedDataModel.currentTransaction.businessSelection.isServicesOpportunity == "Yes") {
            self.servicesOpportunityTextView.editable = true
            self.servicesSegmentedControl.selectedSegmentIndex = 1
            self.escrowImgWarning.hidden = true
            self.escrowTxtWarning.hidden = true
        } else if self.sharedDataModel.currentTransaction.businessSelection.isServicesOpportunity == "No"{
            self.servicesOpportunityTextView.editable = false
            self.servicesSegmentedControl.selectedSegmentIndex = 0
            self.escrowImgWarning.hidden = true
            self.escrowTxtWarning.hidden = true
        } else {
            self.servicesOpportunityTextView.editable = false
            self.servicesSegmentedControl.selectedSegmentIndex = -1
            self.escrowImgWarning.hidden = false
            self.escrowTxtWarning.hidden = false
        }
        
        if (self.sharedDataModel.currentTransaction.businessSelection.toIncludeCash == "Yes") {
            self.includeCashSegmentedControl.selectedSegmentIndex = 1
            self.cashImgWarning.hidden = true
            self.cashTxtWarning.hidden = true
        } else if self.sharedDataModel.currentTransaction.businessSelection.toIncludeCash == "No"{
            self.includeCashSegmentedControl.selectedSegmentIndex = 0
            self.cashImgWarning.hidden = true
            self.cashTxtWarning.hidden = true
        } else {
            self.includeCashSegmentedControl.selectedSegmentIndex = -1
            self.cashImgWarning.hidden = false
            self.cashTxtWarning.hidden = false
        }
        
        
        if (self.sharedDataModel.currentTransaction.businessSelection.toIncludeStock == "Yes") {
            self.includeStockSegmentedControl.selectedSegmentIndex = 1
            self.stockImgWarning.hidden = true
            self.stockTxtWarning.hidden = true
        } else if self.sharedDataModel.currentTransaction.businessSelection.toIncludeStock == "No" {
            self.includeStockSegmentedControl.selectedSegmentIndex = 0
            self.stockImgWarning.hidden = true
            self.stockTxtWarning.hidden = true
        } else {
            self.includeStockSegmentedControl.selectedSegmentIndex = -1
            self.stockImgWarning.hidden = false
            self.stockTxtWarning.hidden = false
        }
        
        
        if (self.sharedDataModel.currentTransaction.businessSelection.toIncludeOther == "Yes") {
            self.considerationExplainTextView.editable = true
            self.includeOtherSegmentedControl.selectedSegmentIndex = 1
            self.otherImgWarning.hidden = true
            self.otherTxtWarning.hidden = true
        } else if self.sharedDataModel.currentTransaction.businessSelection.toIncludeOther == "No"{
            self.considerationExplainTextView.editable = false
            self.includeOtherSegmentedControl.selectedSegmentIndex = 0
            self.otherImgWarning.hidden = true
            self.otherTxtWarning.hidden = true
        } else {
            self.considerationExplainTextView.editable = false
            self.includeOtherSegmentedControl.selectedSegmentIndex = -1
            self.otherImgWarning.hidden = false
            self.otherTxtWarning.hidden = false
        }
        
        if (self.sharedDataModel.currentTransaction.businessSelection.servicesOpportunityDescription == "" && self.sharedDataModel.currentTransaction.businessSelection.isServicesOpportunity == "Yes") {
            self.servicesOpportunityTextView.text = "enter a Opportunity Description"
            self.servicesOpportunityTextView.textColor = UIColor.lightGrayColor()
            self.oppImgWarning.hidden = false
            self.oppTxtWarning.hidden = false
        } else {
            self.servicesOpportunityTextView.text = self.sharedDataModel.currentTransaction.businessSelection.servicesOpportunityDescription
            self.oppImgWarning.hidden = true
            self.oppTxtWarning.hidden = true
        }
        
        if (self.sharedDataModel.currentTransaction.businessSelection.pleaseExplain == "" && self.sharedDataModel.currentTransaction.businessSelection.toIncludeOther == "Yes") {
            self.considerationExplainTextView.text = "enter an Explanation"
            self.considerationExplainTextView.textColor = UIColor.lightGrayColor()
            self.otherQImgWarning.hidden = false
            self.otherQTxtWarning.hidden = false
        } else {
            self.considerationExplainTextView.text = self.sharedDataModel.currentTransaction.businessSelection.pleaseExplain
            self.otherQImgWarning.hidden = true
            self.otherQTxtWarning.hidden = true
        }
    }
    
    /// this method determines to show the next page or not by enabling/hiding the forward button based on current transaction business type
    func showHidePage4or5() {
        if (forwardButton != nil) {
            if self.sharedDataModel.getBusinessType(self.sharedDataModel.currentTransaction) != "Either"{
                self.forwardButton.enabled = true
                self.forwardImage.hidden = false
            } else {
                self.forwardButton.enabled = false
                self.forwardImage.hidden = true
            
            }
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.sharedDataModel.checkForOrientationChange == "portrait"
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
//        self.showHidePage4or5()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "methodOfReceivedNotification:", name:"NotificationIdentifier", object: nil)
        notificationCheck()
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "NotificationIdentifier", object: nil)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue
        {
            if self.sharedDataModel.checkForCollapseButton == "YES"
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
            if self.sharedDataModel.checkForCollapseButton == "YES"
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
        self.servicesOpportunityTextView.delegate = self
        self.considerationExplainTextView.delegate = self
        self.appAttributes.setColorAttributesTV(servicesOpportunityTextView)
        self.appAttributes.setColorAttributesTV(considerationExplainTextView)

        super.pageNumber = 3
        self.view.layer.backgroundColor = (appAttributes.colorBackgroundColor).CGColor
        appAttributes.setColorAttributesSegmentControl(servicesSegmentedControl)
        appAttributes.setColorAttributesSegmentControl(includeCashSegmentedControl)
        appAttributes.setColorAttributesSegmentControl(includeStockSegmentedControl)
        appAttributes.setColorAttributesSegmentControl(includeOtherSegmentedControl)
        if let image = backImage.image {
            backImage.image = image.imageWithColor(UIColor(CGColor: appAttributes.colorBlue)).imageWithRenderingMode(.AlwaysOriginal)
        }
        if let image = forwardImage.image {
            forwardImage.image = image.imageWithColor(UIColor(CGColor: appAttributes.colorBlue)).imageWithRenderingMode(.AlwaysOriginal)
        }
        
       if sharedDataModel.currentTransaction.transactionStatus != "Draft" && sharedDataModel.currentTransaction.transactionStatus != "Pending Review" && sharedDataModel.currentTransaction.transactionStatus != "Cleared" && sharedDataModel.currentTransaction.transactionStatus != "Template"
        {
            self.servicesSegmentedControl.userInteractionEnabled = false
            self.servicesSegmentedControl.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.includeCashSegmentedControl.userInteractionEnabled = false
            self.includeCashSegmentedControl.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.includeStockSegmentedControl.userInteractionEnabled = false
            self.includeStockSegmentedControl.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.includeOtherSegmentedControl.userInteractionEnabled = false
            self.includeOtherSegmentedControl.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.servicesOpportunityTextView.userInteractionEnabled = false
            self.servicesOpportunityTextView.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.considerationExplainTextView.userInteractionEnabled = false
            self.considerationExplainTextView.backgroundColor = appAttributes.grayColorForClosedDeals
        }

        
        self.debugUtil.printLog("viewDidLoad", msg: "END")
    }
    
    override func didReceiveMemoryWarning() {
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "BEGIN")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "END")
    }
    
    func notificationCheck()
    {
        //Take Action on Notification
        if sharedDataModel.checkForCollapseButton == "YES"
        {
            if self.sharedDataModel.checkForOrientationChange == "landscape"
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
            if self.sharedDataModel.checkForOrientationChange == "landscape"
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

extension BusinessSelectionPage3ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(textView: UITextView) {
        if (textView.textColor != nil && textView.textColor == UIColor.lightGrayColor()) {
            textView.text = nil
            textView.textColor =  UIColor.blackColor()
        }
    }
    func textViewDidChange(textView: UITextView) {
        switch textView {
        
        case servicesOpportunityTextView:
            self.sharedDataModel.currentTransaction.businessSelection.servicesOpportunityDescription = self.servicesOpportunityTextView.text
        case considerationExplainTextView:
            self.sharedDataModel.currentTransaction.businessSelection.pleaseExplain = self.considerationExplainTextView.text
            
        default:
            break
        }
        
    }
}
