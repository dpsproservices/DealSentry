//
//  CompaniesQuestionsViewController
//

import UIKit

class CompaniesQuestionsViewController: UITableViewController {
    
    var debugUtil = DebugUtility(thisClassName: "CompaniesQuestionsViewController", enabled: false)
    var selectedCompany: TransactionCompanyData!
    let vcCon = VCConnection.sharedInstance
    let viewStateManager = ViewStateManager.sharedInstance
    

    let appAttributes = AppAttributes()
    var addCompaniesViewController: AddCompaniesViewController!
    var defineCompanyViewController: DefineCompanyViewController!
    var rolePicker: PopTextPicker?
    var primaryRoleCount = 0
    var detailViewController: DetailViewController!
    var masterViewController: MasterViewController!
    var agreementsViewController: AgreementsTableViewController!
    var selectedCompRowIndex = 0
    var emptyTableLabel:UILabel = UILabel()

    @IBOutlet weak var roleImgWarning: UIImageView!
    @IBOutlet weak var roleTxtWarning: UILabel!
    @IBAction func dismissAddCompany(unwindSegue: UIStoryboardSegue ){
        self.debugUtil.printLog("dismissAdd", msg: "BEGIN")
        unwindSegue.sourceViewController.dismissViewControllerAnimated(true, completion: nil)
        reselectLastSelectedRow()
        self.debugUtil.printLog("dismissAdd", msg: "END")
        
    }
   
    /// this method will add agreement object to the transaction company whenever add agreement button pressed
    /// - Parameter sender: this paramater ensures that this method will be invoked only using UIBarButtonItem
    func agreementFromIconAction(sender: UIBarButtonItem) {
        self.debugUtil.printLog("agreementaction", msg: String(sender.tag))

        self.viewStateManager.currentTransaction.currentTransactionCompanyIndex = sender.tag
        
        let lastSelectedIndexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        self.tableView.selectRowAtIndexPath(lastSelectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
        //now that user has selected a row, we can re-enable swipe
      //  self.detailViewController.embeddedMaterialityViewController.materialityPage1ViewController.viewWillAppear(true)
        self.detailViewController.showQuestionaireTabByIndex(0)
        self.viewStateManager.checkForAgreementClicked = "YES"
    }
    
    /// dismisses company view
    @IBAction func dismissDefineCompanyView(unwindSeque: UIStoryboardSegue ){
        self.debugUtil.printLog("dismissDefineCompanyView", msg: "BEGIN")

        if !self.viewStateManager.currentTransaction.transactionCompanies.isEmpty {
            self.viewStateManager.companynameArrayForManuallyDefined = [String]()

            self.tableView.reloadData()
            
            self.detailViewController.returnToCompany()
        }
        
    }
    // select the last selected table row cell based on current category
    func reselectLastSelectedRow() {
        self.debugUtil.printLog("reselect" , msg: "BEGIN")
        var lastSelectedRowIndex: Int = 0
        if self.viewStateManager.currentTransaction.transactionCompanies.count > 0 {
            lastSelectedRowIndex = self.viewStateManager.currentTransaction.currentTransactionCompanyIndex
            let lastSelectedIndexPath = NSIndexPath(forRow: lastSelectedRowIndex, inSection: 0)
            self.selectedCompRowIndex = lastSelectedRowIndex
            self.tableView.selectRowAtIndexPath(lastSelectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
            self.detailViewController.changeToMaterialityVC()
        } else {
            self.detailViewController.embeddedMaterialityViewController.goToPage(3, whichWay: 1)
            self.detailViewController.embeddedMaterialityViewController.pageViewController.dataSource = nil

           // self.performSegueWithIdentifier("addCompanySegue", sender: self)
        }
        
       
        self.debugUtil.printLog("reselect" , msg: "END")
        
    }
    
    /// ths method delete a transaction company from transaction
    /// - Parameter sender: this paramater ensures that this method will be invoked only using UIBarButtonItem
    func deleteCompanyFromIconAction(sender: UIBarButtonItem) {
        
        
        self.selectedCompRowIndex = sender.tag
        self.setSelectedRow(sender.tag)
        
        let lastSelectedIndexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        
        //now that user has selected a row, we can re-enable swipe
        //self.splitViewController!.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
        self.tableView.selectRowAtIndexPath(lastSelectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
        
        let cell = self.tableView.cellForRowAtIndexPath(lastSelectedIndexPath) as! CompaniesQuestionsTableViewCell
        toggleCompanyHeaderCellColor(cell, isSelect: true)
        
        
        //the call to get the company vc should be esentially be done by creating the Materiality VC not by recreating segue. otherwise, we lose focus
        //to the original VC.
        self.detailViewController.changeToMaterialityVC()
        
        
        self.detailViewController.embeddedMaterialityViewController.goToPage(1, whichWay: 1)
        self.detailViewController.embeddedMaterialityViewController.materialityPage1ViewController.viewWillAppear(true)
        
        
        let alert = UIAlertController(title: "Delete Company " +  self.viewStateManager.currentTransaction.transactionCompanies[selectedCompRowIndex].company.companyName , message: "Deleting company " +  self.viewStateManager.currentTransaction.transactionCompanies[selectedCompRowIndex].company.companyName + " will also remove its materiality and agreements. Continue?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                self.debugUtil.printLog( String(sender.tag))
                self.viewStateManager.currentTransaction.currentTransactionCompanyIndex = sender.tag
                self.viewStateManager.currentTransaction.removeCompanyAtIndex(sender.tag)
                self.tableView.reloadData()
                //after delete make sure items are not selected
                self.viewStateManager.currentTransaction.currentTransactionCompanyIndex = -1
                
                
                if self.viewStateManager.currentTransaction.transactionCompanies.count == 0{
                    //self.detailViewController.changeToAddCompanyVC()
                    self.detailViewController.embeddedMaterialityViewController.goToPage(3, whichWay: 1)
                    self.showHideWarnings()
                } else {
                    self.debugUtil.printLog("deleteCompanyFromIcon ", msg: "sender " + String(sender.tag) + " selectedComp " + String(self.selectedCompRowIndex))
                    //make sure a new row is now selected and that company is now shown.
                    //self.debugUtil("deleteCompanyFromIconAction", msg: String(stringInterpolationSegment: self.tableView.indexPathForSelectedRow()))
                    //also make sure that the only row reselected is not the current row if it is select
                    if sender.tag == self.selectedCompRowIndex {
                        //set new row as the first row
                        self.setSelectedRow(0)
                        self.reselectLastSelectedRow()
                        
                        self.detailViewController.changeToMaterialityVC()
                        self.detailViewController.selectedIndex = 1
                        self.detailViewController.embeddedMaterialityViewController.materialityPage1ViewController.viewWillAppear(true)
                        
                        self.debugUtil.printLog("deleteCompanyFromIconAction", msg: "same row")
                        
                    } else {
                        //this else condition is when row is selected already but did not delete that row.
                        //lets reset the selected row
                        //there are two cases.
                        //1.  the row index is before delete
                        //2.  the row index is after delete
                        if self.selectedCompRowIndex > sender.tag {
                            self.setSelectedRow(self.selectedCompRowIndex - 1)
                        } else {
                            self.setSelectedRow(self.selectedCompRowIndex)
                        }
                        self.reselectLastSelectedRow()
                        self.detailViewController.changeToMaterialityVC()
                        self.detailViewController.selectedIndex = 1
                        
                    }
                    
                    
                }
                
                
            case .Cancel:
                print("cancel")
                
            case .Destructive:
                print("destructive")
            }
        }))
        
        
        
        
        
        self.debugUtil.printLog("deleteCompanyFromIconAction", msg: "END")
        
    }
    
    // @IBOutlet weak var tableView: UITableView!
    func setSelectedRow(index: Int) {
        // update the currently selected transaction company index
        //self.viewStateManager.currentTransaction.currentTransactionCompanyIndex = index
        self.selectedCompany = self.viewStateManager.currentTransaction.transactionCompanies[index]
        
        self.viewStateManager.currentTransaction.currentTransactionCompanyIndex = index
        
        //allow user to swipe afterwards
        //   self.materialityViewController.materialityPageViewController.setViewControllers([self.materialityViewController.materialityPage1ViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        
    }
    
    /// this method moves the view from company to deal list and transaction detail page
    /// - Parameter sender: this paramater ensures that this method will be invoked only using UIBarButtonItem
    func returnToDeal(sender: UIBarButtonItem) {
       // let appDel = UIApplication.sharedApplication().delegate! as! AppDelegate
        vcCon.masterNavigationController.popToRootViewControllerAnimated(true)
        self.detailViewController.selectTab("Details")
    }

    
    override func viewWillAppear(animated: Bool) {
        debugUtil.printLog("viewWillappear", msg: "called")
        self.viewStateManager.companynameArrayForManuallyDefined = [String]()
        tableView.reloadData()

        self.reselectLastSelectedRow()
        primaryRoleCount = getPrimaryClientCount()

        self.showHideWarnings()

        appAttributes.animateTable(tableView)
        //disable swiping until a select has been recognized
        //still needs to handle case where page comes from page 2.
        //      self.materialityViewController.pageViewController.isMovingFromParentViewController()
        
        //    self.materialityViewController.pageViewController.dataSource = nil
        if self.viewStateManager.currentTransaction.transactionCompanies.count == 0 {
            self.detailViewController.embeddedMaterialityViewController.goToPage(3, whichWay: 1)
            self.detailViewController.embeddedMaterialityViewController.pageViewController.dataSource = nil

            //self.performSegueWithIdentifier("addCompanySegue", sender: self)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
//        for var i=0; i<self.viewStateManager.currentTransaction.transactionCompanies.count - 1; i++ {
//            var indexPath = NSIndexPath(forRow: i, inSection: 0)
//
//            var cell = self.tableView.cellForRowAtIndexPath(indexPath) as! CompaniesQuestionsTableViewCell
//
//            self.styleizeButtons(cell)
//        }
        
    }
    override func viewWillDisappear(animated: Bool) {
     //   if self.isMovingFromParentViewController() {
       //     self.detailViewController.selectedIndex = 0
        //}
    }
    override func viewDidLoad() {
        self.debugUtil.printLog("viewDidLoad", msg: "BEGIN")
        super.viewDidLoad()
        self.detailViewController.embeddedCompaniesQuestions2ViewController = self

        self.tableView.delegate = self
        self.tableView.dataSource = self
        //hides the empty gridlines at bottom of page
        //self.tableView.tableFooterView = UIView()
        
        self.rolePicker?.delegate = self
        

        //self.navigationItem.
        self.navigationItem.title =  "Companies"
        let addCompanyButton = UIBarButtonItem(
            image: UIImage(named:"plus_organization.png"),
           // title: "(+)",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "addCompany:"
        )

        self.navigationItem.setRightBarButtonItems(
            // buttons right to left
            [addCompanyButton],
            animated: false
        )

       // var backTitle = self.viewStateManager.selectedCategory + " (" + String(self.viewStateManager.getTransactionCountByCategory(self.viewStateManager.selectedCategory)) + ")"
        let backButton = UIBarButtonItem (
            //image: UIImage( named: "back.png" ),
            title: "< Deals",
            //title: backTitle,
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "returnToDeal:"
            
        )
        
        
        
        self.navigationItem.setLeftBarButtonItems([backButton], animated: false)
        

        //super.pageNumber = 1
        self.view.layer.backgroundColor = (appAttributes.colorBackgroundColor).CGColor
        
        if viewStateManager.currentTransaction.transactionStatus != "Draft" && viewStateManager.currentTransaction.transactionStatus != "Pending Review" && viewStateManager.currentTransaction.transactionStatus != "Cleared" && viewStateManager.currentTransaction.transactionStatus != "Template"
        {
            self.navigationItem.rightBarButtonItem = nil
            
        }
        
        self.debugUtil.printLog("viewDidLoad", msg: "END")
    }

    override func didReceiveMemoryWarning() {
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "BEGIN")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "END")
    }
    func editFromIconAction(sender: UIBarButtonItem) {
        self.viewStateManager.currentTransaction.currentTransactionCompanyIndex = sender.tag
        //  prepareForSegue("editCompany",sender)
        
    }
    func showHideWarnings() {
        if self.viewStateManager.currentTransaction.transactionCompanies.count == 0 {
            roleImgWarning.hidden = true
            roleTxtWarning.hidden = true
            
        }
        else if primaryRoleCount == 0 {
            roleImgWarning.hidden = false
            roleTxtWarning.hidden = false
            roleTxtWarning.text = "At least one client must be a role of Primary Client"
        } else if primaryRoleCount > 1 {
            roleImgWarning.hidden = false
            roleTxtWarning.hidden = false
            roleTxtWarning.text = "Duplicate Company/Role not allowed"
        } else {
            //only one Primary Client exists.  hide the warnings
            roleImgWarning.hidden = true
            roleTxtWarning.hidden = true
            
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       // self.debugUtil.printLog("prepareForSegue", msg: "BEGIN")
        
        if let segueId = segue.identifier {
        //    self.debugUtil.printLog("prepareForSegue", msg: "segueId = " + segueId)
            
            switch segueId {
           /* case "showQuestionaire2":
                
                //make sure the right index is selected on selected row
                
                self.debugUtil.printLog("prepareForSegue", msg: "showQuestionaire2")
                var selectedIndexPath = self.tableView.indexPathForSelectedRow()
                var selectedIndex = selectedIndexPath?.row

                self.setSelectedRow(selectedIndex!)
                
                var navController = segue.destinationViewController as! UINavigationController
                self.detailViewController = navController.topViewController as! DetailViewController
                self.detailViewController.embeddedCompaniesQuestions2ViewController = self
                self.detailViewController.selectedIndex = 1
*/
            case "addCompanySegue" :
                self.addCompaniesViewController = segue.destinationViewController as! AddCompaniesViewController
                self.addCompaniesViewController.detailViewController = self.detailViewController
                
            case "addAnotherCompany":
                self.debugUtil.printLog("prepareForSegue", msg: "Add another company")
                
                self.addCompaniesViewController = segue.destinationViewController as! AddCompaniesViewController
                //allow user to swipe afterwards
                //      self.materialityViewController.materialityPageViewController.setViewControllers([self.materialityViewController.materialityPage1ViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
                
                //self.addCompaniesViewController.resetView()
            case "editCompany":
                self.debugUtil.printLog("prepareForSegue", msg: "Edit Defined company")
                
                
                self.viewStateManager.currentTransaction.currentTransactionCompanyIndex = sender!.tag
                self.setSelectedRow(sender!.tag)
                // this will be used later by Define Company view
                self.viewStateManager.definedCompany = self.selectedCompany
                
                let navigationController = segue.destinationViewController as! UINavigationController
                
                self.defineCompanyViewController = navigationController.topViewController as! DefineCompanyViewController
                //self.defineCompanyViewController = segue.destinationViewController as! DefineCompanyViewController
                self.defineCompanyViewController.detailViewController = self.detailViewController
                self.defineCompanyViewController.definedCompany = self.selectedCompany
                self.defineCompanyViewController.editMode = true
                
                //set the index from the viewStateManager first.
                //make sure this is the correct index corresponding to the viewStateManager
                //currently it works for both edit/delete
             //   let selectedIndexPath = self.tableView.indexPathForSelectedRow!
                //var selectedIndex = selectedIndexPath.row
                
                //allow user to swipe afterwards
                //      self.materialityViewController.materialityPageViewController.setViewControllers([self.materialityViewController.materialityPage1ViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
                
            case "showAgreements":
            //    self.debugUtil.printLog("prepareForSegue", msg: "segueId = showAgreements template")
                if sender != nil {
                    self.viewStateManager.currentTransaction.currentTransactionCompanyIndex = sender!.tag
                }
                self.setSelectedRow(self.viewStateManager.currentTransaction.currentTransactionCompanyIndex)
                
               // self.performSegueWithIdentifier("showQuestionaire", sender: self)
                self.agreementsViewController = segue.destinationViewController as! AgreementsTableViewController
                self.agreementsViewController.detailViewController = self.detailViewController
                self.agreementsViewController.companiesViewController = self
                
              
                self.detailViewController.embeddedCompaniesQuestions2ViewController = self
               
               // let appDel = UIApplication.sharedApplication().delegate! as! AppDelegate
                vcCon.masterViewController.embeddedCompaniesViewController = self
                
//           case  "popoverSegue" :
//                let popoverViewController = segue.destinationViewController 
//                //     popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
//                //       popoverViewController.preferredContentSize = CGSizeMake(500, 500)
//                //              popoverViewController.popoverPresentationController!.delegate = self
//                
//                
            default:
                break
            }
            
        }
        
      //  self.debugUtil.printLog("prepareForSegue", msg: "END")
    }
    
}

extension CompaniesQuestionsViewController: UIPopoverPresentationControllerDelegate {
    
    //add a company
    func addCompany(sender: UIBarButtonItem) {
        //  self.debugUtil.printLog("addCompany", msg: "BEGIN")

       // if viewStateManager.currentTransaction.transactionCompanies.count > 0 {
            /*
            var popoverContent = detailViewController.embeddedAddCompaniesViewController
            popoverContent.preferredContentSize = CGSizeMake(600,700)
            
            
            //var nav = popoverContent//UINavigationController(rootViewController: popoverContent)
            //nav.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverContent.modalPresentationStyle = UIModalPresentationStyle.Popover
            var popover = popoverContent.popoverPresentationController
            popover!.delegate = self
            popover!.sourceView = self.view
            popover!.sourceRect = CGRectMake(0,0,10,0)
            self.presentViewController(popoverContent, animated: true, completion: nil)
            // popoverContent.popoverPresentationController?.sourceView = sender
            */
            self.performSegueWithIdentifier("addCompanySegue", sender: self)
        //} else {
       //     self.detailViewController.changeToAddCompanyVC()
            self.detailViewController.selectedIndex = 1
       // }
    }

}
extension CompaniesQuestionsViewController: PopTextPickerDelegate {
    func getPrimaryClientCount() -> Int{
        var count = 0
        for c in self.viewStateManager.currentTransaction.transactionCompanies {
            if c.role == "Primary Client" {
                count++
            }
        }
        return count
    }
    func textDelegateCallBack(textField: UITextField) {
        if textField.text == "Primary Client" {
            self.viewStateManager.currentTransaction.transactionCompanies[textField.tag].role = textField.text!
            self.viewStateManager.currentTransaction.primaryClient = self.viewStateManager.currentTransaction.transactionCompanies[textField.tag].company.companyName
            //also update the header
           // self.detailViewController.embeddedHeaderViewController.viewWillAppear(true)
        } else {
            if self.viewStateManager.currentTransaction.transactionCompanies[textField.tag].role == "Primary Client" {
                self.viewStateManager.currentTransaction.primaryClient = ""
                //also update the header
               // self.detailViewController.embeddedHeaderViewController.viewWillAppear(true)
            }
            self.viewStateManager.currentTransaction.transactionCompanies[textField.tag].role = textField.text!
        }
        primaryRoleCount = getPrimaryClientCount()
        self.showHideWarnings()
        self.debugUtil.printLog("textFieldBegin", msg: String(textField.tag))
        
    }
}
extension CompaniesQuestionsViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        var companyRole = self.viewStateManager.companyRolesArray.map { (CompanyRoleData) -> String in
            return CompanyRoleData.roleDescription
        }
        companyRole = companyRole.sort({ $0 < $1 })
        
        self.rolePicker = PopTextPicker(forTextField: textField, pickerItemsArray: companyRole)
        self.rolePicker?.delegate = self
        
        textField.resignFirstResponder()
        
        let initText: String? = textField.text
        
        self.rolePicker!.setSelection(initText!)
        
        let dataChangedCallback: PopTextPicker.PopTextPickerCallback = { (newText: String, forTextField: UITextField) -> () in
            // here we don't use self (no retain cycle)
            forTextField.text = newText as String
        }
        self.debugUtil.printLog("textFieldBegin", msg: String(textField.tag))
        self.rolePicker!.pick(self, dataChanged: dataChangedCallback)
        self.debugUtil.printLog("textFieldBegin", msg: String(textField.text))
        return false
        
    }

}

extension CompaniesQuestionsViewController {
    
    func styleizeButtons(cell: CompaniesQuestionsTableViewCell) {
        
        if viewStateManager.currentTransaction.transactionStatus != "Draft" && viewStateManager.currentTransaction.transactionStatus != "Pending Review" && viewStateManager.currentTransaction.transactionStatus != "Cleared" && viewStateManager.currentTransaction.transactionStatus != "Template"
        {
            cell.roleTextField.backgroundColor = appAttributes.grayColorForClosedDeals

        }
        else
        {
            cell.roleTextField.backgroundColor = UIColor.whiteColor()
        }
    }
    
    func toggleCompanyHeaderCellColor(cell: CompaniesQuestionsTableViewCell, isSelect: Bool){
        
        if isSelect {
            cell.companyBackgroundView.backgroundColor = UIColor(CGColor: appAttributes.colorOcean)
        } else {
            cell.companyBackgroundView.backgroundColor = UIColor(CGColor: appAttributes.colorCyan)
        }
        styleizeButtons(cell)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  self.debugUtil.printLog("numberOfRowsInSection", msg: "BEGIN")
        //  self.debugUtil.printLog("numberOfRowsInSection", msg: "company row count = "+ String(self.viewStateManager.currentTransaction.transactionCompanies.count))
        //  self.debugUtil.printLog("numberOfRowsInSection", msg: "END")
        
        //reloading table view - make sure no rows are selected
        //self.viewStateManager.currentTransactionCompanyIndex = -1
        
        if (self.viewStateManager.currentTransaction.transactionCompanies.count == 0) {
            return 1 // No Companies added yet.
            //return nil
        } else {
            primaryRoleCount = 0
           return self.viewStateManager.currentTransaction.transactionCompanies.count
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //  self.debugUtil.printLog("numberOfSectionsInTableView", msg: "BEGIN")
        //  self.debugUtil.printLog("numberOfSectionsInTableView", msg: "END" )
        var numberOfSections = 0
        if !self.viewStateManager.currentTransaction.transactionCompanies.isEmpty
        {
            numberOfSections = 1
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            self.tableView.backgroundView = nil
        }
        else
        {
            emptyTableLabel.text = "No Company Available"
            emptyTableLabel.textColor = UIColor.blackColor()
            emptyTableLabel.textAlignment = NSTextAlignment.Center
            self.tableView.backgroundView = emptyTableLabel
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        }
        return numberOfSections
    }
    /*
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            //  self.debugUtil.printLog("tableViewCommitEdit", msg: String(indexPath.row))
            self.viewStateManager.currentTransaction.currentTransactionCompanyIndex = indexPath.row
            self.viewStateManager.currentTransaction.removeCompanyAtIndex(indexPath.row)
            //self.hideButtonsFromDelete()
        
            //after delete make sure items are not selected
            self.viewStateManager.currentTransaction.currentTransactionCompanyIndex = -1
            
            
            if self.viewStateManager.currentTransaction.transactionCompanies.count == 0{
                self.detailViewController.changeToAddCompanyVC()
                
            } else {
                //make sure a new row is now selected and that company is now shown.
                //self.debugUtil("deleteCompanyFromIconAction", msg: String(stringInterpolationSegment: self.tableView.indexPathForSelectedRow()))
                //also make sure that the only row reselected is not the current row if it is select
                if indexPath.row == self.selectedCompRowIndex {
                    //set new row as the first row
                    setSelectedRow(0)
                    self.reselectLastSelectedRow()
                    
                    self.detailViewController.changeToMaterialityVC()
                    self.detailViewController.selectedIndex = 1
                    
                    self.detailViewController.embeddedMaterialityViewController.materialityPage1ViewController.viewWillAppear(true)
                    
                    self.debugUtil.printLog("deleteCompanyFromIconAction", msg: "same row")
                    
                } else {
                    // setSelectedRow(sender.tag)
                    // self.reselectLastSelectedRow()
                    
                }
                
                
            }
           
        }
    }*/
    // set the custom Prototype table view cell data labels
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        self.debugUtil.printLog("cellForRowAtIndexPath", msg: "BEGIN")
       // var index = String(indexPath.row)

        if self.viewStateManager.currentTransaction.transactionCompanies.count == 0 {
            
            let cell: NoCompaniesTableViewCell = tableView.dequeueReusableCellWithIdentifier("NoCompaniesCell", forIndexPath: indexPath) as! NoCompaniesTableViewCell
            cell.hidden = false
            
            //       self.debugUtil.printLog("cellForRowAtIndexPath", msg: "END")
            
            return cell
            
        } else {
            

            
            let companyCell: CompaniesQuestionsTableViewCell = tableView.dequeueReusableCellWithIdentifier("QuestionaireCompanyCell", forIndexPath: indexPath) as! CompaniesQuestionsTableViewCell
            
            let cellCompany = self.viewStateManager.currentTransaction.transactionCompanies[indexPath.row]
            companyCell.selectedBackgroundView = appAttributes.getcolorHighlightRowColor()
            companyCell.companyNameLabel.text = cellCompany.company.companyName
            companyCell.roleTextField.delegate = self
            companyCell.roleTextField.text = cellCompany.role
            companyCell.roleTextField.tag = indexPath.row
            
            self.viewStateManager.companynameArrayForManuallyDefined.append(cellCompany.company.companyName)
          
            
            
            appAttributes.setColorAttributesTF(companyCell.roleTextField)
            
            
            companyCell.gfcid.text = cellCompany.company.gfcid
            companyCell.levelOneParentLabel.text = cellCompany.company.parentCompany
            companyCell.tickerLabel.text = cellCompany.company.ticker
            companyCell.industryLabel.text = cellCompany.company.franchiseIndustry
            companyCell.segmentLabel.text = cellCompany.company.marketSegment
            companyCell.parentNameLabel.text = cellCompany.company.companyName
            companyCell.deleteButton.tag = indexPath.row
            companyCell.deleteButton.addTarget(self, action: "deleteCompanyFromIconAction:", forControlEvents: .TouchUpInside)
            let countryCodeForCountry =  cellCompany.company.countryFlag + ".png"
            companyCell.countryFlagImage.image = UIImage(named: countryCodeForCountry)
            companyCell.countryLabel.text = cellCompany.company.country
            companyCell.exchangeLabel.text = cellCompany.company.exchange
            self.debugUtil.printLog("tableView", msg: "SelInd:" + String(self.selectedCompRowIndex) + "   indPath:" + String(indexPath.row))
            
            
            if self.tableView.indexPathForSelectedRow == indexPath {
                companyCell.companyBackgroundView.backgroundColor = UIColor(CGColor: appAttributes.colorOcean)
                
            } else {
                //var bgLayer = appAttributes.getcolorCompSubTaskBackground()
                //bgLayer.frame = companyCell.companyBackgroundView.bounds
                //companyCell.companyBackgroundView.layer.insertSublayer(bgLayer, atIndex: 0)
                companyCell.companyBackgroundView.backgroundColor = UIColor(CGColor: appAttributes.colorCyan)
            }
            
            
            companyCell.editButton.tag = indexPath.row
            if ( cellCompany.isManuallyDefinedByUser ) {
                companyCell.editButton.addTarget(self, action: "editFromIconAction:", forControlEvents: .TouchUpInside)
                companyCell.editButton.hidden = false
            } else {
                companyCell.editButton.hidden = true
            }
            companyCell.agreementButton.tag = indexPath.row
            companyCell.agreementButton.addTarget(self, action: "agreementFromIconAction:", forControlEvents: .TouchUpInside)
            if (cellCompany.materiality.hasStandardAgreements == "No") {
                companyCell.agreementButton.hidden = false
                //determine if "add agreement for 0 counter add agreements.
                if cellCompany.agreements.count == 0 {
                    companyCell.agreementButton.setTitle("   Add Agreements", forState: UIControlState.Normal)
                } else {
                    companyCell.agreementButton.setTitle("   Agreements", forState: UIControlState.Normal)

                }
                
            } else {
                companyCell.agreementButton.hidden = true
            }
            
            //Style-ize  Cyan
            styleizeButtons(companyCell)
          
            
            if cellCompany.role == "Primary Client" {
                primaryRoleCount++
            }
            //    self.debugUtil.printLog("cellForRowAtIndexPath", msg: "END")
//            if (indexPath.row == self.viewStateManager.currentTransaction.transactionCompanies.count-1) {
            primaryRoleCount = getPrimaryClientCount()

                self.showHideWarnings()
              //  self.debugUtil.printLog("tableView", msg: "Last row")
//            }
            
            if viewStateManager.currentTransaction.transactionStatus != "Draft" && viewStateManager.currentTransaction.transactionStatus != "Pending Review" && viewStateManager.currentTransaction.transactionStatus != "Cleared" && viewStateManager.currentTransaction.transactionStatus != "Template"
            {
                companyCell.roleTextField.userInteractionEnabled = false
                companyCell.deleteButton.hidden = true

            }
            
            return companyCell
        }
    }
    /*
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    if indexPath.row == 0 {
    //    return CGFloat(200)
    } else{
    //  return CGFloat(3)
    }
    
    }*/

    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        self.debugUtil.printLog("willSelectRowAtIndexPath", msg: "BEGIN")
       // var index = String(indexPath.row)
        return indexPath
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.debugUtil.printLog("didSelectRowAtIndexPath", msg: "BEGIN index = " + String(indexPath.row))
        
        
      //  var index = String(indexPath.row)
        self.selectedCompRowIndex = indexPath.row
        self.setSelectedRow(indexPath.row)

        
        //now that user has selected a row, we can re-enable swipe
        //self.splitViewController!.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
        
        
        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! CompaniesQuestionsTableViewCell
        toggleCompanyHeaderCellColor(cell, isSelect: true)
        
        
        //the call to get the company vc should be esentially be done by creating the Materiality VC not by recreating segue. otherwise, we lose focus
        //to the original VC.
        self.detailViewController.changeToMaterialityVC()
        
        
        self.detailViewController.embeddedMaterialityViewController.goToPage(1, whichWay: 1)
        self.detailViewController.embeddedMaterialityViewController.materialityPage1ViewController.viewWillAppear(true)
        self.debugUtil.printLog("didSelectRowAtIndexPath", msg: "END")
        
    }
    


    override func tableView(tableView: UITableView, willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        self.debugUtil.printLog("willDeselectRowAtIndexPath", msg: "BEGIN")
       // var index = String(indexPath.row)
        return indexPath
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        self.debugUtil.printLog("didDeselectRowAtIndexPath", msg: "BEGIN")
        
       // var index = String(indexPath.row)
//        var cell = self.tableView.cellForRowAtIndexPath(indexPath) as! CompaniesQuestionsTableViewCell
//        
//        toggleCompanyHeaderCellColor(cell, isSelect: false)
        
    }
    
}
