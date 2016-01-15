//
// SearchCompaniesViewController.swift
//
import Foundation
import UIKit

enum CompanySearchScope: Int {
    case startsWith
    case contains
    case ticker
    case gfcid
}

class SearchCompaniesViewController: UITableViewController {
    
    var debugUtil = DebugUtility(thisClassName: "SearchCompaniesViewController", enabled:false)
    let viewStateManager = ViewStateManager.sharedInstance
    var detailViewController: DetailViewController!
    var addCompaniesViewController: AddCompaniesViewController! // presenting reference
    
    var searchPreviousCompanies = false

    var searchMethod = CompanySearchScope.startsWith

    var searchController = UISearchController()

    var selectedCompany: CompanyData?
    let appAttributes = AppAttributes()
    
    ///this method is invoked when user selects a company. and then selected company is checked with the companies added by the user. 
    /// - YES: alert will be thrown stating "Duplicate Company"
    /// -  NO: company added as transaction company
    /// - Parameter sender: this paramater ensures that this method will be invoked only using UIBarButtonItem
    @IBAction func doneAction(sender: UIBarButtonItem) {
        
        if self.selectedCompany != nil {
            
            var companyAlreadyPresent = "NO"
            
            for transactionCompany in self.viewStateManager.currentTransaction.transactionCompanies
            {
                if transactionCompany.company.companyName.caseInsensitiveCompare(self.selectedCompany!.companyName) == NSComparisonResult.OrderedSame
                {
                    companyAlreadyPresent = "YES"
                    break
                }
            }
            
            
            if companyAlreadyPresent == "NO"
            {
                //populate default values but make sure they are not "" for segmented controls
                let tComp = TransactionCompanyData(company: self.selectedCompany!, role: "",
                    materiality: MaterialityData(
                        isMaterial: "",
                        isMaterialDescription: "",
                        hasPubliclyTradedSecurities: "",
                        isGovtOwned: "", percentOwned: "",
                        //          hasFinancialSponsor: "", hasNonProfitOrganization: "",hasUSGovtAffiliatedMunicipality: "",
                        hasPRC: "", hasStandardAgreements: "", specialCircumstances: ""))
                self.viewStateManager.currentTransaction.addCompany(tComp)
                
                // UIView.animateWithDuration(0.3, delay: 0.0, options: nil, animations: {self.detailViewController.companiesContainerView.alpha = 1.0}, completion: nil)
                
                self.performSegueWithIdentifier("dismissSearchCompaniesView", sender: self)
                //  splitViewController?.viewControllers[0].popViewControllerAnimated(true)
            }
            else
            {
                let alert = UIAlertController(title: "Duplicate Company", message: "This company is already in deal list", preferredStyle: UIAlertControllerStyle.Alert)
                
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
    
    /// dismisses the compan search view
    @IBAction func cancelAction(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("dismissSearchCompaniesView", sender: self)
//        splitViewController?.viewControllers[0].
    }
    
    override func awakeFromNib() {
        
        self.debugUtil.printLog("awakeFromNib", msg: "BEGIN")
        
        super.awakeFromNib()
        //self.clearsSelectionOnViewWillAppear = false
        self.preferredContentSize = CGSize(width: 400.0, height: 120.0)
        
        self.debugUtil.printLog("awakeFromNib", msg: "END")
    }
    
    override func viewDidLoad() {
        self.debugUtil.printLog("viewDidLoad", msg: "BEGIN")
        
        super.viewDidLoad()
        
        //self.tableView.registerClass(CompaniesSearchTableViewCell.self, forCellReuseIdentifier: "SearchResultCompanyCell")

        self.tableView.delegate = self
        self.tableView.dataSource = self

        // Configure companies SearchController
        self.initSearchController()
        
        if self.searchPreviousCompanies {
            self.title = "Previous Companies"
        } else {
            self.title = "Search Companies"
        }
        let navImage: UIImage = UIImage(named: "blue-wave.png")!
        self.navigationController?.navigationBar.setBackgroundImage(navImage, forBarMetrics: .Default)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.titleView?.tintColor = UIColor.whiteColor()
        let titleDic: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = titleDic as? [String : AnyObject]

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
            
            
        }
        
        self.debugUtil.printLog("prepareForSegue", msg: "END")
    }
    
    
    private func initSearchController() {
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.searchBarStyle = UISearchBarStyle.Prominent
        self.searchController.searchBar.scopeButtonTitles = ["Starts with","Contains","Ticker","GFCID"]
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.tintColor = UIColor(CGColor: appAttributes.colorCyan)
        self.searchController.searchBar.barTintColor = appAttributes.colorBackgroundColor
        self.searchController.searchBar.layer.backgroundColor = appAttributes.colorBackgroundColor.CGColor
        self.searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.definesPresentationContext = true
    }
    
    func resetView() {
        
        self.searchPreviousCompanies = false
        
        // reset company search
        //self.searchController.searchBar.text = ""
        self.tableView.reloadData()
    }
}

extension SearchCompaniesViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.debugUtil.printLog("numberOfRowsInSection", msg: "BEGIN")

        
        self.debugUtil.printLog("numberOfRowsInSection", msg: "END")
        
        // searchResultsTableView
        return self.companiesForShowing().count + 1 //add the header row

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
        
        if ( indexPath.row == 0 ) { // sort filter transactions cell
            
            let searchHeaderCompanyCell: CompaniesSearchHeaderTableViewCell = tableView.dequeueReusableCellWithIdentifier("CompaniesSearchHeaderCell", forIndexPath: indexPath) as! CompaniesSearchHeaderTableViewCell
            searchHeaderCompanyCell.backgroundColor = UIColor(CGColor: appAttributes.colorOcean)

            return searchHeaderCompanyCell
        
        }else {
            let cellCompany = self.companiesForShowing()[indexPath.row - 1]
            let searchResultCompanyCell: CompaniesSearchTableViewCell = tableView.dequeueReusableCellWithIdentifier("SearchResultCompanyCell", forIndexPath: indexPath) as! CompaniesSearchTableViewCell
       
            searchResultCompanyCell.selectedBackgroundView = appAttributes.getcolorHighlightRowColor()

            searchResultCompanyCell.companyNameLabel.text = cellCompany.companyName
            if cellCompany.countryFlag != "" {
                searchResultCompanyCell.countryFlag.image =  UIImage( named: cellCompany.countryFlag )
            }
            searchResultCompanyCell.tickerLabel.text = cellCompany.ticker
            searchResultCompanyCell.levelLabel.text = cellCompany.level
            searchResultCompanyCell.countryLabel.text = cellCompany.country
            searchResultCompanyCell.gfcidLabel.text = cellCompany.gfcid
            searchResultCompanyCell.marketSegmentLabel.text = cellCompany.marketSegment
            searchResultCompanyCell.exchangeLabel.text = cellCompany.exchange
            searchResultCompanyCell.industryLabel.text = cellCompany.franchiseIndustry
            
            self.debugUtil.printLog("cellForRowAtIndexPath", msg: "END")
            return searchResultCompanyCell

        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let index = String(indexPath.row)
        
        self.debugUtil.printLog("didSelectRowAtIndexPath", msg: "BEGIN indexPath.row = " + index)

   //     let searchResultCompanyCell: CompaniesSearchTableViewCell = tableView.dequeueReusableCellWithIdentifier("SearchResultCompanyCell", forIndexPath: indexPath) as! CompaniesSearchTableViewCell
        
        let cellCompany = self.companiesForShowing()[indexPath.row - 1]
        
        self.selectedCompany = cellCompany // add this to model on Done

        self.debugUtil.printLog("didSelectRowAtIndexPath", msg: "END")
    }
}
    
extension SearchCompaniesViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    
    private func companiesForShowing() -> [CompanyData] {
        if self.searchController.active {
            return self.viewStateManager.filteredCompaniesArray
        } else {
            
            if self.searchPreviousCompanies {
                return self.viewStateManager.previousCompaniesArray
            } else {
                return self.viewStateManager.companiesArray
            }
        }
    }
    
    // set the filtered array to the full list, then filter it based on the string matching
    func searchForText(searchText: String, scope: CompanySearchScope) {
        self.debugUtil.printLog("searchForText" , msg: "BEGIN")
        self.debugUtil.printLog("searchForText" , msg: "searchText = " + searchText)
        
        if ( searchText.isEmpty ) {
            self.debugUtil.printLog("searchForText" , msg: "searchText isEmpty")
            self.viewStateManager.filteredCompaniesArray = self.viewStateManager.companiesArray // reset to full list
        } else {
            self.debugUtil.printLog("searchForText" , msg: "searchText = " + searchText)
            
            // Filter the array using the filter method
            self.viewStateManager.filteredCompaniesArray = self.viewStateManager.companiesArray.filter({( company: CompanyData) -> Bool in
                
                switch scope {
                    
                case .startsWith:
                    // number of characters in search string
//                    var searchStringLength = count(searchText.utf16) //.lengthOfBytesUsingEncoding(NSUTF16StringEncoding)
                    
//                    var companyPrefix = company.companyName.substringWithRange(
//                        Range<String.Index>(
//                            start: company.companyName.startIndex,
//                            end: advance(company.companyName.startIndex, searchStringLength)
//                        )
//                    )
                    
                    self.debugUtil.printLog("searchForText", msg: "scope = Starts With")
                    self.debugUtil.printLog("searchForText", msg: "END")
                    return company.companyName.lowercaseString.rangeOfString(searchText.lowercaseString) != nil
                    
                case .contains:
                    self.debugUtil.printLog("searchForText", msg: "scope = Contains")
                    self.debugUtil.printLog("searchForText", msg: "END")
                    return company.companyName.lowercaseString.rangeOfString(searchText.lowercaseString) != nil
                    
                case .ticker:
                    self.debugUtil.printLog("searchForText", msg: "scope = Ticker")
                    self.debugUtil.printLog("searchForText", msg: "END")
                    return company.ticker.lowercaseString.rangeOfString(searchText.lowercaseString) != nil
                    
                case .gfcid:
                    self.debugUtil.printLog("searchForText", msg: "scope = GFCID")
                    self.debugUtil.printLog("searchForText", msg: "END")
                    return company.gfcid.rangeOfString(searchText) != nil
                    

                }
                
            })
        }
        
    }
    
    // empty the filtered array, fill it with search results, reload the tableview with it
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        self.debugUtil.printLog("updateSearchResultsForSearchController", msg: "BEGIN")
        
        let searchString = self.searchController.searchBar.text
        //if !searchString.isEmpty {
        let scopeIndex = CompanySearchScope(rawValue: self.searchController.searchBar.selectedScopeButtonIndex)!
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