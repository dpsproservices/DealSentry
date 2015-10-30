//
//  DealSizeWidget
//  DealSentry
//
//  Created by Skarulis, Joseph    on 6/30/15.
//  Copyright (c) 2015 . All rights reserved.
//

import UIKit
import WebKit
class DealSizeWidget: UIViewController , WKScriptMessageHandler
{
    @IBOutlet weak var containerView:UIView!
    let sharedDataModel = SharedDataModel.sharedInstance
    var transDetail2VC: TransactionDetailPage2ViewController!
    
    var webView: WKWebView?
    var dealSize: String = ""
    
    override func loadView() {
        super.loadView()
        let contentController = WKUserContentController();
        
        contentController.addScriptMessageHandler(
            self,
            name: "callbackHandler"
        )
        
        //        var country = selectedCountry //"'RU'"
        var size = dealSize
        if dealSize == "" {
            size = "0"
        }
        let setSizeScript = WKUserScript(
            source: "setSize("+size+")",
            injectionTime: WKUserScriptInjectionTime.AtDocumentEnd,
            forMainFrameOnly: true
        )
        contentController.addUserScript(setSizeScript)
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        let testFrame : CGRect = CGRectMake(15,15,600 ,600)
        self.webView = WKWebView(
            frame: testFrame, //self.containerView.bounds,
            //frame: self.containerView.bounds,
            
            configuration: config
        )
        
        self.containerView = self.webView
        self.view.addSubview( self.containerView!)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //
        
        let pathHtml = NSBundle.mainBundle().pathForResource("dial", ofType: "html")
        do{
            let html = try String (contentsOfFile: pathHtml!, encoding: NSUTF8StringEncoding)
            self.webView!.loadHTMLString(html , baseURL: nil)
            
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func userContentController(userContentController: WKUserContentController,didReceiveScriptMessage message: WKScriptMessage)
    {
        
        if(message.name == "callbackHandler")
        {
         //   println(message.body)
            let msg = String(message.body as! NSString)
            self.dealSize = msg
            /*
            var formatter = NSNumberFormatter()
            formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
            formatter.locale = NSLocale(localeIdentifier: "en_US")
            var price = formatter.stringFromNumber( NSString(string: self.dealSize).doubleValue)
            */
            
            let origPrice = NSString(string: self.dealSize).doubleValue
            //price is in millions (MILLIONS)
            //format to k or m or b
//            var unit = " MM"
//            if origPrice == 0 {
//                unit = ""
//            }else if origPrice < 1 {
//                origPrice = origPrice * 1000
//                unit = " K"
//            } else if origPrice > 1000 {
//                origPrice = origPrice / 1000
//                unit = " B"
//            }
            let formatter = NSNumberFormatter()
            formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
            formatter.locale = NSLocale(localeIdentifier: "en_US")
            let price = formatter.stringFromNumber(origPrice)
            
            self.transDetail2VC.dealSizeTextField.text = price! /*+ unit*/
            
            
            self.sharedDataModel.currentTransaction.transactionDetail.dealSize = msg
        }
        
        

        
        
        
    }
}

