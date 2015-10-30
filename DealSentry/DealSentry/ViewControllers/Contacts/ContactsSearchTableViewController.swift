//
//  ContactsSearchTableViewController.swift
//  truemobile
//

import UIKit



class ContactsSearchTableViewController: UITableViewController {
    var debugUtil = DebugUtility(thisClassName: "ContactsSearchTableViewController", enabled:false)
    let sharedDataModel = SharedDataModel.sharedInstance
    var searchController = UISearchController()
    var selectedContact: ContactData?
    let appAttributes = AppAttributes()
    
    ///this method is invoked when user taps the done button present in contact search controller. once the done button is clicked the selected contact will be compared with the already existing contacts. if a match is found, then an alert will be thorwn stating that CONTACT ALREADY PRESENT else contact will be added
    /// - Parameter sender: this paramater ensures that this method will be invoked only using bar button
    @IBAction func doneAction(sender: UIBarButtonItem) {
        
        var contactAlreadyPresent = "NO"
        
        if self.selectedContact != nil {
            
            for ContactData in self.sharedDataModel.currentTransaction.transactionContacts
            {
               if ContactData.contact.soeID == selectedContact?.soeID
               {
                        contactAlreadyPresent = "YES"
                        break
               }
            }
            
            if contactAlreadyPresent == "NO"
            {
                let newTransContact = TransactionContactData( contact: self.selectedContact!, role: "")
                
                self.sharedDataModel.currentTransaction.addContacts([newTransContact]
                )
                self.sharedDataModel.currentTransaction.currentTransactionContactIndex = self.sharedDataModel.currentTransaction.transactionContacts.count - 1
                
                self.performSegueWithIdentifier("dismissSearchContactsView", sender: self)
            }
            
            else
            {
                let alert = UIAlertController(title: "Duplicate Contact", message: "This contact is already in deal team list", preferredStyle: UIAlertControllerStyle.Alert)
                
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
            
            
            
        } else {
            // show alert view need to select a company
        }
    }
    
    @IBAction func cancelAction(sender: UIBarButtonItem) {
        if self.sharedDataModel.currentTransaction.transactionContacts.count == 1
        {
            self.sharedDataModel.currentTransaction.currentTransactionContactIndex = 0
        }

        self.performSegueWithIdentifier("dismissSearchContactsView", sender: self)
    }
    
    private func initContactsSearchController() {
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.searchBarStyle = UISearchBarStyle.Prominent
        self.searchController.searchBar.scopeButtonTitles = ["Both","First","Last"]
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.sizeToFit()
        self.searchController.searchBar.tintColor = UIColor(CGColor: appAttributes.colorCyan)
        self.searchController.searchBar.barTintColor = appAttributes.colorBackgroundColor
        self.searchController.searchBar.layer.backgroundColor = appAttributes.colorBackgroundColor.CGColor

        self.tableView.tableHeaderView = self.searchController.searchBar
        self.definesPresentationContext = true
    }
    
    override func awakeFromNib() {
        
        self.debugUtil.printLog("awakeFromNib", msg: "BEGIN")
        
        super.awakeFromNib()
        //self.clearsSelectionOnViewWillAppear = false
        self.preferredContentSize = CGSize(width: 400.0, height: 220.0)
        
        self.debugUtil.printLog("awakeFromNib", msg: "END")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //hides the empty gridlines at bottom of page
        self.tableView.tableFooterView = UIView()
       
        // Configure AddController
        self.initContactsSearchController()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let navImage: UIImage = UIImage(named: "blue-wave.png")!
        self.navigationController?.navigationBar.setBackgroundImage(navImage, forBarMetrics: .Default)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.title = "Search Contacts"
        self.navigationItem.titleView?.tintColor = UIColor.whiteColor()
        let titleDic: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = titleDic as? [String : AnyObject]
        


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ContactsSearchTableViewController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.debugUtil.printLog("numberOfRowsInSection", msg: "BEGIN")
        self.debugUtil.printLog("numberOfRowsInSection", msg: "END")
        
        // searchResultsTableView
        return self.contactsForShowing().count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        self.debugUtil.printLog("numberOfSectionsInTableView", msg: "BEGIN")
        self.debugUtil.printLog("numberOfSectionsInTableView", msg: "END" )
        return 1
    }
    
    // set the custom Prototype table view cell data labels
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let index = String(indexPath.row)
        
        self.debugUtil.printLog("cellForRowAtIndexPath", msg: "BEGIN indexPath.row = " + index)
        
        let searchResultContactCell: ContactsSearchTableViewCell = tableView.dequeueReusableCellWithIdentifier("ContactsSearchCell", forIndexPath: indexPath) as! ContactsSearchTableViewCell
        
        let cellCompany = self.contactsForShowing()[indexPath.row]
        
        searchResultContactCell.selectedBackgroundView = appAttributes.getcolorHighlightRowColor()
        searchResultContactCell.nameLabel.text = cellCompany.firstName + " " + cellCompany.lastName
        searchResultContactCell.emailLabel.text = cellCompany.email
        
        searchResultContactCell.phoneLabel.text = cellCompany.phone
        searchResultContactCell.gocDescriptionLabel.text = cellCompany.gocDescription
        
        self.debugUtil.printLog("cellForRowAtIndexPath", msg: "END")
        return searchResultContactCell
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let index = String(indexPath.row)
        
        self.debugUtil.printLog("didSelectRowAtIndexPath", msg: "BEGIN indexPath.row = " + index)
        

        
        let cellContact = self.contactsForShowing()[indexPath.row]
        
        self.selectedContact = cellContact // add this to model on Done
        
        self.debugUtil.printLog("didSelectRowAtIndexPath", msg: "END")
    }
    
}
extension ContactsSearchTableViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
        
        private func contactsForShowing() -> [ContactData] {
            if self.searchController.active {
                return self.sharedDataModel.filteredContactsArray
            } else {
                return self.sharedDataModel.contactsArray
            }
        }
    // set the filtered array to the full list, then filter it based on the string matching
    func searchForText(searchText: String, scope: ContactSearchScope) {
        self.debugUtil.printLog("searchForText" , msg: "BEGIN")
        self.debugUtil.printLog("searchForText" , msg: "searchText = " + searchText)
        
        if ( searchText.isEmpty ) {
            self.debugUtil.printLog("searchForText" , msg: "searchText isEmpty")
            self.sharedDataModel.filteredContactsArray = self.sharedDataModel.contactsArray // reset to full list
        } else {
            self.debugUtil.printLog("searchForText" , msg: "searchText = " + searchText)
            
            // Filter the array using the filter method
            self.sharedDataModel.filteredContactsArray = self.sharedDataModel.contactsArray.filter({( contact: ContactData) -> Bool in
                
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
        //}
        
        self.debugUtil.printLog("updateSearchResultsForSearchController", msg: "END")
    }
    
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.debugUtil.printLog("selectedScopeButtonIndexDidChange", msg: "BEGIN")
        
        self.updateSearchResultsForSearchController(self.searchController)
        
        self.debugUtil.printLog("selectedScopeButtonIndexDidChange", msg: "END")
    }

}