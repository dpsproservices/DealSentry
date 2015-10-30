//
//  AddCompaniesViewController.swift
//

import UIKit

enum addMethodEnum {
    case previous
    case search
    case define
}

class AddCompaniesViewController: UIViewController {
    
    var debugUtil = DebugUtility(thisClassName: "AddCompaniesViewController", enabled: false)
    let appAttributes = AppAttributes()
    let sharedDataModel = SharedDataModel.sharedInstance
    var detailViewController: DetailViewController! // reference the parent detail view controller which this is embedded

    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var previousImageView: UIImageView!
    @IBOutlet weak var defineImageView: UIImageView!
    
    
    @IBOutlet weak var navView: UINavigationBar!
    var searchCompaniesViewController: SearchCompaniesViewController!
    var defineCompanyViewController: DefineCompanyViewController!
    
    
    /// dismisses add company search view
    @IBAction func cancelAddAction(sender: AnyObject) {
        self.performSegueWithIdentifier("dismissAddCompany", sender: self)

        
    }
    // called by popup unwind segue
    /// dismisses search companies view and add the company to the already present transaction companies stack
    @IBAction func dismissSearchCompaniesView(unwindSeque: UIStoryboardSegue ){
        self.debugUtil.printLog("dismissSearchCompaniesView", msg: "BEGIN")
        if !self.sharedDataModel.currentTransaction.transactionCompanies.isEmpty {

            //dont forget to update company index
            self.sharedDataModel.currentTransaction.currentTransactionCompanyIndex = self.sharedDataModel.currentTransaction.transactionCompanies.count - 1
            
            //if there is only one company being added in the total list.  force the role of company to be primary client
            if self.sharedDataModel.currentTransaction.transactionCompanies.count == 1 {
                self.sharedDataModel.currentTransaction.transactionCompanies[0].role = "Primary Client"
            }
            // toggle to company questions tab

            self.detailViewController.embeddedCompaniesQuestions2ViewController.tableView.reloadData()
            self.performSegueWithIdentifier("dismissAddCompany", sender: self)
            //make sure now the detailVC for companies shows companies
            //self.detailViewController.changeToMaterialityVC()
            self.detailViewController.embeddedMaterialityViewController.pageViewController.dataSource = self.detailViewController.embeddedMaterialityViewController
            self.detailViewController.embeddedMaterialityViewController.goToPage(1, whichWay: -1)
            self.detailViewController.returnToCompany()
        }

        self.debugUtil.printLog("dismissSearchCompaniesView", msg: "END")
    }

    /// dismisses search companies view and add the company to the already present transaction companies stack. the company is manually defined by the user
    @IBAction func dismissDefineCompanyView(unwindSeque: UIStoryboardSegue ){
        self.debugUtil.printLog("dismissDefineCompanyView", msg: "BEGIN")
        
        
        if !self.sharedDataModel.currentTransaction.transactionCompanies.isEmpty {

            //ADD the company index - IMPORTANT
            self.sharedDataModel.currentTransaction.currentTransactionCompanyIndex = self.sharedDataModel.currentTransaction.transactionCompanies.count - 1
           self.sharedDataModel.companynameArrayForManuallyDefined = [String]()

            self.detailViewController.embeddedCompaniesQuestions2ViewController.tableView.reloadData()
            self.performSegueWithIdentifier("dismissAddCompany", sender: self)

            //self.detailViewController.changeToMaterialityVC()
            self.detailViewController.embeddedMaterialityViewController.pageViewController.dataSource = self.detailViewController.embeddedMaterialityViewController
            self.detailViewController.embeddedMaterialityViewController.goToPage(1, whichWay: -1)
            self.detailViewController.returnToCompany()
        }

        self.debugUtil.printLog("dismissDefineCompanyView", msg: "END")
    }
    override func viewWillAppear(animated: Bool) {
    }
    override func viewDidLoad() {
        self.debugUtil.printLog("viewDidLoad", msg: "BEGIN")
        
        super.viewDidLoad()
        self.view.backgroundColor = appAttributes.colorBackgroundColor
        searchImageView.highlightedImage = UIImage( named: "search_org_filled.png")
        previousImageView.highlightedImage = UIImage( named: "search_property_filled.png")
        defineImageView.highlightedImage = UIImage( named: "create_new_filled.png")
      
/*        let navImage: UIImage = UIImage(named: "ocean.png")!
        self..navigationBar.setBackgroundImage(navImage, forBarMetrics: .Default)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

        if self.sharedDataModel.currentTransaction.transactionCompanies.isEmpty {
            self.navView.hidden = true
        } else {
            self.navView.hidden = false
        }
*/        self.debugUtil.printLog("viewDidLoad", msg: "END")
    }
    //automatically resize
    override func shouldAutorotate() -> Bool {
        return true
    }
//    override func supportedInterfaceOrientations() -> Int {
//        return Int(UIInterfaceOrientation.Portrait.rawValue) | Int(UIInterfaceOrientation.LandscapeLeft.rawValue) | Int(UIInterfaceOrientation.LandscapeRight.rawValue)
//    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        let orientation: UIInterfaceOrientationMask = [UIInterfaceOrientationMask.Portrait, UIInterfaceOrientationMask.LandscapeLeft,UIInterfaceOrientationMask.LandscapeRight]
        return orientation
    }

    override func didReceiveMemoryWarning() {
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "BEGIN")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "END")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.debugUtil.printLog("prepareForSegue", msg: "BEGIN")
        let segueId = segue.identifier
        
        self.debugUtil.printLog("prepareForSegue", msg: "segueId = " + segueId!)



        
        if let segueId = segue.identifier {
                
            switch segueId {
                
            case "searchExistingCompanies":
                // modal segway
                let navigationController = segue.destinationViewController as! UINavigationController
                self.searchCompaniesViewController = navigationController.topViewController as! SearchCompaniesViewController
                
                self.searchCompaniesViewController.searchPreviousCompanies = false
                self.searchCompaniesViewController.detailViewController = self.detailViewController

            case "searchPreviousCompanies":
                // modal segway

                let navigationController = segue.destinationViewController as! UINavigationController
                self.searchCompaniesViewController = navigationController.topViewController as! SearchCompaniesViewController
                
                self.searchCompaniesViewController.searchPreviousCompanies = true
                self.searchCompaniesViewController.detailViewController = self.detailViewController

            case "defineCompany":
                // modal segway
                
                let navigationController = segue.destinationViewController as! UINavigationController
                self.defineCompanyViewController = navigationController.topViewController as! DefineCompanyViewController
                self.defineCompanyViewController.detailViewController = self.detailViewController

            default:
                break
            }

        }
        
        self.debugUtil.printLog("prepareForSegue", msg: "END")
    }

}