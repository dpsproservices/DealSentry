//
//  DateCalendar.swift
//  truemobile
//
//  Created by Skarulis, Joseph    on 8/13/15.
//  Copyright (c) 2015 Skarulis, Joseph   . All rights reserved.
//

import UIKit
import WebKit
class DateCalendar: UIViewController , WKScriptMessageHandler
{
    @IBOutlet weak var containerView:UIView!
    let sharedDataModel = SharedDataModel.sharedInstance
    var transDetail3VC: TransactionDetailPage3ViewController!
    var enterAgreementVC: EnterAgreementViewController!
    var webView: WKWebView?
    var dealSize: String = ""
    

    override func loadView() {
        super.loadView()
        let contentController = WKUserContentController();
        
        contentController.addScriptMessageHandler(
            self,
            name: "callbackHandler"
        )
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        var names = dateFormatter.stringFromDate(NSDate())
        
        // getting the value from date textfield and passing it to the html for showing the exact date in calendar 
        
        if(self.sharedDataModel.selectedButtonTextForDate == "PitchDate")
        {
          names =   self.transDetail3VC.estimatedPitchDateTextField.text!
        }
        else if(self.sharedDataModel.selectedButtonTextForDate == "AnnouncementDate")
        {
            names =   self.transDetail3VC.announcementDateTextField.text!
        }
        else if(self.sharedDataModel.selectedButtonTextForDate == "ClosingDate")
        {
            names =   self.transDetail3VC.closingDateTextField.text!
        }
        else if(self.sharedDataModel.selectedButtonTextForDate == "EffectiveDate")
        {
            names =   self.enterAgreementVC.effectiveDateTextField.text!
        }
        else if(self.sharedDataModel.selectedButtonTextForDate == "ExpirationDate")
        {
            names =   self.enterAgreementVC.expirationDateTextField.text!
        }
        else
        {
            names = dateFormatter.stringFromDate(NSDate())
        }
        
        
        let setSizeScript = WKUserScript(
            source: "setupDate("+"'"+names+"'"+")",
            injectionTime: WKUserScriptInjectionTime.AtDocumentEnd,
            forMainFrameOnly: true
        )
        contentController.addUserScript(setSizeScript)
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        let testFrame : CGRect = CGRectMake(-55,-50,1200 ,1200)
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
        
        
        let pathHtml = NSBundle.mainBundle().pathForResource("calendar", ofType: "html")
        do{
            let html = try String (contentsOfFile: pathHtml!, encoding: NSUTF8StringEncoding)
            self.webView!.loadHTMLString(html , baseURL: NSBundle.mainBundle().bundleURL)
            
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
            // Getting the selected value from webview and passing it to the respective view controllers textfields
            let msg = String(message.body as! NSString)
            if(self.sharedDataModel.selectedButtonTextForDate == "PitchDate")
            {
                self.transDetail3VC.estimatedPitchDateTextField.text = msg
                self.sharedDataModel.currentTransaction.transactionDetail.estimatedPitchDate = msg
                self.transDetail3VC.pitchDateImgWarning.hidden = true
                self.transDetail3VC.pitchDateTxtWarning.hidden = true
            }
            else if(self.sharedDataModel.selectedButtonTextForDate == "AnnouncementDate")
            {
                self.transDetail3VC.announcementDateTextField.text = msg
                self.sharedDataModel.currentTransaction.transactionDetail.expectedAnnouncementDate = msg
                self.transDetail3VC.announcementDateImgWarning.hidden = true
                self.transDetail3VC.announcementDateTxtWarning.hidden = true
            }
            else if(self.sharedDataModel.selectedButtonTextForDate == "ClosingDate")
            {
                self.transDetail3VC.closingDateTextField.text = msg
                self.sharedDataModel.currentTransaction.transactionDetail.expectedClosingDate = msg
            }
            else if(self.sharedDataModel.selectedButtonTextForDate == "EffectiveDate")
            {
                self.enterAgreementVC.effectiveDateTextField.text = msg
                self.enterAgreementVC.enteredAgreement.effectiveDate = msg
                self.enterAgreementVC.effectiveDateTxtWarning.hidden = true
                self.enterAgreementVC.effectiveDateImgWarning.hidden = true
            }
            else if(self.sharedDataModel.selectedButtonTextForDate == "ExpirationDate")
            {
                self.enterAgreementVC.expirationDateTextField.text = msg
                self.enterAgreementVC.enteredAgreement.expirationDate = msg
                self.enterAgreementVC.expirationDateImgWarning.hidden = true
                self.enterAgreementVC.expirationDateTxtWarning.hidden = true
            }
            else
            {
                self.transDetail3VC.estimatedPitchDateTextField.text = ""
                self.transDetail3VC.announcementDateTextField.text = ""
                self.transDetail3VC.closingDateTextField.text = ""
                self.enterAgreementVC.effectiveDateTextField.text = ""
                self.enterAgreementVC.expirationDateTextField.text = ""
            }
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
        
        
        
        
        
    }
}
