//
//  TransactionDetailPage4ViewController.swift
//

import UIKit

class TransactionDetailPage4ViewController: TransactionDetailPageViewController {
    
    var debugUtil = DebugUtility(thisClassName: "TransactionDetailPage4ViewController", enabled: false)
    let viewStateManager = ViewStateManager.sharedInstance

    @IBOutlet weak var indyImgWarning: UIImageView!
    @IBOutlet weak var indyTxtWarning: UILabel!
    
    @IBOutlet weak var backImageCenterX: NSLayoutConstraint!
    
    @IBOutlet weak var forwardImageCenterX: NSLayoutConstraint!
    
         /// this method will push the user to previous page
    @IBAction func backButtonAction(sender: UIButton) {
        self.transactionDetailViewController.goToPage(3,whichWay: -1)
        NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: nil)

    }
    
         /// this method will push the user to next page
    @IBAction func forwardButtonAction(sender: UIButton) {
        self.transactionDetailViewController.goToPage(5,whichWay: 1)
        NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: nil)

        
    }
    
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var forwardImage: UIImageView!
    
    
    @IBOutlet weak var sponsorSegmentedControl: UISegmentedControl!
    
    
    @IBAction func sponsorValueChanged(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 1 {
            self.viewStateManager.currentTransaction.transactionDetail.isSubjectToTakeOver = "Yes"
        } else {
            self.viewStateManager.currentTransaction.transactionDetail.isSubjectToTakeOver = "No"
        }
        self.indyImgWarning.hidden = true
        self.indyTxtWarning.hidden = true
        
    }
    
    
    @IBOutlet weak var watchListingSegmentedControl: UISegmentedControl!
    
    /// this method will set the index for watchListingSegmentedControl segmentControl and update the corresponding object of the transaction
    @IBAction func watchListingValueChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            self.viewStateManager.currentTransaction.transactionDetail.likelyToTakePlace = "Yes"
        } else {
            self.viewStateManager.currentTransaction.transactionDetail.likelyToTakePlace = "No"
        }
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
        super.pageNumber=4
        
        self.view.layer.backgroundColor = (appAttributes.colorBackgroundColor).CGColor
        appAttributes.setColorAttributesSegmentControl(sponsorSegmentedControl)
        appAttributes.setColorAttributesSegmentControl(watchListingSegmentedControl)
        if let image = backImage.image {
            backImage.image = image.imageWithColor(UIColor(CGColor: appAttributes.colorBlue)).imageWithRenderingMode(.AlwaysOriginal)
        }
        if let image = forwardImage.image {
            forwardImage.image = image.imageWithColor(UIColor(CGColor: appAttributes.colorBlue)).imageWithRenderingMode(.AlwaysOriginal)
        }
        
        if viewStateManager.currentTransaction.transactionStatus != "Draft" && viewStateManager.currentTransaction.transactionStatus != "Pending Review" && viewStateManager.currentTransaction.transactionStatus != "Cleared" && viewStateManager.currentTransaction.transactionStatus != "Template"
        {
            self.sponsorSegmentedControl.userInteractionEnabled = false
            self.sponsorSegmentedControl.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.watchListingSegmentedControl.userInteractionEnabled = false
            self.watchListingSegmentedControl.backgroundColor = appAttributes.grayColorForClosedDeals
            
        }

        self.debugUtil.printLog("viewDidLoad", msg: "END")
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
    
    
    func resetViewsFromModel() {
        
        
        if self.viewStateManager.currentTransaction.transactionDetail.isSubjectToTakeOver == "Yes" {
            self.sponsorSegmentedControl.selectedSegmentIndex = 1
            self.indyImgWarning.hidden = true
            self.indyTxtWarning.hidden = true
        } else if self.viewStateManager.currentTransaction.transactionDetail.isSubjectToTakeOver == "No"{
            self.sponsorSegmentedControl.selectedSegmentIndex = 0
            self.indyImgWarning.hidden = true
            self.indyTxtWarning.hidden = true
        } else {
            self.sponsorSegmentedControl.selectedSegmentIndex = -1
            self.indyImgWarning.hidden = true
            self.indyTxtWarning.hidden = true
        }
        
        if self.viewStateManager.currentTransaction.transactionDetail.likelyToTakePlace == "Yes" {
            
            self.watchListingSegmentedControl.selectedSegmentIndex = 1
        } else if self.viewStateManager.currentTransaction.transactionDetail.likelyToTakePlace == "No"{
            self.watchListingSegmentedControl.selectedSegmentIndex = 0
        } else {
            self.watchListingSegmentedControl.selectedSegmentIndex = -1

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
