//
//  MasterViewController.swift
//

import Foundation
import UIKit

enum sortDirectionEnum {
case up // "△",
case down // "▽"
}

enum TransactionSortingSearchScope: Int {
case All, Id, Name, Product
}

class MasterViewController: UITableViewController {
    
    var debugUtil = DebugUtility(thisClassName: "MasterViewController", enabled: false)
    let appAttributes = AppAttributes()
    let vcCon = VCConnection.sharedInstance
    let sharedDataModel = SharedDataModel.sharedInstance
    var emptyTableLabel:UILabel = UILabel()
    var detailViewController: DetailViewController!
    var appDelegate: AppDelegate!
    
    private var currentSortOption = "Date" // default
    
    private var currentSortDirection = sortDirectionEnum.down // default
    
    private var searchController: UISearchController!
    var embeddedCompaniesViewController: CompaniesQuestionsViewController!
    var embeddedContactsTableViewController: ContactsTableViewController!
    var embeddedTransactionFilterViewController: TransactionFilterTableViewController!
    
    // set the view title based on current category
    //this needs to be made public so that the tran. filter can update count
    func setNavigationItemTitle() {
        if self.sharedDataModel.selectedCategory == "Template" {
            self.navigationItem.title = self.sharedDataModel.selectedCategory
        } else {
            let counter = self.sharedDataModel.getTransactionCountByCategory(self.sharedDataModel.selectedCategory)
            self.navigationItem.title = self.sharedDataModel.selectedCategory + " (" + String(counter) + ")"
        }
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.titleView?.tintColor = UIColor.whiteColor()
        let titleDic: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = titleDic as? [String : AnyObject]
    }
    
    /*
    func addRightNavItemsOnView() {
    
    var rightBarButtonItemSortOption: UIBarButtonItem = UIBarButtonItem(
    title: "Sort: Date",
    style: UIBarButtonItemStyle.Plain,
    target: self,
    action: "sortAction:"
    )
    
    var rightBarButtonItemSortDirection: UIBarButtonItem = UIBarButtonItem(
    title: "▽",
    style: UIBarButtonItemStyle.Plain,
    target: self,
    action: "toggleSortDirection:"
    )
    
    // add multiple right bar button items
    self.navigationItem.setRightBarButtonItems(
    // buttons right to left
    [rightBarButtonItemSortDirection,rightBarButtonItemSortOption],
    animated: false
    )
    }
    */
    
    func checkForOrientationChange()
    {
        if self.sharedDataModel.checkForOrientationChange == "landscape"
        {
            vcCon.splitViewController!.preferredPrimaryColumnWidthFraction = 0.31
        }
        else
        {
            vcCon.splitViewController!.preferredPrimaryColumnWidthFraction = 0.4
        }
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        if UIDevice.currentDevice().orientation.isLandscape.boolValue
        {
            vcCon.splitViewController!.preferredPrimaryColumnWidthFraction = 0.31
        }
        else
        {
            vcCon.splitViewController!.preferredPrimaryColumnWidthFraction = 0.4
        }
    }
    
    // initialize the SearchController
    private func initSearchController() {
        
        // present the results in the current view.
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.hidesNavigationBarDuringPresentation = true
        self.searchController.dimsBackgroundDuringPresentation = false
        //self.searchController.searchBar.showsScopeBar = false // only when active
        self.searchController.searchBar.scopeButtonTitles = ["All","Id","Name","Product"]
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
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        //hello
    }
    func searchBarResultsListButtonClicked(searchBar: UISearchBar) {
        //hello
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        //hello
    }
    
    // select the last selected table row cell based on current category
    func reselectLastSelectedRow() {
         var lastSelectedRowIndex = 0
        if(self.transactionsForShowing().count > 1 )
        {
          lastSelectedRowIndex  = self.sharedDataModel.getLastViewedTransactionIndexByCategory()
        }
        else
        {
            lastSelectedRowIndex = 0
        }
        let lastSelectedIndexPath = NSIndexPath(forRow: lastSelectedRowIndex, inSection: 0)
        self.tableView.selectRowAtIndexPath(lastSelectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
       // self.performSegueWithIdentifier("showQuestionaire", sender: self)
      //    self.performSegueWithIdentifier("showCompanies", sender: self)
    }
    
    /// adding bar button on top of masterview controller
    func initTopNav() {
        let filterButton = UIBarButtonItem (
            image: UIImage( named: "briefcase.png" ),
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "filterDealAction:"
            
        )
        self.navigationItem.setLeftBarButtonItems(
            // buttons right to left
            [filterButton],
            animated: true
        )
      /*  self.navigationItem.setRightBarButtonItems(
            // buttons right to left
            [compButton],
            animated: true
        )*/

    }
    
    /// this method will be invoked to show the company or contact as master view controller
    func initDefault() {
        self.performSegueWithIdentifier("showQuestionaire", sender: self)
        self.embeddedCompaniesViewController = self.storyboard!.instantiateViewControllerWithIdentifier("companiesViewController") as! CompaniesQuestionsViewController
        self.embeddedCompaniesViewController.detailViewController = self.detailViewController
        self.detailViewController.embeddedCompaniesQuestions2ViewController = embeddedCompaniesViewController
        self.embeddedContactsTableViewController = self.storyboard!.instantiateViewControllerWithIdentifier("contactsTableViewController") as! ContactsTableViewController
        self.embeddedContactsTableViewController.detailViewController = self.detailViewController
        self.detailViewController.embeddedContactsTableViewController = embeddedContactsTableViewController
    }
    /*
    func launchCompanies(sender: UIButton) {
         //self.performSegueWithIdentifier("showCompanies", sender: self)
    }*/
    @IBAction func filterDealAction(sender: UIButton) {
        self.debugUtil.printLog("filterDealAction", msg: "BEGIN")
        
        
        let popoverContent = self.storyboard!.instantiateViewControllerWithIdentifier("TransactionFilterTableViewController") as! TransactionFilterTableViewController
        let nav = UINavigationController(rootViewController: popoverContent)
        nav.modalPresentationStyle = UIModalPresentationStyle.Popover
        let popover = nav.popoverPresentationController
        popoverContent.preferredContentSize = CGSizeMake(295,490)
        popover!.delegate = self
        popover!.sourceView = self.view
        popover!.sourceRect = CGRectMake(15,self.view.bounds.origin.y+63,40,0)
//        popover!.sourceRect = CGRectMake(15,0,40,0)
        
        self.presentViewController(nav, animated: true, completion: nil)
        popoverContent.title = "Choose a Category"
        popoverContent.popoverPresentationController?.sourceView = sender
        self.embeddedTransactionFilterViewController = popoverContent
        self.embeddedTransactionFilterViewController.detailViewController = vcCon.detailViewController
        
        self.debugUtil.printLog("filterDealAction", msg: "END")
    }
    
    
    override func awakeFromNib() {
        
        self.debugUtil.printLog("awakeFromNib", msg: "BEGIN")
        
        super.awakeFromNib()
        self.clearsSelectionOnViewWillAppear = false
        //self.preferredContentSize = CGSize(width: 520.0, height: 600.0)
        
        self.debugUtil.printLog("awakeFromNib", msg: "END")
    }
    
    
    override func viewDidLoad() {
        self.debugUtil.printLog("viewDidLoad", msg: "BEGIN")
        
        super.viewDidLoad()

        vcCon.splitViewController!.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
        
        // Configure tableview
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.debugUtil.printLog("viewDidLoad", msg: "selectedCategory = " + self.sharedDataModel.selectedCategory)
        
        
        // add the right side buttons to nav bar
        //self.addRightNavItemsOnView()
        
        // initialize the SearchController
        self.initSearchController()
        // select the last selected table row cell based on current category
        self.reselectLastSelectedRow()
        
        // var detailNav = self.splitViewController?.viewControllers[1] as! UINavigationController
        //self.detailViewController = detailNav.topViewController as! DetailViewController
        
        self.initTopNav()
        self.initDefault()
        
        //set background
        let navImage: UIImage = UIImage(named: "blue-wave.png")!
        
        self.navigationController?.navigationBar.setBackgroundImage(navImage, forBarMetrics: .Default)

        self.view.layer.backgroundColor = (appAttributes.colorBackgroundColor).CGColor
        self.debugUtil.printLog("viewDidLoad", msg: "END")
    }
    
    /// UI refresh controller method when the user swipe down the masterview controller
    /// - Parameter sender: can be invoked by any object
    func refresh(sender:AnyObject)
    {
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.debugUtil.printLog("viewWillAppear", msg: "BEGIN")
        
        super.viewWillAppear(true)
        checkForOrientationChange()
        //self.searchController.searchBar.sizeToFit()
        //self.tableView.tableHeaderView = self.searchController.searchBar
        
        // set the view title based on current category - in view will appear to reflect refresh in filter
        self.setNavigationItemTitle()

        self.debugUtil.printLog("viewWillAppear", msg: "END")
    }
    func setDetailPageDelegate(idx:Int) {
        self.detailViewController.selectedIndex = idx
    }
    override func viewDidAppear(animated: Bool) {
        self.debugUtil.printLog("viewDidAppear", msg: "BEGIN")
        super.viewDidAppear(true)
         //self.tableView.reloadData()
        //var lastViewedCellRow = self.sharedDataModel.getLastViewedTransactionIndexByCategory()
        //var selectedCellIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        //self.tableView.selectRowAtIndexPath( selectedCellIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.None )
        
        self.debugUtil.printLog("viewDidAppear", msg: "END")
    }
    
    override func didReceiveMemoryWarning() {
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "BEGIN")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "END")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        self.debugUtil.printLog("prepareForSegue", msg: "BEGIN")
        
        //var indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow()!
        self.debugUtil.printLog("prepareForSegue", msg: " selectedStatus = " + self.sharedDataModel.selectedCategory)
        
        if let segueId = segue.identifier {
            
            switch segueId {
                
                // user touched a transaction in the list shows its detail
            case "showQuestionaire":
                
                var navController: UINavigationController
                navController = segue.destinationViewController as! UINavigationController
                
                
                self.detailViewController = navController.topViewController as! DetailViewController
                                
                if ( self.sharedDataModel.selectedCategory == "Template" ) {
                    self.debugUtil.printLog("prepareForSegue", msg: "segueId = showQuestionaire template")
                    self.sharedDataModel.prepareTemplateModel()
                } else {
                    let indexPath = self.tableView.indexPathForSelectedRow!
                    let txnIndex = indexPath.row - 1 // first row is the sort and filter prototype cell
                    
                    // when searched filtered
                    if self.searchController.active {
                        self.debugUtil.printLog("prepareForSegue", msg: "segueId = showQuestionaire search is active")
                        if (self.transactionsForShowing().count > 1)
                        {
                            self.sharedDataModel.prepareQuestionaireModel(txnIndex, filtered: true)
                        }
                        else
                        {
                            self.sharedDataModel.prepareQuestionaireModel(0, filtered: true)
                        }
                    } else if (self.transactionsForShowing().count > 1) {
                        self.debugUtil.printLog("prepareForSegue", msg: "segueId = showQuestionaire")
                        self.sharedDataModel.prepareQuestionaireModel(txnIndex, filtered: false)
                    }
                    else
                    {
                        self.debugUtil.printLog("prepareForSegue", msg: "segueId = showQuestionaire")
                        self.sharedDataModel.prepareQuestionaireModel(0, filtered: false)
                    }
                }
            case "showCompanies" :
                self.debugUtil.printLog("prepareForSegue", msg: "segueId = showCompanies template")
                self.embeddedCompaniesViewController = segue.destinationViewController as! CompaniesQuestionsViewController
                self.embeddedCompaniesViewController.detailViewController = self.detailViewController
                self.embeddedCompaniesViewController.detailViewController.selectTab("Companies")
            case "showContacts" :
                self.debugUtil.printLog("prepareForSegue", msg: "segueId = showContacts")
                self.embeddedContactsTableViewController = segue.destinationViewController as! ContactsTableViewController
                self.embeddedContactsTableViewController.detailViewController = self.detailViewController
                self.embeddedContactsTableViewController.detailViewController.selectTab("Contacts")
            default:
                self.debugUtil.printLog("prepareForSegue", msg: "segueId = " + segueId)
                break
            }
        }
        
        self.debugUtil.printLog("prepareForSegue", msg: "END")
    }
    
}



extension  MasterViewController {
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //self.debugUtil.printLog("numberOfRowsInSection", msg: "BEGIN")
        
        if ( self.sharedDataModel.selectedCategory == "Template" || self.transactionsForShowing().count == 1 ) {
            // dont include the first sort and filter cell
            //self.debugUtil.printLog("numberOfRowsInSection", msg: "END")
            return 1
        }
            else if self.transactionsForShowing().count == 0
            {
                return 0
            }
         else {
            //self.debugUtil.printLog("numberOfRowsInSection", msg: "END")
            return self.transactionsForShowing().count + 1 // add the first sort filter cell
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //self.debugUtil.printLog("numberOfSectionsInTableView", msg: "BEGIN")
        //self.debugUtil.printLog("numberOfSectionsInTableView", msg: "END" )
        var numberOfSections = 0
        if !self.transactionsForShowing().isEmpty
        {
            numberOfSections = 1
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            self.tableView.backgroundView = nil
        }
        else
        {
            emptyTableLabel.text = "No Deal Available"
            emptyTableLabel.textColor = UIColor.blackColor()
            emptyTableLabel.textAlignment = NSTextAlignment.Center
            self.tableView.backgroundView = emptyTableLabel
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        }
        return numberOfSections
    }
    
    // select the cell if it represents the last viewed transaction in the currently selected category
    /*
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    
    var intIndex = indexPath.row
    var txnIndex = indexPath.row - 1
    
    // always select the template
    if ( self.sharedDataModel.selectedCategory == "Template" ) {
    
    cell.setSelected(true, animated: true)
    
    } else if ( intIndex > 0 ) {
    
    if ( txnIndex == self.sharedDataModel.getLastViewedTransactionIndexByCategory() ) {
    cell.setSelected(true, animated: true)
    }
    }
    }
    */
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        //self.debugUtil.printLog("heightForRowAtIndexPath", msg: "BEGIN")
        
        var rowHeight = 155 // default
        
        if ( self.sharedDataModel.selectedCategory == "Template"  || self.transactionsForShowing().count == 1) {
            //self.debugUtil.printLog("heightForRowAtIndexPath 125", msg: "END")
            rowHeight = 155 // no sort filter cell
            
        }
        else {
            if ( indexPath.row == 0) { // sort filter cell
                
                rowHeight = 44
            } else { // transaction cell
                
                rowHeight = 155
            }
        }
        
        //self.debugUtil.printLog("heightForRowAtIndexPath", msg: "rowHeight = " + String(rowHeight))
        
        return CGFloat(rowHeight)
        //self.debugUtil.printLog("heightForRowAtIndexPath", msg: "END")
    }
    
    // set the custom Prototype table view cell data labels
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
       // var index = String(indexPath.row)
        
        var conditionLabel: String = "Conditions: "
        //self.debugUtil.printLog("cellForRowAtIndexPath", msg: "BEGIN indexPath.row = " + index)
        
        if ( self.sharedDataModel.selectedCategory == "Template" ) {
            
            // dont show sort filter cell
            let templateCell: TransactionTableViewCell = tableView.dequeueReusableCellWithIdentifier("TransactionCell", forIndexPath: indexPath) as! TransactionTableViewCell
            
            // actual cell model object
            let templateTransaction = self.sharedDataModel.templateTransaction
            
           // var txnIndex = indexPath.row // always only one template cell
            
            
            templateCell.savedOnDateLbl.text = templateTransaction.savedOnDate
            
            conditionLabel = conditionLabel + templateTransaction.fulfillmentCondition
            
            templateCell.conditionLabel.text = conditionLabel
            templateCell.conditionLabel.hidden  = true
            templateCell.IdTransactionStatusLbl.text = "Template"
            // product and sub product combo label
            if(templateTransaction.savedOnDate == "Not Saved") {
                templateCell.ProductSubDealStatusLbl.text = templateTransaction.transactionDetail.productSub
            } else {
                templateCell.ProductSubDealStatusLbl.text = templateTransaction.transactionDetail.productSub
                    + " (" + templateTransaction.transactionDetail.dealStatus + ")"
            }
            
            templateCell.primaryClientLbl.text = templateTransaction.primaryClient
            
            templateCell.counterpartyLbl.text = templateTransaction.counterparty
            
            //self.debugUtil.printLog("cellForRowAtIndexPath", msg: "END")
            
            //templateCell.selected
            //templateCell.setSelected(true, animated: true)
            
            return templateCell
            
        } else {
            if ( indexPath.row == 0 && self.transactionsForShowing().count > 1 ) { // sort filter transactions cell
                
                let sortFilterTxnCell: SortFilterTxnTableViewCell = tableView.dequeueReusableCellWithIdentifier("SortFilterTxnCell", forIndexPath: indexPath) as! SortFilterTxnTableViewCell
                
                // when TableView reloads make certain the button labels
                // relect the current sort option and direction
                sortFilterTxnCell.sortByButton.setTitle("By " + self.currentSortOption, forState: UIControlState.Normal)
                
                if ( self.currentSortDirection == sortDirectionEnum.down ) {
                    sortFilterTxnCell.sortDirectionButton.setTitle("▼", forState: UIControlState.Normal)
                } else { // up
                    sortFilterTxnCell.sortDirectionButton.setTitle("▲", forState: UIControlState.Normal)
                }
                
                
                sortFilterTxnCell.contentView.backgroundColor = UIColor(CGColor:appAttributes.colorOcean)
                //var bgLayer = appAttributes.getcolorSubTaskBackground()
                //bgLayer.frame = sortFilterTxnCell.contentView.bounds
                //sortFilterTxnCell.contentView.layer.insertSublayer(bgLayer, atIndex: 0)
                
                
                
                //self.debugUtil.printLog("cellForRowAtIndexPath", msg: "END")
                
                return sortFilterTxnCell
                
            } else { // transaction cell
               
                let customTransactionCell: TransactionTableViewCell = tableView.dequeueReusableCellWithIdentifier("TransactionCell", forIndexPath: indexPath) as! TransactionTableViewCell
                

                var cellTransaction: TransactionData
                 var txnIndex = 0
                if(self.transactionsForShowing().count > 1)
                {
                  txnIndex  = indexPath.row - 1 // first cell is different so minus one
                }
                else
                {
                    txnIndex  = 0
                }
                
                cellTransaction = self.transactionsForShowing()[txnIndex]
                customTransactionCell.selectedBackgroundView = appAttributes.getcolorHighlightRowColor()

                // set the labels text in the cell based on transaction values
                if(self.sharedDataModel.selectedCategory == "All") {
                    customTransactionCell.IdTransactionStatusLbl.text = cellTransaction.transactionId
                        + " (" + cellTransaction.transactionStatus + ")"
                } else {
                    // don't need the true status for the other categories besides All
                    customTransactionCell.IdTransactionStatusLbl.text = cellTransaction.transactionId
                }
                
                
                
                // product and sub product combo label
                if(cellTransaction.savedOnDate == "Not Saved") {
                    customTransactionCell.IdTransactionStatusLbl.font = UIFont.boldSystemFontOfSize(21.0)
                    customTransactionCell.ProductSubDealStatusLbl.text =  cellTransaction.transactionDetail.productSub
                    customTransactionCell.savedOnDateLbl.text = cellTransaction.savedOnDate
                } else {
                    customTransactionCell.IdTransactionStatusLbl.font = UIFont.boldSystemFontOfSize(17.0)
                    
                    if cellTransaction.transactionDetail.dealStatus.isEmpty
                    {
                        customTransactionCell.ProductSubDealStatusLbl.text =  cellTransaction.transactionDetail.productSub
                    }
                    else
                    {
                    customTransactionCell.ProductSubDealStatusLbl.text = cellTransaction.transactionDetail.productSub
                        + " (" + cellTransaction.transactionDetail.dealStatus + ")"
                    }
                    customTransactionCell.savedOnDateLbl.text = self.sharedDataModel.separateStringFromTime(cellTransaction.savedOnDate)
                }
                
                customTransactionCell.primaryClientLbl.text = cellTransaction.primaryClient
                
                customTransactionCell.counterpartyLbl.text = cellTransaction.counterparty
                
                conditionLabel = conditionLabel + cellTransaction.fulfillmentCondition
                
                if cellTransaction.transactionId == "New" || cellTransaction.transactionStatus == "Draft" || cellTransaction.fulfillmentCondition.isEmpty
                {
                    customTransactionCell.conditionLabel.hidden = true
                }
                else
                {
                    customTransactionCell.conditionLabel.hidden = false
                    customTransactionCell.conditionLabel.text = conditionLabel
                }
                
                if ( txnIndex == self.sharedDataModel.getLastViewedTransactionIndexByCategory() ) {
                    //customTransactionCell.setSelected(true, animated: true)
                }
                
                //self.debugUtil.printLog("cellForRowAtIndexPath", msg: "END")
                
                return customTransactionCell
                }
                
            
        }
        
    }
    
    // Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
    /*
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    
    var cell = self.tableView.cellForRowAtIndexPath(indexPath)!
    
    if( cell.selectionStyle == UITableViewCellSelectionStyle.None ){
    return nil;
    }
    
    return indexPath
    }
    */
    
    // MARK: - Segues
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //self.performSegueWithIdentifier("showCompanies", sender: self)
        //self.splitViewController!.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
    }
  
    // tableview itself provide a delete option for each row. if needed we can simply swipe the row left and delete it.
/*
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if sharedDataModel.currentTransaction.transactionStatus == "Draft"
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if sharedDataModel.currentTransaction.transactionStatus == "Draft"
        {
            if editingStyle == UITableViewCellEditingStyle.Delete
            {
                self.debugUtil.printLog("deleteDraft", msg: "BEGIN")
                
                
                let alert = UIAlertController(title: "Delete Draft", message: "Do you want to delete the draft?", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
                alert.addAction(UIAlertAction(title: "Delete", style: .Default, handler: { action in
                    switch action.style{
                    case .Default:
                        
                        if self.sharedDataModel.currentTransaction.transactionId == "New"
                        {
                            self.sharedDataModel.checkForNewDraft = "NO"
                            self.sharedDataModel.transactionsArray.removeAtIndex(0)
                            
                            
                            if(self.sharedDataModel.selectedCategory == "Draft" && self.sharedDataModel.filteredTransactionArray.count > 1)
                            {
                                self.sharedDataModel.prepareQuestionaireModel(0, filtered: false)
                            }
                            
                            self.sharedDataModel.filteredTransactionArray = self.sharedDataModel.transactionsArray
                            self.sharedDataModel.selectedTransactionArray = self.sharedDataModel.transactionsArray
                            
                            self.sharedDataModel.selectedCategory = "All"
                            
                            self.vcCon.masterViewController.setNavigationItemTitle()
                            self.vcCon.masterViewController.tableView.reloadData()
                        }
                        else
                        {
                            let coreDataManager: AnyObject! = DataManager.getInstance()
                            coreDataManager.checkForDeletePressed("YES")
                            //saveTransactionArray.append(self.sharedDataModel.currentTransaction)
                            coreDataManager.deleteTransaction(self.sharedDataModel.currentTransaction.transactionId)
                            
                            let arrayFortransaction = coreDataManager.transactionArray() as NSArray as! [TransactionData]
                            self.sharedDataModel.transactionsArray = arrayFortransaction
                            
                            
                            if(self.sharedDataModel.selectedCategory == "Draft" && self.sharedDataModel.filteredTransactionArray.count > 1)
                            {
                                self.sharedDataModel.prepareQuestionaireModel(0, filtered: false)
                            }
                            
                            if self.sharedDataModel.checkForNewDraft == "YES"
                            {
                                self.sharedDataModel.transactionsArray =  self.sharedDataModel.preserveDrafttransaction + self.sharedDataModel.transactionsArray
                            }
                            
                            self.sharedDataModel.filteredTransactionArray = self.sharedDataModel.transactionsArray
                            self.sharedDataModel.selectedTransactionArray = self.sharedDataModel.transactionsArray
                            
                            
                            
                            self.sharedDataModel.selectedCategory = "All"
                            
                            self.vcCon.masterViewController.setNavigationItemTitle()
                            self.vcCon.masterViewController.tableView.reloadData()
                        }
                        self.sharedDataModel.lastViewedTransactionsIndexes[self.sharedDataModel.selectedCategory] = 0
                        self.vcCon.masterViewController.reselectLastSelectedRow()
                        self.vcCon.masterViewController.initDefault()
                        
                        self.vcCon.masterNavigationController.popToRootViewControllerAnimated(true)
                        
                        
                    case .Cancel:
                        print("cancel")
                        
                    case .Destructive:
                        print("destructive")
                    }
                }))
                
            }
        }
        
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .Default, title: "Delete Draft", handler: {
            (ACTION,indexPath) in self.tableView.dataSource?.tableView?(self.tableView, commitEditingStyle: .Delete, forRowAtIndexPath: indexPath)
            return
        })
        deleteButton.backgroundColor = UIColor(CGColor: appAttributes.colorOcean)
        return [deleteButton]
    }
*/
    
}


extension MasterViewController: UIPopoverPresentationControllerDelegate {
    
}


extension MasterViewController: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    func sortDateAscending(this:TransactionData,that:TransactionData) -> Bool
    {
        let date1 = self.sharedDataModel.convertStringToDate(this.savedOnDate)
        let date2 = self.sharedDataModel.convertStringToDate(that.savedOnDate)
        return  date1.compare(date2) == .OrderedAscending
    }
    
    func sortDateDescending(this:TransactionData,that:TransactionData) -> Bool
    {
        let date1 = self.sharedDataModel.convertStringToDate(this.savedOnDate)
        let date2 = self.sharedDataModel.convertStringToDate(that.savedOnDate)
        return  date1.compare(date2) == .OrderedDescending
    }
    
    // presents the sort popover
    @IBAction func sortAction(sender: UIButton) {
        self.debugUtil.printLog("sortAction", msg: "BEGIN")
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Sort Transactions", message: "Choose an attribute", preferredStyle: .ActionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        actionSheetController.addAction(cancelAction)
        
        //Create sort by Id option action
        let sortByIdAction: UIAlertAction = UIAlertAction(title: "Id", style: .Default) { action -> Void in
            //Code for launching the camera goes here
            self.currentSortOption = "Id"
            //sender.titleLabel?.text = self.currentSortOption
            self.sortByAttributeName("Id")
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        actionSheetController.addAction(sortByIdAction)
        
        //Create sort by Date option action
        let sortByDateAction: UIAlertAction = UIAlertAction(title: "Date", style: .Default) { action -> Void in
            self.currentSortOption = "Date"
            sender.titleLabel?.text = self.currentSortOption
            self.sortByAttributeName("Date")
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        actionSheetController.addAction(sortByDateAction)
        
        //Create sort by Date option action
        let sortBytransactionStatusAction: UIAlertAction = UIAlertAction(title: "TRue Status", style: .Default) { action -> Void in
            self.currentSortOption = "TRue Status"
            //sender.titleLabel?.text = self.currentSortOption
            self.sortByAttributeName("TRue Status")
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        actionSheetController.addAction(sortBytransactionStatusAction)
        
        //Create sort by Date option action
        let sortByDealStatusAction: UIAlertAction = UIAlertAction(title: "Deal Status", style: .Default) { action -> Void in
            self.currentSortOption = "Deal Status"
            //sender.titleLabel?.text = self.currentSortOption
            self.sortByAttributeName("Deal Status")
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        actionSheetController.addAction(sortByDealStatusAction)
        
        //Create sort by Date option action
        let sortByProductAction: UIAlertAction = UIAlertAction(title: "Product", style: .Default) { action -> Void in
            self.currentSortOption = "Product"
            //sender.titleLabel?.text = self.currentSortOption
            self.sortByAttributeName("Product")
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        actionSheetController.addAction(sortByProductAction)
        
        // Create sort by Date option action
        let sortBySubProductAction: UIAlertAction = UIAlertAction(title: "Sub Product", style: .Default) { action -> Void in
            self.currentSortOption = "Sub Product"
            //sender.titleLabel?.text = self.currentSortOption
            self.sortByAttributeName("Sub Product")
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        actionSheetController.addAction(sortBySubProductAction)
        
        //We need to provide a popover sourceView when using it on iPad
        //actionSheetController.popoverPresentationController?.sourceView = sender as UIView;
        
        //actionSheetController.popoverPresentationController?.barButtonItem = sender
        
        actionSheetController.popoverPresentationController?.sourceView = sender
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
        
        self.debugUtil.printLog("sortAction", msg: "END")
    }
    
    
    
    @IBAction func toggleSortDirectionAction(sender: UIButton) {
        self.debugUtil.printLog("toggleSortDirectionAction", msg: "BEGIN")
        
        if (self.currentSortDirection == sortDirectionEnum.up) {
            self.currentSortDirection = sortDirectionEnum.down
            //sender.titleLabel?.text = "▼"
            
        } else {
            self.currentSortDirection = sortDirectionEnum.up
            //sender.titleLabel?.text =  "▲"
        }
        
        // re-sort again
        self.sortByAttributeName(self.currentSortOption)
        
        self.debugUtil.printLog("toggleSortDirectionAction", msg: "END")
    }
    
    
    // handle sort action sheet popover events
    func sortByAttributeName(attributeName: String) {
        self.debugUtil.printLog("sortByAttributeName", msg: "BEGIN")
        self.debugUtil.printLog("sortByAttributeName", msg: "attributeName = " + attributeName)
        
        if self.searchController.active {
            
            // sort filtered array ascending
            if ( self.currentSortDirection == sortDirectionEnum.up ) {
                
                switch attributeName {
                case "Id":
                    self.sharedDataModel.filteredTransactionArray.sortInPlace({ $0.transactionId < $1.transactionId })
                case "Date":
                    
                   
                    self.sharedDataModel.filteredTransactionArray.sortInPlace(sortDateAscending)
                case "TRue Status":
                    self.sharedDataModel.filteredTransactionArray.sortInPlace({ $0.transactionStatus < $1.transactionStatus })
                case "Deal Status":
                    self.sharedDataModel.filteredTransactionArray.sortInPlace({ $0.transactionDetail.dealStatus < $1.transactionDetail.dealStatus })
                case "Product":
                    self.sharedDataModel.filteredTransactionArray.sortInPlace({ $0.transactionDetail.product < $1.transactionDetail.product })
                case "Sub Product":
                    self.sharedDataModel.filteredTransactionArray.sortInPlace({ $0.transactionDetail.productSub < $1.transactionDetail.productSub })
                default:
                    self.sharedDataModel.filteredTransactionArray.sortInPlace(sortDateAscending)
                    
                    
                    break
                }
            } else { // sort filtered array descending
                switch attributeName {
                case "Id":
                    self.sharedDataModel.filteredTransactionArray.sortInPlace({ $0.transactionId > $1.transactionId })
                case "Date":
                   self.sharedDataModel.filteredTransactionArray.sortInPlace(sortDateDescending)
                case "TRue Status":
                    self.sharedDataModel.filteredTransactionArray.sortInPlace({ $0.transactionStatus > $1.transactionStatus })
                case "Deal Status":
                    self.sharedDataModel.filteredTransactionArray.sortInPlace({ $0.transactionDetail.dealStatus > $1.transactionDetail.dealStatus })
                case "Product":
                    self.sharedDataModel.filteredTransactionArray.sortInPlace({ $0.transactionDetail.product > $1.transactionDetail.product })
                case "Sub Product":
                    self.sharedDataModel.filteredTransactionArray.sortInPlace({ $0.transactionDetail.productSub > $1.transactionDetail.productSub })
                default:
                    self.sharedDataModel.filteredTransactionArray.sortInPlace(sortDateDescending)
                    break
                }
            }
            
        } else {
            
            // sort selected array ascending by attribute
            if ( self.currentSortDirection == sortDirectionEnum.up ) {
                
                switch attributeName {
                case "Id":
                    self.sharedDataModel.selectedTransactionArray.sortInPlace({ $0.transactionId < $1.transactionId })
                case "Date":
                   self.sharedDataModel.selectedTransactionArray.sortInPlace(sortDateAscending)
                case "TRue Status":
                    self.sharedDataModel.selectedTransactionArray.sortInPlace({ $0.transactionStatus < $1.transactionStatus })
                case "Deal Status":
                    self.sharedDataModel.selectedTransactionArray.sortInPlace({ $0.transactionDetail.dealStatus < $1.transactionDetail.dealStatus })
                case "Product":
                    self.sharedDataModel.selectedTransactionArray.sortInPlace({ $0.transactionDetail.product < $1.transactionDetail.product })
                case "Sub Product":
                    self.sharedDataModel.selectedTransactionArray.sortInPlace({ $0.transactionDetail.productSub < $1.transactionDetail.productSub })
                default:
                   self.sharedDataModel.selectedTransactionArray.sortInPlace(sortDateAscending)
                    break
                }
            } else { // sort descending
                
                switch attributeName {
                case "Id":
                    self.sharedDataModel.selectedTransactionArray.sortInPlace({ $0.transactionId > $1.transactionId })
                case "Date":
                    self.sharedDataModel.selectedTransactionArray.sortInPlace(sortDateDescending)
                case "TRue Status":
                    self.sharedDataModel.selectedTransactionArray.sortInPlace({ $0.transactionStatus > $1.transactionStatus })
                case "Deal Status":
                    self.sharedDataModel.selectedTransactionArray.sortInPlace({ $0.transactionDetail.dealStatus > $1.transactionDetail.dealStatus })
                case "Product":
                    self.sharedDataModel.selectedTransactionArray.sortInPlace({ $0.transactionDetail.product > $1.transactionDetail.product })
                case "Sub Product":
                    self.sharedDataModel.selectedTransactionArray.sortInPlace({ $0.transactionDetail.productSub > $1.transactionDetail.productSub })
                default:
                   self.sharedDataModel.selectedTransactionArray.sortInPlace(sortDateDescending)
                    break
                }
            }
        }
        

        self.tableView.reloadData()
        if(self.sharedDataModel.filteredTransactionArray.count > 0 || self.sharedDataModel.selectedTransactionArray.count > 0)
        {
            self.reselectLastSelectedRow()
            self.initDefault()
        }

        self.debugUtil.printLog("sortByAttributeName", msg: "END")
    }
    
    
    // set the filtered array based on search text and scope
    private func searchForText(searchText: String, scope: TransactionSortingSearchScope) {
        self.debugUtil.printLog("searchForText" , msg: "BEGIN")
        
        if ( searchText.isEmpty ) {
            self.debugUtil.printLog("searchForText" , msg: "searchText isEmpty")
            self.sharedDataModel.filteredTransactionArray = self.sharedDataModel.selectedTransactionArray
        } else {
            self.debugUtil.printLog("searchForText" , msg: "searchText = " + searchText)
            //self.sharedDataModel.filteredTransactionArray.removeAll(keepCapacity: false)
            
            // Filter the array using the filter method
            self.sharedDataModel.filteredTransactionArray = self.sharedDataModel.selectedTransactionArray.filter({( transaction: TransactionData) -> Bool in
                
                switch scope {
                    
                case .All:
                    self.debugUtil.printLog("searchForText", msg: "scope = All")
                    self.debugUtil.printLog("searchForText", msg: "END")
                    return transaction.toString().lowercaseString.rangeOfString(searchText.lowercaseString) != nil
                    
                case .Id:
                    self.debugUtil.printLog("searchForText", msg: "scope = Id")
                    self.debugUtil.printLog("searchForText", msg: "END")
                    return transaction.transactionId.rangeOfString(searchText.lowercaseString) != nil
                    
                case .Name:
                    let concatenatedNames = transaction.primaryClient.lowercaseString + transaction.counterparty.lowercaseString
                    self.debugUtil.printLog("searchForText", msg: "scope = Name, concatenatedNames = " + concatenatedNames)
                    self.debugUtil.printLog("searchForText", msg: "END")
                    return concatenatedNames.rangeOfString(searchText.lowercaseString) != nil
                    
                case .Product:
                    let concatenatedProducts = transaction.transactionDetail.product.lowercaseString + transaction.transactionDetail.productSub.lowercaseString
                    self.debugUtil.printLog("searchForText", msg: "scope = Product , concatenatedProducts = " + concatenatedProducts)
                    self.debugUtil.printLog("searchForText", msg: "END")
                    return concatenatedProducts.rangeOfString(searchText.lowercaseString) != nil

                }
                
            })
        }
        
    }
    
    private func transactionsForShowing() -> [TransactionData] {
        if searchController.active {
            return self.sharedDataModel.filteredTransactionArray
        } else {
            return self.sharedDataModel.selectedTransactionArray
        }
    }
    
    // empty the filtered array, fill it with search results, reload the tableview with it
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        self.debugUtil.printLog("updateSearchResultsForSearchController", msg: "BEGIN")
        
        let searchString = self.searchController.searchBar.text
        //if !searchString.isEmpty {
        let scopeIndex = TransactionSortingSearchScope(rawValue: self.searchController.searchBar.selectedScopeButtonIndex)!
        searchForText(searchString!, scope: scopeIndex)
            tableView.reloadData()
        if(self.sharedDataModel.filteredTransactionArray.count > 0)
        {
            self.reselectLastSelectedRow()
            self.initDefault()
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
