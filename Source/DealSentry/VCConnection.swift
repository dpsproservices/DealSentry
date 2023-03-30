//
//  VCConnection.swift
//

import Foundation
@objc class VCConnection: NSObject{
    
    var window: UIWindow?
    var debugUtil = DebugUtility(thisClassName: "VCConnection", enabled: false)
    
    let dataManager: AnyObject! = DataManager.getInstance()
    let viewStateManager = ViewStateManager.sharedInstance

    var splitViewController: UISplitViewController!
    var masterViewController: MasterViewController!
    var detailViewController: DetailViewController!
    var startViewController: StartViewController!
    
    var masterNavigationController: UINavigationController!
    var detailNavigationController: UINavigationController!
    
    class var sharedInstance: VCConnection {
        
        struct StaticObject {
            static var instance: VCConnection?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&StaticObject.token) {
            StaticObject.instance = VCConnection()

        }
        
        return StaticObject.instance!
        
    }

      /// this method connects the database data in objective C to the arrays present in swift
      /// all independent entities are mapped with their respective arrays of shared data model object
      @objc func forViewController() {
    
        let appDelegate = UIApplication.sharedApplication().delegate! as! AppDelegate
        
    
        let arrayForCompanyRoles = self.dataManager.arrayForCompanyRoles as NSArray as! [CompanyRoleData]
        viewStateManager.companyRolesArray = arrayForCompanyRoles
    
        let arrayForContactRoles = self.dataManager.arrayForContactRoles as NSArray as! [ContactRoleData]
        viewStateManager.contactRolesArray = arrayForContactRoles
    
        let arrayForAgreementTypes = self.dataManager.arrayForAgreementTypes as NSArray as! [AgreementTypeData]
        viewStateManager.agreementTypesArray = arrayForAgreementTypes
    
        let arrayForDealStatuses = self.dataManager.arrayForDealStatuses as NSArray as! [DealStatusData]
        viewStateManager.dealStatusesArray = arrayForDealStatuses
    
        let arrayForIndustries = self.dataManager.arrayForIndustries as NSArray as! [IndustryData]
        viewStateManager.industriesArray = arrayForIndustries
    
        let arrayForLoanTypes = self.dataManager.arrayForLoanTypes as NSArray as! [LoanTypeData]
        viewStateManager.loanTypesArray = arrayForLoanTypes
    
        let arrayForOfferingFormat = self.dataManager.arrayForOfferingFormat as NSArray as! [OfferingFormatData]
        viewStateManager.offeringFormatArray = arrayForOfferingFormat
    
        let arrayForSegments = self.dataManager.arrayForSegments as NSArray as! [SegmentsData]
        viewStateManager.segmentsArray = arrayForSegments
    
        let arrayForTransactionStatuses = self.dataManager.arrayForTransactionStatuses as NSArray as! [TransactionStatusData]
        viewStateManager.transactionStatusesArray = arrayForTransactionStatuses
    
        let arrayForUseOfProceeds = self.dataManager.arrayForUseOfProceeds as NSArray as! [UseOfProceedsData]
        viewStateManager.useOfProceedsArray = arrayForUseOfProceeds
    
        let arrayForProduct = self.dataManager.arrayForProduct as NSArray as! [ProductData]
        viewStateManager.productArray = arrayForProduct
    
        let arrayForProductSub = self.dataManager.arrayForProductSub as NSArray as! [ProductSubData]
        viewStateManager.productSubArray = arrayForProductSub
    
        let arrayForCountries = self.dataManager.arrayForCountries as NSArray as! [CountryData]
        viewStateManager.countriesArray = arrayForCountries
    
        let arrayForProductMap = self.dataManager.arrayForProductmap as NSArray as! [ProductMapData]
        viewStateManager.productMapArray = arrayForProductMap
    
        let startViewController:StartViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("StartViewController") as! StartViewController
        
        self.window?.rootViewController?.presentViewController(startViewController, animated: false, completion: nil)
        self.window?.rootViewController = startViewController
        self.startViewController = startViewController
        self.startViewController.appDelegate = appDelegate
        
        self.masterNavigationController = self.splitViewController.viewControllers[0] as! UINavigationController
        self.masterViewController = masterNavigationController.topViewController as! MasterViewController
        self.masterViewController.appDelegate = appDelegate
        
        self.detailNavigationController = self.splitViewController.viewControllers[1] as! UINavigationController
        self.detailViewController = detailNavigationController.topViewController as! DetailViewController
        self.detailViewController.appDelegate = appDelegate
        
        // double arrow icon to expand or collapse the master view
        self.detailViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem()

    }
}
