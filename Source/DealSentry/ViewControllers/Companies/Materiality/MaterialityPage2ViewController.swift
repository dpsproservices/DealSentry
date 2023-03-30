//
// MaterialityPage2ViewController
//

import UIKit

class MaterialityPage2ViewController: MaterialityPageViewController {
    
    var debugUtil = DebugUtility(thisClassName: "MaterialityPage2ViewController", enabled: false)
    var selectedCompany : TransactionCompanyData!
    let viewStateManager = ViewStateManager.sharedInstance
    let appAttributes = AppAttributes()
    @IBOutlet weak var backImage: UIImageView!

    @IBOutlet weak var legalAgreementCenterY: NSLayoutConstraint!
    
    @IBOutlet weak var specialCircumstancesTextViewCenterY: NSLayoutConstraint!
    @IBOutlet weak var specialCircumStancesCenterY: NSLayoutConstraint!
    @IBOutlet weak var mustSelectCenterY: NSLayoutConstraint!
    @IBOutlet weak var errorAgreementImageCenterY: NSLayoutConstraint!
    @IBOutlet weak var noYesSegmentCenterY: NSLayoutConstraint!
    
    @IBOutlet weak var legalAgreementNotStandardCenterY: NSLayoutConstraint!
    
    @IBOutlet weak var backImageCenterX: NSLayoutConstraint!
    var viewForDealSummary1:UIView = UIView()
    var companyDescriptionLabel:UILabel = UILabel()
    
    @IBOutlet weak var prcImgWarning: UIImageView!
    @IBOutlet weak var prcTxtWarning: UILabel!
    @IBOutlet weak var agreementImgWarning: UIImageView!
    @IBOutlet weak var agreementTxtWarning: UILabel!
   // @IBOutlet weak var companyDescriptionLabel: UILabel!

    @IBOutlet weak var procTransactionField: UISegmentedControl!
    @IBOutlet weak var agreementField: UISegmentedControl!
    @IBOutlet weak var specialCircumstanceField: UITextView!
    
    @IBOutlet weak var prcSecuritiesQuestionLabel: UILabel!
    @IBOutlet weak var legalAgreementsQuestionLabel: UILabel!
    @IBOutlet weak var legalAgreementsNotStandardQuestionLabel: UILabel!
    @IBOutlet weak var specialCircumstancesLabel: UILabel!
    
    @IBAction func returnCompaniesAction(sender: AnyObject) {
        self.materialityViewController.goToCompanies()
    }
    
    @IBAction func backButtonAction(sender: UIButton) {
        self.materialityViewController.goToPage(1,whichWay: -1)
        NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: nil)
    }
    
    @IBAction func procEditingDidEnd(sender: AnyObject) {
    }
    
    @IBAction func procValueChangedAction(sender: AnyObject) {
        
        var newMat : MaterialityData
        
        if (sender.selectedSegmentIndex == 0){
            self.selectedCompany.materiality.hasPRC = "No"
        }else {
            self.selectedCompany.materiality.hasPRC = "Yes"
        }
        newMat = self.selectedCompany.materiality
        self.viewStateManager.currentTransaction.transactionCompanies[self.viewStateManager.currentTransaction.currentTransactionCompanyIndex].materiality = newMat
        self.debugUtil.printLog("PROC", msg: self.selectedCompany.materiality.hasPRC)
        self.prcImgWarning.hidden = true
        self.prcTxtWarning.hidden = true
    }
    @IBAction func agreementEditingDidEnd(sender: AnyObject) {
        var newMat : MaterialityData
        if (sender.selectedSegmentIndex==0) {
            self.selectedCompany.materiality.hasStandardAgreements = "No"
           
            // alert
            
            let alert = UIAlertController(title: "Add Agreements", message: "Since Legal Agreements are not standard, please add legal agreements present beneath company", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        else if (sender.selectedSegmentIndex==1){
            self.selectedCompany.materiality.hasStandardAgreements = "Yes"
            self.selectedCompany.removeAllAgreements()
            self.viewStateManager.currentTransaction.transactionCompanies[self.viewStateManager.currentTransaction.currentTransactionCompanyIndex].removeAllAgreements()
        }
        else
        {
            self.selectedCompany.materiality.hasStandardAgreements = "N/A"
        }
        //update master view
        self.detailViewController.embeddedCompaniesQuestions2ViewController.tableView.reloadData()
        
        self.detailViewController.embeddedCompaniesQuestions2ViewController.reselectLastSelectedRow()
        

        newMat = self.selectedCompany.materiality
        self.viewStateManager.currentTransaction.transactionCompanies[self.viewStateManager.currentTransaction.currentTransactionCompanyIndex].materiality = newMat
        self.agreementImgWarning.hidden = true
        self.agreementTxtWarning.hidden = true
    }

 
    override func viewWillAppear(animated: Bool) {
        debugUtil.printLog("viewWillappear", msg: "called")
        if self.viewStateManager.currentOrientation == "portrait"
        {
            backImageCenterX.constant = -215.0
        }
        else
        {
            backImageCenterX.constant = -325.5
        }
        checkOrientation()

        initTextFields()
        checkViewChangeForHiddenPRC()

        //now that user has selected a row, we can re-enable swipe - SWIPE events are buggy in apple
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "methodOfReceivedNotification:", name:"NotificationIdentifier", object: nil)
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
                self.companyDescriptionLabel.frame = CGRectMake(viewForDealSummary1.frame.origin.x , companyDescriptionLabel.frame.origin.y, companyDescriptionLabel.frame.size.width, companyDescriptionLabel.frame.size.height)
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
                self.companyDescriptionLabel.frame = CGRectMake(viewForDealSummary1.frame.origin.x , companyDescriptionLabel.frame.origin.y, companyDescriptionLabel.frame.size.width, companyDescriptionLabel.frame.size.height)
            
                backImageCenterX.constant = -475.5
            }
            else
            {
                backImageCenterX.constant = -325.5
            }
           
        }
        else
        {
            if viewStateManager.checkForCollapseButton == "YES"
            {
                self.companyDescriptionLabel.frame = CGRectMake(viewForDealSummary1.frame.origin.x - 150, companyDescriptionLabel.frame.origin.y, companyDescriptionLabel.frame.size.width, companyDescriptionLabel.frame.size.height)
            
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
        
        //manually added labels
       // var bounds = UIScreen.mainScreen().bounds
        let width  = 1100.0
        viewForDealSummary1.frame = CGRectMake( -5,  -9,  CGFloat(width), 45.00)
        viewForDealSummary1.backgroundColor = UIColor(CGColor: appAttributes.colorOcean)
        self.view.addSubview(viewForDealSummary1)
        
        companyDescriptionLabel.frame = CGRectMake( 150,  10,  CGFloat (width), 30.00)
        
        companyDescriptionLabel.textColor = UIColor.whiteColor()
        companyDescriptionLabel.textAlignment = NSTextAlignment.Natural
        
        companyDescriptionLabel.font = UIFont(name: companyDescriptionLabel.font.fontName, size: 15)
        
        viewForDealSummary1.addSubview(companyDescriptionLabel)
        
        

        
        
        //
        
        
        super.viewDidLoad()
        super.pageNumber = 2
        self.specialCircumstanceField.delegate = self
        self.appAttributes.setColorAttributesTV(specialCircumstanceField)
        self.appAttributes.setColorAttributesSegmentControl(procTransactionField)
        self.appAttributes.setColorAttributesSegmentControl(agreementField)

        if let image = backImage.image {
            backImage.image = image.imageWithColor(UIColor(CGColor: appAttributes.colorBlue)).imageWithRenderingMode(.AlwaysOriginal)
        }
        self.view.layer.backgroundColor = (appAttributes.colorBackgroundColor).CGColor
        
        if viewStateManager.currentTransaction.transactionStatus != "Draft" && viewStateManager.currentTransaction.transactionStatus != "Pending Review" && viewStateManager.currentTransaction.transactionStatus != "Cleared" && viewStateManager.currentTransaction.transactionStatus != "Template"
        {
            self.procTransactionField.userInteractionEnabled = false
            self.procTransactionField.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.agreementField.userInteractionEnabled = false
            self.agreementField.backgroundColor = appAttributes.grayColorForClosedDeals
            
            self.specialCircumstanceField.userInteractionEnabled = false
            self.specialCircumstanceField.backgroundColor = appAttributes.grayColorForClosedDeals
        }
        
      
        self.debugUtil.printLog("viewDidLoad", msg: "END")
    }
    
    func checkViewChangeForHiddenPRC()
    {
        // checking view alteration:
        if(self.selectedCompany.materiality.isMaterial.isEmpty || self.selectedCompany.materiality.isMaterial == "No"){
            prcSecuritiesQuestionLabel.hidden = true
            prcImgWarning.hidden = true
            prcTxtWarning.hidden = true
            procTransactionField.hidden = true
            
            legalAgreementCenterY.constant = -154
            
            legalAgreementNotStandardCenterY.constant = -112
            
            noYesSegmentCenterY.constant = -68.5
            
            errorAgreementImageCenterY.constant = -42.5
            
            mustSelectCenterY.constant = -41.5
            
            specialCircumStancesCenterY.constant = 1.5
            
            specialCircumstancesTextViewCenterY.constant = 71.5
        }
        else
        {
            prcSecuritiesQuestionLabel.hidden = false
            procTransactionField.hidden = false
            if(self.selectedCompany.materiality.hasPRC.isEmpty)
            {
                prcTxtWarning.hidden = false
                prcImgWarning.hidden = false

            }
            
            
            legalAgreementCenterY.constant = 5.5
            
            legalAgreementNotStandardCenterY.constant = 47.5
            
            noYesSegmentCenterY.constant = 91
            
            errorAgreementImageCenterY.constant = 117
            
            mustSelectCenterY.constant = 118
            
            specialCircumStancesCenterY.constant = 160.5
            
            specialCircumstancesTextViewCenterY.constant = 230
            
        }
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
    
    func initTextFields() {
        if (self.viewStateManager.currentTransaction.transactionCompanies.count != 0) {
            self.selectedCompany = self.viewStateManager.currentTransaction.transactionCompanies[self.viewStateManager.currentTransaction.currentTransactionCompanyIndex]
        
            companyDescriptionLabel.attributedText = changeStringToBold("Materiality: ",textBold:self.selectedCompany.company.companyName)
            if (self.selectedCompany.materiality.hasPRC == "Yes") {
                self.procTransactionField.selectedSegmentIndex = 1
                self.prcImgWarning.hidden = true
                self.prcTxtWarning.hidden = true
            } else if self.selectedCompany.materiality.hasPRC == "No"{
                self.procTransactionField.selectedSegmentIndex = 0
                self.prcImgWarning.hidden = true
                self.prcTxtWarning.hidden = true
            } else {
                self.procTransactionField.selectedSegmentIndex = -1
                if procTransactionField.hidden
                {
                    self.prcImgWarning.hidden = true
                    self.prcTxtWarning.hidden = true
                }
                else
                {
                    self.prcImgWarning.hidden = false
                    self.prcTxtWarning.hidden = false
                }
                
            }
            
            if (self.selectedCompany.materiality.hasStandardAgreements == "Yes") {
                self.agreementField.selectedSegmentIndex = 1
                self.agreementImgWarning.hidden = true
                self.agreementTxtWarning.hidden = true
            } else if self.selectedCompany.materiality.hasStandardAgreements == "No"{
                self.agreementField.selectedSegmentIndex = 0
                self.agreementImgWarning.hidden = true
                self.agreementTxtWarning.hidden = true
            }else if self.selectedCompany.materiality.hasStandardAgreements == "N/A"{
                self.agreementField.selectedSegmentIndex = 2
                self.agreementImgWarning.hidden = true
                self.agreementTxtWarning.hidden = true
            } else {
                self.agreementField.selectedSegmentIndex = -1
                self.agreementImgWarning.hidden = false
                self.agreementTxtWarning.hidden = false
            }
            
            self.specialCircumstanceField.text = self.selectedCompany.materiality.specialCircumstances
            if self.specialCircumstanceField.text == ""  {
                self.specialCircumstanceField.text = "enter Special Circumstance"
                self.specialCircumstanceField.textColor = UIColor.lightGrayColor()
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
      //  var height = bounds.size.height
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
                backImageCenterX.constant = -475.5
            }
            else
            {
                backImageCenterX.constant = -365.0
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
extension MaterialityPage2ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(textView: UITextView) {
        if (textView.textColor != nil && textView.textColor == UIColor.lightGrayColor()) {
            textView.text = nil
            textView.textColor =  UIColor.blackColor()
        }
    }
    
    
    func textViewDidChange(textView: UITextView) {
        if (textView === specialCircumstanceField) {
            var newMat : MaterialityData
            self.selectedCompany.materiality.specialCircumstances = self.specialCircumstanceField.text
            newMat = self.selectedCompany.materiality
            self.viewStateManager.currentTransaction.transactionCompanies[self.viewStateManager.currentTransaction.currentTransactionCompanyIndex].materiality = newMat
            
        }
    }
}
