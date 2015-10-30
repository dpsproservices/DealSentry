//
//  BusinessSelectionPage4ViewController
// Sell Side M & A questions

import UIKit

class BusinessSelectionPage4ViewController: BusinessSelectionPageViewController {
    
    var debugUtil = DebugUtility(thisClassName: "BusinessSelectionPage4ViewController", enabled: false)
    let sharedDataModel = SharedDataModel.sharedInstance
    let appAttributes = AppAttributes()
    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var materialImgWarning: UIImageView!
    @IBOutlet weak var materialTxtWarning: UILabel!
    @IBOutlet weak var materialQuestionLabel: UILabel!

    @IBOutlet weak var typeLabelForEither: UILabel!
    @IBOutlet weak var buySellHeading: UILabel!

    
    @IBOutlet weak var commoditiesImgWarning: UIImageView!
    @IBOutlet weak var commoditiesTxtWarning: UILabel!
    @IBOutlet weak var commoditiesQuestionLabel: UILabel!
    
    @IBOutlet weak var potentialWealthManagementImgWarning: UIImageView!
    @IBOutlet weak var potentialWealthManagementTxtWarning: UILabel!
    @IBOutlet weak var potentialWealthManagementQuestionLabel: UILabel!
    
    @IBOutlet weak var descriptionWealthManagementImgWarning: UIImageView!
    @IBOutlet weak var descriptionWealthManagementTxtWarning: UILabel!
    @IBOutlet weak var descriptionWealthManagementQuestionLabel: UILabel!
    @IBOutlet weak var textViewForDescription: UITextView!
    
    @IBOutlet weak var backImageCenterX: NSLayoutConstraint!
    //Constraints for buy side:
    
    @IBOutlet weak var materialQuestionLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var buySellHeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var commoditiesQuestionLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var commoditiesErrorTextConstraint: NSLayoutConstraint!
    @IBOutlet weak var commoditiesErrorImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var materialTextWarningConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var commoditiesSegmentControlConstraint: NSLayoutConstraint!
    @IBOutlet weak var materialSegmentControlConstraint: NSLayoutConstraint!
    @IBOutlet weak var materialErrorImageConstraint: NSLayoutConstraint!
    
    //
    
    // constraint for sell side
    
    @IBOutlet weak var potentialWealthManagementQuestionLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var potentialWealthManagementSegmentControlConstraint: NSLayoutConstraint!
    @IBOutlet weak var potentialWealthManagementErrorImgConstraint: NSLayoutConstraint!
    @IBOutlet weak var potentialWealthManagementErrorTextConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var opportunitiesDescriptionQuestionLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var opportunitiesDescriptionTextViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var opportunitiesDescriptionErrorImgConstraint: NSLayoutConstraint!
    @IBOutlet weak var opportunitiesDescriptionErrorTextConstraint: NSLayoutConstraint!
    
    
    //
    /// this method will push the user to previous page
    @IBAction func backButtonAction(sender: UIButton) {
         self.businessSelectionViewController.goToPage(3,whichWay: -1)
        NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: nil)

    }

    
    @IBOutlet weak var hasDerivativesExposureSegmentedControl: UISegmentedControl!
    
    /// this method will set the index for hasDerivativesExposureSegmentedControl and update the corresponding object of the transaction
    @IBAction func derivativesExposureValueChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            self.sharedDataModel.currentTransaction.businessSelection.hasDerivativesExposure = "Yes"
        } else {
            self.sharedDataModel.currentTransaction.businessSelection.hasDerivativesExposure  = "No"
        }
        self.materialImgWarning.hidden = true
        self.materialImgWarning.hidden = true
    }
    
    
    @IBOutlet weak var hasCommodityExposureSegmentedControl: UISegmentedControl!
    
    /// this method will set the index for hasCommodityExposureSegmentedControl and update the corresponding object of the transaction 
        @IBAction func commodityExposureValueChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            self.sharedDataModel.currentTransaction.businessSelection.hasCommoditiesExposure = "Yes"
        } else {
            self.sharedDataModel.currentTransaction.businessSelection.hasCommoditiesExposure  = "No"
        }
        self.commoditiesImgWarning.hidden = true
        self.commoditiesTxtWarning.hidden = true
    }
    
    @IBOutlet weak var hasPotentialWealthManagement: UISegmentedControl!

    /// this method will set the index for hasPotentialWealthManagement and update the corresponding object of the transaction
    @IBAction func hasPotentialWealthManagementValueChanged(sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 1 {
        self.sharedDataModel.currentTransaction.businessSelection.hasWealthManagementOpportunity = "Yes"
        self.descriptionWealthManagementImgWarning.hidden = false
        self.descriptionWealthManagementTxtWarning.hidden = false
        self.textViewForDescription.editable = true

    } else {
        self.sharedDataModel.currentTransaction.businessSelection.hasWealthManagementOpportunity  = "No"
        self.sharedDataModel.currentTransaction.businessSelection.wealthManagementOpportunity = ""
        self.textViewForDescription.text = ""
        self.textViewForDescription.editable = false

        self.descriptionWealthManagementImgWarning.hidden = true
        self.descriptionWealthManagementTxtWarning.hidden = true
    }
    self.potentialWealthManagementImgWarning.hidden = true
    self.potentialWealthManagementTxtWarning.hidden = true
    
    }
    
    @IBOutlet weak var hasTypeBuyOrSell: UISegmentedControl!
    
    /// this method will set the index for hasTypeBuyOrSell and update the corresponding object of the transaction
    @IBAction func hasTypeBuyOrSellValueChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0
    {
        self.sharedDataModel.currentTransaction.businessSelection.businessSelectionTypeForEither = "Buy"
        self.hasTypeBuyOrSell.hidden = false
        self.typeLabelForEither.hidden  = false
        self.buySellHeading.hidden = false
        self.buySellHeading.text = "Buy Side M&A"
        potentialWealthManagementImgWarning.hidden = true
        potentialWealthManagementQuestionLabel.hidden = true
        potentialWealthManagementTxtWarning.hidden = true
        descriptionWealthManagementImgWarning.hidden = true
        descriptionWealthManagementQuestionLabel.hidden = true
        descriptionWealthManagementTxtWarning.hidden = true
        textViewForDescription.hidden = true
        hasPotentialWealthManagement.hidden = true
        textViewForDescription.text = ""
        hasPotentialWealthManagement.selectedSegmentIndex = 0
        self.sharedDataModel.currentTransaction.businessSelection.hasWealthManagementOpportunity = "No"
        self.sharedDataModel.currentTransaction.businessSelection.wealthManagementOpportunity = ""
        
        self.materialImgWarning.hidden = true
        self.materialQuestionLabel.hidden = false
        self.materialTxtWarning.hidden = true
        self.commoditiesImgWarning.hidden = true
        self.commoditiesQuestionLabel.hidden = false
        self.commoditiesTxtWarning.hidden = true
        self.hasCommodityExposureSegmentedControl.hidden = false
        self.hasDerivativesExposureSegmentedControl.hidden = false
        self.hasCommodityExposureSegmentedControl.selectedSegmentIndex = 0
        self.hasDerivativesExposureSegmentedControl.selectedSegmentIndex = 0
    }
    else if sender.selectedSegmentIndex == 1
    {
        self.sharedDataModel.currentTransaction.businessSelection.businessSelectionTypeForEither = "Sell"

        self.hasTypeBuyOrSell.hidden = false
        self.typeLabelForEither.hidden  = false
        self.buySellHeading.hidden = false
        self.buySellHeading.text = "Sell Side M&A"
        self.potentialWealthManagementImgWarning.hidden = true
        self.potentialWealthManagementQuestionLabel.hidden = false
        self.potentialWealthManagementTxtWarning.hidden = true
        self.descriptionWealthManagementImgWarning.hidden = true
        self.descriptionWealthManagementQuestionLabel.hidden = false
        self.descriptionWealthManagementTxtWarning.hidden = true
        textViewForDescription.hidden = false
        textViewForDescription.editable = false
        self.hasPotentialWealthManagement.hidden = false
        hasPotentialWealthManagement.selectedSegmentIndex = 0
        
        self.materialImgWarning.hidden = true
        self.materialQuestionLabel.hidden = true
        self.materialTxtWarning.hidden = true
        self.commoditiesImgWarning.hidden = true
        self.commoditiesQuestionLabel.hidden = true
        self.commoditiesTxtWarning.hidden = true
        self.hasCommodityExposureSegmentedControl.hidden = true
        self.hasDerivativesExposureSegmentedControl.hidden = true
        self.hasCommodityExposureSegmentedControl.selectedSegmentIndex = 0
        self.hasDerivativesExposureSegmentedControl.selectedSegmentIndex = 0
        
        self.sharedDataModel.currentTransaction.businessSelection.hasCommoditiesExposure = "No"
        self.sharedDataModel.currentTransaction.businessSelection.hasDerivativesExposure = "No"
        
        potentialWealthManagementQuestionLabelConstraint.constant = 145.5
        
        potentialWealthManagementSegmentControlConstraint.constant = 53.0
        
        potentialWealthManagementErrorImgConstraint.constant = 22.0
        
        potentialWealthManagementErrorTextConstraint.constant = 22.0
        
        opportunitiesDescriptionQuestionLabelConstraint.constant = -17.5
        
        opportunitiesDescriptionTextViewConstraint.constant = -95.0
        
        opportunitiesDescriptionErrorImgConstraint.constant = -147.5
        
        opportunitiesDescriptionErrorTextConstraint.constant = -147.5
    }
        
    else
    {
            self.hasTypeBuyOrSell.hidden = false
            self.typeLabelForEither.hidden  = false
            self.buySellHeading.hidden = true
            potentialWealthManagementImgWarning.hidden = true
            potentialWealthManagementQuestionLabel.hidden = true
            potentialWealthManagementTxtWarning.hidden = true
            descriptionWealthManagementImgWarning.hidden = true
            descriptionWealthManagementQuestionLabel.hidden = true
            descriptionWealthManagementTxtWarning.hidden = true
            textViewForDescription.hidden = true
            hasPotentialWealthManagement.hidden = true
            
            self.materialImgWarning.hidden = true
            self.materialQuestionLabel.hidden = true
            self.materialTxtWarning.hidden = true
            self.commoditiesImgWarning.hidden = true
            self.commoditiesQuestionLabel.hidden = true
            self.commoditiesTxtWarning.hidden = true
            self.hasCommodityExposureSegmentedControl.hidden = true
            self.hasDerivativesExposureSegmentedControl.hidden = true
    }

        
    }
    
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue
        {
            if self.sharedDataModel.checkForCollapseButton == "YES"
            {
                backImageCenterX.constant = -475.5
            }
            else
            {
                backImageCenterX.constant = -325.5
            }
        }
        else
        {
            if self.sharedDataModel.checkForCollapseButton == "YES"
            {
                backImageCenterX.constant = -365.0
            }
            else
            {
                backImageCenterX.constant = -215.0
            }
            
        }
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    override func viewDidLoad() {
        self.debugUtil.printLog("viewDidLoad", msg: "BEGIN")
        
        super.viewDidLoad()
        super.pageNumber = 4
        self.textViewForDescription.delegate = self
        self.appAttributes.setColorAttributesTV(textViewForDescription)
        self.view.layer.backgroundColor = (appAttributes.colorBackgroundColor).CGColor
        appAttributes.setColorAttributesSegmentControl(hasDerivativesExposureSegmentedControl)
        appAttributes.setColorAttributesSegmentControl(hasCommodityExposureSegmentedControl)
        appAttributes.setColorAttributesSegmentControl(hasTypeBuyOrSell)
        appAttributes.setColorAttributesSegmentControl(hasPotentialWealthManagement)
        if let image = backImage.image {
            backImage.image = image.imageWithColor(UIColor(CGColor: appAttributes.colorBlue)).imageWithRenderingMode(.AlwaysOriginal)
        }
        
        if sharedDataModel.currentTransaction.transactionStatus != "Draft" && sharedDataModel.currentTransaction.transactionStatus != "Pending Review" && sharedDataModel.currentTransaction.transactionStatus != "Cleared" && sharedDataModel.currentTransaction.transactionStatus != "Template"
        {
            self.hasDerivativesExposureSegmentedControl.userInteractionEnabled = false
            self.hasDerivativesExposureSegmentedControl.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.hasCommodityExposureSegmentedControl.userInteractionEnabled = false
            self.hasCommodityExposureSegmentedControl.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.hasTypeBuyOrSell.userInteractionEnabled = false
            self.hasTypeBuyOrSell.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.hasPotentialWealthManagement.userInteractionEnabled = false
            self.hasPotentialWealthManagement.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.textViewForDescription.userInteractionEnabled = false
            self.textViewForDescription.backgroundColor = appAttributes.grayColorForClosedDeals

        }


        self.debugUtil.printLog("viewDidLoad", msg: "END")
    }
    
    ///this method provides data from the object to the view controller
    func resetViewsFromModel() {
        
        if (self.sharedDataModel.currentTransaction.businessSelection.hasDerivativesExposure == "Yes") {
            self.hasDerivativesExposureSegmentedControl.selectedSegmentIndex = 1
            self.materialImgWarning.hidden = true
            self.materialTxtWarning.hidden = true
        } else if self.sharedDataModel.currentTransaction.businessSelection.hasDerivativesExposure == "No" {
            self.hasDerivativesExposureSegmentedControl.selectedSegmentIndex = 0
            self.materialImgWarning.hidden = true
            self.materialTxtWarning.hidden = true
        } else {
            self.hasDerivativesExposureSegmentedControl.selectedSegmentIndex = 0
            if(!hasDerivativesExposureSegmentedControl.hidden)
            {
                self.materialImgWarning.hidden = true
                self.materialTxtWarning.hidden = true
            }
            else
            {
                self.materialImgWarning.hidden = true
                self.materialTxtWarning.hidden = true
            }
            
        }
        
        if (self.sharedDataModel.currentTransaction.businessSelection.hasCommoditiesExposure == "Yes") {
            self.hasCommodityExposureSegmentedControl.selectedSegmentIndex = 1
            self.commoditiesImgWarning.hidden = true
            self.commoditiesTxtWarning.hidden = true
        } else if self.sharedDataModel.currentTransaction.businessSelection.hasCommoditiesExposure == "No" {
            self.hasCommodityExposureSegmentedControl.selectedSegmentIndex = 0
            self.commoditiesImgWarning.hidden = true
            self.commoditiesTxtWarning.hidden = true
        } else {
            self.hasCommodityExposureSegmentedControl.selectedSegmentIndex = 0
            if(!hasCommodityExposureSegmentedControl.hidden)
            {
                self.commoditiesImgWarning.hidden = true
                self.commoditiesTxtWarning.hidden = true
            }
            else
            {
                self.commoditiesImgWarning.hidden = true
                self.commoditiesTxtWarning.hidden = true
            }
            
        }
        
        if self.sharedDataModel.getBusinessType(self.sharedDataModel.currentTransaction) == "Either"
        {
        
        if (self.sharedDataModel.currentTransaction.businessSelection.hasWealthManagementOpportunity == "Yes") {
            self.hasPotentialWealthManagement.selectedSegmentIndex = 1
            self.potentialWealthManagementImgWarning.hidden = true
            self.potentialWealthManagementTxtWarning.hidden = true
            self.textViewForDescription.editable = true
        } else if self.sharedDataModel.currentTransaction.businessSelection.hasWealthManagementOpportunity == "No"{
            self.hasPotentialWealthManagement.selectedSegmentIndex = 0
            self.potentialWealthManagementImgWarning.hidden = true
            self.potentialWealthManagementTxtWarning.hidden = true
            self.textViewForDescription.editable = false
        } else {
            self.hasPotentialWealthManagement.selectedSegmentIndex = 0
            if(!hasPotentialWealthManagement.hidden)
            {
                self.potentialWealthManagementImgWarning.hidden = true
                self.potentialWealthManagementTxtWarning.hidden = true
                self.textViewForDescription.editable = false
            }
            else
            {
                self.potentialWealthManagementImgWarning.hidden = true
                self.potentialWealthManagementTxtWarning.hidden = true
                self.textViewForDescription.editable = true
            }
            
            
        }
        
        if (self.sharedDataModel.currentTransaction.businessSelection.wealthManagementOpportunity == "" && self.sharedDataModel.currentTransaction.businessSelection.hasWealthManagementOpportunity == "Yes") {
            self.textViewForDescription.text = "enter a Deal Description"
            self.textViewForDescription.textColor = UIColor.lightGrayColor()
            self.descriptionWealthManagementImgWarning.hidden = false
            self.descriptionWealthManagementTxtWarning.hidden = false
        } else {
            self.textViewForDescription.text = self.sharedDataModel.currentTransaction.businessSelection.wealthManagementOpportunity
            self.descriptionWealthManagementImgWarning.hidden = true
            self.descriptionWealthManagementTxtWarning.hidden = true
        }
        
        if self.sharedDataModel.currentTransaction.businessSelection.businessSelectionTypeForEither == "Buy"
        {
            self.hasTypeBuyOrSell.selectedSegmentIndex = 0
            self.potentialWealthManagementImgWarning.hidden = true
            self.potentialWealthManagementTxtWarning.hidden = true
            self.descriptionWealthManagementImgWarning.hidden = true
            self.descriptionWealthManagementTxtWarning.hidden = true
        }
        else if self.sharedDataModel.currentTransaction.businessSelection.businessSelectionTypeForEither == "Sell"
        {
            self.hasTypeBuyOrSell.selectedSegmentIndex = 1
            self.commoditiesImgWarning.hidden = true
            self.commoditiesTxtWarning.hidden = true
            self.materialImgWarning.hidden = true
            self.materialTxtWarning.hidden = true
        }
        else
        {
            self.hasTypeBuyOrSell.selectedSegmentIndex = -1
        }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.sharedDataModel.checkForOrientationChange == "portrait"
        {
            backImageCenterX.constant = -215.0
        }
        else
        {
            backImageCenterX.constant = -325.5
        }

        self.resetViewsFromModel()
        self.uiChangeForBuyAndSell()

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
    
    func notificationCheck()
    {
        //Take Action on Notification
        if sharedDataModel.checkForCollapseButton == "YES"
        {
            if self.sharedDataModel.checkForOrientationChange == "landscape"
            {
                backImageCenterX.constant = -475.5
            }
            else
            {
                backImageCenterX.constant = -365.0
            }
            
        }
        else
        {
            if self.sharedDataModel.checkForOrientationChange == "landscape"
            {
                backImageCenterX.constant = -325.5
            }
            else
            {
                backImageCenterX.constant = -215.0
            }
        }
    }
    
    func methodOfReceivedNotification(notification: NSNotification){
        notificationCheck()
    }
    /// this method shows buy/sell views based on the selection of buySell segment control selection only if the business type is either. if the business type is Buy then Buy views will be shown
    func uiChangeForBuyAndSell()
    {
        if self.sharedDataModel.getBusinessType(self.sharedDataModel.currentTransaction) == "Buy"
    {
        self.hasTypeBuyOrSell.hidden = true
        self.typeLabelForEither.hidden  = true
        self.buySellHeading.text = "Buy Side M&A"
        potentialWealthManagementImgWarning.hidden = true
        potentialWealthManagementQuestionLabel.hidden = true
        potentialWealthManagementTxtWarning.hidden = true
        descriptionWealthManagementImgWarning.hidden = true
        descriptionWealthManagementQuestionLabel.hidden = true
        descriptionWealthManagementTxtWarning.hidden = true
        textViewForDescription.hidden = true
        hasPotentialWealthManagement.hidden = true
        
        self.materialImgWarning.hidden = true
        self.materialQuestionLabel.hidden = false
        self.materialTxtWarning.hidden = true
        self.commoditiesImgWarning.hidden = true
        self.commoditiesQuestionLabel.hidden = false
        self.commoditiesTxtWarning.hidden = true
        self.hasCommodityExposureSegmentedControl.hidden = false
        self.hasDerivativesExposureSegmentedControl.hidden = false
        
    }
    
    else if self.sharedDataModel.getBusinessType(self.sharedDataModel.currentTransaction) == "Either"
    {
        if self.sharedDataModel.currentTransaction.businessSelection.businessSelectionTypeForEither == "Sell"
        {
            self.hasTypeBuyOrSell.hidden = false
            self.typeLabelForEither.hidden  = false
            self.buySellHeading.text = "Sell Side M&A"
            self.potentialWealthManagementImgWarning.hidden = true
            self.potentialWealthManagementQuestionLabel.hidden = false
            self.potentialWealthManagementTxtWarning.hidden = true
            self.descriptionWealthManagementQuestionLabel.hidden = false
            textViewForDescription.hidden = false
            self.hasPotentialWealthManagement.hidden = false
            if self.hasPotentialWealthManagement.selectedSegmentIndex == 1 && textViewForDescription.text.isEmpty || textViewForDescription.text == "enter a Deal Description"
            {
                self.descriptionWealthManagementImgWarning.hidden = false
                self.descriptionWealthManagementTxtWarning.hidden = false
            }
            else
            {
                self.descriptionWealthManagementImgWarning.hidden = true
                self.descriptionWealthManagementTxtWarning.hidden = true
            }

            self.materialImgWarning.hidden = true
            self.materialQuestionLabel.hidden = true
            self.materialTxtWarning.hidden = true
            self.commoditiesImgWarning.hidden = true
            self.commoditiesQuestionLabel.hidden = true
            self.commoditiesTxtWarning.hidden = true
            self.hasCommodityExposureSegmentedControl.hidden = true
            self.hasDerivativesExposureSegmentedControl.hidden = true
        
            potentialWealthManagementQuestionLabelConstraint.constant = 145.5
        
            potentialWealthManagementSegmentControlConstraint.constant = 53.0
        
            potentialWealthManagementErrorImgConstraint.constant = 22.0
        
            potentialWealthManagementErrorTextConstraint.constant = 22.0
        
            opportunitiesDescriptionQuestionLabelConstraint.constant = -17.5
        
            opportunitiesDescriptionTextViewConstraint.constant = -95.0
        
            opportunitiesDescriptionErrorImgConstraint.constant = -147.5
        
            opportunitiesDescriptionErrorTextConstraint.constant = -147.5
        }
        else if self.sharedDataModel.currentTransaction.businessSelection.businessSelectionTypeForEither == "Buy"
        {
            self.hasTypeBuyOrSell.hidden = false
            self.typeLabelForEither.hidden  = false
            self.buySellHeading.text = "Buy Side M&A"
            potentialWealthManagementImgWarning.hidden = true
            potentialWealthManagementQuestionLabel.hidden = true
            potentialWealthManagementTxtWarning.hidden = true
            descriptionWealthManagementImgWarning.hidden = true
            descriptionWealthManagementQuestionLabel.hidden = true
            descriptionWealthManagementTxtWarning.hidden = true
            textViewForDescription.hidden = true
            hasPotentialWealthManagement.hidden = true
            
            self.materialImgWarning.hidden = true
            self.materialQuestionLabel.hidden = false
            self.materialTxtWarning.hidden = true
            self.commoditiesImgWarning.hidden = true
            self.commoditiesQuestionLabel.hidden = false
            self.commoditiesTxtWarning.hidden = true
            self.hasCommodityExposureSegmentedControl.hidden = false
            self.hasDerivativesExposureSegmentedControl.hidden = false
        }
        else
        {
            self.hasTypeBuyOrSell.hidden = false
            self.typeLabelForEither.hidden  = false
            self.buySellHeading.hidden = true
            potentialWealthManagementImgWarning.hidden = true
            potentialWealthManagementQuestionLabel.hidden = true
            potentialWealthManagementTxtWarning.hidden = true
            descriptionWealthManagementImgWarning.hidden = true
            descriptionWealthManagementQuestionLabel.hidden = true
            descriptionWealthManagementTxtWarning.hidden = true
            textViewForDescription.hidden = true
            hasPotentialWealthManagement.hidden = true
            
            self.materialImgWarning.hidden = true
            self.materialQuestionLabel.hidden = true
            self.materialTxtWarning.hidden = true
            self.commoditiesImgWarning.hidden = true
            self.commoditiesQuestionLabel.hidden = true
            self.commoditiesTxtWarning.hidden = true
            self.hasCommodityExposureSegmentedControl.hidden = true
            self.hasDerivativesExposureSegmentedControl.hidden = true
        }
        
        
        
    }
    
    }
    
}

extension BusinessSelectionPage4ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(textView: UITextView) {
    if (textView.textColor != nil && textView.textColor == UIColor.lightGrayColor()) {
    textView.text = nil
    textView.textColor =  UIColor.blackColor()
    }
    }
    
    func textViewDidChange(textView: UITextView) {
        if (textView === textViewForDescription) {
            if(!textViewForDescription.text.isEmpty)
            {
                self.sharedDataModel.currentTransaction.businessSelection.wealthManagementOpportunity = self.textViewForDescription.text
                self.descriptionWealthManagementImgWarning.hidden = true
                self.descriptionWealthManagementTxtWarning.hidden = true
            }
            else
            {
                self.sharedDataModel.currentTransaction.businessSelection.wealthManagementOpportunity = ""
                self.descriptionWealthManagementImgWarning.hidden = false
                self.descriptionWealthManagementTxtWarning.hidden = false
            }
        
        }
        
    }
}
