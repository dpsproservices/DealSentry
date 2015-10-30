//
//  VCConnection.swift
//

import Foundation
@objc class VCConnection: NSObject{
    
    var window: UIWindow?
    var debugUtil = DebugUtility(thisClassName: "AppDelegate", enabled: false)
    
    let coreDataManager: AnyObject! = DataManager.getInstance()
    let sharedDataModel = SharedDataModel.sharedInstance

    var splitViewController: UISplitViewController!
    var masterViewController: MasterViewController!
    var detailViewController: DetailViewController!
    var newViewController: NewViewController!
    
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
      @objc  func forViewController() {
    
        let appDelegate = UIApplication.sharedApplication().delegate! as! AppDelegate
        
    
        let arrayForCR = self.coreDataManager.arrayForCR as NSArray as! [CompanyRoleData]
        sharedDataModel.companyRolesArray = arrayForCR
    
        let arrayForContactRoles = self.coreDataManager.arrayForContactRoles as NSArray as! [ContactRoleData]
        sharedDataModel.contactRolesArray = arrayForContactRoles
    
        let arrayForAgreementTypes = self.coreDataManager.arrayForAgreementTypes as NSArray as! [AgreementTypeData]
        sharedDataModel.agreementTypesArray = arrayForAgreementTypes
    
        let arrayForDealStatuses = self.coreDataManager.arrayForDealStatuses as NSArray as! [DealStatusData]
        sharedDataModel.dealStatusesArray = arrayForDealStatuses
    
        let arrayForIndustries = self.coreDataManager.arrayForIndustries as NSArray as! [IndustryData]
        sharedDataModel.industriesArray = arrayForIndustries
    
        let arrayForLoanTypes = self.coreDataManager.arrayForLoanTypes as NSArray as! [LoanTypeData]
        sharedDataModel.loanTypesArray = arrayForLoanTypes
    
        let arrayForOfferingFormat = self.coreDataManager.arrayForOfferingFormat as NSArray as! [OfferingFormatData]
        sharedDataModel.offeringFormatArray = arrayForOfferingFormat
    
        let arrayForSegments = self.coreDataManager.arrayForSegments as NSArray as! [SegmentsData]
        sharedDataModel.segmentsArray = arrayForSegments
    
        let arrayForTransactionStatuses = self.coreDataManager.arrayForTransactionStatuses as NSArray as! [TransactionStatusData]
        sharedDataModel.transactionStatusesArray = arrayForTransactionStatuses
    
        let arrayForUseOfProceeds = self.coreDataManager.arrayForUseOfProceeds as NSArray as! [UseOfProceedsData]
        sharedDataModel.useOfProceedsArray = arrayForUseOfProceeds
    
        let arrayForProduct = self.coreDataManager.arrayForProduct as NSArray as! [ProductData]
        sharedDataModel.productArray = arrayForProduct
    
        let arrayForProductSub = self.coreDataManager.arrayForProductSub as NSArray as! [ProductSubData]
        sharedDataModel.productSubArray = arrayForProductSub
    
        let arrayForCountries = self.coreDataManager.arrayForCountries as NSArray as! [CountryData]
        sharedDataModel.countriesArray = arrayForCountries
    
        let arrayForProductMap = self.coreDataManager.arrayForProductmap as NSArray as! [ProductMapData]
        sharedDataModel.productMapArray = arrayForProductMap
    
        let newViewController:NewViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("NewViewController") as! NewViewController
        self.window?.rootViewController?.presentViewController(newViewController, animated: false, completion: nil)
        self.window?.rootViewController = newViewController
        self.newViewController = newViewController
        self.newViewController.appDelegate = appDelegate
        
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
