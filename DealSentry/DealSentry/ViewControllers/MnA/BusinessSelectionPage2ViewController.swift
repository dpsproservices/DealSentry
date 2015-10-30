//
//  BusinessSelectionPage2ViewController
//

import UIKit

class BusinessSelectionPage2ViewController: BusinessSelectionPageViewController {
    
    var debugUtil = DebugUtility(thisClassName: "BusinessSelectionPage2ViewController", enabled: false)
    let sharedDataModel = SharedDataModel.sharedInstance
    let appAttributes = AppAttributes()
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var forwardImage: UIImageView!
    
    @IBOutlet weak var consolidatedBankSegmentedControl: UISegmentedControl!
    @IBOutlet weak var investmentOpportunitySegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var consolidatedBenefitTextView: UITextView!
    @IBOutlet weak var investmentOpportunityTextView: UITextView!

    @IBOutlet weak var seg1ImgWarning: UIImageView!
    @IBOutlet weak var seg1TxtWarning: UILabel!
    @IBOutlet weak var opp1ImgWarning: UIImageView!
    @IBOutlet weak var opp1TxtWarning: UILabel!
    
    @IBOutlet weak var seg2ImgWarning: UIImageView!
    @IBOutlet weak var seg2TxtWarning: UILabel!
    @IBOutlet weak var opp2ImgWarning: UIImageView!
    @IBOutlet weak var opp2TxtWarning: UILabel!
    @IBOutlet weak var backImageCenterX: NSLayoutConstraint!
    @IBOutlet weak var forwardImageCenterX: NSLayoutConstraint!
    
    /// this method will set the index for consolidatedBankSegmentedControl and update the corresponding object of the transaction
    @IBAction func consolidatedBankValueChangeAction(sender: AnyObject) {
        if sender.selectedSegmentIndex == 1 {
            self.sharedDataModel.currentTransaction.businessSelection.isConsolidatedBankingOpportunity = "Yes"
            self.consolidatedBenefitTextView.editable = true
            opp1ImgWarning.hidden = false
            opp1TxtWarning.hidden = false

        } else {
            self.sharedDataModel.currentTransaction.businessSelection.isConsolidatedBankingOpportunity = "No"
            self.sharedDataModel.currentTransaction.businessSelection.consolidatedBankingOpportunityDescription = ""
            self.consolidatedBenefitTextView.text = ""
            self.consolidatedBenefitTextView.editable = false
            opp1ImgWarning.hidden = true
            opp1TxtWarning.hidden = true
        }
        seg1ImgWarning.hidden = true
        seg1TxtWarning.hidden = true
    }
    
        /// this method will set the index for investmentOpportunitySegmentedControl and update the corresponding object of the transaction
    @IBAction func investmentOpportunityValueChangeAction(sender: AnyObject) {
        if sender.selectedSegmentIndex == 1 {
            self.sharedDataModel.currentTransaction.businessSelection.isInvestmentOpportunity = "Yes"
            self.investmentOpportunityTextView.editable = true
            opp2ImgWarning.hidden = false
            opp2TxtWarning.hidden = false
        } else {
            self.sharedDataModel.currentTransaction.businessSelection.isInvestmentOpportunity = "No"
            self.sharedDataModel.currentTransaction.businessSelection.investmentOpportunityDescription = ""
            self.investmentOpportunityTextView.text = ""
            self.investmentOpportunityTextView.editable = false
            opp2ImgWarning.hidden = true
            opp2TxtWarning.hidden = true
        }
        seg2ImgWarning.hidden = true
        seg2TxtWarning.hidden = true
    }
    
     /// this method will push the user to previous page
    @IBAction func backButtonAction(sender: UIButton) {
        //self.businessSelectionViewController.goToPreviousContentViewController()
        self.businessSelectionViewController.goToPage(1,whichWay: -1)
        NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: nil)

    }
    
     /// this method will push the user to next page
    @IBAction func forwardButtonAction(sender: UIButton) {
        self.businessSelectionViewController.goToPage(3,whichWay: 1)
        NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: nil)

    }
    
    ///this method provides data from the object to the view controller
    func resetViewsFromModel() {
        
        if (self.sharedDataModel.currentTransaction.businessSelection.isConsolidatedBankingOpportunity == "Yes") {
            self.consolidatedBankSegmentedControl.selectedSegmentIndex = 1
            self.consolidatedBenefitTextView.editable = true
            seg1ImgWarning.hidden = true
            seg1TxtWarning.hidden = true
        } else if self.sharedDataModel.currentTransaction.businessSelection.isConsolidatedBankingOpportunity == "No"{
            self.consolidatedBankSegmentedControl.selectedSegmentIndex = 0
            self.consolidatedBenefitTextView.editable = false
            seg1ImgWarning.hidden = true
            seg1TxtWarning.hidden = true
        } else {
            self.consolidatedBankSegmentedControl.selectedSegmentIndex = -1
            self.consolidatedBenefitTextView.editable = false
            seg1ImgWarning.hidden = false
            seg1TxtWarning.hidden = false

        }
        if (self.sharedDataModel.currentTransaction.businessSelection.isInvestmentOpportunity == "Yes") {
            self.investmentOpportunitySegmentedControl.selectedSegmentIndex = 1
            self.investmentOpportunityTextView.editable = true
            seg2ImgWarning.hidden = true
            seg2TxtWarning.hidden = true
        } else if self.sharedDataModel.currentTransaction.businessSelection.isInvestmentOpportunity == "No"{
            self.investmentOpportunitySegmentedControl.selectedSegmentIndex = 0
            self.investmentOpportunityTextView.editable = false
            seg2ImgWarning.hidden = false
            seg2TxtWarning.hidden = false
        } else {
            self.investmentOpportunitySegmentedControl.selectedSegmentIndex = -1
            self.investmentOpportunityTextView.editable = false
            seg2ImgWarning.hidden = false
            seg2TxtWarning.hidden = false
        }


        if (self.sharedDataModel.currentTransaction.businessSelection.consolidatedBankingOpportunityDescription == "" && self.sharedDataModel.currentTransaction.businessSelection.isConsolidatedBankingOpportunity == "Yes") {
            self.consolidatedBenefitTextView.text = "enter a Opportunity Description"
            self.consolidatedBenefitTextView.textColor = UIColor.lightGrayColor()
            opp1ImgWarning.hidden = false
            opp1TxtWarning.hidden = false
          
        } else {
            self.consolidatedBenefitTextView.text = self.sharedDataModel.currentTransaction.businessSelection.consolidatedBankingOpportunityDescription
            opp1ImgWarning.hidden = true
            opp1TxtWarning.hidden = true
        }
        if (self.sharedDataModel.currentTransaction.businessSelection.investmentOpportunityDescription == "" && self.sharedDataModel.currentTransaction.businessSelection.isInvestmentOpportunity == "Yes") {
            self.investmentOpportunityTextView.text = "enter a Opportunity Description"
            self.investmentOpportunityTextView.textColor = UIColor.lightGrayColor()
            opp2ImgWarning.hidden = false
            opp2TxtWarning.hidden = false

        } else {
            self.investmentOpportunityTextView.text = self.sharedDataModel.currentTransaction.businessSelection.investmentOpportunityDescription
            opp2ImgWarning.hidden = true
            opp2TxtWarning.hidden = true
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
        super.pageNumber = 2
        self.appAttributes.setColorAttributesTV(consolidatedBenefitTextView)
        self.consolidatedBenefitTextView.delegate = self
        self.appAttributes.setColorAttributesTV(investmentOpportunityTextView)
        self.investmentOpportunityTextView.delegate = self
        self.view.layer.backgroundColor = (appAttributes.colorBackgroundColor).CGColor
        appAttributes.setColorAttributesSegmentControl(consolidatedBankSegmentedControl)
        appAttributes.setColorAttributesSegmentControl(investmentOpportunitySegmentedControl)
        if let image = backImage.image {
            backImage.image = image.imageWithColor(UIColor(CGColor: appAttributes.colorBlue)).imageWithRenderingMode(.AlwaysOriginal)
        }
        if let image = forwardImage.image {
            forwardImage.image = image.imageWithColor(UIColor(CGColor: appAttributes.colorBlue)).imageWithRenderingMode(.AlwaysOriginal)
        }
        
        if sharedDataModel.currentTransaction.transactionStatus != "Draft" && sharedDataModel.currentTransaction.transactionStatus != "Pending Review" && sharedDataModel.currentTransaction.transactionStatus != "Cleared" && sharedDataModel.currentTransaction.transactionStatus != "Template"
        {
            self.consolidatedBankSegmentedControl.userInteractionEnabled = false
            self.consolidatedBankSegmentedControl.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.investmentOpportunitySegmentedControl.userInteractionEnabled = false
            self.investmentOpportunitySegmentedControl.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.consolidatedBenefitTextView.userInteractionEnabled = false
            self.consolidatedBenefitTextView.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.investmentOpportunityTextView.userInteractionEnabled = false
            self.investmentOpportunityTextView.backgroundColor = appAttributes.grayColorForClosedDeals
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
extension BusinessSelectionPage2ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(textView: UITextView) {
        if (textView.textColor != nil && textView.textColor == UIColor.lightGrayColor()) {
            textView.text = nil
            textView.textColor =  UIColor.blackColor()
        }
    }
    
    
    func textViewDidChange(textView: UITextView) {
        if (textView === consolidatedBenefitTextView) {
            self.sharedDataModel.currentTransaction.businessSelection.consolidatedBankingOpportunityDescription = self.consolidatedBenefitTextView.text
            if self.consolidatedBenefitTextView == "" {
                opp1ImgWarning.hidden = false
                opp1TxtWarning.hidden = false
            } else {
                opp1ImgWarning.hidden = true
                opp1TxtWarning.hidden = true
               
            }
        }
        if (textView === investmentOpportunityTextView) {
            self.sharedDataModel.currentTransaction.businessSelection.investmentOpportunityDescription = self.investmentOpportunityTextView.text
            if self.investmentOpportunityTextView == "" {
                opp2ImgWarning.hidden = false
                opp2TxtWarning.hidden = false
            } else {
                opp2ImgWarning.hidden = true
                opp2TxtWarning.hidden = true

            }
        }

    }
}
