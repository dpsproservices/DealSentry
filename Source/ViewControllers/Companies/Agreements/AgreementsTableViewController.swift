///
//  AgreementsTableViewController.swift
//

import UIKit

class AgreementsTableViewController: UITableViewController {
    var debugUtil = DebugUtility(thisClassName: "AgreementsTableViewController",enabled: false)
    let appAttributes = AppAttributes()
     let vcCon = VCConnection.sharedInstance
    let viewStateManager = ViewStateManager.sharedInstance
   

    var selectedContact: ContactData!
    var detailViewController: DetailViewController!
    var companiesViewController: CompaniesQuestionsViewController!
    var currentCompanyIndex: Int!
    var currentTransactionCompany: TransactionCompanyData!
    
    var currentCompany: CompanyData!
    
    var hasAgreements = false
    var agreementsArray: [AgreementData]!
    
    var selectedAgreement: AgreementData!
    

    // called by popup unwind segue
    @IBAction func dismissEnterAgreementView(unwindSeque: UIStoryboardSegue ){
        self.debugUtil.printLog("dismissEnterAgreementView", msg: "BEGIN")

        self.updateLocalVariables()
        
        // toggle to company questions tab
        self.tableView.reloadData()
        
        self.handleEditButtonState()
        self.handleDeleteButtonState()
        
        self.debugUtil.printLog("dismissEnterAgreementView", msg: "END")
    }

    ///this method is invoked only when user wants to delete a agreement from transaction company. delete button present in ach cell will trigger this method
    /// - Parameter sender: this paramater ensures that this method will be invoked only using UIBarButtonItem
    func deleteAgreementAction(sender: UIBarButtonItem) {
        //get the current company first
        var agreementMessage = ""
        setSelectedRow(sender.tag)
        reselectRow()
        let selectedIndex = sender.tag
         let lastSelectedIndexPath = NSIndexPath(forRow: selectedIndex, inSection: 0)
        let cell = self.tableView.cellForRowAtIndexPath(lastSelectedIndexPath) as! AgreementsTableViewCell
        toggleCompanyHeaderCellColor(cell, isSelect: true)
        
        if self.agreementsArray[selectedIndex].agreementType.isEmpty
        {
            agreementMessage = "Delete this agreement with " + self.currentCompany.companyName + "?"
        }
        else
        {
            agreementMessage = "Are you certain you wish to delete " +  self.agreementsArray[selectedIndex].agreementType  + " with " + self.currentCompany.companyName + "?"
        }
        
        let alert = UIAlertController(title: "Delete Agreement ", message: agreementMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                self.viewStateManager.checkForDeleteDraftClicked = "YES"
                self.viewStateManager.currentTransaction.transactionCompanies[self.currentCompanyIndex].agreements.removeAtIndex(selectedIndex)
                //update index of sharedModel
                if self.viewStateManager.currentTransaction.transactionCompanies[self.currentCompanyIndex].agreements.count == 0 {
                    self.viewStateManager.currentTransaction.transactionCompanies[self.currentCompanyIndex].currentTransactionCompanyAgreementIndex = -1
                    
                    //return back to companies if there are no more agreements
                    self.back()
                } else {
                    self.viewStateManager.currentTransaction.transactionCompanies[self.currentCompanyIndex].currentTransactionCompanyAgreementIndex = self.viewStateManager.currentTransaction.transactionCompanies[self.currentCompanyIndex].agreements.count  - 1
                    
                    self.updateLocalVariables()
                    self.tableView.reloadData()
                    self.reselectRow()
                }
                
            case .Cancel:
                print("cancel")
                
            case .Destructive:
                print("destructive")
            }
        }))
        

    }
    
    func setSelectedRow(index: Int) {
        // update the currently selected transaction company index
        let currentCompIndex = self.viewStateManager.currentTransaction.currentTransactionCompanyIndex
        self.viewStateManager.currentTransaction.transactionCompanies[currentCompIndex].currentTransactionCompanyAgreementIndex = index
      
        self.selectedAgreement = self.agreementsArray[index]
     }
    
    func updateLocalVariables(){
        self.currentCompanyIndex = self.viewStateManager.currentTransaction.currentTransactionCompanyIndex
        
        self.debugUtil.printLog("updateLocalVar", msg: String(self.viewStateManager.currentTransaction.currentTransactionCompanyIndex))
        self.currentTransactionCompany = self.viewStateManager.currentTransaction.transactionCompanies[self.currentCompanyIndex]
        self.currentCompany = self.currentTransactionCompany.company
       // self.debugUtil.printLog("updateLocalVar", msg: currentCompany.companyName)
       // self.debugUtil.printLog("updateLocalVar", msg: currentCompany)
        
        self.agreementsArray = self.currentTransactionCompany.agreements
        if self.agreementsArray.count > 0 {
            if self.viewStateManager.checkForDeleteDraftClicked == "YES"
            {
                self.selectedAgreement = self.agreementsArray[0]
            }
            else
            {
                self.selectedAgreement = self.agreementsArray[self.viewStateManager.currentTransaction.transactionCompanies[self.viewStateManager.currentTransaction.currentTransactionCompanyIndex].currentTransactionCompanyAgreementIndex]
            }
        }
    }
    
    func reselectRow() {
        var lastSelectedRowIndex: Int = 0
        
        //We will now have to either display the last selected row.  or "FORCE" create a new row
        if self.agreementsArray.count > 0 {
            if self.viewStateManager.checkForDeleteDraftClicked == "YES"
            {
                lastSelectedRowIndex = 0
                self.viewStateManager.checkForDeleteDraftClicked = "NO"

            }
            else
            {
                lastSelectedRowIndex = self.currentTransactionCompany.currentTransactionCompanyAgreementIndex

            }
            let lastSelectedIndexPath = NSIndexPath(forRow: lastSelectedRowIndex, inSection: 0)
            self.tableView.selectRowAtIndexPath(lastSelectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
            //self.detailViewController.selectedIndex = 1
            self.editAgreementAction(lastSelectedRowIndex)
        } else {
            
            lastSelectedRowIndex = self.currentTransactionCompany.currentTransactionCompanyAgreementIndex
            let lastSelectedIndexPath = NSIndexPath(forRow: lastSelectedRowIndex, inSection: 0)
            self.tableView.selectRowAtIndexPath(lastSelectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
            //self.detailViewController.selectedIndex = 1
            self.editAgreementAction(lastSelectedRowIndex)
        }
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if viewStateManager.currentTransaction.transactionCompanies[self.viewStateManager.currentTransaction.currentTransactionCompanyIndex].agreements.count == 0{
            //Add a new Agreement to the table.
            //then pretend its an EDIT mode
            let newAgmt = AgreementData(
                agreementType: "",
                effectiveDate: "",
                expirationDate: "",
                agreementTerms: "",
                legalReviewBy: "",
                exclusivityApprovedBy: ""
            )
            self.viewStateManager.currentTransaction.transactionCompanies[currentCompanyIndex].addAgreement(newAgmt)
            self.viewStateManager.currentTransaction.transactionCompanies[currentCompanyIndex].currentTransactionCompanyAgreementIndex = 0
        }
        self.updateLocalVariables()
        self.reselectRow()
//        self.tableView.reloadData()
 
    }

    override func viewDidLoad() {
        self.debugUtil.printLog("viewDidLoad", msg: "BEGIN")

        super.viewDidLoad()
        self.updateLocalVariables()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        //hides the empty gridlines at bottom of page
        self.tableView.tableFooterView = UIView()

        self.handleEditButtonState()
        self.handleDeleteButtonState()
        self.navigationItem.title =  "Agreements"
        
        let addAgreementBtn = UIBarButtonItem(
            image: UIImage(named:"add_list.png"),
            //title: "(+)",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "addAgreementAction:"
        )
        
        self.navigationItem.setRightBarButtonItems(
            // buttons right to left
            [addAgreementBtn],
            animated: false
        )
        
        let backBtn = UIBarButtonItem(
            //image: UIImage(named:"plusbox.png"),
            title: "< Companies",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "backAction:"
        )
        
        self.navigationItem.setLeftBarButtonItems(
            [backBtn],
            animated: false
        )
        if viewStateManager.currentTransaction.transactionStatus != "Draft" && viewStateManager.currentTransaction.transactionStatus != "Pending Review" && viewStateManager.currentTransaction.transactionStatus != "Cleared" && viewStateManager.currentTransaction.transactionStatus != "Template"
        {
            self.navigationItem.rightBarButtonItem = nil
        }

    }
    func back() {
       // let appDel = UIApplication.sharedApplication().delegate! as! AppDelegate
        vcCon.masterNavigationController.popViewControllerAnimated(true)
        self.detailViewController.changeToMaterialityVC()
    }
    func backAction(sender: UIBarButtonItem) {
        self.back()
    }
    
    /// this method will add agreement object to the transaction company whenever add agreement button pressed
    func addAgreement() {
        //Add a new Agreement to the table.
        //then pretend its an EDIT mode
        let newAgmt = AgreementData(
            agreementType: "",
            effectiveDate: "",
            expirationDate: "",
            agreementTerms: "",
            legalReviewBy: "",
            exclusivityApprovedBy: ""
        )
        self.viewStateManager.currentTransaction.transactionCompanies[currentCompanyIndex].addAgreement(newAgmt)
        self.viewStateManager.currentTransaction.transactionCompanies[self.currentCompanyIndex].currentTransactionCompanyAgreementIndex = self.viewStateManager.currentTransaction.transactionCompanies[self.currentCompanyIndex].agreements.count - 1
        self.updateLocalVariables()
        self.tableView.reloadData()
        self.reselectRow()
       
        
        
        self.detailViewController.embeddedEnterAgreementsViewController.agreementsTableViewController = self
        self.detailViewController.embeddedEnterAgreementsViewController.editMode = true
        self.detailViewController.embeddedEnterAgreementsViewController.enteredAgreement = self.selectedAgreement
        self.detailViewController.changeToAgreementsVC()
        self.detailViewController.selectedIndex = 1
        self.detailViewController.embeddedEnterAgreementsViewController.viewWillAppear(true)
        
    }
    func addAgreementAction(sender: UIBarButtonItem) {
        self.addAgreement()
    }
    
    /// this method will invoke the right side view based on the cell selection
    /// - Parameter index: based on the index it will invoke the respective agreement object
    func editAgreementAction(index: Int) {
     
        self.detailViewController.embeddedEnterAgreementsViewController.agreementsTableViewController = self
        self.detailViewController.embeddedEnterAgreementsViewController.agreementsTableViewController.companiesViewController = self.companiesViewController
        self.detailViewController.embeddedEnterAgreementsViewController.lastSelectedIndexFromTable = index
        self.detailViewController.embeddedEnterAgreementsViewController.editMode = true
        self.detailViewController.embeddedEnterAgreementsViewController.enteredAgreement = self.selectedAgreement
        self.detailViewController.changeToAgreementsVC()
        self.detailViewController.selectedIndex = 1
        self.detailViewController.embeddedEnterAgreementsViewController.viewWillAppear(true)
        

    }
    
    //automatically resize
    override func shouldAutorotate() -> Bool {
        return true
    }
//    override func supportedInterfaceOrientations() -> Int {
//        return Int(UIInterfaceOrientation.Portrait.rawValue) | Int(UIInterfaceOrientation.LandscapeLeft.rawValue) | Int(UIInterfaceOrientation.LandscapeRight.rawValue)
//    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        let currentOrientation: UIInterfaceOrientationMask = [UIInterfaceOrientationMask.Portrait, UIInterfaceOrientationMask.LandscapeLeft,UIInterfaceOrientationMask.LandscapeRight]
        return currentOrientation
    }
    
    func handleEditButtonState(){
       // let selectedIndexPath = self.tableView.indexPathForSelectedRow
       // var selectedIndex = selectedIndexPath?.row
        
          }
    
    func handleDeleteButtonState(){
//        let selectedIndexPath = self.tableView.indexPathForSelectedRow
       // var selectedIndex = selectedIndexPath?.row
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       /* self.debugUtil.printLog("prepareForSegue", msg: "BEGIN")
        var segueId = segue.identifier
        
        self.debugUtil.printLog("prepareForSegue", msg: "segueId = " + segueId!)
        
        if let segueId = segue.identifier {
            
            switch segueId {
               
            case "editAgreement":
                // modal segway
                //self.setSelectedRow(sender!.tag)

                let navigationController = segue.destinationViewController as! UINavigationController
                self.enterAgreementViewController = navigationController.topViewController as! EnterAgreementViewController
                self.enterAgreementViewController.agreementsTableViewController = self
                self.enterAgreementViewController.editMode = true
                self.enterAgreementViewController.enteredAgreement = self.selectedAgreement
            case "addAgreement":
                // modal segway
                
                let navigationController = segue.destinationViewController as! UINavigationController
                self.enterAgreementViewController = navigationController.topViewController as! EnterAgreementViewController
                self.enterAgreementViewController.agreementsTableViewController = self
                self.enterAgreementViewController.editMode = false
                self.enterAgreementViewController.enteredAgreement = nil//self.selectedAgreement
                
    
            default:
                break
            }
            
        }
        */
        self.debugUtil.printLog("prepareForSegue", msg: "END")
    }
}

extension AgreementsTableViewController{
    func toggleCompanyHeaderCellColor(cell: AgreementsTableViewCell, isSelect: Bool){
        
        if isSelect {
            cell.companyBackgroundView.backgroundColor = UIColor(CGColor: appAttributes.colorOcean)
        } else {
            cell.companyBackgroundView.backgroundColor = UIColor(CGColor: appAttributes.colorCyan)
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        self.debugUtil.printLog("numberOfSectionsInTableView", msg: "BEGIN")
        self.debugUtil.printLog("numberOfSectionsInTableView", msg: "END" )
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        self.debugUtil.printLog("numberOfRowsInSect", msg: String(self.agreementsArray.count))
        if self.agreementsArray.count == 0 {
            return 1
        } else {
            return self.agreementsArray.count
        }
      }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let index = String(indexPath.row)
        
        self.debugUtil.printLog("cellForRowAtIndexPath", msg: "BEGIN indexPath.row = " + index)

        if  self.agreementsArray.count == 0 {
           
                let cell: NoAgreementsTableViewCell = tableView.dequeueReusableCellWithIdentifier("NoAgreementsCell", forIndexPath: indexPath) as! NoAgreementsTableViewCell
                cell.hidden = false
                self.debugUtil.printLog("cellForRowAtIndexPath", msg: "END")
            
                return cell
            
        } else {

            
            let cell: AgreementsTableViewCell = tableView.dequeueReusableCellWithIdentifier("AgreementsCell", forIndexPath: indexPath) as! AgreementsTableViewCell
            
            let cellAgreement = self.agreementsArray[indexPath.row]
            
            //self.viewStateManager.selectedCompaniesArray[self.viewStateManager.currentTransactionCompanyIndex].agreements[indexPath.row]
            //comment out temporarily
            cell.selectedBackgroundView = appAttributes.getcolorHighlightRowColor()

            cell.companyNameLabel.text = self.currentCompany.companyName
            
                //self.viewStateManager.selectedCompaniesArray[self.viewStateManager.currentTransactionCompanyIndex].company.companyName
            cell.agreementTypeLabel.text = cellAgreement.agreementType
            
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: "deleteAgreementAction:", forControlEvents: .TouchUpInside)
                     
            if self.tableView.indexPathForSelectedRow == indexPath {
                cell.companyBackgroundView.backgroundColor = UIColor(CGColor: appAttributes.colorOcean)
            } else {
                cell.companyBackgroundView.backgroundColor = UIColor(CGColor: appAttributes.colorCyan)
            }
            
            
            if viewStateManager.currentTransaction.transactionStatus != "Draft" && viewStateManager.currentTransaction.transactionStatus != "Pending Review" && viewStateManager.currentTransaction.transactionStatus != "Cleared" && viewStateManager.currentTransaction.transactionStatus != "Template"
            {
                cell.deleteButton.hidden = true
            }
            
           self.debugUtil.printLog("cellForRowAtIndexPath", msg: "END")
            
            return cell
            
        }
            
    }
    
    
    
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        self.debugUtil.printLog("didSelectRowAtIndexPath", msg: "BEGIN")
        let selectedIndexPath = self.tableView.indexPathForSelectedRow!
    let selectedIndex = selectedIndexPath.row
        
        if (Int(selectedIndex) != nil){
            self.handleEditButtonState()
            self.handleDeleteButtonState()
            let currTransIndex = self.viewStateManager.currentTransaction.currentTransactionCompanyIndex
            self.viewStateManager.currentTransaction.transactionCompanies[currTransIndex].currentTransactionCompanyAgreementIndex = selectedIndex
//            self.viewStateManager.currentTransactionCompanyAgreementIndex = selectedIndex
            self.selectedAgreement = self.agreementsArray[selectedIndex]
            
        } else {
            self.selectedAgreement = nil
        
        }
        self.editAgreementAction(indexPath.row)
 //       self.performSegueWithIdentifier("editAgreement", sender:self)
       // var index = String(indexPath.row)
        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! AgreementsTableViewCell
        toggleCompanyHeaderCellColor(cell, isSelect: true)
    
        self.debugUtil.printLog("didSelectRowAtIndexPath", msg: "END")
        
    }
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        self.debugUtil.printLog("didDeselectRowAtIndexPath", msg: "BEGIN")
        
       // var index = String(indexPath.row)
//        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! AgreementsTableViewCell
//        
//        toggleCompanyHeaderCellColor(cell, isSelect: false)
        
    }

}


