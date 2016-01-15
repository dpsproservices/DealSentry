//
//  BusinessSelectionPage5ViewController
// Sell Side M & A questions

import UIKit

class BusinessSelectionPage5ViewController: BusinessSelectionPageViewController {
    
    var debugUtil = DebugUtility(thisClassName: "BusinessSelectionPage5ViewController", enabled: false)
    let viewStateManager = ViewStateManager.sharedInstance
    let appAttributes = AppAttributes()
    @IBOutlet weak var backImage: UIImageView!
   
    @IBOutlet weak var oppImgWarning: UIImageView!
    
    @IBOutlet weak var oppTxtWarning: UILabel!
    
    @IBOutlet weak var oppDescImgWarning: UIImageView!
    
    @IBOutlet weak var oppDescTxtWarning: UILabel!
    
    @IBOutlet weak var backImageCenterX: NSLayoutConstraint!

    /// this method will push the user to previous page    
    @IBAction func backButtonAction(sender: UIButton) {
        self.businessSelectionViewController.goToPage(3,whichWay: -1)
        NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: nil)

    }
    
    
    @IBOutlet weak var wealthManagementSegmentedControl: UISegmentedControl!
    
    /// this method will set the index for wealthManagementSegmentedControl and update the corresponding object of the transaction
    @IBAction func wealthManagementValueChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            self.viewStateManager.currentTransaction.businessSelection.hasWealthManagementOpportunity = "Yes"
            self.oppDescImgWarning.hidden = false
            self.oppDescTxtWarning.hidden = false
            self.wealthManagementOpportunityTextView.editable = true
        } else {
            self.viewStateManager.currentTransaction.businessSelection.hasWealthManagementOpportunity  = "No"
            self.viewStateManager.currentTransaction.businessSelection.wealthManagementOpportunity = ""
            self.wealthManagementOpportunityTextView.text = ""
            self.oppDescImgWarning.hidden = true
            self.oppDescTxtWarning.hidden = true
            self.wealthManagementOpportunityTextView.editable = false
        }
        self.oppImgWarning.hidden = true
        self.oppTxtWarning.hidden = true
        
    }
    
    
    @IBOutlet weak var wealthManagementOpportunityTextView: UITextView!
    
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
            }
            else
            {
                backImageCenterX.constant = -325.5
            }
            
        }
        else
        {
            if self.viewStateManager.checkForCollapseButton == "YES"
            {
                backImageCenterX.constant = -365.0
            }
            else
            {
                backImageCenterX.constant = -215.0
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        self.debugUtil.printLog("viewDidLoad", msg: "BEGIN")
        
        super.viewDidLoad()
        super.pageNumber = 5
        self.appAttributes.setColorAttributesTV(wealthManagementOpportunityTextView)
        self.wealthManagementOpportunityTextView.delegate = self
        self.resetViewsFromModel()
        self.view.layer.backgroundColor = (appAttributes.colorBackgroundColor).CGColor
        appAttributes.setColorAttributesSegmentControl(wealthManagementSegmentedControl)
        if let image = backImage.image {
            backImage.image = image.imageWithColor(UIColor(CGColor: appAttributes.colorBlue)).imageWithRenderingMode(.AlwaysOriginal)
        }
        
        if viewStateManager.currentTransaction.transactionStatus != "Draft" && viewStateManager.currentTransaction.transactionStatus != "Pending Review" && viewStateManager.currentTransaction.transactionStatus != "Cleared" && viewStateManager.currentTransaction.transactionStatus != "Template"
        {
            self.wealthManagementSegmentedControl.userInteractionEnabled = false
            self.wealthManagementSegmentedControl.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.wealthManagementOpportunityTextView.userInteractionEnabled = false
            self.wealthManagementOpportunityTextView.backgroundColor = appAttributes.grayColorForClosedDeals
            
        }

        
        self.debugUtil.printLog("viewDidLoad", msg: "END")
    }

    override func didReceiveMemoryWarning() {
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "BEGIN")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "END")
    }
    
    ///this method provides data from the object to the view controller
    func resetViewsFromModel() {
        
        if (self.viewStateManager.currentTransaction.businessSelection.hasWealthManagementOpportunity == "Yes") {
            self.wealthManagementSegmentedControl.selectedSegmentIndex = 1
            self.oppImgWarning.hidden = true
            self.oppTxtWarning.hidden = true
            self.wealthManagementOpportunityTextView.editable = true
        } else if self.viewStateManager.currentTransaction.businessSelection.hasWealthManagementOpportunity == "No"{
            self.wealthManagementSegmentedControl.selectedSegmentIndex = 0
            self.oppImgWarning.hidden = true
            self.oppTxtWarning.hidden = true
            self.wealthManagementOpportunityTextView.editable = false
        } else {
            self.wealthManagementSegmentedControl.selectedSegmentIndex = 0
            self.oppImgWarning.hidden = true
            self.oppTxtWarning.hidden = true
            self.wealthManagementOpportunityTextView.editable = false

        }
        
        if (self.viewStateManager.currentTransaction.businessSelection.wealthManagementOpportunity == "" && self.viewStateManager.currentTransaction.businessSelection.hasWealthManagementOpportunity == "Yes") {
            self.wealthManagementOpportunityTextView.text = "enter a Deal Description"
            self.wealthManagementOpportunityTextView.textColor = UIColor.lightGrayColor()
            self.oppDescImgWarning.hidden = false
            self.oppDescTxtWarning.hidden = false
        } else {
            self.wealthManagementOpportunityTextView.text = self.viewStateManager.currentTransaction.businessSelection.wealthManagementOpportunity
            self.oppDescImgWarning.hidden = true
            self.oppDescTxtWarning.hidden = true
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.viewStateManager.currentOrientation == "portrait"
        {
            backImageCenterX.constant = -215.0
        }
        else
        {
            backImageCenterX.constant = -325.5
        }

        self.resetViewsFromModel()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "methodOfReceivedNotification:", name:"NotificationIdentifier", object: nil)
        notificationCheck()
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "NotificationIdentifier", object: nil)
        
    }
    
    func notificationCheck()
    {
        //Take Action on Notification
        if viewStateManager.checkForCollapseButton == "YES"
        {
            if self.viewStateManager.currentOrientation == "landscape"
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
            if self.viewStateManager.currentOrientation == "landscape"
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

    
}

extension BusinessSelectionPage5ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(textView: UITextView) {
        if (textView.textColor != nil && textView.textColor == UIColor.lightGrayColor()) {
            textView.text = nil
            textView.textColor =  UIColor.blackColor()
        }
    }
    
    func textViewDidChange(textView: UITextView) {
        if (textView === wealthManagementOpportunityTextView) {
            if(!wealthManagementOpportunityTextView.text.isEmpty)
            {
                self.viewStateManager.currentTransaction.businessSelection.wealthManagementOpportunity = self.wealthManagementOpportunityTextView.text
                self.oppDescImgWarning.hidden = true
                self.oppDescTxtWarning.hidden = true
            }
            else
            {
                self.viewStateManager.currentTransaction.businessSelection.wealthManagementOpportunity = ""
                self.oppDescImgWarning.hidden = false
                self.oppDescTxtWarning.hidden = false
            }
        }
        
    }
}
