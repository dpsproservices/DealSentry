//
//  TransactionDetailPage5ViewController.swift
//

import UIKit

class TransactionDetailPage6ViewController: TransactionDetailPageViewController {
    
    var debugUtil = DebugUtility(thisClassName: "TransactionDetailPage5ViewController", enabled: false)
    let sharedDataModel = SharedDataModel.sharedInstance
    
    @IBAction func backButtonAction(sender: UIButton) {
        self.transactionDetailViewController.goToPage(5,whichWay: -1)
        NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: nil)

    }
    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var backImageCenterX: NSLayoutConstraint!
    @IBOutlet weak var backwardExplanationTextView: UITextView!
    @IBOutlet weak var terminatedExplanationTextView: UITextView!
    @IBOutlet weak var uncollectedFeesSegmentedControl: UISegmentedControl!
    @IBOutlet weak var uncollectedFeesValueChanged: UISegmentedControl!
    
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
    
    override func viewDidLoad() {
        self.debugUtil.printLog("viewDidLoad", msg: "BEGIN")
        
        super.viewDidLoad()
        super.pageNumber=6
        
        self.backwardExplanationTextView.delegate = self
        self.appAttributes.setColorAttributesTV(backwardExplanationTextView)
        
        self.terminatedExplanationTextView.delegate = self
        self.appAttributes.setColorAttributesTV(terminatedExplanationTextView)
        self.view.layer.backgroundColor = (appAttributes.colorBackgroundColor).CGColor
        appAttributes.setColorAttributesSegmentControl(uncollectedFeesSegmentedControl)
        if let image = backImage.image {
            backImage.image = image.imageWithColor(UIColor(CGColor: appAttributes.colorBlue)).imageWithRenderingMode(.AlwaysOriginal)
        }
        
        if sharedDataModel.currentTransaction.transactionStatus != "Draft" && sharedDataModel.currentTransaction.transactionStatus != "Pending Review" && sharedDataModel.currentTransaction.transactionStatus != "Cleared" && sharedDataModel.currentTransaction.transactionStatus != "Template"
        {
            self.backwardExplanationTextView.userInteractionEnabled = false
            self.backwardExplanationTextView.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.terminatedExplanationTextView.userInteractionEnabled = false
            self.terminatedExplanationTextView.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.uncollectedFeesSegmentedControl.userInteractionEnabled = false
            self.uncollectedFeesSegmentedControl.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.uncollectedFeesValueChanged.userInteractionEnabled = false
            self.uncollectedFeesValueChanged.backgroundColor = appAttributes.grayColorForClosedDeals
            
        }
        
        self.debugUtil.printLog("viewDidLoad", msg: "END")
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
        if (self.sharedDataModel.currentTransaction.transactionDetail.backwardsDealStatusExplanation == "") {
            self.backwardExplanationTextView.text = "enter a Backwards Deal Status Explanation"
            self.backwardExplanationTextView.textColor = UIColor.lightGrayColor()
        } else {
            self.backwardExplanationTextView.text = self.sharedDataModel.currentTransaction.transactionDetail.backwardsDealStatusExplanation
        }

        if (self.sharedDataModel.currentTransaction.transactionDetail.terminatedExplanation == "") {
            self.terminatedExplanationTextView.text = "enter a Terminated Explanation"
            self.terminatedExplanationTextView.textColor = UIColor.lightGrayColor()
        } else {
            self.terminatedExplanationTextView.text = self.sharedDataModel.currentTransaction.transactionDetail.terminatedExplanation
        }
        if self.sharedDataModel.currentTransaction.transactionDetail.uncollectedFees == "Yes" {
            self.uncollectedFeesSegmentedControl.selectedSegmentIndex = 1
        } else  if self.sharedDataModel.currentTransaction.transactionDetail.uncollectedFees == "No" {
            self.uncollectedFeesSegmentedControl.selectedSegmentIndex = 0
        } else {
            self.uncollectedFeesSegmentedControl.selectedSegmentIndex = -1

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
}

extension TransactionDetailPage6ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(textView: UITextView) {
        if (textView.textColor != nil && textView.textColor == UIColor.lightGrayColor()) {
            textView.text = nil
            textView.textColor =  UIColor.blackColor()
        }
    }
    
    
    func textViewDidChange(textView: UITextView) {
        switch textView {
        case backwardExplanationTextView:
            self.sharedDataModel.currentTransaction.transactionDetail.backwardsDealStatusExplanation = backwardExplanationTextView.text
        case terminatedExplanationTextView:
            self.sharedDataModel.currentTransaction.transactionDetail.terminatedExplanation = terminatedExplanationTextView.text
        default:
            break
        }
    }
}
