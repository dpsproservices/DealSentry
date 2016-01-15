//
//  DefineCompanyViewController.swift
//

import UIKit

class DefineCompanyViewController: UIViewController {
    
    var debugUtil = DebugUtility(thisClassName: "DefineCompanyViewController",enabled: false)
    
    let viewStateManager = ViewStateManager.sharedInstance
    var detailViewController: DetailViewController!
    var embeddedMapController: CompanyMap!
    
    var addCompaniesViewController: AddCompaniesViewController! // presenting reference
    let appAttributes = AppAttributes()
    var editMode = false
    
    @IBOutlet weak var errorImgWarning: UIImageView!
    @IBOutlet weak var errorTxtWarning: UILabel!
    
    @IBOutlet weak var companyNameTextField: UITextField!
    
    //@IBOutlet weak var gfcidTextField: UITextField!
    @IBOutlet weak var exchangeTextField: UITextField!
    
    @IBOutlet weak var tickerTextField: UITextField!
    
    @IBOutlet weak var marketSegmentTextField: UITextField!
    var marketSegmentPicker: PopTextPicker?
    
    @IBOutlet weak var franchiseIndustryTextField: UITextField!
    var franchiseIndustryPicker: PopTextPicker?
    
    @IBOutlet weak var parentCompanySegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var countryButton: UIButton!
    var countryCode = ""
    var countryFlag = ""
    var countryPicker: PopTextPicker?
    
    @IBOutlet weak var assignRoleTextField: UITextField!
    var assignRolePicker: PopTextPicker?
    
     @IBAction func countryButtonAction(sender: UIButton) {
        self.performSegueWithIdentifier("showCountryMap", sender: self)
    }
    @IBAction func dismissDefineCompanyView(unwindSeque: UIStoryboardSegue ){
        self.debugUtil.printLog("dismissDefineCompanyView", msg: "BEGIN")
        
    }
    
    /// this method invokes the dismissal of Country map
    @IBAction func dismissCompanyMap(unwindSegue: UIStoryboardSegue ){
        self.debugUtil.printLog("dismissMap", msg: "BEGIN")
     //   unwindSegue.sourceViewController.dismissViewControllerAnimated(true, completion: nil)
        self.debugUtil.printLog("dismissMap", msg: "END")
        
    }
    
        /// this method invokes the dismissal of Define Company View
    @IBAction func cancelAction(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("dismissDefineCompanyView", sender: self)
    }
    
    
    ///this method is invoked when user manually defines a company and presses the done button. then the manually defined company name is checked with the company names already added by the user.
    /// - YES: alert will be thrown stating "Duplicate Company Name"
    /// -  NO: company added as transaction company
    /// - Parameter sender: this paramater ensures that this method will be invoked only using UIBarButtonItem
    @IBAction func doneAction(sender: UIBarButtonItem) {
        self.debugUtil.printLog("doneAction", msg: "BEGIN")
        var proceedToDoneButton = "Yes"
        
        if(!self.editMode)
        {
        if(self.companyNameTextField.text != "")
        {
            for companyName in self.viewStateManager.companynameArrayForManuallyDefined
            {
                if companyName.caseInsensitiveCompare(self.companyNameTextField.text!) == NSComparisonResult.OrderedSame
                {
                    proceedToDoneButton = "No"
                    break
                }
            }
        }
        
        if proceedToDoneButton == "No"
        {
            self.errorImgWarning.hidden = false
            self.errorTxtWarning.hidden = false
        }
        else
        {
            self.errorImgWarning.hidden = true
            self.errorTxtWarning.hidden = true
        }
        }
        //revise to handle blank spaces ** TO DO
        if (self.companyNameTextField != nil && self.companyNameTextField.text != "" && proceedToDoneButton == "Yes") {
            
        
            if(self.editMode && self.definedCompany != nil){
                //update company edited record with the new manual defined Company
                
                let companyIndex = self.viewStateManager.currentTransaction.currentTransactionCompanyIndex
                
                self.viewStateManager.currentTransaction.editCompanyAtIndex(companyIndex,transactionCompany: self.getManuallyDefinedCompany() )
                self.detailViewController.changeToMaterialityVC()
                self.detailViewController.selectedIndex = 1
                self.detailViewController.embeddedMaterialityViewController.materialityPage1ViewController.viewWillAppear(true)
                self.performSegueWithIdentifier("dismissDefineCompanyView", sender: self)

                
            } else {
                //add as manual defined company
                
                self.viewStateManager.currentTransaction.addCompany(self.getManuallyDefinedCompany())
          
                self.performSegueWithIdentifier("dismissDefineCompanyView", sender: self)
                //self.debugUtil.printLog("doneAction",  msg: self.getManuallyDefinedCompany().companyName)
            }

            
            self.detailViewController.embeddedCompaniesQuestions2ViewController.viewWillAppear(true)
        } else {
            //alert ('dont save')
        }

        self.debugUtil.printLog("doneAction", msg: "END")
    }
    
    var definedCompany: TransactionCompanyData!
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    override func viewDidLoad() {
        self.debugUtil.printLog("viewDidLoad", msg: "BEGIN")
        self.errorImgWarning.hidden = true
        self.errorTxtWarning.hidden = true
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var segments = self.viewStateManager.segmentsArray.map { (SegmentsData) -> String in
            return SegmentsData.name
        }
        segments = segments.sort({ $0 < $1 })

        self.marketSegmentPicker = PopTextPicker(forTextField: marketSegmentTextField, pickerItemsArray: segments)
        self.marketSegmentTextField.delegate = self
        
        var industries = self.viewStateManager.industriesArray.map { (IndustryData) -> String in
            return IndustryData.name
        }
        industries = industries.sort({ $0 < $1 })
        
        self.franchiseIndustryPicker = PopTextPicker(forTextField: franchiseIndustryTextField, pickerItemsArray: industries)
        self.franchiseIndustryTextField.delegate = self
        
        var countries = self.viewStateManager.countriesArray.map { (CountryData) -> String in
            return CountryData.countryName
        }
         countries = countries.sort({ $0 < $1 })
        
        self.countryPicker = PopTextPicker(forTextField: countryTextField, pickerItemsArray: countries)
        self.countryTextField.delegate = self
        var companyRole = self.viewStateManager.companyRolesArray.map { (CompanyRoleData) -> String in
            return CompanyRoleData.roleDescription
        }
        companyRole = companyRole.sort({ $0 < $1 })
        
        self.assignRolePicker = PopTextPicker(forTextField: assignRoleTextField, pickerItemsArray: companyRole)
        self.assignRoleTextField.delegate = self
        
        if editMode {
            self.editCompany()
        }
        let navImage: UIImage = UIImage(named: "blue-wave.png")!
        self.navigationController?.navigationBar.setBackgroundImage(navImage, forBarMetrics: .Default)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.titleView?.tintColor = UIColor.whiteColor()
        self.navigationItem.title =  "Define Company"

        let titleDic: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = titleDic as? [String : AnyObject]
        appAttributes.setColorAttributesSegmentControl(parentCompanySegmentedControl)
        self.view.layer.backgroundColor = (appAttributes.colorBackgroundColor).CGColor

        self.debugUtil.printLog("viewDidLoad", msg: "END")
    }
    
    override func didReceiveMemoryWarning() {
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "BEGIN")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "END")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.debugUtil.printLog("prepareForSegue", msg: "BEGIN")
        
        
        
        if let segueId = segue.identifier {
            
            self.debugUtil.printLog("prepareForSegue", msg: "segueId = " + segueId)
            
            
            switch segueId {
              
            case "showCountryMap":
                let embeddedMapController = segue.destinationViewController as! CompanyMap
                embeddedMapController.defineCompanyController = self
                embeddedMapController.selectedCountry = self.countryCode
                
            default:
                break
            }
            
            
            
        }
        
        self.debugUtil.printLog("prepareForSegue", msg: "END")
    }
    
    
    /// this method add an object of transaction company to the transaction object data
    func getManuallyDefinedCompany() -> TransactionCompanyData {
        var parComp = ""
        if(self.viewStateManager.checkForCountryPicker == "YES")
        {
            var i = 0
            var found = false
            var selectedCountry = ""
            while i<self.viewStateManager.countriesArray.count && !found{
                if self.viewStateManager.countriesArray[i].countryName == self.self.countryTextField.text {
                    selectedCountry = self.viewStateManager.countriesArray[i].countryCode
                    found = true
                }
                i++
            }
            countryFlag = selectedCountry
        }
        if self.parentCompanySegmentedControl==1 {
            parComp = "Yes"
        }else {
            parComp = "No"
        }
        return TransactionCompanyData (
            
            company: CompanyData(
                companyId: "",
                companyName: self.companyNameTextField.text!,
                ticker: self.tickerTextField.text!,
                country: countryFlag,
                gfcid: "",
                level: "",
                exchange: self.exchangeTextField.text!,
                marketSegment: self.marketSegmentTextField.text!,
                franchiseIndustry: self.franchiseIndustryTextField.text!,
                parentCompany: parComp,
                countryFlag: countryFlag
            ),
            
            role: self.assignRoleTextField.text!,
            
            materiality: MaterialityData(
                isMaterial: "",
                isMaterialDescription: "",
                hasPubliclyTradedSecurities: "",
                isGovtOwned: "",
                percentOwned: "",
             //   hasFinancialSponsor: "No",
              //  hasNonProfitOrganization: "No",
               // hasUSGovtAffiliatedMunicipality: "No",
                hasPRC: "",
                hasStandardAgreements: "",
                specialCircumstances: ""
            ),
            
            agreements: [],
            
            isManuallyDefinedByUser: true
        )
        
    }
    
    
    func resetView() {
        self.viewStateManager.definedCompany = nil
        self.companyNameTextField.text = ""
        self.exchangeTextField.text = ""
        self.tickerTextField.text = ""
        self.marketSegmentTextField.text = ""
        self.franchiseIndustryTextField.text = ""
        self.parentCompanySegmentedControl.selectedSegmentIndex = 0
        self.parentCompanySegmentedControl.tintColor = UIColor(CGColor:appAttributes.colorBlue)

        self.countryTextField.text = ""
        self.assignRoleTextField.text = ""
    }
    
    
    /// this method provides the user to edit the manually defined company
    func editCompany() {
        self.debugUtil.printLog("editCompany", msg: "BEGIN")
        
        if (self.definedCompany != nil) {
            self.debugUtil.printLog("editCompany", msg: "definedCompany not nil")
            self.companyNameTextField.text = self.definedCompany.company.companyName
            self.exchangeTextField.text = self.definedCompany!.company.exchange
            self.tickerTextField.text = self.definedCompany.company.ticker
            self.marketSegmentTextField!.text = self.definedCompany.company.marketSegment
            self.franchiseIndustryTextField.text = self.definedCompany.company.franchiseIndustry
            if self.definedCompany.company.parentCompany == "Yes" {
                self.parentCompanySegmentedControl.selectedSegmentIndex = 1
            } else {
                self.parentCompanySegmentedControl.selectedSegmentIndex = 0
            }
            self.parentCompanySegmentedControl.tintColor = UIColor(CGColor:appAttributes.colorBlue)
            self.countryCode = self.definedCompany.company.country
            
            var selectedCountryName = ""
            var i = 0
            var found = false
            while i<self.viewStateManager.countriesArray.count && !found{
                if self.viewStateManager.countriesArray[i].countryCode == self.countryCode {
                    selectedCountryName = self.viewStateManager.countriesArray[i].countryName
                    found = true
                }
                i++
            }
            self.countryTextField.text = selectedCountryName
            self.assignRoleTextField.text = self.definedCompany.role
            
        }
        
        self.debugUtil.printLog("editCompany", msg: "END")
    }
}

extension DefineCompanyViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if (textField === marketSegmentTextField) {
            
            self.marketSegmentTextField.resignFirstResponder()
            
            let initText: String? = marketSegmentTextField.text
            
            self.marketSegmentPicker!.setSelection(initText!)
            
            let dataChangedCallback: PopTextPicker.PopTextPickerCallback = { (newText: String, forTextField: UITextField) -> () in
                // here we don't use self (no retain cycle)
                forTextField.text = newText as String
            }
            
            self.marketSegmentPicker!.pick(self, dataChanged: dataChangedCallback)
            
            return false
            
        } else if (textField === franchiseIndustryTextField) {
            
            self.franchiseIndustryTextField.resignFirstResponder()
            
            let initText: String? = franchiseIndustryTextField.text
            
            self.franchiseIndustryPicker!.setSelection(initText!)
            
            let dataChangedCallback: PopTextPicker.PopTextPickerCallback = { (newText: String, forTextField: UITextField) -> () in
                // here we don't use self (no retain cycle)
                forTextField.text = newText as String
            }
            
            self.franchiseIndustryPicker!.pick(self, dataChanged: dataChangedCallback)
            
            return false
            
        } else if (textField === countryTextField) {
            self.viewStateManager.checkForCountryPicker = "YES"
            self.countryTextField.resignFirstResponder()
            
            let initText: String? = countryTextField.text
            
            self.countryPicker!.setSelection(initText!)
            
            let dataChangedCallback: PopTextPicker.PopTextPickerCallback = { (newText: String, forTextField: UITextField) -> () in
                // here we don't use self (no retain cycle)
                forTextField.text = newText as String
            }
            
            self.countryPicker!.pick(self, dataChanged: dataChangedCallback)

            return false

        } else if (textField === assignRoleTextField) {
            
            self.assignRoleTextField.resignFirstResponder()
            
            let initText: String? = assignRoleTextField.text
            
            self.assignRolePicker!.setSelection(initText!)
            
            let dataChangedCallback: PopTextPicker.PopTextPickerCallback = { (newText: String, forTextField: UITextField) -> () in
                // here we don't use self (no retain cycle)
                forTextField.text = newText as String
            }
            
            self.assignRolePicker!.pick(self, dataChanged: dataChangedCallback)
            
            return false
            
        } else {
            return true
        }
    }
    
}
