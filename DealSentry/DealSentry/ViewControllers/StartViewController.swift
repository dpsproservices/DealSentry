//
//  StartViewController.swift
//

import UIKit

class StartViewController: UIViewController {
    var detailViewController: DetailViewController!
    var appDelegate: AppDelegate!
    let appAttributes = AppAttributes()
    let vcCon = VCConnection.sharedInstance
    let viewStateManager = ViewStateManager.sharedInstance

    @IBOutlet weak var startButton: UIButton!
    @IBAction func startAction(sender: UIButton) {

        vcCon.window?.rootViewController = vcCon.splitViewController
    }
    
    @IBAction func dismissNewView(unwindSegue: UIStoryboardSegue) {

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
            self.viewStateManager.currentOrientation = "landscape"
        }
        else
        {
            self.viewStateManager.currentOrientation = "portrait"
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

}
