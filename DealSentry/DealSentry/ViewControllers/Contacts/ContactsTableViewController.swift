//
//  ContactsTableViewController.swift
//  DealSentry
//
//  Created by Skarulis, Joseph    on 7/22/15.
//  Copyright (c) 2015 Skarulis, Joseph   . All rights reserved.
//

import UIKit

enum ContactSearchScope: Int {
    case both
    case first
    case last
}

class ContactsTableViewController: UITableViewController {
    var debugUtil = DebugUtility(thisClassName: "CompaniesQuestionsViewController", enabled: false)
    var detailViewController: DetailViewController!
    var contactsArray: [ContactData]!
    let appAttributes = AppAttributes()
    var contactSearchtableViewController : ContactsSearchTableViewController!
    let sharedDataModel = SharedDataModel.sharedInstance
    var selectedContact: TransactionContactData!
    var selectedContactDataFromFilter: ContactData!
    let vcCon = VCConnection.sharedInstance
    var currentContactIndex: Int = 0
    var searchControlContactIndex = 0
    var contactsArrayForSearch = [ContactData]()
    var filteredContactsArrayForSearch = [ContactData]()
    @IBOutlet weak var roleImgWarningForSponsoringMD: UIImageView!
    @IBOutlet weak var roleTxtWarningForSponsoringMD: UILabel!
    @IBOutlet weak var roleImgWarningForRequestor: UIImageView!
    @IBOutlet weak var roleTxtWarningForRequestor: UILabel!
    @IBOutlet weak var roleImgWarningForCrossSell: UIImageView!
    @IBOutlet weak var roleTxtWarningForCrossSell: UILabel!
    
    var emptyTableLabel:UILabel = UILabel()

    var deleteButtonClicked = "NO"
    var deleteClicked = "NO"
    var requestorCount = 0
    var sponsoringMDCount = 0
    var crossSellCount = 0
    
    var searchController = UISearchController()

    
    override func viewWillAppear(animated: Bool) {
       // self.performSegueWithIdentifier("addContactsSegue", sender: self)
        reselectRow()
        showHideWarnings()
        showHideWarningForCrossSell()
    }
    
    private func initSearchController() {
        
        // present the results in the current view.
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.hidesNavigationBarDuringPresentation = true
        self.searchController.dimsBackgroundDuringPresentation = false
        //self.searchController.searchBar.showsScopeBar = false // only when active
        self.searchController.searchBar.scopeButtonTitles = ["Both","First","Last"]
        self.searchController.searchBar.searchBarStyle = UISearchBarStyle.Prominent
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.tintColor = UIColor(CGColor: appAttributes.colorCyan)
        self.searchController.searchBar.barTintColor = appAttributes.colorBackgroundColor
        self.searchController.searchBar.layer.backgroundColor = appAttributes.colorBackgroundColor.CGColor
        self.searchController.searchBar.sizeToFit()
        
        
        self.tableView.tableHeaderView = searchController.searchBar
        
        self.definesPresentationContext = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailViewController.embeddedContactsTableViewController = self

        self.debugUtil.printLog("viewDidLoad", msg: "BEGIN")
        
        super.viewDidLoad()
        //self.updateLocalVariables()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //self.tableView.tableFooterView = UIView()
        initSearchController()
        getContactFromCurrentTransaction()

        //hides the empty gridlines at bottom of page
        
        self.handleEditButtonState()
        self.handleDeleteButtonState()
        self.navigationItem.title =  "Contacts"
        
        let addContactBtn = UIBarButtonItem(
            image: UIImage(named:"add_user_white.png"),
            //title: "(+)",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "addContactAction:"
        )
        
        self.navigationItem.setRightBarButtonItems(
            // buttons right to left
            [addContactBtn],
            animated: false
        )
        
        let backButton = UIBarButtonItem (
            //image: UIImage( named: "back.png" ),
            title: "< Deals",
            //title: backTitle,
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "returnToDeal:"
            
        )
        
        
        
        self.navigationItem.setLeftBarButtonItems([backButton], animated: false)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if sharedDataModel.currentTransaction.transactionStatus != "Draft" && sharedDataModel.currentTransaction.transactionStatus != "Pending Review" && sharedDataModel.currentTransaction.transactionStatus != "Cleared" && sharedDataModel.currentTransaction.transactionStatus != "Template"
        {
            self.navigationItem.rightBarButtonItem = nil
            
        }
    }
    
    ///this method is used to update the contactsArrayForSearch array if a new contact is added or deleted from transaction contact
    func getContactFromCurrentTransaction()
    {
        for ContactData in self.sharedDataModel.currentTransaction.transactionContacts
        {
            contactsArrayForSearch.append(ContactData.contact)
        }
    }
 
    ///this method is invoked when a contact is tapped on the left hand side so that the index will be passed to the collection view controller which in turn shows the contact's entire details on the right hand side
    /// - Parameter index: index of the selected contact in the right hand side
    func editContactAction(index: Int) {
        
        self.detailViewController.embeddedContactsQuestionsCollectionsViewController.contactsTableViewController = self
       // self.detailViewController.embeddedEnterAgreementsViewController.agreementsTableViewController.companiesViewController = self.companiesViewController
        self.detailViewController.embeddedContactsQuestionsCollectionsViewController.selectedContact = self.selectedContact
        if searchController.active
        {
            self.detailViewController.embeddedContactsQuestionsCollectionsViewController.searchControllerActive = "YES"
        }
        else
        {
            self.detailViewController.embeddedContactsQuestionsCollectionsViewController.searchControllerActive = "NO"
        }
        self.detailViewController.embeddedContactsQuestionsCollectionsViewController.currentContactIndex = index
       // self.detailViewController.changeToAgreementsVC()
       // self.detailViewController.selectedIndex = 1
        self.detailViewController.embeddedContactsQuestionsCollectionsViewController.viewWillAppear(true)
        
        
    }
    
    
    @IBAction func dismissSearchContactsView(unwindSeque: UIStoryboardSegue ){
        self.debugUtil.printLog("dismissSearchContactsView", msg: "BEGIN")
        if !self.sharedDataModel.currentTransaction.transactionContacts.isEmpty {
            
            // toggle to company questions tab
            contactsArrayForSearch = [ContactData]()
            currentContactIndex = self.sharedDataModel.currentTransaction.currentTransactionContactIndex
            getContactFromCurrentTransaction()
            self.tableView.reloadData()
            setSelectedRow(currentContactIndex)
            reselectRow()

//            self.handleEditButtonState()
//            self.handleDeleteButtonState()
        }
        self.debugUtil.printLog("dismissSearchContactsView", msg: "END")
    }
 
    ///this method pops up the contact search controller to choose contact from the list. if its a DDT restricted transaction then an alert will be thrown to inform the user that THEY CANT ADD CONTACT FOR THIS TRANSACTION
    /// - Parameter sender: this paramater ensures that this method will be invoked only using button
    func addContactAction(sender: UIBarButtonItem) {
        
        if self.sharedDataModel.currentTransaction.ddtRestriction == "Yes"
        {
            let alert = UIAlertController(title: "DDT Restriction", message: "Ring fenced transaction.Additions to the deal team can only be done by contacting your local Control Group", preferredStyle: UIAlertControllerStyle.Alert)
            
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
        }
        else
        {
            self.performSegueWithIdentifier("addContactsSegue", sender: self)
        }
    }

    ///this method changes the view to details tab
    /// - Parameter sender: this paramater ensures that this method will be invoked only using bar button
    func returnToDeal(sender: UIBarButtonItem) {
        // let appDel = UIApplication.sharedApplication().delegate! as! AppDelegate
        vcCon.masterNavigationController.popToRootViewControllerAnimated(true)
        self.detailViewController.selectTab("Details")
    }

    ///this method is invoked only when user wants to delete a contact from transaction. delete button triggers this method which is present along with each contact
    /// - Parameter sender: this paramater ensures that this method will be invoked only using bar button
    func deleteContactAction(sender: UIBarButtonItem) {
        //get the current company first
        
        var contactName = ""
        var indexForCollection = -1
        deleteButtonClicked = "YES"
        deleteClicked = "YES"
        
        let selectedIndex = sender.tag
        
        if(searchController.active)
        {
          contactName =   filteredContactsArrayForSearch[selectedIndex].firstName + " " + filteredContactsArrayForSearch[selectedIndex].lastName
            
            if !self.filteredContactsArrayForSearch.isEmpty
            {
                self.selectedContactDataFromFilter = self.filteredContactsArrayForSearch[selectedIndex]
                
                for contactDataSearch in self.sharedDataModel.currentTransaction.transactionContacts
                {
                    indexForCollection++
                    
                    if contactDataSearch.contact.firstName == self.selectedContactDataFromFilter.firstName
                    {
                        break
                    }
                    
                }

            }
            
            searchControlContactIndex = indexForCollection
            
        }
        else
        {
            contactName = self.sharedDataModel.currentTransaction.transactionContacts[selectedIndex].contact.firstName + " " + self.sharedDataModel.currentTransaction.transactionContacts[selectedIndex].contact.lastName
        }
        
        setSelectedRow(sender.tag)
        self.reselectRow()
        
        
        let alert = UIAlertController(title: "Delete Contact" , message: "Deleting company " + " Are you certain you wish to delete " + contactName + " from the deal team?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                // condition made to delete the right contact as we can delete the contact in their normal state as well as in searched state
                if(self.searchController.active)
                {
                    indexForCollection = -1
                    if !self.filteredContactsArrayForSearch.isEmpty
                    {
                        self.selectedContactDataFromFilter = self.filteredContactsArrayForSearch[selectedIndex]
                        self.filteredContactsArrayForSearch.removeAtIndex(selectedIndex)
                        
                        for contactDataSearch in self.sharedDataModel.currentTransaction.transactionContacts
                        {
                            indexForCollection++
                            
                            if contactDataSearch.contact.firstName == self.selectedContactDataFromFilter.firstName
                            {
                                break
                            }
                            
                        }
                        
                        self.sharedDataModel.currentTransaction.transactionContacts.removeAtIndex(indexForCollection)
                        self.contactsArrayForSearch = [ContactData]()
                        self.getContactFromCurrentTransaction()
                        self.tableView.reloadData()
                        
                        if !self.filteredContactsArrayForSearch.isEmpty
                        {
                            indexForCollection = -1
                            self.selectedContactDataFromFilter = self.filteredContactsArrayForSearch[0]
                            
                            for contactDataSearch in self.sharedDataModel.currentTransaction.transactionContacts
                            {
                                indexForCollection++
                                
                                if contactDataSearch.contact.firstName == self.selectedContactDataFromFilter.firstName
                                {
                                    break
                                }
                                
                            }
                            self.searchControlContactIndex = indexForCollection
                            self.setSelectedRow(0)
                            self.reselectRow()
                        }
                        else
                        {
                            self.searchController.active = false
                        }
                        
                        
                    }
                    
                }
                else
                {
                    self.sharedDataModel.currentTransaction.transactionContacts.removeAtIndex(selectedIndex)
                    self.contactsArrayForSearch = [ContactData]()
                    self.getContactFromCurrentTransaction()
                    self.tableView.reloadData()
                    if sender.tag == self.currentContactIndex {
                        //set new row as the first row
                        self.setSelectedRow(0)
                        self.reselectRow()
                        
                        
                    } else {
                        //this else condition is when row is selected already but did not delete that row.
                        //lets reset the selected row
                        //there are two cases.
                        //1.  the row index is before delete
                        //2.  the row index is after delete
                        if self.currentContactIndex > sender.tag {
                            self.setSelectedRow(self.currentContactIndex - 1)
                        } else {
                            self.setSelectedRow(self.currentContactIndex)
                        }
                       self.reselectRow()
                    }
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

        if(searchController.active && deleteButtonClicked == "YES")
        {
            self.selectedContact = self.sharedDataModel.currentTransaction.transactionContacts[searchControlContactIndex]
        }
        else
        {
            self.selectedContact = self.sharedDataModel.currentTransaction.transactionContacts[index]
        }
        currentContactIndex = index
        self.sharedDataModel.currentTransaction.currentTransactionContactIndex = index
    }
    

    func reselectRow() {
        var lastSelectedRowIndex: Int = 0
        //We will now have to either display the last selected row.  or "FORCE" create a new row
        if self.sharedDataModel.currentTransaction.transactionContacts.count > 0 {
            lastSelectedRowIndex = self.sharedDataModel.currentTransaction.currentTransactionContactIndex
            let lastSelectedIndexPath = NSIndexPath(forRow: lastSelectedRowIndex, inSection: 0)
            self.tableView.selectRowAtIndexPath(lastSelectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
            //self.detailViewController.selectedIndex = 1
            self.editContactAction(lastSelectedRowIndex)
        } else {
            lastSelectedRowIndex = self.sharedDataModel.currentTransaction.currentTransactionContactIndex
            let lastSelectedIndexPath = NSIndexPath(forRow: lastSelectedRowIndex, inSection: 0)
            self.tableView.selectRowAtIndexPath(lastSelectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
            //self.detailViewController.selectedIndex = 1
            self.editContactAction(lastSelectedRowIndex)
            
        }
        let lastSelectedIndexPath = NSIndexPath(forRow: lastSelectedRowIndex, inSection: 0)
        if deleteClicked == "YES"
        {
            self.tableView(self.tableView, didSelectRowAtIndexPath: lastSelectedIndexPath)
            deleteClicked = "NO"
        }
    }
    override func shouldAutorotate() -> Bool {
        return true
    }
//    override func supportedInterfaceOrientations() -> Int {
//        return Int(UIInterfaceOrientation.Portrait.rawValue) | Int(UIInterfaceOrientation.LandscapeLeft.rawValue) | Int(UIInterfaceOrientation.LandscapeRight.rawValue)
//    }
//    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        let orientation: UIInterfaceOrientationMask = [UIInterfaceOrientationMask.Portrait, UIInterfaceOrientationMask.LandscapeLeft,UIInterfaceOrientationMask.LandscapeRight]
        return orientation
    }
    
    func handleEditButtonState(){
//        var selectedIndexPath = self.tableView.indexPathForSelectedRow!
//        var selectedIndex = selectedIndexPath.row
        
    }
    
    func handleDeleteButtonState(){
//        var selectedIndexPath = self.tableView.indexPathForSelectedRow
//        var selectedIndex = selectedIndexPath?.row
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // self.debugUtil.printLog("prepareForSegue", msg: "BEGIN")
        
        if let segueId = segue.identifier {
            //    self.debugUtil.printLog("prepareForSegue", msg: "segueId = " + segueId)
            
            switch segueId {

            case "addContactsSegue" :
                let navigationController = segue.destinationViewController as! UINavigationController
                self.contactSearchtableViewController = navigationController.topViewController as! ContactsSearchTableViewController
            default:
                break
            }
            
        }
        
        //  self.debugUtil.printLog("prepareForSegue", msg: "END")
    }

    ///this method counts the number of contacts that has role as requestor
    /// - Returns: returns count as integer
    func getRequestorCount() -> Int{
        var count = 0
        for c in self.sharedDataModel.currentTransaction.transactionContacts {
            if c.role == "Requestor" {
                count++
            }
        }
        return count
    }
    
    ///this method counts the number of contacts that has role as sponsoring MD
    /// - Returns: returns count as integer
    func getSponsoringMDCount() -> Int{
        var count = 0
        for c in self.sharedDataModel.currentTransaction.transactionContacts {
            if c.role == "Sponsoring MD" {
                count++
            }
        }
        return count
    }
    
    ///this method counts the number of contact who are cross sell designees
    /// - Returns: returns count as integer
    func getCrossSellCount() -> Int{
        var count = 0
        if self.sharedDataModel.currentTransaction.transactionDetail.product == "M&A"
        {
        for c in self.sharedDataModel.currentTransaction.transactionContacts {
            if c.contact.crossSellDesignee {
                count++
            }
        }
        }
        return count
    }
    
    ///this method shows/hides warning based on the role count
    func showHideWarnings() {
       
        requestorCount = getRequestorCount()
        sponsoringMDCount = getSponsoringMDCount()
       
        if(requestorCount == 0)
        {
            roleImgWarningForRequestor.hidden = false
            roleTxtWarningForRequestor.hidden = false
        }
        else
        {
            roleImgWarningForRequestor.hidden = true
            roleTxtWarningForRequestor.hidden = true
        }
        
        if(sponsoringMDCount == 0)
        {
            roleImgWarningForSponsoringMD.hidden = false
            roleTxtWarningForSponsoringMD.text = "At least one Sponsoring MD role is required"
            roleTxtWarningForSponsoringMD.hidden = false
        }
        else if(sponsoringMDCount > 1)
        {
            roleImgWarningForSponsoringMD.hidden = false
            roleTxtWarningForSponsoringMD.text = "Duplicate Sponsoring MD role not allowed"
            roleTxtWarningForSponsoringMD.hidden = false
        }
        else
        {
            roleImgWarningForSponsoringMD.hidden = true
            roleTxtWarningForSponsoringMD.hidden = true
        }

    }

    ///this method shows/hides cross sell designee warning based on the cross sell designee contacts count
    func showHideWarningForCrossSell()
    {
        crossSellCount = getCrossSellCount()
        if(crossSellCount == 0 && self.sharedDataModel.currentTransaction.transactionDetail.product == "M&A")
        {
            roleImgWarningForCrossSell.hidden = false
            roleTxtWarningForCrossSell.hidden = false
        }
        else
        {
            roleImgWarningForCrossSell.hidden = true
            roleTxtWarningForCrossSell.hidden = true
        }
    }
    
}



extension ContactsTableViewController{
   
     
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        var numberOfSections = 0
        self.debugUtil.printLog("numberOfSectionsInTableView", msg: "BEGIN")
        self.debugUtil.printLog("numberOfSectionsInTableView", msg: "END" )
        if !self.contactsForShowing().isEmpty
        {
            numberOfSections = 1
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            self.tableView.backgroundView = nil
        }
        else
        {
            emptyTableLabel.text = "No Contact Available"
            emptyTableLabel.textColor = UIColor.blackColor()
            emptyTableLabel.textAlignment = NSTextAlignment.Center
            self.tableView.backgroundView = emptyTableLabel
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        }
        return numberOfSections
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
      //  self.debugUtil.printLog("numberOfRowsInSect", msg: String(self.contactsArray.count))
        if self.sharedDataModel.currentTransaction.transactionContacts.count == 0 {
            return 1
        } else {
            return  self.contactsForShowing().count
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let index = String(indexPath.row)
        
        self.debugUtil.printLog("cellForRowAtIndexPath", msg: "BEGIN indexPath.row = " + index)
        

            
            let cell: ContactsTableViewCell = tableView.dequeueReusableCellWithIdentifier("ContactsTableViewCell", forIndexPath: indexPath) as! ContactsTableViewCell
        
        let cellContact = self.contactsForShowing()[indexPath.row]
        
        cell.nameLabel.text = cellContact.firstName +  " " + cellContact.lastName
        
        cell.contactBackgroundView.backgroundColor = UIColor(CGColor: appAttributes.colorOcean)
            //self.sharedDataModel.selectedCompaniesArray[self.sharedDataModel.currentTransactionCompanyIndex].agreements[indexPath.row]
            //comment out temporarily
            cell.selectedBackgroundView = appAttributes.getcolorHighlightRowColor()
            
        if self.tableView.indexPathForSelectedRow == indexPath {
            cell.contactBackgroundView.backgroundColor = UIColor(CGColor: appAttributes.colorOcean)
            
        } else {
            //var bgLayer = appAttributes.getcolorCompSubTaskBackground()
            //bgLayer.frame = companyCell.companyBackgroundView.bounds
            //companyCell.companyBackgroundView.layer.insertSublayer(bgLayer, atIndex: 0)
            cell.contactBackgroundView.backgroundColor = UIColor(CGColor: appAttributes.colorCyan)
        }
            //self.sharedDataModel.selectedCompaniesArray[self.sharedDataModel.currentTransactionCompanyIndex].company.companyName
        
        
        var indexForCollection = -1
        var cellContactRole: TransactionContactData!
        if searchController.active
        {
            if !filteredContactsArrayForSearch.isEmpty
            {
                selectedContactDataFromFilter = filteredContactsArrayForSearch[indexPath.row]
                
                for contactDataSearch in self.sharedDataModel.currentTransaction.transactionContacts
                {
                    indexForCollection++
                    
                    if contactDataSearch.contact.firstName == selectedContactDataFromFilter.firstName
                    {
                        break
                    }
                    
                }
                cellContactRole = self.sharedDataModel.currentTransaction.transactionContacts[indexForCollection]
            }
        }
        else
        {
            cellContactRole = self.sharedDataModel.currentTransaction.transactionContacts[indexPath.row]
        }
        
            cell.roleLabel.text = cellContactRole.role
            
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: "deleteContactAction:", forControlEvents: .TouchUpInside)
            
            showHideWarnings()
        
            if sharedDataModel.currentTransaction.transactionDetail.product == "M&A"
            {
                showHideWarningForCrossSell()
            }

            if sharedDataModel.currentTransaction.transactionStatus != "Draft" && sharedDataModel.currentTransaction.transactionStatus != "Pending Review" && sharedDataModel.currentTransaction.transactionStatus != "Cleared" && sharedDataModel.currentTransaction.transactionStatus != "Template"
            {
                cell.deleteButton.hidden = true
            }
        
           else if self.sharedDataModel.currentTransaction.transactionContacts.count == 1 || cellContactRole.role == "Requestor" || self.sharedDataModel.currentTransaction.ddtRestriction == "Yes"
            {
                cell.deleteButton.hidden = true
            }
        else
            {
                cell.deleteButton.hidden = false
            }
            
            self.debugUtil.printLog("cellForRowAtIndexPath", msg: "END")
            
            return cell
            
        
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        self.debugUtil.printLog("willSelectRowAtIndexPath", msg: "BEGIN")
//        let index = String(indexPath.row)
        return indexPath
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        self.debugUtil.printLog("didSelectRowAtIndexPath", msg: "BEGIN")
        let selectedIndexPath = self.tableView.indexPathForSelectedRow!
        let selectedIndex = selectedIndexPath.row
        var indexForCollection = -1
        if (Int(selectedIndex) != nil){
            self.handleEditButtonState()
            self.handleDeleteButtonState()
            if searchController.active
            {
                if !filteredContactsArrayForSearch.isEmpty
                {
                    selectedContactDataFromFilter = filteredContactsArrayForSearch[selectedIndex]
               
                    for contactDataSearch in self.sharedDataModel.currentTransaction.transactionContacts
                        {
                            indexForCollection++

                            if contactDataSearch.contact.firstName == selectedContactDataFromFilter.firstName
                            {
                                break
                            }

                        }
                self.selectedContact = self.sharedDataModel.currentTransaction.transactionContacts[indexForCollection]
                currentContactIndex = indexForCollection
                }
            }
            else
            {
                self.selectedContact = self.sharedDataModel.currentTransaction.transactionContacts[selectedIndex]
                currentContactIndex = selectedIndex
            }
            
        } else {
            self.selectedContact = nil
            
        }
        self.sharedDataModel.currentTransaction.currentTransactionContactIndex = selectedIndex
         
        self.editContactAction(indexPath.row)
       // var index = String(indexPath.row)
        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! ContactsTableViewCell
        toggleCompanyHeaderCellColor(cell, isSelect: true)

        
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
//        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! ContactsTableViewCell
//        toggleCompanyHeaderCellColor(cell, isSelect: false)
        
    }
    
    func toggleCompanyHeaderCellColor(cell: ContactsTableViewCell, isSelect: Bool){
        
        if isSelect {
            cell.contactBackgroundView.backgroundColor = UIColor(CGColor: appAttributes.colorOcean)
        } else {
            cell.contactBackgroundView.backgroundColor = UIColor(CGColor: appAttributes.colorCyan)
        }
    }
    
}

extension ContactsTableViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    private func contactsForShowing() -> [ContactData] {

        if self.searchController.active {
            return self.filteredContactsArrayForSearch
        } else {
            return self.contactsArrayForSearch
        }
    }
    // set the filtered array to the full list, then filter it based on the string matching
    func searchForText(searchText: String, scope: ContactSearchScope) {
        self.debugUtil.printLog("searchForText" , msg: "BEGIN")
        self.debugUtil.printLog("searchForText" , msg: "searchText = " + searchText)
        if ( searchText.isEmpty ) {
            self.debugUtil.printLog("searchForText" , msg: "searchText isEmpty")
            self.filteredContactsArrayForSearch = self.contactsArrayForSearch// reset to full list
        } else {
            self.debugUtil.printLog("searchForText" , msg: "searchText = " + searchText)
            
            // Filter the array using the filter method
            self.filteredContactsArrayForSearch = self.contactsArrayForSearch.filter({( contact: ContactData) -> Bool in
                
                switch scope {
                    
                case .both:
                    // number of characters in search string
                    //var searchStringLength = searchText.lengthOfBytesUsingEncoding(NSUTF16StringEncoding)
                    let bothContactName = (contact.firstName + contact.lastName).lowercaseString
                    /* var contactPrefix = bothContactName.substringWithRange(
                    Range<String.Index>(
                    start: bothContactName.startIndex,
                    end: advance(bothContactName.startIndex, searchStringLength)
                    )
                    )*/
                    
                    self.debugUtil.printLog("searchForText", msg: "scope = Both")
                    self.debugUtil.printLog("searchForText", msg: "END")
                    return bothContactName.rangeOfString(searchText.lowercaseString) != nil
                    
                case .first:
                    self.debugUtil.printLog("searchForText", msg: "scope = First")
                    self.debugUtil.printLog("searchForText", msg: "END")
                    return contact.firstName.lowercaseString.rangeOfString(searchText.lowercaseString) != nil
                    
                case .last:
                    self.debugUtil.printLog("searchForText", msg: "scope = Last")
                    self.debugUtil.printLog("searchForText", msg: "END")
                    return contact.lastName.lowercaseString.rangeOfString(searchText.lowercaseString) != nil

                }
                
            })
        }
        
    }
    
    // empty the filtered array, fill it with search results, reload the tableview with it
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        self.debugUtil.printLog("updateSearchResultsForSearchController", msg: "BEGIN")
        let searchString = self.searchController.searchBar.text
        //if !searchString.isEmpty {
        let scopeIndex = ContactSearchScope(rawValue: self.searchController.searchBar.selectedScopeButtonIndex)!
        searchForText(searchString!, scope: scopeIndex)
        self.tableView.reloadData()
        if !filteredContactsArrayForSearch.isEmpty
        {
            setSelectedRow(0)
            reselectRow()
        }

        //}
        
        self.debugUtil.printLog("updateSearchResultsForSearchController", msg: "END")
    }
    
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.debugUtil.printLog("selectedScopeButtonIndexDidChange", msg: "BEGIN")
        
        self.updateSearchResultsForSearchController(self.searchController)
        
        self.debugUtil.printLog("selectedScopeButtonIndexDidChange", msg: "END")
    }
    
}
