 //
 //  TransactionDetailPage1ViewController
 //
 
 import UIKit
 
 class TransactionDetailPage1ViewController: TransactionDetailPageViewController {
    
    var debugUtil = DebugUtility(thisClassName: "TransactionDetailPage1ViewController", enabled: false)
    let sharedDataModel = SharedDataModel.sharedInstance
    
    @IBOutlet weak var fwdImage: UIImageView!
    
    
    @IBOutlet weak var fwdImageForCenterX: NSLayoutConstraint!
    
//    @IBAction func launchStoryboard(sender: AnyObject) {
//        
//        var storyboard = UIStoryboard(name: "TransactionDetail", bundle: nil)
//        var controller = storyboard.instantiateViewControllerWithIdentifier("TransactionDetailPage1") as! UIViewController
//        
//        self.presentViewController(controller, animated: true, completion: nil)
//        
//    }
    @IBAction func forwardButtonAction(sender: UIButton) {
        self.transactionDetailViewController.goToPage(2,whichWay: 1)
        NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: nil)

    }
    @IBOutlet weak var projectNameTextField: UITextField!
    
    @IBOutlet weak var dealStatusTextField: UITextField!
    var dealStatusPicker: PopTextPicker?
    
    @IBOutlet weak var productTextField: UITextField!
    var productPicker: PopTextPicker?
    
    @IBOutlet weak var productSubTextField: UITextField!
    var productSubPicker: PopTextPicker?
    
    @IBOutlet weak var dealDescriptionTextView: UITextView!
    
    @IBOutlet weak var dealDescriptionImgWarning: UIImageView!
    @IBOutlet weak var dealDescriptionTxtWarning: UILabel!
    
    var products: [String]!
    
    var productSubs: [String]!
    
    ///this method passes the products present in productMap table in core data.
    func setProducts() {
        
        var allProducts = self.sharedDataModel.productMapArray.map({ (ProductMapData) -> String in
            return ProductMapData.productDescription
        })
        
        
        
        allProducts = allProducts.sort({ $0 < $1 })
        var productDictionary = Dictionary<String,String>()
        
        self.products = []
        
        for product in allProducts {
            
            if productDictionary.indexForKey(product) == nil {
                productDictionary.updateValue(product, forKey: product)
                self.products.append(product)
            }
            
        }
        
        
        
    }
    
    ///this method passes the sub products present in productMap table in core data.
    func setProductSubs() {
        
        var allProductSubs = self.sharedDataModel.productMapArray.map({ (ProductMapData) -> String in
            return ProductMapData.productSubDescription
        })
        
       allProductSubs =  allProductSubs.sort({ $0 < $1 })
        var productSubDictionary = Dictionary<String,String>()
        
        self.productSubs = []
        
        for productSub in allProductSubs {
            
            if productSubDictionary.indexForKey(productSub) == nil {
                productSubDictionary.updateValue(productSub, forKey: productSub)
                self.productSubs.append(productSub)
            }
            
        }
    }
    
    ///this method reset the sub product based on the product choosen
    func resetProductSubs() {
        
        let productSubsMap = self.sharedDataModel.productMapArray.filter({ (ProductMapData) -> Bool in
            if ProductMapData.productDescription == self.productTextField.text {
                return true
            } else {
                return false
            }
        })
        
        var allProductSubs = productSubsMap.map({ (ProductMapData) -> String in
            return ProductMapData.productSubDescription
        })
        
       allProductSubs =  allProductSubs.sort({ $0 < $1 })
        
        var productSubDictionary = Dictionary<String,String>()
        
        self.productSubs = []
        
        for productSub in allProductSubs {
            
            if productSubDictionary.indexForKey(productSub) == nil {
                productSubDictionary.updateValue(productSub, forKey: productSub)
                self.productSubs.append(productSub)
            }
            
        }
        debugUtil.printLog("resetProductSubs", msg: String(self.productSubs.count))
    }
    

    
    /// This lifecycle method provides value to the back and forward button constraints based on their orientation
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue
        {
            if self.sharedDataModel.checkForCollapseButton == "YES"
            {
                fwdImageForCenterX.constant = 475.5
            }
            else
            {
                fwdImageForCenterX.constant = 325.5
            }
        }
        else
        {
            if self.sharedDataModel.checkForCollapseButton == "YES"
            {
                fwdImageForCenterX.constant = 365.0
            }
            else
            {
                fwdImageForCenterX.constant = 215.0
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
        super.pageNumber = 1
        
        self.projectNameTextField.delegate = self
        self.appAttributes.setColorAttributesTF(projectNameTextField)
        
        var dealStatus = self.sharedDataModel.dealStatusesArray.map { (DealStatusData) -> String in
            return DealStatusData.dealStatusDescription
        }
        dealStatus = dealStatus.sort({ $0 < $1 })
        
        self.dealStatusPicker = PopTextPicker(forTextField: dealStatusTextField, pickerItemsArray: dealStatus)
        self.dealStatusPicker?.delegate = self
        self.dealStatusTextField.delegate = self
        self.appAttributes.setColorAttributesTF(dealStatusTextField)
        
        self.setProducts()
        self.productPicker = PopTextPicker(forTextField: productTextField, pickerItemsArray: self.products!)
        self.productPicker?.delegate = self
        self.productTextField.delegate = self
        self.appAttributes.setColorAttributesTF(productTextField)

        self.setProductSubs()
        self.productSubPicker = PopTextPicker(forTextField: productSubTextField, pickerItemsArray: self.productSubs!)
        self.productSubPicker?.delegate = self
        self.productSubTextField.delegate = self
        self.appAttributes.setColorAttributesTF(productSubTextField)
        
        self.dealDescriptionTextView.delegate = self
        self.appAttributes.setColorAttributesTV(dealDescriptionTextView)
        
        self.view.layer.backgroundColor = (appAttributes.colorBackgroundColor).CGColor
        if let image = fwdImage.image {
            fwdImage.image = image.imageWithColor(UIColor(CGColor: appAttributes.colorBlue)).imageWithRenderingMode(.AlwaysOriginal)
        }
        // some of the true statuses are not editable and their user interaction is disabled and painted with grey color
       if sharedDataModel.currentTransaction.transactionStatus != "Draft" && sharedDataModel.currentTransaction.transactionStatus != "Pending Review" && sharedDataModel.currentTransaction.transactionStatus != "Cleared" && sharedDataModel.currentTransaction.transactionStatus != "Template"
       {
        self.projectNameTextField.userInteractionEnabled = false
        self.projectNameTextField.backgroundColor = appAttributes.grayColorForClosedDeals
        
        self.dealStatusTextField.userInteractionEnabled = false
         self.dealStatusTextField.backgroundColor = appAttributes.grayColorForClosedDeals
        
        self.productTextField.userInteractionEnabled = false
         self.productTextField.backgroundColor = appAttributes.grayColorForClosedDeals
        
        self.productSubTextField.userInteractionEnabled = false
         self.productSubTextField.backgroundColor = appAttributes.grayColorForClosedDeals
        
        self.dealDescriptionTextView.userInteractionEnabled = false
         self.dealDescriptionTextView.backgroundColor = appAttributes.grayColorForClosedDeals
        }
        
        self.debugUtil.printLog("viewDidLoad", msg: "END")

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.sharedDataModel.checkForOrientationChange == "portrait"
        {
            fwdImageForCenterX.constant = 215.0
        }
        else
        {
            fwdImageForCenterX.constant = 325.5
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
    
    
    ///this method passses the data from object to the view controllers
    func resetViewsFromModel() {
        
        self.projectNameTextField.text = self.sharedDataModel.currentTransaction.transactionDetail.projectName
        
        if(self.sharedDataModel.checkForNewDealStatus == "YES" && self.sharedDataModel.currentTransaction.transactionId == "New" && self.sharedDataModel.currentTransaction.transactionDetail.dealStatus.isEmpty)
        {
            self.dealStatusTextField.text = "Pitch"
            self.sharedDataModel.currentTransaction.transactionDetail.dealStatus = self.dealStatusTextField.text!
        }
        else
        {
            self.dealStatusTextField.text = self.sharedDataModel.currentTransaction.transactionDetail.dealStatus
        }
        if(self.sharedDataModel.checkForNewDraftProduct == "YES" && self.sharedDataModel.currentTransaction.transactionId == "New" && self.sharedDataModel.currentTransaction.transactionDetail.product.isEmpty)
        {
            self.productTextField.text = "Bank Loan"
            self.sharedDataModel.currentTransaction.transactionDetail.product = self.productTextField.text!
        }
        else
        {
            self.productTextField.text = self.sharedDataModel.currentTransaction.transactionDetail.product
        }

        if(self.sharedDataModel.checkForNewDraftSubProduct == "YES" && self.sharedDataModel.currentTransaction.transactionId == "New" && self.sharedDataModel.currentTransaction.transactionDetail.productSub.isEmpty)
        {
            self.productSubTextField.text = self.productSubs[0]
            self.sharedDataModel.currentTransaction.transactionDetail.productSub = self.productSubTextField.text!
        }
        else
        {
            self.productSubTextField.text = self.sharedDataModel.currentTransaction.transactionDetail.productSub
        }
        //change the product sub here
        self.resetProductSubs()
        
        if self.productSubs.count != 0 {
            self.productSubPicker = PopTextPicker(forTextField: productSubTextField, pickerItemsArray: self.productSubs)
            self.productSubPicker?.delegate = self
        }

        if (self.sharedDataModel.currentTransaction.transactionDetail.dealDescription == "") {
            self.dealDescriptionTextView.text = "enter a Deal Description"
            self.dealDescriptionTextView.textColor = UIColor.lightGrayColor()
            self.dealDescriptionImgWarning.hidden = false
            self.dealDescriptionTxtWarning.hidden = false
        } else {
            self.dealDescriptionTextView.text = self.sharedDataModel.currentTransaction.transactionDetail.dealDescription
            self.dealDescriptionImgWarning.hidden = true
            self.dealDescriptionTxtWarning.hidden = true
        }
        
    }
    
    ///this method enables the user to provide data for business selection based on the product they are choosing which are related to M&A
    func updateBusinessType() {

        //must also reset the Business M&A to a init state since sub has changed
        
        switch sharedDataModel.getBusinessType(self.sharedDataModel.currentTransaction) {
        case "Buy","Sell","Either":
            self.sharedDataModel.currentTransaction.businessSelection.hasDerivativesExposure = ""
            self.sharedDataModel.currentTransaction.businessSelection.hasCommoditiesExposure = ""
            self.sharedDataModel.currentTransaction.businessSelection.hasWealthManagementOpportunity = ""
            self.sharedDataModel.currentTransaction.businessSelection.wealthManagementOpportunity = ""
        case "N/A":
            //reset all after page 1
            self.sharedDataModel.currentTransaction.businessSelection.isConsolidatedBankingOpportunity = ""
            self.sharedDataModel.currentTransaction.businessSelection.consolidatedBankingOpportunityDescription = ""
            self.sharedDataModel.currentTransaction.businessSelection.isInvestmentOpportunity = ""
            self.sharedDataModel.currentTransaction.businessSelection.investmentOpportunityDescription = ""
            self.sharedDataModel.currentTransaction.businessSelection.isServicesOpportunity = ""
            self.sharedDataModel.currentTransaction.businessSelection.servicesOpportunityDescription = ""
            self.sharedDataModel.currentTransaction.businessSelection.toIncludeCash = ""
            self.sharedDataModel.currentTransaction.businessSelection.toIncludeStock = ""
            self.sharedDataModel.currentTransaction.businessSelection.toIncludeOther = ""
            self.sharedDataModel.currentTransaction.businessSelection.pleaseExplain = ""
            self.sharedDataModel.currentTransaction.businessSelection.hasDerivativesExposure = ""
            self.sharedDataModel.currentTransaction.businessSelection.hasCommoditiesExposure = ""
            self.sharedDataModel.currentTransaction.businessSelection.hasWealthManagementOpportunity = ""
            self.sharedDataModel.currentTransaction.businessSelection.wealthManagementOpportunity = ""
        default:
            break
        }
        
        //now must reset page view on business selection
        // *** important.  only if never shown
        if self.detailViewController.embeddedBusinessSelectionViewController.businessSelectionPageViewController != nil {
            self.detailViewController.embeddedBusinessSelectionViewController.viewWillAppear(true)
            self.detailViewController.embeddedBusinessSelectionViewController.goToPage(1, whichWay: -1)
        }
    }
    
    func notificationCheck()
    {
        //Take Action on Notification
        if sharedDataModel.checkForCollapseButton == "YES"
        {
            if self.sharedDataModel.checkForOrientationChange == "landscape"
            {
                fwdImageForCenterX.constant = 475.5
            }
            else
            {
                fwdImageForCenterX.constant = 365.0
            }
        }
        else
        {
            if self.sharedDataModel.checkForOrientationChange == "landscape"
            {
                fwdImageForCenterX.constant = 325.5
            }
            else
            {
                fwdImageForCenterX.constant = 215.0
            }
        }
    }
 
    /// notification method triggered by NSnotificationCenter whenever the splitview button is collapsed or expanded
    func methodOfReceivedNotification(notification: NSNotification){
        notificationCheck()
    }
 }
 
 extension TransactionDetailPage1ViewController: PopTextPickerDelegate {
    func textDelegateCallBack(textField: UITextField) {
        switch textField {
           
        case dealStatusTextField:
         
            if ((self.sharedDataModel.currentTransaction.transactionStatus == "Draft") && (dealStatusTextField.text == "Completed" || dealStatusTextField.text == "Terminated" || dealStatusTextField.text == "Duplicate")) {
                let alert = UIAlertController(title: "Deal Status", message: "Deal Status should not be Terminated/Completed/Duplicate for new deals.Reverting to default Pitch status", preferredStyle: UIAlertControllerStyle.Alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                    switch action.style{
                    case .Default:
                        
                        print("Pitch")
                        
                    case .Cancel:
                        print("cancel")
                        
                    case .Destructive:
                        print("destructive")
                    }
                }))
                
                self.presentViewController(alert, animated: true, completion: nil)
                self.dealStatusTextField.text = "Pitch"
                self.sharedDataModel.currentTransaction.transactionDetail.dealStatus = self.dealStatusTextField.text!
            }
            else
            {
                self.sharedDataModel.currentTransaction.transactionDetail.dealStatus = dealStatusTextField.text!

            }
            if (dealStatusTextField.text == "Dormant" || dealStatusTextField.text == "Completed" || dealStatusTextField.text == "Terminated" || dealStatusTextField.text == "Duplicate") {
                self.transactionDetailViewController.numberOfPages = 5
            } else {
                //check to see if deal status went backwards by status from db
                //get index of deal status from DB first
                
                let dealStatus = self.sharedDataModel.dealStatusesArray.map { (DealStatusData) -> String in
                    return DealStatusData.dealStatusDescription
                }
               // var dbIndex = find(dealStatus,self.sharedDataModel.currentTransaction.transactionDetail.dealStatusDB)
                let dbIndex = dealStatus.indexOf(self.sharedDataModel.currentTransaction.transactionDetail.dealStatusDB)
               // var selectedIndex = find(dealStatus, dealStatusTextField.text)
                let selectedIndex = dealStatus.indexOf(dealStatusTextField.text!)
                if (dbIndex != nil && selectedIndex < dbIndex) {
                    self.transactionDetailViewController.numberOfPages = 6
                } else {
                    self.transactionDetailViewController.numberOfPages = 5
                    //clear the backward deal statuses
                    self.sharedDataModel.currentTransaction.transactionDetail.backwardsDealStatusExplanation = ""
                    self.sharedDataModel.currentTransaction.transactionDetail.terminatedExplanation = ""
                    self.sharedDataModel.currentTransaction.transactionDetail.uncollectedFees = "No"
                }
             }
            

            self.transactionDetailViewController.transactionDetailPageViewController.setViewControllers([self], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        case productTextField:
            self.sharedDataModel.currentTransaction.transactionDetail.product = productTextField.text!
            // enable M&A Business Selection tab
            self.detailViewController.updateMenu()
            if productTextField.text == "M&A" {
                self.sharedDataModel.currentTransaction.transactionDetail.estimatedPitchDate = ""
            }
            
            //also reset the sub product
            
            
            //change the product sub here
            self.resetProductSubs()
            
            if (self.sharedDataModel.currentTransaction.transactionId == "New"  && productSubTextField.text!.isEmpty)
            {
                self.productSubTextField.text = self.productSubs[0]
                self.sharedDataModel.currentTransaction.transactionDetail.productSub = self.productSubTextField.text!
            }
            else
            {
                self.productSubTextField.text = self.productSubs[0]
                self.sharedDataModel.currentTransaction.transactionDetail.productSub = self.productSubTextField.text!
            }
            
            if self.productSubs.count != 0 {
                self.productSubPicker = PopTextPicker(forTextField: productSubTextField, pickerItemsArray: self.productSubs)
                self.productSubPicker?.delegate = self
            }
            //also update the header
            //dont need to do this since it is now refreshed by each click
            //self.detailViewController.embeddedHeaderViewController.viewWillAppear(true)
          
        case productSubTextField:
            self.sharedDataModel.currentTransaction.transactionDetail.productSub = productSubTextField.text!
            self.updateBusinessType()
            //also update the header
            //dont need to do this since it is now refreshed by each click
            //self.detailViewController.embeddedHeaderViewController.viewWillAppear(true)
        default:
            break
        }

    }
    
 }
 extension TransactionDetailPage1ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    }
    func textFieldDidChange(textField: UITextField) {
        switch textField {
            
            case projectNameTextField:
                self.sharedDataModel.currentTransaction.transactionDetail.projectName = projectNameTextField.text!
        default:
            break
        }
        
     }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if (textField === dealStatusTextField) {
            
            self.sharedDataModel.checkForNewDealStatus = "NO"
            self.dealStatusTextField.resignFirstResponder()
            
            let initText: String? = dealStatusTextField.text
            
            self.dealStatusPicker!.setSelection(initText!)
            
            let dataChangedCallback: PopTextPicker.PopTextPickerCallback = { (newText: String, forTextField: UITextField) -> () in
                // here we don't use self (no retain cycle)
                forTextField.text = newText as String
            }
            
            self.dealStatusPicker!.pick(self, dataChanged: dataChangedCallback)
            return false
            
        } else if (textField === productTextField) {
            self.sharedDataModel.checkForNewDraftProduct = "NO"
            
            self.productTextField.resignFirstResponder()
            
            let initText: String? = productTextField.text
            
            self.productPicker!.setSelection(initText!)
            
            let dataChangedCallback: PopTextPicker.PopTextPickerCallback = { (newText: String, forTextField: UITextField) -> () in
                // here we don't use self (no retain cycle)
                forTextField.text = newText as String
            }
            
            self.productPicker!.pick(self, dataChanged: dataChangedCallback)
            return false
            
            
        } else if (textField === productSubTextField) {
            self.sharedDataModel.checkForNewDraftSubProduct = "NO"
            self.productSubTextField.resignFirstResponder()
            
            let initText: String? = productSubTextField.text
            
            self.productSubPicker!.setSelection(initText!)
            
            let dataChangedCallback: PopTextPicker.PopTextPickerCallback = { (newText: String, forTextField: UITextField) -> () in
                // here we don't use self (no retain cycle)
                forTextField.text = newText as String
            }
            
            self.productSubPicker!.pick(self, dataChanged: dataChangedCallback)
            
            return false
            
            
        } else {
            return true
        }
    }
    
 }
 
 
extension TransactionDetailPage1ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(textView: UITextView) {
        if (textView.textColor != nil && textView.textColor == UIColor.lightGrayColor()) {
            textView.text = nil
            textView.textColor =  UIColor.blackColor()
        }
    }
    
    func textViewDidChange(textView: UITextView) {
        if (textView === dealDescriptionTextView) {
           /* if (textView.text == "") {
                //show the warning again
                textView.text = "enter a Deal Description"
                textView.textColor = UIColor.lightGrayColor()
                self.dealDescriptionImgWarning.hidden = false
                self.dealDescriptionTxtWarning.hidden = false
            } else {
                            }*/
            self.dealDescriptionImgWarning.hidden = true
            self.dealDescriptionTxtWarning.hidden = true
            textView.textColor = UIColor.blackColor()

            self.sharedDataModel.currentTransaction.transactionDetail.dealDescription = self.dealDescriptionTextView.text
        }
    }
}
