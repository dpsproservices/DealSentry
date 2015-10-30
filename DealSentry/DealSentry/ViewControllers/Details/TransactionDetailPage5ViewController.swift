//
//  TransactionDetailPage4ViewController.swift
//

import UIKit

class TransactionDetailPage5ViewController: TransactionDetailPageViewController {
    
    var debugUtil = DebugUtility(thisClassName: "TransactionDetailPage4ViewController", enabled: false)
    let sharedDataModel = SharedDataModel.sharedInstance

    @IBOutlet weak var nonProfitImgWarning: UIImageView!
    @IBOutlet weak var nonProfitTxtWarning: UILabel!
    
    @IBOutlet weak var govtImgWarning: UIImageView!
    @IBOutlet weak var govtTxtWarning: UILabel!
    @IBOutlet weak var backImageCenterX: NSLayoutConstraint!
    @IBOutlet weak var forwardImageCenterX: NSLayoutConstraint!
    
    @IBAction func backButtonAction(sender: UIButton) {
        self.transactionDetailViewController.goToPage(4,whichWay: -1)
        NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: nil)

    }
    
    @IBAction func forwardButtonAction(sender: UIButton) {
        if (!self.sharedDataModel.currentTransaction.transactionDetail.dealStatus.isEmpty){
            self.transactionDetailViewController.goToPage(6,whichWay: 1)
            NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: nil)

        }

        
    }
    
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var forwardImage: UIImageView!
    
    @IBOutlet weak var financialSponsorSegmentedControl: UISegmentedControl!
    @IBOutlet weak var nonProfitSegmentedControl: UISegmentedControl!
    @IBOutlet weak var govtAffiliatedSegmentedControl: UISegmentedControl!
   // @IBOutlet weak var likelyTakePlaceSegmentedControl: UISegmentedControl!
   // @IBOutlet weak var requestsSegmentedControl: UISegmentedControl!
    
    /// this method will set the index for financialSponsorSegmentedControl segmentControl and update the corresponding object of the transaction
    @IBAction func sponsorValueChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            self.sharedDataModel.currentTransaction.transactionDetail.hasFinancialSponsor = "Yes"
        } else {
            self.sharedDataModel.currentTransaction.transactionDetail.hasFinancialSponsor = "No"
        }
    }
    
    /// this method will set the index for nonProfitSegmentedControl segmentControl and update the corresponding object of the transaction
    @IBAction func nonProfitValueChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            self.sharedDataModel.currentTransaction.transactionDetail.hasNonProfitOrganization = "Yes"
        } else {
            self.sharedDataModel.currentTransaction.transactionDetail.hasNonProfitOrganization = "No"
        }
        self.nonProfitImgWarning.hidden = true
        self.nonProfitTxtWarning.hidden = true
    }
    
    /// this method will set the index for govtAffiliatedSegmentedControl segmentControl and update the corresponding object of the transaction
    @IBAction func govtAffiliatedValueChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            self.sharedDataModel.currentTransaction.transactionDetail.hasUSGovtAffiliatedMunicipality = "Yes"
        } else {
            self.sharedDataModel.currentTransaction.transactionDetail.hasUSGovtAffiliatedMunicipality = "No"
        }
        self.govtImgWarning.hidden = true
        self.govtTxtWarning.hidden = true
    }
    
//    @IBAction func likelyToTakePlaceValueChanged(sender: UISegmentedControl) {
//        if sender.selectedSegmentIndex == 1 {
//            self.sharedDataModel.currentTransaction.transactionDetail.likelyToTakePlace = "Yes"
//        } else {
//            self.sharedDataModel.currentTransaction.transactionDetail.likelyToTakePlace = "No"
//        }
//    }
    
    
    @IBAction func requestsValueChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            self.sharedDataModel.currentTransaction.transactionDetail.requests = "Yes"
        } else {
            self.sharedDataModel.currentTransaction.transactionDetail.requests = "No"
        }
        
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
        super.pageNumber=5
        
        self.view.layer.backgroundColor = (appAttributes.colorBackgroundColor).CGColor
        appAttributes.setColorAttributesSegmentControl(financialSponsorSegmentedControl)
        appAttributes.setColorAttributesSegmentControl(nonProfitSegmentedControl)
        appAttributes.setColorAttributesSegmentControl(govtAffiliatedSegmentedControl)
       // appAttributes.setColorAttributesSegmentControl(likelyTakePlaceSegmentedControl)
        //appAttributes.setColorAttributesSegmentControl(requestsSegmentedControl)
        if let image = backImage.image {
            backImage.image = image.imageWithColor(UIColor(CGColor: appAttributes.colorBlue)).imageWithRenderingMode(.AlwaysOriginal)
        }
        if let image = forwardImage.image {
            forwardImage.image = image.imageWithColor(UIColor(CGColor: appAttributes.colorBlue)).imageWithRenderingMode(.AlwaysOriginal)
        }
        
        if sharedDataModel.currentTransaction.transactionStatus != "Draft" && sharedDataModel.currentTransaction.transactionStatus != "Pending Review" && sharedDataModel.currentTransaction.transactionStatus != "Cleared" && sharedDataModel.currentTransaction.transactionStatus != "Template"
        {
            self.financialSponsorSegmentedControl.userInteractionEnabled = false
            self.financialSponsorSegmentedControl.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.nonProfitSegmentedControl.userInteractionEnabled = false
            self.nonProfitSegmentedControl.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.govtAffiliatedSegmentedControl.userInteractionEnabled = false
            self.govtAffiliatedSegmentedControl.backgroundColor = appAttributes.grayColorForClosedDeals
            
//            self.likelyTakePlaceSegmentedControl.userInteractionEnabled = false
//            self.likelyTakePlaceSegmentedControl.backgroundColor = appAttributes.grayColorForClosedDeals
            
        }
        
        self.debugUtil.printLog("viewDidLoad", msg: "END")
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
        showHidePage6()

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
    
    /// this method provides data from object to view controller
    func resetViewsFromModel() {
        if self.sharedDataModel.currentTransaction.transactionDetail.hasFinancialSponsor == "Yes" {
            self.financialSponsorSegmentedControl.selectedSegmentIndex = 1
        } else  if self.sharedDataModel.currentTransaction.transactionDetail.hasFinancialSponsor == "No" {
            self.financialSponsorSegmentedControl.selectedSegmentIndex = 0
        } else {
            self.financialSponsorSegmentedControl.selectedSegmentIndex = -1

        }
        if self.sharedDataModel.currentTransaction.transactionDetail.hasNonProfitOrganization == "Yes" {
            self.nonProfitImgWarning.hidden = true
            self.nonProfitTxtWarning.hidden = true
            self.nonProfitSegmentedControl.selectedSegmentIndex = 1
        } else if self.sharedDataModel.currentTransaction.transactionDetail.hasNonProfitOrganization == "No" {
            self.nonProfitSegmentedControl.selectedSegmentIndex = 0
            self.nonProfitImgWarning.hidden = true
            self.nonProfitTxtWarning.hidden = true
        } else {
            self.nonProfitSegmentedControl.selectedSegmentIndex = -1
            self.nonProfitImgWarning.hidden = true
            self.nonProfitTxtWarning.hidden = true
        }
        if self.sharedDataModel.currentTransaction.transactionDetail.hasUSGovtAffiliatedMunicipality == "Yes" {
            self.govtAffiliatedSegmentedControl.selectedSegmentIndex = 1
            self.govtImgWarning.hidden = true
            self.govtTxtWarning.hidden = true
        } else if self.sharedDataModel.currentTransaction.transactionDetail.hasUSGovtAffiliatedMunicipality == "No" {
            self.govtAffiliatedSegmentedControl.selectedSegmentIndex = 0
            self.govtImgWarning.hidden = true
            self.govtTxtWarning.hidden = true
        } else {
            self.govtAffiliatedSegmentedControl.selectedSegmentIndex = -1
            self.govtImgWarning.hidden = true
            self.govtTxtWarning.hidden = true
        }
//        if self.sharedDataModel.currentTransaction.transactionDetail.likelyToTakePlace == "Yes" {
//            self.likelyTakePlaceSegmentedControl.selectedSegmentIndex = 1
//        } else if self.sharedDataModel.currentTransaction.transactionDetail.likelyToTakePlace == "No"{
//            self.likelyTakePlaceSegmentedControl.selectedSegmentIndex = 0
//        } else {
//            self.likelyTakePlaceSegmentedControl.selectedSegmentIndex = -1
//
//        }
        /*
        if self.sharedDataModel.currentTransaction.transactionDetail.requests == "Yes" {
            self.requestsSegmentedControl.selectedSegmentIndex = 1
        } else if self.sharedDataModel.currentTransaction.transactionDetail.requests == "No"{
            self.requestsSegmentedControl.selectedSegmentIndex = 0
        } else {
            self.requestsSegmentedControl.selectedSegmentIndex = -1
        }*/
        
    }
    
    func showHidePage6() {
        if (forwardButton != nil) {
            if (self.transactionDetailViewController.numberOfPages == 6){
                self.forwardButton.enabled = true
                self.forwardImage.hidden = false
            } else {
                self.forwardButton.enabled = false
                self.forwardImage.hidden = true
                
            }
        }
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
