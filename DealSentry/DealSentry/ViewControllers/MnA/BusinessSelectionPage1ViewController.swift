//
//  BusinessSelectionPage1ViewController
//

import UIKit

class BusinessSelectionPage1ViewController: BusinessSelectionPageViewController {
    
    var debugUtil = DebugUtility(thisClassName: "BusinessSelectionPage1ViewController", enabled: false)
    let viewStateManager = ViewStateManager.sharedInstance
    let appAttributes = AppAttributes()
    
    @IBOutlet weak var buySellDiffCurrenciesButton: UISegmentedControl!
    @IBOutlet weak var ukCompanyButton: UISegmentedControl!
    @IBOutlet weak var friendlyHostileButton: UISegmentedControl!
    @IBOutlet weak var ratingChgButton: UISegmentedControl!
    @IBOutlet weak var govtAgencyButton: UISegmentedControl!
    
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var forwardImage: UIImageView!
    
    @IBOutlet weak var forwardImageCenterX: NSLayoutConstraint!
    
    @IBOutlet weak var buySellImgWarning: UIImageView!
    @IBOutlet weak var buySellTxtWarning: UILabel!
    @IBOutlet weak var ukPublicImgWarning: UIImageView!
    @IBOutlet weak var ukPublicTxtWarning: UILabel!
    @IBOutlet weak var friendlyImgWarning: UIImageView!
    @IBOutlet weak var friendlyTxtWarning: UILabel!
    @IBOutlet weak var ratingImgWarning: UIImageView!
    @IBOutlet weak var ratingTxtWarning: UILabel!
    @IBOutlet weak var govtImgWarning: UIImageView!
    @IBOutlet weak var govtTxtWarning: UILabel!
    
    
    /// this method will set the index for buySellDiffCurrenciesButton segmentControl and update the corresponding object of the transaction
    @IBAction func buySellDiffCurrenciesValueChangedAction(sender: AnyObject) {
        if sender.selectedSegmentIndex == 1 {
            self.viewStateManager.currentTransaction.businessSelection.isDifferentCurrencies = "Yes"
        } else {
            self.viewStateManager.currentTransaction.businessSelection.isDifferentCurrencies = "No"
        }
        buySellImgWarning.hidden = true
        buySellTxtWarning.hidden = true
    }
    
    /// this method will set the index for ukCompanyButton segmentControl and update the corresponding object of the transaction
    @IBAction func ukCompanyValueChangedAction(sender: AnyObject) {
        if sender.selectedSegmentIndex == 1 {
            self.viewStateManager.currentTransaction.businessSelection.isUKCompanyInvolved = "Yes"
        } else {
            self.viewStateManager.currentTransaction.businessSelection.isUKCompanyInvolved = "No"
        }
        ukPublicImgWarning.hidden = true
        ukPublicTxtWarning.hidden = true
    }
    
    /// this method will set the index for friendlyHostileButton segmentControl and update the corresponding object of the transaction
    @IBAction func friendlyHostileValueChangedAction(sender: AnyObject) {
        if sender.selectedSegmentIndex == 1 {
            self.viewStateManager.currentTransaction.businessSelection.isFriendlyOrHostile = "Hostile"
        } else {
            self.viewStateManager.currentTransaction.businessSelection.isFriendlyOrHostile = "Friendly"
        }
        friendlyImgWarning.hidden = true
        friendlyTxtWarning.hidden = true
    }
    
     /// this method will set the index for ratingChgButton segmentControl and update the corresponding object of the transaction
    @IBAction func ratingChgValueChangedAction(sender: AnyObject) {
        if sender.selectedSegmentIndex == 1 {
            self.viewStateManager.currentTransaction.businessSelection.isDownwardRatingsLikely = "Yes"
        } else {
            self.viewStateManager.currentTransaction.businessSelection.isDownwardRatingsLikely = "No"
        }
        ratingImgWarning.hidden = true
        ratingTxtWarning.hidden = true
    }
    
    /// this method will set the index for govtAgencyButton segmentControl and update the corresponding object of the transaction
    @IBAction func govtAgencyValueChangedAction(sender: AnyObject) {
        if sender.selectedSegmentIndex == 1 {
            self.viewStateManager.currentTransaction.businessSelection.isGovernmentAgency = "Yes"
        } else {
            self.viewStateManager.currentTransaction.businessSelection.isGovernmentAgency = "No"
        }
        govtImgWarning.hidden = true
        govtTxtWarning.hidden = true
    }
    
    /// this method will push the user to next page
    @IBAction func forwardButtonAction(sender: UIButton) {
        self.businessSelectionViewController.goToPage(2,whichWay: 1)
        NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: nil)

    }

    ///this method provides data from the object to the view controller
    func resetViewsFromModel() {
        
        if (self.viewStateManager.currentTransaction.businessSelection.isDifferentCurrencies == "Yes") {
            self.buySellDiffCurrenciesButton.selectedSegmentIndex = 1
            self.buySellImgWarning.hidden = true
            self.buySellTxtWarning.hidden = true
        } else if self.viewStateManager.currentTransaction.businessSelection.isDifferentCurrencies == "No"{
            self.buySellDiffCurrenciesButton.selectedSegmentIndex = 0
            self.buySellImgWarning.hidden = true
            self.buySellTxtWarning.hidden = true
        } else {
            self.buySellDiffCurrenciesButton.selectedSegmentIndex = -1
            self.buySellImgWarning.hidden = false
            self.buySellTxtWarning.hidden = false
        }
        if (self.viewStateManager.currentTransaction.businessSelection.isUKCompanyInvolved == "Yes") {
            self.ukCompanyButton.selectedSegmentIndex = 1
            self.ukPublicImgWarning.hidden = true
            self.ukPublicTxtWarning.hidden = true
        } else if self.viewStateManager.currentTransaction.businessSelection.isUKCompanyInvolved == "No"{
            self.ukCompanyButton.selectedSegmentIndex = 0
            self.ukPublicImgWarning.hidden = true
            self.ukPublicTxtWarning.hidden = true
        } else {
            self.ukCompanyButton.selectedSegmentIndex = -1
            self.ukPublicImgWarning.hidden = false
            self.ukPublicTxtWarning.hidden = false
        }
        if (self.viewStateManager.currentTransaction.businessSelection.isFriendlyOrHostile == "Hostile") {
            self.friendlyHostileButton.selectedSegmentIndex = 1
            self.friendlyImgWarning.hidden = true
            self.friendlyTxtWarning.hidden = true
        } else if self.viewStateManager.currentTransaction.businessSelection.isFriendlyOrHostile == "Friendly"{
            self.friendlyHostileButton.selectedSegmentIndex = 0
            self.friendlyImgWarning.hidden = true
            self.friendlyTxtWarning.hidden = true
        } else {
            self.friendlyHostileButton.selectedSegmentIndex = -1
            self.friendlyImgWarning.hidden = false
            self.friendlyTxtWarning.hidden = false
        }
        if (self.viewStateManager.currentTransaction.businessSelection.isDownwardRatingsLikely == "Yes") {
            self.ratingChgButton.selectedSegmentIndex = 1
            self.ratingImgWarning.hidden = true
            self.ratingTxtWarning.hidden = true
        } else if self.viewStateManager.currentTransaction.businessSelection.isDownwardRatingsLikely == "No"{
            self.ratingChgButton.selectedSegmentIndex = 0
            self.ratingImgWarning.hidden = true
            self.ratingTxtWarning.hidden = true
        } else {
            self.ratingChgButton.selectedSegmentIndex = -1
            self.ratingImgWarning.hidden = false
            self.ratingTxtWarning.hidden = false
        }
        if (self.viewStateManager.currentTransaction.businessSelection.isGovernmentAgency == "Yes") {
            self.govtAgencyButton.selectedSegmentIndex = 1
            self.govtImgWarning.hidden = true
            self.govtTxtWarning.hidden = true
        } else if self.viewStateManager.currentTransaction.businessSelection.isGovernmentAgency == "No"{
            self.govtAgencyButton.selectedSegmentIndex = 0
            self.govtImgWarning.hidden = true
            self.govtTxtWarning.hidden = true
        } else {
            self.govtAgencyButton.selectedSegmentIndex = -1
            self.govtImgWarning.hidden = false
            self.govtTxtWarning.hidden = false
        }


    }
    
    /// this method determines to show the next page or not by enabling/hiding the forward button based on current transaction business type
    func showHidePage2() {
        if (forwardButton != nil) {
            if self.viewStateManager.getBusinessType(self.viewStateManager.currentTransaction) != "N/A"{
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
        if self.viewStateManager.currentOrientation == "portrait"
        {
            forwardImageCenterX.constant = 215.0
        }
        else
        {
            forwardImageCenterX.constant = 325.5
        }

        self.resetViewsFromModel()
        self.businessSelectionViewController.setLastPage()
        self.showHidePage2()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "methodOfReceivedNotification:", name:"NotificationIdentifier", object: nil)
        notificationCheck()
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "NotificationIdentifier", object: nil)
        
    }
    
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue
        {
            if viewStateManager.checkForCollapseButton == "YES"
            {
                forwardImageCenterX.constant = 475.5
            }
            else
            {
                forwardImageCenterX.constant = 325.5
            }
           
        }
        else
        {
            if viewStateManager.checkForCollapseButton == "YES"
            {
                forwardImageCenterX.constant = 365.0
            }
            else
            {
                forwardImageCenterX.constant = 215.0
            }
            
        }
        
    }
    
    
    override func viewDidLoad() {
        self.debugUtil.printLog("viewDidLoad", msg: "BEGIN")
        
        super.viewDidLoad()
        super.pageNumber = 1
        self.view.layer.backgroundColor = (appAttributes.colorBackgroundColor).CGColor
        if let image = forwardImage.image {
            forwardImage.image = image.imageWithColor(UIColor(CGColor: appAttributes.colorBlue)).imageWithRenderingMode(.AlwaysOriginal)
        }
        
        appAttributes.setColorAttributesSegmentControl(buySellDiffCurrenciesButton)
        appAttributes.setColorAttributesSegmentControl(ukCompanyButton)
        appAttributes.setColorAttributesSegmentControl(friendlyHostileButton)
        appAttributes.setColorAttributesSegmentControl(ratingChgButton)
        appAttributes.setColorAttributesSegmentControl(govtAgencyButton)
        
        if viewStateManager.currentTransaction.transactionStatus != "Draft" && viewStateManager.currentTransaction.transactionStatus != "Pending Review" && viewStateManager.currentTransaction.transactionStatus != "Cleared" && viewStateManager.currentTransaction.transactionStatus != "Template"
        {
            self.buySellDiffCurrenciesButton.userInteractionEnabled = false
            self.buySellDiffCurrenciesButton.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.friendlyHostileButton.userInteractionEnabled = false
            self.friendlyHostileButton.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.ukCompanyButton.userInteractionEnabled = false
            self.ukCompanyButton.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.ratingChgButton.userInteractionEnabled = false
            self.ratingChgButton.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.govtAgencyButton.userInteractionEnabled = false
            self.govtAgencyButton.backgroundColor = appAttributes.grayColorForClosedDeals
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
        if viewStateManager.checkForCollapseButton == "YES"
        {
            if self.viewStateManager.currentOrientation == "landscape"
            {
                forwardImageCenterX.constant = 475.5
            }
            else
            {
                forwardImageCenterX.constant = 365.0
            }
           
        }
        else
        {
            if self.viewStateManager.currentOrientation == "landscape"
            {
                forwardImageCenterX.constant = 325.5
            }
            else
            {
                forwardImageCenterX.constant = 215.0
            }
        }
    }
    
    func methodOfReceivedNotification(notification: NSNotification){
        notificationCheck()
    }

    
}
