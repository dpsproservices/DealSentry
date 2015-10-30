//
// MaterialityPage2ViewController
//

import UIKit

class MaterialityPage0ViewController: MaterialityPageViewController {
    
    var debugUtil = DebugUtility(thisClassName: "MaterialityPage2ViewController", enabled: false)
    var selectedCompany : TransactionCompanyData!
    let sharedDataModel = SharedDataModel.sharedInstance
    let appAttributes = AppAttributes()
    var addCompaniesViewController: AddCompaniesViewController!
    @IBOutlet weak var companyDescriptionLabel: UILabel!
    @IBOutlet weak var companyIconButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        debugUtil.printLog("viewWillappear", msg: "called")
        //now that user has selected a row, we can re-enable swipe - SWIPE events are buggy in apple
        self.materialityViewController.pageViewController.dataSource = nil
    }
    override func viewDidLoad() {
        self.debugUtil.printLog("viewDidLoad", msg: "BEGIN")
        
        super.viewDidLoad()
        super.pageNumber = 2
        self.view.layer.backgroundColor = (appAttributes.colorBackgroundColor).CGColor
        self.debugUtil.printLog("viewDidLoad", msg: "END")
    }
    
     @IBAction func companyIconAction(sender: UIButton)
     {
        self.performSegueWithIdentifier("addCompanySegue", sender: self)

     }
    
    @IBAction func dismissAddCompany(unwindSegue: UIStoryboardSegue ){
        self.debugUtil.printLog("dismissAdd", msg: "BEGIN")
        unwindSegue.sourceViewController.dismissViewControllerAnimated(true, completion: nil)
        self.detailViewController.embeddedCompaniesQuestions2ViewController.reselectLastSelectedRow()
        self.debugUtil.printLog("dismissAdd", msg: "END")
        
    }
    
    override func didReceiveMemoryWarning() {
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "BEGIN")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "END")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // self.debugUtil.printLog("prepareForSegue", msg: "BEGIN")
        
        if let segueId = segue.identifier {
            
            switch segueId {

            case "addCompanySegue" :
                self.addCompaniesViewController = segue.destinationViewController as! AddCompaniesViewController
                self.addCompaniesViewController.detailViewController = self.detailViewController
                
            default:
                break
            }
            
        }
        
        //  self.debugUtil.printLog("prepareForSegue", msg: "END")
    }

    
}
