//
// MaterialityPage1ViewController
//

import UIKit

class MaterialityPage1ViewController: MaterialityPageViewController {
    
    var debugUtil = DebugUtility(thisClassName: "MaterialityPage1ViewController", enabled: false)
    
    let viewStateManager = ViewStateManager.sharedInstance
    var selectedCompany : TransactionCompanyData!
    let appAttributes = AppAttributes()
    @IBOutlet weak var forwardImage: UIImageView!
    var embeddedSliderController: SliderController!

    var viewForDealSummary1:UIView = UIView()
    var companyDescriptionLabel:UILabel = UILabel()

  
//    @IBOutlet weak var percentSlider: UISlider!
    @IBOutlet weak var percentTextField: UITextField!
    
    @IBOutlet weak var forwardImageCenterX: NSLayoutConstraint!
//    @IBOutlet weak var percentMinusButton: UIButton!
//    @IBOutlet weak var percentPlusButton: UIButton!
    @IBOutlet weak var materialGuideButton: UISegmentedControl!
    @IBOutlet weak var materialGuideDescriptionText: UITextView!
    @IBOutlet weak var publiclyTradedButton: UISegmentedControl!
    @IBOutlet weak var govtOwnedButton: UISegmentedControl!
    @IBOutlet weak var percentOwnedLabel: UILabel!
//    @IBOutlet weak var dealSummaryView: UIView!
//    @IBOutlet weak var companyLabelView: UIView!
    
//    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var matImgWarning: UIImageView!
    @IBOutlet weak var matTxtWarning: UILabel!
    @IBOutlet weak var matDescImgWarning: UIImageView!
    @IBOutlet weak var matDescTxtWarning: UILabel!
    @IBOutlet weak var govtImgWarning: UIImageView!
    @IBOutlet weak var govtTxtWarning: UILabel!
    
    @IBOutlet weak var publiclyImgWarning: UIImageView!
    @IBOutlet weak var publiclyTxtWarning: UILabel!
    @IBOutlet weak var percentOwnedImgWarning: UIImageView!
    @IBOutlet weak var percentOwnedTxtWarning: UILabel!
    
    
    @IBAction func launchSlider(sender: UITextField) {
        self.performSegueWithIdentifier("sliderController", sender: sender)
    }
    
    
//    @IBAction func percentPlusRepeatAction(sender: UIButton) {
//        var doubleValue : Double = NSString(string: self.percentLabel.text!).doubleValue
//        doubleValue = doubleValue + 0.1
//        if doubleValue > 100 {
//            doubleValue = 100
//        }
//        self.percentLabel.text = String(stringInterpolationSegment: doubleValue) + "%"
//        self.percentSlider.value = Float(doubleValue)
//        var newMat : MaterialityData
//        
//        self.selectedCompany.materiality.percentOwned = String(stringInterpolationSegment: doubleValue)
//        
//        newMat = self.selectedCompany.materiality
//        self.viewStateManager.currentTransaction.transactionCompanies[self.viewStateManager.currentTransaction.currentTransactionCompanyIndex].materiality = newMat
//        
//    }
//    @IBAction func percentMinusRepeatAction(sender: UIButton) {
//        self.debugUtil.printLog("percentMINUS", msg: "BEGIN")
//        var doubleValue : Double = NSString(string: self.percentLabel.text!).doubleValue
//        doubleValue = doubleValue - 0.1
//        if doubleValue < 0 {
//            doubleValue = 0.0
//        }
//
//        self.percentLabel.text = String(stringInterpolationSegment: doubleValue) + "%"
//        self.percentSlider.value = Float(doubleValue)
//        var newMat : MaterialityData
//        
//        self.selectedCompany.materiality.percentOwned = String(stringInterpolationSegment: doubleValue)
//        
//        newMat = self.selectedCompany.materiality
//        self.viewStateManager.currentTransaction.transactionCompanies[self.viewStateManager.currentTransaction.currentTransactionCompanyIndex].materiality = newMat
//        self.debugUtil.printLog("percentMINUS", msg: "END")
//
//    }
    
    @IBAction func materialityGuideAction(sender: AnyObject) {
        var newMat : MaterialityData
        
        if (sender.selectedSegmentIndex == 0){
            self.selectedCompany.materiality.isMaterial = "No"
            self.materialGuideDescriptionText.editable = true
            self.selectedCompany.materiality.isMaterialDescription = ""
            self.materialGuideDescriptionText.text = ""
            self.matDescImgWarning.hidden = true
            self.matDescTxtWarning.hidden = true

        }else {
            self.selectedCompany.materiality.isMaterial = "Yes"
            self.materialGuideDescriptionText.editable = true
            if self.materialGuideDescriptionText.text == "" {
                self.materialGuideDescriptionText.text = "enter Materiality Description"
                self.materialGuideDescriptionText.textColor = UIColor.lightGrayColor()
                self.matDescImgWarning.hidden = false
                self.matDescTxtWarning.hidden = false
            }
        }
        self.matImgWarning.hidden = true
        self.matTxtWarning.hidden = true

        newMat = self.selectedCompany.materiality
        self.viewStateManager.currentTransaction.transactionCompanies[self.viewStateManager.currentTransaction.currentTransactionCompanyIndex].materiality = newMat
    }
    @IBAction func publiclyTradedAction(sender: AnyObject) {
        var newMat : MaterialityData
        
        if (sender.selectedSegmentIndex == 0){
            self.selectedCompany.materiality.hasPubliclyTradedSecurities = "No"
         }else {
            self.selectedCompany.materiality.hasPubliclyTradedSecurities = "Yes"
        }
        
        newMat = self.selectedCompany.materiality
        self.viewStateManager.currentTransaction.transactionCompanies[self.viewStateManager.currentTransaction.currentTransactionCompanyIndex].materiality = newMat
        self.publiclyImgWarning.hidden = true
        self.publiclyTxtWarning.hidden = true
    }
    @IBAction func govtOwnedAction(sender: AnyObject) {
        var newMat : MaterialityData
        
        if (sender.selectedSegmentIndex == 0){
            self.percentTextField.text = ""
            self.selectedCompany.materiality.percentOwned = ""
            self.selectedCompany.materiality.isGovtOwned = "No"
           self.percentTextField.userInteractionEnabled = false
            self.percentTextField.hidden = true
            self.percentOwnedLabel.hidden = true
            self.percentOwnedImgWarning.hidden = true
            self.percentOwnedTxtWarning.hidden = true
        }else {
            self.selectedCompany.materiality.isGovtOwned = "Yes"
            self.percentTextField.hidden = false
            self.percentOwnedLabel.hidden = false
            self.percentTextField.userInteractionEnabled = true
            if (self.selectedCompany.materiality.percentOwned == "") {
                self.percentOwnedImgWarning.hidden = false
                self.percentOwnedTxtWarning.hidden = false
            }

        }
        self.govtImgWarning.hidden = true
        self.govtTxtWarning.hidden = true
        newMat = self.selectedCompany.materiality
        self.viewStateManager.currentTransaction.transactionCompanies[self.viewStateManager.currentTransaction.currentTransactionCompanyIndex].materiality = newMat
    }
 
//    @IBAction func percentSliderValueChangedAction(sender: UISlider) {
//        var newMat : MaterialityData
//        percentLabel.text = NSString(format: "%.1f", sender.value) as String + "%"
//        
//        self.selectedCompany.materiality.percentOwned = NSString(format: "%.1f", sender.value) as String
//        
//        newMat = self.selectedCompany.materiality
//        self.viewStateManager.currentTransaction.transactionCompanies[self.viewStateManager.currentTransaction.currentTransactionCompanyIndex].materiality = newMat
//        self.percentOwnedImgWarning.hidden = true
//        self.percentOwnedTxtWarning.hidden = true
//    }
    @IBAction func returnCompaniesAction(sender: AnyObject) {
        self.materialityViewController.goToCompanies()
    }
    
    @IBAction func forwardButtonAction(sender: UIButton) {
        self.materialityViewController.goToPage(2,whichWay: 1)
        NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: nil)

    }
    
 
    override func viewWillAppear(animated: Bool) {
        debugUtil.printLog("viewWillappear", msg: "called")
        if self.viewStateManager.currentOrientation == "portrait"
        {
            forwardImageCenterX.constant = 215.0
        }
        else
        {
            forwardImageCenterX.constant = 325.5
        }

        checkOrientation()

        initTextFields()
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "methodOfReceivedNotification:", name:"NotificationIdentifier", object: nil)
        //now that user has selected a row, we can re-enable swipe - SWIPE events are buggy in apple
        //self.materialityViewController.pageViewController.dataSource = nil
            notificationCheck()
        self.materialityViewController.pageViewController.dataSource = self.materialityViewController
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "NotificationIdentifier", object: nil)

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func checkOrientation()
    {
        if viewStateManager.currentOrientation == "landscape"
        {
            if viewStateManager.checkForCollapseButton == "YES"
            {
                self.companyDescriptionLabel.frame = CGRectMake(viewForDealSummary1.frame.origin.x, companyDescriptionLabel.frame.origin.y, companyDescriptionLabel.frame.size.width, companyDescriptionLabel.frame.size.height)
            }
        }
        else
        {
            if viewStateManager.checkForCollapseButton == "YES"
            {
                self.companyDescriptionLabel.frame = CGRectMake(viewForDealSummary1.frame.origin.x - 150, companyDescriptionLabel.frame.origin.y, companyDescriptionLabel.frame.size.width, companyDescriptionLabel.frame.size.height)
            }
        }
        
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue
        {
            if viewStateManager.checkForCollapseButton == "YES"
            {
                self.companyDescriptionLabel.frame = CGRectMake(viewForDealSummary1.frame.origin.x, companyDescriptionLabel.frame.origin.y, companyDescriptionLabel.frame.size.width, companyDescriptionLabel.frame.size.height)
            
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
                self.companyDescriptionLabel.frame = CGRectMake(viewForDealSummary1.frame.origin.x - 150, companyDescriptionLabel.frame.origin.y, companyDescriptionLabel.frame.size.width, companyDescriptionLabel.frame.size.height)
            
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
        
      //  let bounds = UIScreen.mainScreen().bounds
        let width  = 1100.0
       
        viewForDealSummary1.frame = CGRectMake( -5,  -9,  CGFloat (width), 45.00)
        viewForDealSummary1.backgroundColor = UIColor(CGColor: appAttributes.colorOcean)
        self.view.addSubview(viewForDealSummary1)
            
        companyDescriptionLabel.frame = CGRectMake( 150,  10,  CGFloat (width), 30.00)

            companyDescriptionLabel.textColor = UIColor.whiteColor()
            companyDescriptionLabel.textAlignment = NSTextAlignment.Natural
        
        companyDescriptionLabel.font = UIFont(name: companyDescriptionLabel.font.fontName, size: 15)

            viewForDealSummary1.addSubview(companyDescriptionLabel)
       


        super.viewDidLoad()
        super.pageNumber = 1
        percentTextField.delegate = self
        appAttributes.setColorAttributesTF(percentTextField)
        
        self.appAttributes.setColorAttributesTV(materialGuideDescriptionText)
        self.view.layer.backgroundColor = (appAttributes.colorBackgroundColor).CGColor
        appAttributes.setColorAttributesSegmentControl(materialGuideButton)
        appAttributes.setColorAttributesSegmentControl(govtOwnedButton)
        appAttributes.setColorAttributesSegmentControl(publiclyTradedButton)
        if let image = forwardImage.image {
            forwardImage.image = image.imageWithColor(UIColor(CGColor: appAttributes.colorBlue)).imageWithRenderingMode(.AlwaysOriginal)
        }
        
        if viewStateManager.currentTransaction.transactionStatus != "Draft" && viewStateManager.currentTransaction.transactionStatus != "Pending Review" && viewStateManager.currentTransaction.transactionStatus != "Cleared" && viewStateManager.currentTransaction.transactionStatus != "Template"
        {
            self.percentTextField.userInteractionEnabled = false
            self.percentTextField.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.materialGuideButton.userInteractionEnabled = false
            self.materialGuideButton.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.materialGuideDescriptionText.userInteractionEnabled = false
            self.materialGuideDescriptionText.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.publiclyTradedButton.userInteractionEnabled = false
            self.publiclyTradedButton.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.govtOwnedButton.userInteractionEnabled = false
            self.govtOwnedButton.backgroundColor = appAttributes.grayColorForClosedDeals
        }

        self.debugUtil.printLog("viewDidLoad", msg: "END")
    }
    
    func changeStringToBold(normalText:String, textBold:String)->NSAttributedString
    {
        let attributedString = NSMutableAttributedString(string:textBold)
        if normalText == "Materiality: "
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
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.debugUtil.printLog("prepareForSegue", msg: "BEGIN")
        let segueId = segue.identifier
        
        self.debugUtil.printLog("prepareForSegue", msg: "segueId = " + segueId!)
        if let segueId = segue.identifier {
            switch segueId {
                
            case "sliderController":
                embeddedSliderController =  segue.destinationViewController as! SliderController
                embeddedSliderController.materialityPage1Controller = self
                embeddedSliderController.preferredContentSize = CGSize(width: 480, height: 75)
                //  dealSizeWidget.dealSize = self.viewStateManager.currentTransaction.transactionDetail.dealSize
            default :
                break
            }
        }
        
        
    }
    
    
    func initTextFields() {
        if (self.viewStateManager.currentTransaction.transactionCompanies.count != 0) {
            self.selectedCompany = self.viewStateManager.currentTransaction.transactionCompanies[self.viewStateManager.currentTransaction.currentTransactionCompanyIndex]
            companyDescriptionLabel.attributedText = changeStringToBold("Materiality: ",textBold:self.selectedCompany.company.companyName)
        
            self.materialGuideDescriptionText.delegate = self
            if (self.selectedCompany.materiality.isMaterial == "Yes") {
                self.materialGuideButton.selectedSegmentIndex = 1
                self.materialGuideDescriptionText.editable = true
                if self.selectedCompany.materiality.isMaterialDescription == "" {
                    self.materialGuideDescriptionText.text = "enter Materiality Description"
                    self.materialGuideDescriptionText.textColor = UIColor.lightGrayColor()
                    self.matDescImgWarning.hidden = false
                    self.matDescTxtWarning.hidden = false
                } else {
                    self.materialGuideDescriptionText.textColor = UIColor.blackColor()
                    self.materialGuideDescriptionText.text = self.selectedCompany.materiality.isMaterialDescription
                    self.matDescImgWarning.hidden = true
                    self.matDescTxtWarning.hidden = true
                }
                self.matImgWarning.hidden = true
                self.matTxtWarning.hidden = true
            } else if self.selectedCompany.materiality.isMaterial == "No"{
                self.materialGuideButton.selectedSegmentIndex = 0
                self.materialGuideDescriptionText.editable = true
                self.materialGuideDescriptionText.text = self.selectedCompany.materiality.isMaterialDescription
                self.matImgWarning.hidden = true
                self.matTxtWarning.hidden = true
                self.matDescImgWarning.hidden = true
                self.matDescTxtWarning.hidden = true
            } else {
                self.materialGuideButton.selectedSegmentIndex = -1
                self.materialGuideDescriptionText.editable = true
                self.matImgWarning.hidden = false
                self.matTxtWarning.hidden = false
                self.matDescImgWarning.hidden = true
                self.matDescTxtWarning.hidden = true

            }
            
     
          
            if (self.selectedCompany.materiality.hasPubliclyTradedSecurities == "Yes") {
                self.publiclyTradedButton.selectedSegmentIndex = 1
                self.publiclyImgWarning.hidden = true
                self.publiclyTxtWarning.hidden = true
            } else if (self.selectedCompany.materiality.hasPubliclyTradedSecurities == "No") {
                self.publiclyTradedButton.selectedSegmentIndex = 0
                self.publiclyImgWarning.hidden = true
                self.publiclyTxtWarning.hidden = true
            } else {
                self.publiclyTradedButton.selectedSegmentIndex = -1
                self.publiclyImgWarning.hidden = false
                self.publiclyTxtWarning.hidden = false
            }
            
            if (self.selectedCompany.materiality.isGovtOwned == "Yes") {
                self.govtOwnedButton.selectedSegmentIndex = 1
                self.percentTextField.userInteractionEnabled = true
                self.govtImgWarning.hidden = true
                self.govtTxtWarning.hidden = true
                self.percentTextField.hidden = false
                self.percentOwnedLabel.hidden = false
            } else if self.selectedCompany.materiality.isGovtOwned == "No"{
                self.govtOwnedButton.selectedSegmentIndex = 0
               self.percentTextField.userInteractionEnabled = false
                self.percentTextField.hidden = true
                self.percentOwnedLabel.hidden = true
                self.govtImgWarning.hidden = true
                self.govtTxtWarning.hidden = true
            } else {
                self.govtOwnedButton.selectedSegmentIndex = -1
                self.govtImgWarning.hidden = false
                self.govtTxtWarning.hidden = false
                self.percentTextField.hidden = true
                self.percentOwnedLabel.hidden = true
            }
            if self.selectedCompany.materiality.percentOwned.isEmpty
            {
                self.percentTextField.text = ""
            }
            else
            {
                self.percentTextField.text = self.selectedCompany.materiality.percentOwned + "%"
            }
           
            
            if (self.selectedCompany.materiality.percentOwned == "" && self.selectedCompany.materiality.isGovtOwned == "Yes") {
                self.percentOwnedImgWarning.hidden = false
                self.percentOwnedTxtWarning.hidden = false
            } else {
                self.percentOwnedImgWarning.hidden = true
                self.percentOwnedTxtWarning.hidden = true
            }
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "BEGIN")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "END")
    }
    
    func notificationCheck()
    {
        var widthforScreen:CGFloat = 0.0
        
       // let bounds = UIScreen.mainScreen().bounds
        let width  = 1100.0
       // var height = bounds.size.height
        widthforScreen = CGFloat(width)
        
        if viewStateManager.checkForCollapseButton == "YES"
        {
            
            UIView.animateWithDuration(0.1, animations: {
                
                let x = self.viewForDealSummary1.frame.origin.x
                let y = self.detailViewController.viewForDealSummary.frame.origin.y + 45
                let width = widthforScreen
                let height = self.viewForDealSummary1.frame.size.height
                
                let companyX = self.viewForDealSummary1.frame.origin.x
                let companyY = self.companyDescriptionLabel.frame.origin.y
                let companyWidth =  self.companyDescriptionLabel.frame.size.width
                let companyHeight = self.companyDescriptionLabel.frame.size.height
                
                
                if self.viewStateManager.currentOrientation == "portrait"
                {
                    self.companyDescriptionLabel.frame = CGRectMake(companyX - 150, companyY, companyWidth, companyHeight)
                }
                else
                {
                    self.companyDescriptionLabel.frame = CGRectMake(companyX, companyY, companyWidth, companyHeight)
                }
                self.companyDescriptionLabel.textAlignment = NSTextAlignment.Center
                
                self.viewForDealSummary1.frame = CGRectMake(x, y, width, height)
                self.viewForDealSummary1.backgroundColor = UIColor(CGColor: self.appAttributes.colorCyan)
                
            })
            
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
            
            UIView.animateWithDuration(0.0, animations: {
                let x = self.detailViewController.viewForDealSummary.frame.origin.x
                let y = self.detailViewController.viewForDealSummary.frame.origin.y
                let width = widthforScreen
                let height = self.detailViewController.viewForDealSummary.frame.size.height
                
                self.viewForDealSummary1.frame = CGRectMake(x, y, width, height)
                self.viewForDealSummary1.backgroundColor = UIColor(CGColor: self.appAttributes.colorOcean)
                self.companyDescriptionLabel.frame = CGRectMake( 150,  10,  width, 30.00)
                self.companyDescriptionLabel.textAlignment = NSTextAlignment.Natural
            })
            
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


extension MaterialityPage1ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(textView: UITextView) {
        if (textView.textColor != nil && textView.textColor == UIColor.lightGrayColor()) {
            textView.text = nil
            textView.textColor =  UIColor.blackColor()
        }
    }
    
    
    func textViewDidChange(textView: UITextView) {
        if (textView === materialGuideDescriptionText) {
            var newMat : MaterialityData
            self.selectedCompany.materiality.isMaterialDescription = self.materialGuideDescriptionText.text
            newMat = self.selectedCompany.materiality
            self.viewStateManager.currentTransaction.transactionCompanies[self.viewStateManager.currentTransaction.currentTransactionCompanyIndex].materiality = newMat
            self.matDescImgWarning.hidden = true
            self.matDescTxtWarning.hidden = true
        }
    }
}

extension MaterialityPage1ViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    if (textField == percentTextField) {
    
    self.percentTextField.resignFirstResponder()
    
    //            let formatter = NSDateFormatter()
    //            formatter.dateStyle = .MediumStyle
    //            formatter.timeStyle = .NoStyle
    //            let initDate : NSDate? = formatter.dateFromString(estimatedPitchDateTextField.text!)
    //
    //            let dataChangedCallback : PopDatePicker.PopDatePickerCallback = { (newDate : NSDate, forTextField : UITextField) -> () in
    //
    //                // here we don't use self (no retain cycle)
    //                forTextField.text = (newDate.ToDateMediumString() ?? "?") as String
    //
    //            }
    //
    //            self.estimatedPitchDatePicker!.pick(self, initDate: initDate, dataChanged: dataChangedCallback)
    return false
        }
        else
    {
        return true

    }
}
}

