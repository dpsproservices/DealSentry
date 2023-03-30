//
//  CompanyMap.swift
//

import UIKit
import WebKit
class CompanyMap: UIViewController , WKScriptMessageHandler, WKNavigationDelegate
{
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var containerView:UIView!
    let viewStateManager = ViewStateManager.sharedInstance
    var defineCompanyController: DefineCompanyViewController!
    var testFrame : CGRect = CGRect()
    var webView: WKWebView?
    let appAttributes = AppAttributes()
    var selectedCountry = ""
    
    override func loadView() {
        super.loadView()
        let contentController = WKUserContentController();
        
        contentController.addScriptMessageHandler(
            self,
            name: "callbackHandler"
        )
        
        let country = "'" + selectedCountry + "'"
        let selectCountryScript = WKUserScript(
            source: "selectCountry("+country+")",
            injectionTime: WKUserScriptInjectionTime.AtDocumentEnd,
            forMainFrameOnly: true
        )
        contentController.addUserScript(selectCountryScript)
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        testFrame  = CGRectMake(0,80,self.view.frame.width ,550)
        self.webView = WKWebView(
            frame: testFrame, //self.containerView.bounds,
            //frame: self.containerView.bounds,
            
            configuration: config
        )
        
        self.containerView = self.webView
        self.view.insertSubview(self.containerView, belowSubview: activity)
        
    }
    
   
    
    @IBAction func doneMapAction(sender: AnyObject) {
        var selectedCountryName = ""
        var selectedFlag = ""
        var i = 0
        var found = false
        while i<self.viewStateManager.countriesArray.count && !found{
            if self.viewStateManager.countriesArray[i].countryCode == self.selectedCountry {
                selectedCountryName = self.viewStateManager.countriesArray[i].countryName
                selectedFlag = self.selectedCountry
                found = true
            }
            i++
        }
        self.viewStateManager.checkForCountryPicker = "NO"
        defineCompanyController.countryCode = self.selectedCountry
        defineCompanyController.countryTextField.text = selectedCountryName
        defineCompanyController.countryFlag = selectedFlag
        self.dismissViewControllerAnimated(true, completion: nil)
        //        self.performSegueWithIdentifier("dismissCompanyMap", sender: self)
    }
    @IBAction func cancelAddAction(sender: AnyObject) {
        self.performSegueWithIdentifier("dismissCompanyMap", sender: self)
        
        
    }
    
    func checkOrientation()
    {
        if viewStateManager.currentOrientation == "landscape"
        {
            testFrame = CGRectMake(0,80,1024 ,550)
            self.webView?.frame = testFrame
        }
        else
        {
            testFrame = CGRectMake(0,80,768 ,550)
            self.webView?.frame = testFrame
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        checkOrientation()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue
        {
            testFrame = CGRectMake(0,80,1024 ,550)
            self.webView?.frame = testFrame
        }
        else
        {
            testFrame = CGRectMake(0,80,768,550)
            self.webView?.frame = testFrame
        }
    }
    
//    func pathForBuggyWKWebView(filePath: String?) -> String? {
//        let fileMgr = NSFileManager.defaultManager()
//        let tmpPath = (NSTemporaryDirectory() as NSString).stringByAppendingPathComponent("www")
//       // var error: NSErrorPointer = nil
//
//        let dstPath = (tmpPath as NSString).stringByAppendingPathComponent((filePath! as NSString).lastPathComponent)
//        if !fileMgr.fileExistsAtPath(dstPath) {
//            
//                    do{
//                       try  fileMgr.copyItemAtPath(filePath!, toPath: dstPath)
//                    }
//                    catch let error as NSError {
//                        print(error.localizedDescription)
//                    }
//
//
//        }
//        return dstPath
//    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.webView?.navigationDelegate = self
        self.activity.color = UIColor(CGColor: appAttributes.colorOcean)
               let pathHtml = NSBundle.mainBundle().pathForResource("map", ofType: "html")
        do{
             let html = try String (contentsOfFile: pathHtml!, encoding: NSUTF8StringEncoding)
            self.webView!.loadHTMLString(html , baseURL: nil)

        }
        catch let error as NSError {
            print(error.localizedDescription)
        }

//        var filePath = NSBundle.mainBundle().pathForResource("map", ofType: "html")
//        filePath = pathForBuggyWKWebView(filePath!) // This is the reason of this entire thread!
//        let request = NSURLRequest(URL: NSURL.fileURLWithPath(filePath!))
//        self.webView!.loadRequest(request)
        
//        var myURL = NSBundle.mainBundle().pathForResource("map", ofType: "html")
//        let requestObj = NSURLRequest(URL: NSURL.fileURLWithPath(myURL!)!)
//        self.webView!.loadRequest(requestObj)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        activity.stopAnimating()
        activity.hidden = true

    }
    
    
    func userContentController(userContentController: WKUserContentController,didReceiveScriptMessage message: WKScriptMessage)
    {
        
        if(message.name == "callbackHandler")
        {
            self.selectedCountry = message.body as! String
        }
    }
}

