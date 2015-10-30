//
//  NewViewController.swift
//

import UIKit

class NewViewController: UIViewController {
    var detailViewController: DetailViewController!
    var appDelegate: AppDelegate!
    let appAttributes = AppAttributes()
     let vcCon = VCConnection.sharedInstance
    let sharedDataModel = SharedDataModel.sharedInstance
   

    @IBOutlet weak var startButton: UIButton!
    @IBAction func startAction(sender: UIButton) {
        
        
       // self.appDelegate.splitViewController!.preferredDisplayMode = UISplitViewControllerDisplayMode.PrimaryHidden
        //self.appDelegate.detailViewController.appDelegate.masterViewController.performSegueWithIdentifier("showAll", sender: nil)
       // self.appDelegate.detailViewController.appDelegate.performSegueWithIdentifier("showCompanies", sender: self)
        //self.appDelegate.splitViewController!.viewControllers[0].popToRootViewControllerAnimated(false)

        vcCon.window?.rootViewController = vcCon.splitViewController
    }
    @IBAction func dismissNewView(unwindSegue: UIStoryboardSegue) {
        //unwind here
        //       self.splitViewController!.preferredDisplayMode = UISplitViewControllerDisplayMode.PrimaryOverlay
    }
    func initializeBG() {
        self.view.backgroundColor = UIColor.clearColor()
        let backgroundLayer = appAttributes.getcolorBackground()
        backgroundLayer.frame = UIScreen.mainScreen().bounds
        view.layer.insertSublayer(backgroundLayer, atIndex: 0)
        
    }
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        initializeBG()
        if UIDevice.currentDevice().orientation.isLandscape.boolValue
        {
            self.sharedDataModel.checkForOrientationChange = "landscape"
        }
        else
        {
            self.sharedDataModel.checkForOrientationChange = "portrait"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeBG()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
