//
//  DetailViewController.swift
//  truemobile
//
//  Created by Skarulis, Joseph    on 6/11/15.
//  Copyright (c) 2015 . All rights reserved.
//

import UIKit

class DetailViewController: UITabBarController, UITabBarControllerDelegate{

    var debugUtil = DebugUtility(thisClassName: "DetailViewController" , enabled: false)
    let appAttributes = AppAttributes()
     let vcCon = VCConnection.sharedInstance
    let sharedDataModel = SharedDataModel.sharedInstance
    var coverView:UIView = UIView()
    var deleteButtonForDismiss:UIButton = UIButton(type: UIButtonType.System)
    var labelForSelectedTab:UILabel = UILabel()
    var imageFinger:UIImageView = UIImageView()
    var labelForSort:UILabel = UILabel()
    var pullDownToUpdate:UILabel = UILabel()
    var downArrow:UIImageView = UIImageView()
    var resizeButtonForHelp:UIImageView = UIImageView()
    var imageFingerForExpand:UIImageView = UIImageView()
    var labelForExpand:UILabel = UILabel()
    var imageFingerForDealOperation:UIButton = UIButton()
    var labelForDealOperation:UIButton = UIButton()
    var imageFingerForBriefCase:UIImageView = UIImageView()
    var imageForBriefCase:UIImageView = UIImageView()
    var labelForBriefCase:UILabel = UILabel()
    var imageForNewDraft:UIImageView = UIImageView()
    var imageForDeleteDraft:UIImageView = UIImageView()
    var imageForsaveDraft:UIImageView = UIImageView()
    var imageForsubmitDeal:UIImageView = UIImageView()
    var imageForHelp:UIImageView = UIImageView()
    var imageForForwardArrow:UIImageView = UIImageView()
    var imageForBackwardArrow:UIImageView = UIImageView()
    var labelForForward:UILabel = UILabel()
    var labelForBackward:UILabel = UILabel()
    var indexForicons = 0
    var imageForResizeExpand:UIImageView = UIImageView()
    var iconPosition = 0
    var sameTransactionFromHelp = ""
    var sameTransactionFromDismiss = ""
    var helpScreenRotated = ""
    var showhelpScreenActive = ""
    
    var imageFingerForCompany:UIImageView = UIImageView()
    var imageForCompany:UIImageView = UIImageView()
    var labelForCompany:UILabel = UILabel()
    //Deal Summary
    
    var viewForDealSummary: UIView  = UIView()
    var requestorLabel:UILabel = UILabel()
    var primaryClientLabel:UILabel = UILabel()
    var subProductLabel:UILabel = UILabel()
    var submittedDateLabel:UILabel = UILabel()
    
    
    //button items
    var resizeButton: UIBarButtonItem = UIBarButtonItem()

    var summaryButton: UIBarButtonItem = UIBarButtonItem()
    var newButton: UIBarButtonItem = UIBarButtonItem()
    var deleteButton : UIBarButtonItem = UIBarButtonItem()
    var saveButton: UIBarButtonItem = UIBarButtonItem()
    var submitButton: UIBarButtonItem = UIBarButtonItem()
    var helpButton : UIBarButtonItem = UIBarButtonItem()
    let buttonNames = ["info", "create_new", "trash", "save_as", "upload", "help", "resize_diagonal", "resize_diagonal2"]

    //references to other vc's
    var embeddedAddCompaniesViewController: AddCompaniesViewController!
    var embeddedMaterialityViewController: MaterialityViewController!//ViewController!
    var embeddedTransactionDetailViewController: TransactionDetailViewController!
    var embeddedBusinessSelectionViewController: BusinessSelectionViewController!
    var embeddedContactsQuestionsCollectionsViewController: ContactsQuestionsCollectionsViewController!
    var embeddedTransactionSummaryViewController: TransactionSummaryViewController!
    var embeddedCompaniesQuestions2ViewController: CompaniesQuestionsViewController!
    var embeddedContactsTableViewController: ContactsTableViewController!

    var embeddedEnterAgreementsViewController: EnterAgreementViewController!
    var appDelegate: AppDelegate!
   
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
            
        }
    }
    // set the view title based on current category
    //this needs to be made public so that the tran. filter can update count
    func setNavigationItemTitle() {
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.titleView?.tintColor = UIColor.whiteColor()
        let titleDic: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = titleDic as? [String : AnyObject]
        //set background
        let navImage: UIImage = UIImage(named: "blue-wave.png")!
        self.navigationController?.navigationBar.setBackgroundImage(navImage, forBarMetrics: .Default)
    }
    
    
    func configureView() {
        self.debugUtil.printLog("configureView", msg: "BEGIN")
        self.toggleLeftSplitViewButton()
        self.toggleRightSplitViewButton()
        self.setNavigationItemTitle()

        self.debugUtil.printLog("configureView", msg: "END")
    }

/*    func changeToAddCompanyVC() {
        var vc = self.viewControllers
        vc![1] = embeddedAddCompaniesViewController
        self.setViewControllers(vc!, animated: false)
        var tb = self.tabBar.items as! [UITabBarItem]
        let image = tb[1].image
        tb[1].image = image!.imageWithColor(UIColor(CGColor: appAttributes.colorBlue)!).imageWithRenderingMode(.AlwaysOriginal)
        let selectedImage = tb[1].selectedImage
        tb[1].selectedImage = selectedImage!.imageWithColor(UIColor.whiteColor()).imageWithRenderingMode(.AlwaysOriginal)
    }
    
*/
    /// this function will switch the current controller to Materality view controller in detail view
    func changeToMaterialityVC() {
        var vc = self.viewControllers
        vc![1] = embeddedMaterialityViewController
        self.setViewControllers(vc!, animated: false)
        var tb = self.tabBar.items as [UITabBarItem]!
        let image = tb[1].image
        tb[1].image = image!.imageWithColor(UIColor(CGColor: appAttributes.colorBlue)).imageWithRenderingMode(.AlwaysOriginal)
        let selectedImage = tb[1].selectedImage
        tb[1].selectedImage = selectedImage!.imageWithColor(UIColor.whiteColor()).imageWithRenderingMode(.AlwaysOriginal)
    }
    
    /// this function will switch the current controller to Agreements view controller in detail view
    func changeToAgreementsVC() {
        var vc = self.viewControllers
        vc![1] = embeddedEnterAgreementsViewController

        self.setViewControllers(vc!, animated: false)
        var tb = self.tabBar.items as [UITabBarItem]!
        let image = tb[1].image
        tb[1].image = image!.imageWithColor(UIColor(CGColor: appAttributes.colorBlue)).imageWithRenderingMode(.AlwaysOriginal)
        let selectedImage = tb[1].selectedImage
        tb[1].selectedImage = selectedImage!.imageWithColor(UIColor.whiteColor()).imageWithRenderingMode(.AlwaysOriginal)

    }
    func selectTab(tabName: String) {
        switch tabName {
        case "Details" :
            self.selectedIndex = 0
        case "Companies" :
            self.selectedIndex = 1
        case "M&A" :
            self.selectedIndex = 2
        case "Contacts" :
            self.selectedIndex = 3
        case "Summary" :
            self.selectedIndex = 4
        default :
            break
            
        }
    }
    
    /// the deal summary labels are shown by invoking this method whenever detail view is expanded
    /// - requestorLabel: User's Name
    /// - primaryClientLabel: Transaction Company name whose role is primary client
    /// - subProductLabel: Transaction Details Sub Product
    /// - submittedDateLabel: Deal submission date
    func dealSummary()
    {
        //
        
        //let bounds = UIScreen.mainScreen().bounds
        let width  = 1100.0
        // var height = bounds.size.height
        
        viewForDealSummary.frame = CGRectMake(-5, -9, CGFloat(width), 45.00)
        viewForDealSummary.backgroundColor = UIColor(CGColor: appAttributes.colorOcean)
        self.view.addSubview(viewForDealSummary)
        viewForDealSummary.hidden = true
        
        //
        
        requestorLabel.textColor = UIColor.whiteColor()
        requestorLabel.textAlignment = NSTextAlignment.Natural
        requestorLabel.attributedText = changeStringToBold("Requestor: ", textBold: sharedDataModel.loggedInUserName)
        requestorLabel.font = UIFont(name: requestorLabel.font.fontName, size: 13)
        viewForDealSummary.addSubview(requestorLabel)
        
        primaryClientLabel.textColor = UIColor.whiteColor()
        primaryClientLabel.textAlignment = NSTextAlignment.Natural
        primaryClientLabel.attributedText = changeStringToBold("Primary Client: ", textBold: sharedDataModel.currentTransaction.primaryClient)
        primaryClientLabel.font = UIFont(name: primaryClientLabel.font.fontName, size: 13)
        viewForDealSummary.addSubview(primaryClientLabel)
        
        subProductLabel.textColor = UIColor.whiteColor()
        subProductLabel.textAlignment = NSTextAlignment.Natural
        subProductLabel.attributedText = changeStringToBold("Sub Product: ", textBold: sharedDataModel.currentTransaction.transactionDetail.productSub)
        subProductLabel.font = UIFont(name: subProductLabel.font.fontName, size: 13)
        viewForDealSummary.addSubview(subProductLabel)
        
        
        submittedDateLabel.textColor = UIColor.whiteColor()
        submittedDateLabel.textAlignment = NSTextAlignment.Natural
        submittedDateLabel.attributedText = changeStringToBold("Submitted Date: ", textBold:sharedDataModel.separateStringFromTime(sharedDataModel.currentTransaction.submitDate))
        submittedDateLabel.font = UIFont(name: submittedDateLabel.font.fontName, size: 13)
        if sharedDataModel.currentTransaction.transactionStatus == "Draft"
        {
            submittedDateLabel.hidden = true
        }
        else
        {
            submittedDateLabel.hidden = false
        }
        viewForDealSummary.addSubview(submittedDateLabel)
        
        //

    }
    
    /// view controllers which are to be embedded in detail view controller
    func initVC() {
        //initialize header VC
      //  embeddedHeaderViewController = self.storyboard!.instantiateViewControllerWithIdentifier("DealSummarySplitViewController") as! DealSummarySplitViewController
        //self.storyboard!.instantiateViewControllerWithIdentifier("HeaderViewController") as! HeaderViewController
        //initialize addcompany VC
        embeddedAddCompaniesViewController = self.storyboard!.instantiateViewControllerWithIdentifier("addCompaniesViewController") as! AddCompaniesViewController
        //initialize agreements VC
        embeddedEnterAgreementsViewController = self.storyboard!.instantiateViewControllerWithIdentifier("EnterAgreementViewController") as! EnterAgreementViewController

        
        var vc = self.viewControllers
        
        embeddedTransactionDetailViewController = vc![0] as! TransactionDetailViewController
        embeddedMaterialityViewController = vc![1] as! MaterialityViewController
        embeddedBusinessSelectionViewController = vc![2] as! BusinessSelectionViewController
        embeddedContactsQuestionsCollectionsViewController = vc![3] as! ContactsQuestionsCollectionsViewController
        embeddedTransactionSummaryViewController = vc![4] as! TransactionSummaryViewController
        
        embeddedMaterialityViewController.detailViewController = self
        embeddedTransactionDetailViewController.detailViewController = self
        embeddedBusinessSelectionViewController.detailViewController = self
        embeddedContactsQuestionsCollectionsViewController.detailViewController = self
        embeddedTransactionSummaryViewController.detailViewController = self
        embeddedAddCompaniesViewController.detailViewController = self
        embeddedEnterAgreementsViewController.detailViewController = self

    }
    override func viewWillAppear(animated: Bool) {
        self.debugUtil.printLog("viewWillAppear", msg: "BEGIN")
        self.debugUtil.printLog("viewWillAppear", msg: "END")
        checkForOrientationChange()
        notificationCheck()
    }

    override func viewDidAppear(animated: Bool) {
    }
    func setTabColors() {
        for item in self.tabBar.items as [UITabBarItem]! {
            if let image = item.image {
                item.image = image.imageWithColor(UIColor(CGColor: appAttributes.colorBlue)).imageWithRenderingMode(.AlwaysOriginal)
            }
            if let selectedImage = item.selectedImage {
                item.selectedImage = selectedImage.imageWithColor(UIColor.whiteColor()).imageWithRenderingMode(.AlwaysOriginal)
            }
        }
      
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.updateMenu()
        self.initVC()
        dealSummary()
      /*  if sharedDataModel.currentTransaction.transactionCompanies.count == 0 {
            self.changeToAddCompanyVC()
        }
      */
        //set tab bar colors
        self.tabBar.barTintColor = UIColor.blackColor()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(CGColor: appAttributes.colorBlue)], forState:.Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Selected)
        self.setTabColors()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showQuestionaireTabByIndex(index: Int){
    }
    
    /// this method is invoked whenever user chooses a tranaction company for a particular deal
    func returnToCompany() {
        self.embeddedMaterialityViewController.materialityPage1ViewController.viewWillAppear(true)
    }
    func toggleQuestionaireSection(index: Int) {
        //self.tabBar.set
    }
    
    
    func updateMenu(){
        let tb = self.tabBar.items?[2] as UITabBarItem!
        if self.sharedDataModel.currentTransaction.transactionDetail.product == "M&A" {
            // enable Business Selection tab
            tb.enabled = true
        } else {
            // disable Business Selectin tab
            tb.enabled = false
        }
        
    }
    
    
    /// This method is invoked whenever the detail view is expanded or collapsed.
    /// this method also post a notification whenever it is triggered and grabbed by other view controllers accordingly.
    func expandCollapseDetailFrame(sender: UIBarButtonItem) {
        self.debugUtil.printLog("expandCollapseDetailFrame", msg: "BEGIN")
        if ( self.splitViewController!.preferredDisplayMode == UISplitViewControllerDisplayMode.AllVisible){
            let animations: () -> Void = {
                self.splitViewController!.preferredDisplayMode = .PrimaryHidden
            }
            self.resizeButton.image = UIImage(named: self.buttonNames[7] + ".png")
            UIView.animateWithDuration(appAttributes.fadeInDuration, animations: animations, completion: nil)
            sharedDataModel.checkForCollapseButton = "YES"
            NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: nil)
        } else {
            let animations: () -> Void = {
                self.splitViewController!.preferredDisplayMode = .AllVisible
            }
            self.resizeButton.image = UIImage(named: self.buttonNames[6] + ".png")
            UIView.animateWithDuration(appAttributes.fadeInDuration, animations: animations, completion: nil)
            sharedDataModel.checkForCollapseButton = "NO"
            NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: nil)
            
        }
        
        self.navigationItem.setLeftBarButtonItems([resizeButton], animated: false)
        
        notificationCheck()
        
        self.debugUtil.printLog("expandCollapseDetailFrame", msg: "END")
    }
    
    func notificationCheck()
    {
        //Take Action on Notification
        if sharedDataModel.checkForCollapseButton == "YES"
        {
            UIView.animateWithDuration(0.1, animations: {
                self.viewForDealSummary.hidden = false
                
            })
            imageForResizeExpand.frame = CGRectMake( 20,  9,  24, 24)
            imageFingerForExpand.frame = CGRectMake( 20,  42,  50, 50)
            labelForExpand.frame = CGRectMake( 72,  49,  175, 50)
            
            if sharedDataModel.checkForOrientationChange == "landscape"
            {
                imageForForwardArrow.frame = CGRectMake( 965,  356,  44, 44)
                imageForBackwardArrow.frame = CGRectMake( 14,  356,  44, 44)
                labelForForward.frame = CGRectMake( 384,  320,  275, 50)
                labelForBackward.frame = CGRectMake( 384,  370,  275, 50)
            }
            else
            {
                imageForForwardArrow.frame = CGRectMake( 727,  484,  44, 44)
                imageForBackwardArrow.frame = CGRectMake( -3,  484,  44, 44)
                
                labelForForward.frame = CGRectMake( 260,  462,  275, 50)
                labelForBackward.frame = CGRectMake( 260,  512,  275, 50)
            }
        }
            
        else
        {
            UIView.animateWithDuration(0.1, animations: {
                self.viewForDealSummary.hidden = true
            })
            imageFingerForExpand.frame = CGRectMake( 330,  42,  50, 50)
            labelForExpand.frame = CGRectMake( 382,  49,  175, 50)
            if sharedDataModel.checkForOrientationChange == "landscape"
            {
                imageForForwardArrow.frame = CGRectMake( 975,  356,  44, 44)
                imageForBackwardArrow.frame = CGRectMake( 324,  356,  44, 44)
                labelForForward.frame = CGRectMake( 534,  320,  275, 50)
                labelForBackward.frame = CGRectMake( 534,  370,  275, 50)
            }
            else
            {
                imageForForwardArrow.frame = CGRectMake( 732,  484,  44, 44)
                imageForBackwardArrow.frame = CGRectMake( 301,  484,  44, 44)
                
                labelForForward.frame = CGRectMake( 410,  462,  275, 50)
                labelForBackward.frame = CGRectMake( 410,  512,  275, 50)
            }
        }
    }

    /// adding expandcollapse buttton to the left bar button items
    func toggleLeftSplitViewButton() {
        self.debugUtil.printLog("toggleLeftSplitViewButton", msg: "BEGIN")
        
        self.resizeButton = UIBarButtonItem (
            image: UIImage( named: self.buttonNames[6] + ".png"),
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "expandCollapseDetailFrame:"
            
        )
        self.navigationItem.setLeftBarButtonItems([resizeButton], animated: false)
        self.debugUtil.printLog("toggleLeftSplitViewButton", msg: "END")
    }
    
    /// adding deal related buttons to the right bar button items
    func toggleRightSplitViewButton() {
        self.summaryButton = UIBarButtonItem (
            image: UIImage(named:self.buttonNames[0] + ".png"),
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "showHeaderViewContainer:"
        )
        self.newButton = UIBarButtonItem(
            image: UIImage(named:self.buttonNames[1] + ".png"),
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "newDraft:"
        )
        
        self.deleteButton = UIBarButtonItem(
            image: UIImage(named:self.buttonNames[2] + ".png"),
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "deleteDraft:"
        )
        
        self.saveButton = UIBarButtonItem(
            image: UIImage(named:self.buttonNames[3] + ".png"),
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "saveTransaction:"
        )
        
        self.submitButton = UIBarButtonItem(
            image: UIImage(named:self.buttonNames[4] + ".png"),
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "submitTransaction:"
        )
        
        self.helpButton = UIBarButtonItem(
            image: UIImage(named:self.buttonNames[5] + ".png"),
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "showHelp:"
        )/*
        self.summaryButton.setBackgroundImage(UIImage(named:self.buttonNames[0] + "_filled.png"), forState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        self.newButton.setBackgroundImage(UIImage(named:self.buttonNames[1] + "_filled.png"), forState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        self.deleteButton.setBackgroundImage(UIImage(named:self.buttonNames[2] + "_filled.png"), forState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        self.saveButton.setBackgroundImage(UIImage(named:self.buttonNames[3] + "_filled.png"), forState: UIControlState.Highlighted, barMetrics: UIBarMetrics.Default)
        self.saveButton.setBackgroundImage(UIImage(named:self.buttonNames[3] + "_filled.png"), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        self.submitButton.setBackgroundImage(UIImage(named:self.buttonNames[4] + "_filled.png"), forState: UIControlState.Highlighted, barMetrics: UIBarMetrics.Default)
        self.helpButton.setBackgroundImage(UIImage(named:self.buttonNames[5] + "_filled.png"), forState: UIControlState.Highlighted, barMetrics: UIBarMetrics.Default)

        */
//        if sharedDataModel.currentTransaction.transactionStatus == "Draft" || sharedDataModel.currentTransaction.transactionStatus == "Pending Review" || sharedDataModel.currentTransaction.transactionStatus == "Cleared" || sharedDataModel.currentTransaction.transactionStatus == "Template" {
//            self.navigationItem.setRightBarButtonItems(
//                // buttons right to left
//                [self.helpButton,self.submitButton,self.saveButton,self.deleteButton, self.newButton, ],  animated: true
//            )
//            
//        } else {
//            self.navigationItem.setRightBarButtonItems(
//                // buttons right to left
//                [self.helpButton,self.newButton],  animated: true
//            )
//            
//        }
        
        if sharedDataModel.currentTransaction.transactionStatus == "Draft"  {
            self.navigationItem.setRightBarButtonItems(
                // buttons right to left
                [self.helpButton,self.submitButton,self.saveButton,self.deleteButton, self.newButton],  animated: true
            )
            
        } else if sharedDataModel.currentTransaction.transactionStatus == "Pending Review" || sharedDataModel.currentTransaction.transactionStatus == "Cleared" {
            self.navigationItem.setRightBarButtonItems(
                // buttons right to left
                [self.helpButton,self.submitButton, self.newButton],  animated: true
            )
            
        } else if sharedDataModel.currentTransaction.transactionStatus == "Completed" || sharedDataModel.currentTransaction.transactionStatus == "Terminated" || sharedDataModel.currentTransaction.transactionStatus == "Fatal Conflicts" ||
            sharedDataModel.currentTransaction.transactionStatus == "Duplicate" {
                self.navigationItem.setRightBarButtonItems(
                    // buttons right to left
                    [self.helpButton,self.newButton],  animated: true
                )
                
        } else { // Template
            self.navigationItem.setRightBarButtonItems(
                // buttons right to left
                [self.helpButton,self.saveButton,self.newButton],  animated: true
            )
            
        }
}
    // delete draft
    
    ///this method is invoked when the user wants to delete a draft from deal list.
    /// this will pass the draft id information to the database and the correspondent transcation w.r.t this id is deleted from database
    func deleteDraft(sender: UIBarButtonItem) {
        self.debugUtil.printLog("deleteDraft", msg: "BEGIN")
        
        
        let alert = UIAlertController(title: "Delete Draft", message: "Do you want to delete the draft?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                
                if self.sharedDataModel.currentTransaction.transactionId == "New"
                {
                    self.sharedDataModel.checkForNewDraft = "NO"
                    self.sharedDataModel.transactionsArray.removeAtIndex(0)
                    
                    
                    if(self.sharedDataModel.selectedCategory == "Draft" && self.sharedDataModel.filteredTransactionArray.count > 1)
                    {
                        self.sharedDataModel.prepareQuestionaireModel(0, filtered: false)
                    }
                    
                    self.sharedDataModel.filteredTransactionArray = self.sharedDataModel.transactionsArray
                    self.sharedDataModel.selectedTransactionArray = self.sharedDataModel.transactionsArray
                    
                    self.sharedDataModel.selectedCategory = "All"

                    self.vcCon.masterViewController.setNavigationItemTitle()
                    self.vcCon.masterViewController.tableView.reloadData()
                }
                else
                {
                let coreDataManager: AnyObject! = DataManager.getInstance()
                    coreDataManager.checkForDeletePressed("YES")
                //saveTransactionArray.append(self.sharedDataModel.currentTransaction)
                coreDataManager.deleteTransaction(self.sharedDataModel.currentTransaction.transactionId)
                
                let arrayFortransaction = coreDataManager.transactionArray() as NSArray as! [TransactionData]
                self.sharedDataModel.transactionsArray = arrayFortransaction
                
                    
                    if(self.sharedDataModel.selectedCategory == "Draft" && self.sharedDataModel.filteredTransactionArray.count > 1)
                    {
                        self.sharedDataModel.prepareQuestionaireModel(0, filtered: false)
                    }
                    
                if self.sharedDataModel.checkForNewDraft == "YES"
                {
                    self.sharedDataModel.transactionsArray =  self.sharedDataModel.preserveDrafttransaction + self.sharedDataModel.transactionsArray
                }
                
                self.sharedDataModel.filteredTransactionArray = self.sharedDataModel.transactionsArray
                self.sharedDataModel.selectedTransactionArray = self.sharedDataModel.transactionsArray
                    
                  
                    
                    self.sharedDataModel.selectedCategory = "All"

                self.vcCon.masterViewController.setNavigationItemTitle()
                self.vcCon.masterViewController.tableView.reloadData()
                }
                self.sharedDataModel.lastViewedTransactionsIndexes[self.sharedDataModel.selectedCategory] = 0
                self.vcCon.masterViewController.reselectLastSelectedRow()
                self.vcCon.masterViewController.initDefault()
                
                 self.vcCon.masterNavigationController.popToRootViewControllerAnimated(true)
    
                
            case .Cancel:
                print("cancel")
                
            case .Destructive:
                print("destructive")
            }
        }))
        
        
       
        

        
        self.debugUtil.printLog("deleteDraft", msg: "END")
    }
    
    // start new draft questionaire
    ///this method is invoked when the user wants to create a new draft. An empty transaction is created and the user can provide inputs to the created transaction
    /// this draft is added on top of the existing deal list
    /// until the user save the draft he cannot create a new draft again
    func newDraft(sender: UIBarButtonItem) {
        
        self.sharedDataModel.checkForNewDraft = "YES"
        self.sharedDataModel.checkForNewDraftProduct = "YES"
        self.sharedDataModel.checkForNewDraftSubProduct = "YES"
        self.sharedDataModel.checkForNewDraftOfferingFormat = "YES"
        self.sharedDataModel.checkForNewDraftUseOfProceeds = "YES"
        self.sharedDataModel.checkForNewDraftLoanType = "YES"
        self.sharedDataModel.checkForNewDealStatus = "YES"
       self.sharedDataModel.preserveDrafttransaction = [TransactionData]()
        
        
        for transactionDataForId in self.sharedDataModel.transactionsArray
        {
            if transactionDataForId.transactionId == "New"
            {
                self.sharedDataModel.checkForExistingDraft = "YES"
                break
            }
            else
            {
                self.sharedDataModel.checkForExistingDraft = "NO"
            }
        }
        
        if self.sharedDataModel.checkForExistingDraft == "YES" {
            
            
            //trash the currentTransaction
            let txn:TransactionData = TransactionData(
                transactionId: "New",
                transactionStatus: "Draft",
                dealStatus: "",
                ddtRestriction: "No",
                savedOnDate: "Not Saved",
                submitDate: "",
                primaryClient: "",
                counterparty: "",
                product: "",
                productSub: "",
                
                transactionCompanies: [],
                
                transactionDetail: TransactionDetailData (
                    projectName: "",
                    dealStatusDB: "",
                    dealStatus: "",
                    product: "",
                    productSub: "",
                    dealDescription: "",
                    bankRole: "",
                    dealSize: "",
                    offeringFormat: "",
                    offeringFormatComments: "",
                    useOfProceeds: "",
                    useOfProceedsComments: "",
                    loanType: "",
                    isConfidential: "",
                    estimatedPitchDate: "",
                    expectedAnnouncementDate: "",
                    expectedClosingDate: "",
                    isSubjectToTakeOver: "",
                    hasFinancialSponsor: "",
                    hasNonProfitOrganization: "",
                    hasUSGovtAffiliatedMunicipality: "",
                    likelyToTakePlace: "",
                    backwardsDealStatusExplanation: "",
                    terminatedExplanation: "",
                    uncollectedFees: "",
                    requests: ""
                ),
                
                transactionContacts: [
                    TransactionContactData(
                        contact: sharedDataModel.userContactData,
                        role: "Requestor"
                    )
                ]
                
            )
            self.sharedDataModel.preserveDrafttransaction.append(txn)
            self.sharedDataModel.currentTransaction =   txn
            self.sharedDataModel.currentTransactionIndex = 0
            
            /*
            
            let alert = UIAlertController(title: "New Draft", message: "Already you have created a new draft and yet to save it. please save the draft and create a new one", preferredStyle: UIAlertControllerStyle.Alert)
            
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
            
            */
        }
        
        else
        {
            //trash the currentTransaction
            let txn:TransactionData = TransactionData(
                transactionId: "New",
                transactionStatus: "Draft",
                dealStatus: "",
                ddtRestriction: "No",
                savedOnDate: "Not Saved",
                submitDate: "",
                primaryClient: "",
                counterparty: "",
                product: "",
                productSub: "",
                
                transactionCompanies: [],
                
                transactionDetail: TransactionDetailData (
                    projectName: "",
                    dealStatusDB: "",
                    dealStatus: "",
                    product: "",
                    productSub: "",
                    dealDescription: "",
                    bankRole: "",
                    dealSize: "",
                    offeringFormat: "",
                    offeringFormatComments: "",
                    useOfProceeds: "",
                    useOfProceedsComments: "",
                    loanType: "",
                    isConfidential: "",
                    estimatedPitchDate: "",
                    expectedAnnouncementDate: "",
                    expectedClosingDate: "",
                    isSubjectToTakeOver: "",
                    hasFinancialSponsor: "",
                    hasNonProfitOrganization: "",
                    hasUSGovtAffiliatedMunicipality: "",
                    likelyToTakePlace: "",
                    backwardsDealStatusExplanation: "",
                    terminatedExplanation: "",
                    uncollectedFees: "",
                    requests: ""
                ),
                
                transactionContacts: [
                    TransactionContactData(
                        contact: sharedDataModel.userContactData,
                        role: "Requestor"
                    )
                ]
            )
            
            self.sharedDataModel.preserveDrafttransaction.append(txn)

            
            var arrayForNewDraft = [TransactionData]()
            arrayForNewDraft.append(txn)
            
            self.sharedDataModel.transactionsArray = arrayForNewDraft + self.sharedDataModel.transactionsArray
            
            if self.sharedDataModel.selectedCategory != "All"
            {
                self.sharedDataModel.selectedCategory = "Draft"
                self.sharedDataModel.prepareTransactionListModel(self.sharedDataModel.selectedCategory)
            }
            else
            {
                self.sharedDataModel.selectedCategory = "All"
                self.sharedDataModel.filteredTransactionArray = self.sharedDataModel.transactionsArray
                self.sharedDataModel.selectedTransactionArray = self.sharedDataModel.transactionsArray
                
            }
            
            self.sharedDataModel.currentTransaction =   txn
            self.sharedDataModel.currentTransactionIndex = 0
            
        }
        
        
        vcCon.masterViewController.setNavigationItemTitle()
        vcCon.masterViewController.tableView.reloadData()
        
        self.sharedDataModel.lastViewedTransactionsIndexes[self.sharedDataModel.selectedCategory] = 0
        self.vcCon.masterViewController.reselectLastSelectedRow()
        self.vcCon.masterViewController.initDefault()
        self.vcCon.masterNavigationController.popToRootViewControllerAnimated(true)

    }
    
    
    // submit transaction
    ///this method is invoked when the user wants to create a new draft. An empty transaction is created and the user can provide inputs to the created transaction
    /// this draft is added on top of the existing deal list
    /// until the user save the draft he cannot create a new draft again
    func saveTransaction(sender: UIBarButtonItem) {
        self.debugUtil.printLog("saveTransaction", msg: "BEGIN")
        
        
        // do validation ? maybe not needed only on submit
        //for now update the save date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy HH:mm:ss"
        let dateString = dateFormatter.stringFromDate(NSDate())
        self.sharedDataModel.currentTransaction.savedOnDate = dateString
        
        //
        if self.sharedDataModel.currentTransaction.transactionId == "Template"
        {
                self.sharedDataModel.currentTransaction.transactionId = "New"
                self.sharedDataModel.currentTransaction.transactionStatus = "Draft"
        }
        
        var messageForAlert: String = ""
        
        if self.sharedDataModel.currentTransaction.transactionId == "New"
        {
                messageForAlert = "Do you want to save the draft?"
                self.sharedDataModel.checkForNewDraft = "NO"
        }
        else
        {
            messageForAlert = "Do you want to save the changes?"
        }
        
        let alert = UIAlertController(title: "Save Draft", message: messageForAlert, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: "Save", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                
                self.sharedDataModel.currentTransaction.requestorName = self.sharedDataModel.loggedInUserName
                self.sharedDataModel.currentTransaction.ddtRestriction = "No"
                let coreDataManager: AnyObject! = DataManager.getInstance()
                var saveTransactionArray = [TransactionData]()
                saveTransactionArray.append(self.sharedDataModel.currentTransaction)
                coreDataManager.saveTransactionValue(saveTransactionArray)
                
                let arrayFortransaction = coreDataManager.transactionArray() as NSArray as! [TransactionData]
                self.sharedDataModel.transactionsArray = arrayFortransaction
                
                if self.sharedDataModel.checkForNewDraft == "YES"
                {
                    self.sharedDataModel.transactionsArray =  self.sharedDataModel.preserveDrafttransaction + self.sharedDataModel.transactionsArray
                }
                
                self.sharedDataModel.filteredTransactionArray = self.sharedDataModel.transactionsArray
                self.sharedDataModel.selectedTransactionArray = self.sharedDataModel.transactionsArray
                self.sharedDataModel.selectedCategory = "All"
                
                self.vcCon.masterViewController.setNavigationItemTitle()
                self.vcCon.masterViewController.tableView.reloadData()
                
                self.vcCon.masterViewController.reselectLastSelectedRow()
                self.vcCon.masterViewController.initDefault()
                self.vcCon.masterNavigationController.popToRootViewControllerAnimated(true)

            case .Cancel:
                print("cancel")
                
            case .Destructive:
                print("destructive")
            }
        }))
        

       
        //
        
        //
        self.debugUtil.printLog("saveTransaction", msg: "END")
    }
    
    // submit transaction
    ///this method is invoked when the user wants to submit a new draft. this draft is saved again but the true status is changed to pending review
    func submitTransaction(sender: UIBarButtonItem) {
        self.debugUtil.printLog("submitTransaction", msg: "BEGIN")
        
        // do validation ? maybe not needed only on submit
        //for now update the save date
        
        if self.sharedDataModel.currentTransaction.transactionId == "New"
        {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM/dd/yy HH:mm:ss"
            let dateString = dateFormatter.stringFromDate(NSDate())
            self.sharedDataModel.currentTransaction.savedOnDate = dateString
            self.sharedDataModel.checkForNewDraft = "NO"
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy HH:mm:ss"
        let dateString = dateFormatter.stringFromDate(NSDate())
        self.sharedDataModel.currentTransaction.submitDate = dateString
        
        let alert = UIAlertController(title: "Submit Transaction", message: "Do you want to submit the draft as transaction?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Submit", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                self.sharedDataModel.currentTransaction.requestorName = self.sharedDataModel.loggedInUserName
                
                if self.sharedDataModel.currentTransaction.ddtRestriction.isEmpty
                {
                    self.sharedDataModel.currentTransaction.ddtRestriction = "No"
                }

                
                if self.sharedDataModel.currentTransaction.transactionId != "New"
                {
                    if self.sharedDataModel.currentTransaction.transactionStatus == "Draft"
                    {
                        self.sharedDataModel.currentTransaction.transactionStatus = "Pending Review"
                    }
                }
                let coreDataManager: AnyObject! = DataManager.getInstance()
                var saveTransactionArray = [TransactionData]()
                saveTransactionArray.append(self.sharedDataModel.currentTransaction)
                coreDataManager.saveTransactionValue(saveTransactionArray)
                
                let arrayFortransaction = coreDataManager.transactionArray() as NSArray as! [TransactionData]
                self.sharedDataModel.transactionsArray = arrayFortransaction
                
                if self.sharedDataModel.checkForNewDraft == "YES"
                {
                    self.sharedDataModel.transactionsArray =  self.sharedDataModel.preserveDrafttransaction + self.sharedDataModel.transactionsArray
                }
                
                self.sharedDataModel.filteredTransactionArray = self.sharedDataModel.transactionsArray
                self.sharedDataModel.selectedTransactionArray = self.sharedDataModel.transactionsArray
                
                self.sharedDataModel.selectedCategory = "All"
                
                self.vcCon.masterViewController.setNavigationItemTitle()
                self.vcCon.masterViewController.tableView.reloadData()
                self.vcCon.masterViewController.reselectLastSelectedRow()
                self.vcCon.masterViewController.initDefault()
                self.vcCon.masterNavigationController.popToRootViewControllerAnimated(true)

            case .Cancel:
                print("cancel")
                
            case .Destructive:
                print("destructive")
            }
        }))

        self.presentViewController(alert, animated: true, completion: nil)
        
        
        self.debugUtil.printLog("submitTransaction", msg: "END")
    }
    
    // show help scnreens
    func showHelp(sender: UIBarButtonItem) {
        self.debugUtil.printLog("showHelp", msg: "BEGIN")
        deleteButtonForDismiss.hidden = false
       // labelForSelectedTab.hidden = false
        showHelpScreen()
        
        self.debugUtil.printLog("showHelp", msg: "END")
    }
    
    /// this method will remove the help screen from window
    func dismissHelpScreen(sender: AnyObject)
    {
        self.coverView.removeFromSuperview()
        deleteButtonForDismiss.hidden = true
        iconPosition = 0
        self.sameTransactionFromDismiss = self.sharedDataModel.currentTransaction.transactionId
        showhelpScreenActive = "NO"
       // labelForSelectedTab.hidden = true
    }
    
    /// this method set the frames for deal summary labels as well as help screen views based on the current orientation of the device
    func checkForOrientationChange()
    {
        let screenRect = UIScreen.mainScreen().bounds
        if sharedDataModel.checkForOrientationChange == "landscape"
        {
            coverView.frame = screenRect
            coverView.frame = CGRectMake(coverView.frame.origin.x, coverView.frame.origin.y + 20, coverView.frame.size.width, coverView.frame.size.height+300)
            //labelForSelectedTab.frame = CGRectMake( 450,  45,  200, 50)
            deleteButtonForDismiss.frame = CGRectMake( 54,  90,  40, 40)
            imageFinger.frame = CGRectMake( 56,  128,  50, 50)
            labelForSort.frame = CGRectMake( 108,  135,  150, 50)
            pullDownToUpdate.frame = CGRectMake( 76,  525,  175, 50)
            downArrow.frame = CGRectMake( 131,  600,  50, 50)
            resizeButtonForHelp.frame = CGRectMake( 338,  9,  24, 24)
            imageFingerForExpand.frame = CGRectMake( 330,  42,  50, 50)
            labelForExpand.frame = CGRectMake( 382,  49,  175, 50)
           
            imageFingerForDealOperation.frame = CGRectMake( 775,  42,  50, 50)
            labelForDealOperation.frame = CGRectMake( 745,  95,  175, 50)
            
            imageForBriefCase.frame = CGRectMake( 15,  9,  22, 22)
            imageFingerForBriefCase.frame = CGRectMake( 45,  0,  50, 50)
            labelForBriefCase.frame = CGRectMake( 100,  3,  150, 50)
            
            imageForNewDraft.frame = CGRectMake( 773,  7,  26, 26)
            imageForDeleteDraft.frame = CGRectMake( 826,  9,  22, 22)
            imageForsaveDraft.frame = CGRectMake( 878,  9,  22, 22)
            imageForsubmitDeal.frame = CGRectMake( 930,  9,  22, 22)
            imageForHelp.frame = CGRectMake( 982,  9,  22, 22)
            
            imageForForwardArrow.frame = CGRectMake( 975,  356,  44, 44)
            imageForBackwardArrow.frame = CGRectMake( 324,  356,  44, 44)
            
            labelForForward.frame = CGRectMake( 534,  320,  275, 50)
            labelForBackward.frame = CGRectMake( 534,  370,  275, 50)
            
            imageForCompany.frame = CGRectMake( 280,  10,  22, 22)
            imageFingerForCompany.frame = CGRectMake( 205,  0,  50, 50)
            labelForCompany.frame = CGRectMake( 50,  3,  150, 50)
            
            // deal summary
            
            requestorLabel.frame = CGRectMake( 30,  10,  200, 30.00)
            primaryClientLabel.frame = CGRectMake(requestorLabel.frame.origin.x + requestorLabel.frame.size.width + 50,  10,  270, 30.00)
            subProductLabel.frame = CGRectMake(primaryClientLabel.frame.origin.x +  primaryClientLabel.frame.size.width + 15,  10,  205, 30.00)
            submittedDateLabel.frame = CGRectMake( subProductLabel.frame.origin.x + subProductLabel.frame.size.width + 75,  10,  175, 30.00)
            if sharedDataModel.currentTransaction.transactionStatus == "Draft"
            {
                requestorLabel.frame = CGRectMake( 100,  10,  175, 30.00)
                primaryClientLabel.frame = CGRectMake(requestorLabel.frame.origin.x + requestorLabel.frame.size.width + 5,  10,  300, 30.00)
                subProductLabel.frame = CGRectMake(primaryClientLabel.frame.origin.x +  primaryClientLabel.frame.size.width + 5,  10,  210, 30.00)
            }
            
            //
            
            
            
        }
        else
        {
            coverView.frame = screenRect
            coverView.frame = CGRectMake(coverView.frame.origin.x, coverView.frame.origin.y + 20, coverView.frame.size.width+300, coverView.frame.size.height)
            //labelForSelectedTab.frame = CGRectMake( 300,  45,  200, 50)
           // deleteButtonForDismiss.frame = CGRectMake( 600,  60,  44, 44)
            deleteButtonForDismiss.frame = CGRectMake( 54,  90,  40, 40)
            imageFinger.frame = CGRectMake( 56,  128,  50, 50)
            labelForSort.frame = CGRectMake( 108,  135,  150, 50)
            pullDownToUpdate.frame = CGRectMake( 76,  525,  175, 50)
            downArrow.frame = CGRectMake( 131,  600,  50, 50)
            resizeButtonForHelp.frame = CGRectMake( 328,  9,  24, 24)
            imageFingerForExpand.frame = CGRectMake( 320,  42,  50, 50)
            labelForExpand.frame = CGRectMake( 372,  49,  175, 50)
            imageFingerForDealOperation.frame = CGRectMake( 575,  42,  50, 50)
            labelForDealOperation.frame = CGRectMake( 540,  95,  175, 50)
            
            imageForBriefCase.frame = CGRectMake( 15,  9,  22, 22)
            imageFingerForBriefCase.frame = CGRectMake( 45,  0,  50, 50)
            labelForBriefCase.frame = CGRectMake( 100,  3,  150, 50)
            
            imageForNewDraft.frame = CGRectMake( 517,  7,  26, 26)
            imageForDeleteDraft.frame = CGRectMake( 570,  9,  22, 22)
            imageForsaveDraft.frame = CGRectMake( 622,  9,  22, 22)
            imageForsubmitDeal.frame = CGRectMake( 674,  9,  22, 22)
            imageForHelp.frame = CGRectMake( 726,  9,  22, 22)
            
            imageForForwardArrow.frame = CGRectMake( 732,  484,  44, 44)
            imageForBackwardArrow.frame = CGRectMake( 301,  484,  44, 44)
            
            labelForForward.frame = CGRectMake( 410,  462,  275, 50)
            labelForBackward.frame = CGRectMake( 410,  512,  275, 50)
            
            imageForCompany.frame = CGRectMake( 270,  10,  22, 22)
            imageFingerForCompany.frame = CGRectMake( 205,  0,  50, 50)
            labelForCompany.frame = CGRectMake( 50,  3,  150, 50)
            
            //Deal summary
            
            requestorLabel.frame = CGRectMake( 10,  10,  175, 30.00)
            primaryClientLabel.frame = CGRectMake(requestorLabel.frame.origin.x + requestorLabel.frame.size.width + 5,  10,  240, 30.00)
            subProductLabel.frame = CGRectMake(primaryClientLabel.frame.origin.x +  primaryClientLabel.frame.size.width + 5,  10,  175, 30.00)
            submittedDateLabel.frame = CGRectMake( subProductLabel.frame.origin.x + subProductLabel.frame.size.width + 5,  10,  175, 30.00)
            if sharedDataModel.currentTransaction.transactionStatus == "Draft"
            {
                requestorLabel.frame = CGRectMake( 50,  10,  175, 30.00)
                primaryClientLabel.frame = CGRectMake(requestorLabel.frame.origin.x + requestorLabel.frame.size.width + 5,  10,  300, 30.00)
                subProductLabel.frame = CGRectMake(primaryClientLabel.frame.origin.x +  primaryClientLabel.frame.size.width + 5,  10,  210, 30.00)
            }
            
            //
            
        }
        
    }
    // this method set the frames for deal summary labels as well as help screen views based on the current orientation of the device
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        helpScreenRotated = "YES"
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        let screenRect = UIScreen.mainScreen().bounds
        
        if UIDevice.currentDevice().orientation.isLandscape.boolValue
        {
            coverView.frame = screenRect
            coverView.frame = CGRectMake(coverView.frame.origin.x, coverView.frame.origin.y + 20, coverView.frame.size.width, coverView.frame.size.height+300)
            deleteButtonForDismiss.frame = CGRectMake( 54,  90,  40, 40)
            imageFinger.frame = CGRectMake( 56,  128,  50, 50)
            labelForSort.frame = CGRectMake( 108,  135,  150, 50)
            pullDownToUpdate.frame = CGRectMake( 76,  525,  175, 50)
            downArrow.frame = CGRectMake( 131,  600,  50, 50)
            resizeButtonForHelp.frame = CGRectMake( 338,  9,  24, 24)
            if sharedDataModel.checkForCollapseButton == "NO"
            {
                imageFingerForExpand.frame = CGRectMake( 330,  42,  50, 50)
                labelForExpand.frame = CGRectMake( 382,  49,  175, 50)
            }
            else
            {
                imageFingerForExpand.frame = CGRectMake( 20,  42,  50, 50)
                labelForExpand.frame = CGRectMake( 72,  49,  175, 50)
            }
            
            imageFingerForDealOperation.frame = CGRectMake( 775,  42,  50, 50)
            labelForDealOperation.frame = CGRectMake( 745,  95,  175, 50)
            
            imageForBriefCase.frame = CGRectMake( 15,  9,  22, 22)
            imageFingerForBriefCase.frame = CGRectMake( 45,  0,  50, 50)
            labelForBriefCase.frame = CGRectMake( 100,  3,  150, 50)

            imageForNewDraft.frame = CGRectMake( 773,  7,  26, 26)
            imageForDeleteDraft.frame = CGRectMake( 826,  9,  22, 22)
            imageForsaveDraft.frame = CGRectMake( 878,  9,  22, 22)
            imageForsubmitDeal.frame = CGRectMake( 930,  9,  22, 22)
            imageForHelp.frame = CGRectMake( 982,  9,  22, 22)
            
            if sharedDataModel.checkForCollapseButton == "NO"
            {
                imageForForwardArrow.frame = CGRectMake( 975,  356,  44, 44)
                imageForBackwardArrow.frame = CGRectMake( 324,  356,  44, 44)
                labelForForward.frame = CGRectMake( 534,  320,  275, 50)
                labelForBackward.frame = CGRectMake( 534,  370,  275, 50)
            }
            else
            {
                imageForForwardArrow.frame = CGRectMake( 965,  356,  44, 44)
                imageForBackwardArrow.frame = CGRectMake( 14,  356,  44, 44)
                labelForForward.frame = CGRectMake( 384,  320,  275, 50)
                labelForBackward.frame = CGRectMake( 384,  370,  275, 50)
            }

            imageForCompany.frame = CGRectMake( 280,  10,  22, 22)
            imageFingerForCompany.frame = CGRectMake( 205,  0,  50, 50)
            labelForCompany.frame = CGRectMake( 50,  3,  150, 50)
            
            // Deal summary
            
            requestorLabel.frame = CGRectMake( 30,  10,  200, 30.00)
            primaryClientLabel.frame = CGRectMake(requestorLabel.frame.origin.x + requestorLabel.frame.size.width + 50,  10,  270, 30.00)
            subProductLabel.frame = CGRectMake(primaryClientLabel.frame.origin.x +  primaryClientLabel.frame.size.width + 15,  10,  205, 30.00)
            submittedDateLabel.frame = CGRectMake( subProductLabel.frame.origin.x + subProductLabel.frame.size.width + 75,  10,  175, 30.00)
            sharedDataModel.checkForOrientationChange = "landscape"
            
            if sharedDataModel.currentTransaction.transactionStatus == "Draft"
            {
                requestorLabel.frame = CGRectMake( 100,  10,  175, 30.00)
                primaryClientLabel.frame = CGRectMake(requestorLabel.frame.origin.x + requestorLabel.frame.size.width + 5,  10,  300, 30.00)
                subProductLabel.frame = CGRectMake(primaryClientLabel.frame.origin.x +  primaryClientLabel.frame.size.width + 5,  10,  210, 30.00)
            }
            
            //
            
        }
        else
        {
            coverView.frame = screenRect
            coverView.frame = CGRectMake(coverView.frame.origin.x, coverView.frame.origin.y + 20, coverView.frame.size.width+300, coverView.frame.size.height)
            deleteButtonForDismiss.frame = CGRectMake( 54,  90,  40, 40)
            imageFinger.frame = CGRectMake( 56,  128,  50, 50)
            labelForSort.frame = CGRectMake( 108,  135,  150, 50)
            pullDownToUpdate.frame = CGRectMake( 76,  525,  175, 50)
            downArrow.frame = CGRectMake( 131,  600,  50, 50)
            resizeButtonForHelp.frame = CGRectMake( 328,  9,  24, 24)
            if sharedDataModel.checkForCollapseButton == "NO"
            {
                imageFingerForExpand.frame = CGRectMake( 320,  42,  50, 50)
                labelForExpand.frame = CGRectMake( 372,  49,  175, 50)
            }
            else
            {
                imageFingerForExpand.frame = CGRectMake( 20,  42,  50, 50)
                labelForExpand.frame = CGRectMake( 72,  49,  175, 50)
            }
            imageFingerForDealOperation.frame = CGRectMake( 575,  42,  50, 50)
            labelForDealOperation.frame = CGRectMake( 540,  95,  175, 50)
            
            imageForBriefCase.frame = CGRectMake( 15,  9,  22, 22)
            imageFingerForBriefCase.frame = CGRectMake( 45,  0,  50, 50)
            labelForBriefCase.frame = CGRectMake( 100,  3,  150, 50)
            imageForNewDraft.frame = CGRectMake( 517,  7,  26, 26)
            imageForDeleteDraft.frame = CGRectMake( 570,  9,  22, 22)
            imageForsaveDraft.frame = CGRectMake( 622,  9,  22, 22)
            imageForsubmitDeal.frame = CGRectMake( 674,  9,  22, 22)
            imageForHelp.frame = CGRectMake( 726,  9,  22, 22)
            
            imageForCompany.frame = CGRectMake( 270,  10,  22, 22)
            imageFingerForCompany.frame = CGRectMake( 205,  0,  50, 50)
            labelForCompany.frame = CGRectMake( 50,  3,  150, 50)
            
            if sharedDataModel.checkForCollapseButton == "NO"
            {
                imageForForwardArrow.frame = CGRectMake( 732,  484,  44, 44)
                imageForBackwardArrow.frame = CGRectMake( 301,  484,  44, 44)
                labelForForward.frame = CGRectMake( 410,  462,  275, 50)
                labelForBackward.frame = CGRectMake( 410,  512,  275, 50)
            }
            else
            {
                imageForForwardArrow.frame = CGRectMake( 727,  484,  44, 44)
                imageForBackwardArrow.frame = CGRectMake( -3,  484,  44, 44)
                labelForForward.frame = CGRectMake( 260,  462,  275, 50)
                labelForBackward.frame = CGRectMake( 260,  512,  275, 50)
            }
            
            // Deal Summary
            requestorLabel.frame = CGRectMake( 10,  10,  175, 30.00)
            primaryClientLabel.frame = CGRectMake(requestorLabel.frame.origin.x + requestorLabel.frame.size.width + 5,  10,  240, 30.00)
            subProductLabel.frame = CGRectMake(primaryClientLabel.frame.origin.x +  primaryClientLabel.frame.size.width + 5,  10,  175, 30.00)
            submittedDateLabel.frame = CGRectMake( subProductLabel.frame.origin.x + subProductLabel.frame.size.width + 5,  10,  175, 30.00)
            sharedDataModel.checkForOrientationChange = "portrait"
            
            if sharedDataModel.currentTransaction.transactionStatus == "Draft"
            {
                requestorLabel.frame = CGRectMake( 50,  10,  175, 30.00)
                primaryClientLabel.frame = CGRectMake(requestorLabel.frame.origin.x + requestorLabel.frame.size.width + 5,  10,  300, 30.00)
                subProductLabel.frame = CGRectMake(primaryClientLabel.frame.origin.x +  primaryClientLabel.frame.size.width + 5,  10,  210, 30.00)
            }

            
            //
        }
        
    }
    
    /// this method is invoked when the help bar button is clicked.
    /// this method adds the help screen views to the window on top of the main screen
    func showHelpScreen()
    {
       // var selectedTabName = ""
        showhelpScreenActive = "YES"
            indexForicons = 0
        coverView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        let tapgesture = UITapGestureRecognizer(target: self, action:Selector ("dismissHelpScreen:"))
        coverView.addGestureRecognizer(tapgesture)
        
        let image1 = UIImage(named: "giveWayFilled44")
        deleteButtonForDismiss.setImage(image1, forState: .Normal)
        deleteButtonForDismiss.addTarget(self, action: "dismissHelpScreen:", forControlEvents: .TouchUpInside)
        coverView.addSubview(deleteButtonForDismiss)
        
//        labelForSelectedTab.textColor = UIColor.whiteColor()
//        labelForSelectedTab.textAlignment = NSTextAlignment.Center
//        if selectedIndex == 0
//        {
//            selectedTabName = "Help-Details"
//        }
//        else if selectedIndex == 1
//        {
//            selectedTabName = "Help-Companies"
//        }
//        else if selectedIndex == 2
//        {
//            selectedTabName = "Help-M&A"
//        }
//        else if selectedIndex == 3
//        {
//            selectedTabName = "Help-Contacts"
//        }
//        else
//        {
//            selectedTabName = "Help-Summary"
//        }
//        labelForSelectedTab.attributedText = changeStringToBold(selectedTabName,textBold: "")
//        labelForSelectedTab.font = UIFont(name: labelForSelectedTab.font.fontName, size: 22)
//        coverView.addSubview(labelForSelectedTab)
        
        imageFinger.image = UIImage(named: "oneFinger75")
        coverView.addSubview(imageFinger)
        
        labelForSort.textColor = UIColor.whiteColor()
        labelForSort.textAlignment = NSTextAlignment.Natural
        labelForSort.attributedText = changeStringToBold("TAP HERE TO SORT UP OR DOWN",textBold: "")
        labelForSort.numberOfLines = 2
        labelForSort.font = UIFont(name: labelForSort.font.fontName, size: 14)
        coverView.addSubview(labelForSort)
        
        pullDownToUpdate.textColor = UIColor.whiteColor()
        pullDownToUpdate.textAlignment = NSTextAlignment.Natural
        pullDownToUpdate.attributedText = changeStringToBold("PULL DOWN TO UPDATE",textBold: "")
        pullDownToUpdate.font = UIFont(name: pullDownToUpdate.font.fontName, size: 14)
        coverView.addSubview(pullDownToUpdate)
        
        downArrow.image = UIImage(named: "downArrow")
        coverView.addSubview(downArrow)
        
        resizeButtonForHelp.image = UIImage(named: "resizeDiagonal44")
        coverView.addSubview(resizeButtonForHelp)
        
        imageFingerForExpand.image = UIImage(named: "oneFinger75")
        coverView.addSubview(imageFingerForExpand)
        
        labelForExpand.textColor = UIColor.whiteColor()
        labelForExpand.textAlignment = NSTextAlignment.Natural
        labelForExpand.attributedText = changeStringToBold("TAP HERE TO SHOW OR HIDE THE LEFT SIDE LIST",textBold: "")
        labelForExpand.numberOfLines = 2
        labelForExpand.font = UIFont(name: labelForExpand.font.fontName, size: 14)
        coverView.addSubview(labelForExpand)
        
        
        let image11 = UIImage(named: "oneFinger75")
        imageFingerForDealOperation.setImage(image11, forState: .Normal)
        imageFingerForDealOperation.addTarget(self, action: "showIcons:", forControlEvents: .TouchUpInside)

        coverView.addSubview(imageFingerForDealOperation)
        
        
        labelForDealOperation.addTarget(self, action: "showIcons:", forControlEvents: .TouchUpInside)
        labelForDealOperation.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        labelForDealOperation.setAttributedTitle(changeStringToBold("TAP HERE FOR ICONS",textBold: "A"), forState: UIControlState.Normal)
        coverView.addSubview(labelForDealOperation)
        
        imageFingerForBriefCase.image = UIImage(named: "oneFingerLeft75")
        coverView.addSubview(imageFingerForBriefCase)
        
        imageForBriefCase.image = UIImage(named: "briefcase50")
        coverView.addSubview(imageForBriefCase)
        
        labelForBriefCase.textColor = UIColor.whiteColor()
        labelForBriefCase.textAlignment = NSTextAlignment.Natural
        labelForBriefCase.attributedText = changeStringToBold("TAP HERE TO CHOOSE THE DEAL LIST",textBold: "")
        labelForBriefCase.numberOfLines = 2
        labelForBriefCase.font = UIFont(name: labelForBriefCase.font.fontName, size: 14)
        coverView.addSubview(labelForBriefCase)
        
        imageForNewDraft.image = UIImage(named: "createNew44")
        imageForNewDraft.hidden = true
        coverView.addSubview(imageForNewDraft)
        
        imageForDeleteDraft.image = UIImage(named: "trash44")
        imageForDeleteDraft.hidden = true
        coverView.addSubview(imageForDeleteDraft)
        
        imageForsaveDraft.image = UIImage(named: "saveAs44")
        imageForsaveDraft.hidden = true
        coverView.addSubview(imageForsaveDraft)
        
        imageForsubmitDeal.image = UIImage(named: "upload44")
        imageForsubmitDeal.hidden = true
        coverView.addSubview(imageForsubmitDeal)
        
        imageForHelp.image = UIImage(named: "help44")
        imageForHelp.hidden = true
        coverView.addSubview(imageForHelp)
        
        imageForForwardArrow.image = UIImage(named: "forward75")
        coverView.addSubview(imageForForwardArrow)
        
        imageForBackwardArrow.image = UIImage(named: "backward75")
        coverView.addSubview(imageForBackwardArrow)
        
        labelForForward.textColor = UIColor.whiteColor()
        labelForForward.textAlignment = NSTextAlignment.Natural
        labelForForward.attributedText = changeStringToBold("SWIPE LEFT OR TAP THE FORWARD ARROW TO GO TO NEXT PAGE",textBold: "")
        labelForForward.numberOfLines = 2
        labelForForward.font = UIFont(name: labelForForward.font.fontName, size: 14)
        coverView.addSubview(labelForForward)
        
        labelForBackward.textColor = UIColor.whiteColor()
        labelForBackward.textAlignment = NSTextAlignment.Natural
        labelForBackward.attributedText = changeStringToBold("SWIPE RIGHT OR TAP THE BACK ARROW TO GO TO PREVIOUS PAGE",textBold: "")
        labelForBackward.numberOfLines = 2
        labelForBackward.font = UIFont(name: labelForBackward.font.fontName, size: 14)
        coverView.addSubview(labelForBackward)
        
        imageForResizeExpand.image = UIImage(named: "resizeDiagonalForExpand44")
        coverView.addSubview(imageForResizeExpand)

        imageFingerForCompany.image = UIImage(named: "oneFingerRight75")
        coverView.addSubview(imageFingerForCompany)
        
        imageForCompany.image = UIImage(named: "plusOrganization44")
        coverView.addSubview(imageForCompany)
        
        labelForCompany.textColor = UIColor.whiteColor()
        labelForCompany.textAlignment = NSTextAlignment.Natural
        labelForCompany.attributedText = changeStringToBold("TAP HERE TO CHOOSE A COMPANY",textBold: "")
        labelForCompany.numberOfLines = 2
        labelForCompany.font = UIFont(name: labelForCompany.font.fontName, size: 14)
        coverView.addSubview(labelForCompany)
        
        self.vcCon.window?.addSubview(coverView)

        /*
        var deleteButtonForDismiss:UIButton = UIButton(type: UIButtonType.System)
        var imageFinger:UIImageView = UIImageView()
        var labelForSort:UILabel = UILabel()
        var pullDownToUpdate:UILabel = UILabel()
        var downArrow:UIImageView = UIImageView()
        var imageFingerForBriefCase:UIImageView = UIImageView()
        var imageForBriefCase:UIImageView = UIImageView()
        var imageForBriefCase:UILabel = UILabel()
        
        */
        if sharedDataModel.checkForCollapseButton == "YES"
        {
            deleteButtonForDismiss.hidden = true
            imageFinger.hidden = true
            labelForSort.hidden = true
            pullDownToUpdate.hidden = true
            downArrow.hidden = true
            imageFingerForBriefCase.hidden = true
            imageForBriefCase.hidden = true
            imageForBriefCase.hidden = true
            labelForBriefCase.hidden = true
            resizeButtonForHelp.hidden = true
            imageForResizeExpand.hidden = false
            
        }
        else
        {
            deleteButtonForDismiss.hidden = false
            imageFinger.hidden = false
            labelForSort.hidden = false
            pullDownToUpdate.hidden = false
            downArrow.hidden = false
            imageFingerForBriefCase.hidden = false
            imageForBriefCase.hidden = false
            imageForBriefCase.hidden = false
            imageForResizeExpand.hidden = true
            labelForBriefCase.hidden = false
            resizeButtonForHelp.hidden = false
        }
        
        if !sharedDataModel.filteredTransactionArray.isEmpty
        {
            if sharedDataModel.filteredTransactionArray.count < 2 || selectedIndex == 1 || selectedIndex == 3
            {
                deleteButtonForDismiss.hidden = true
                imageFinger.hidden = true
                labelForSort.hidden = true
            }
        }
        
        if selectedIndex == 1 || selectedIndex == 3
        {
            imageFingerForBriefCase.hidden = true
            imageForBriefCase.hidden = true
            labelForBriefCase.hidden = true
            
            if selectedIndex == 1 && self.sharedDataModel.checkForAgreementClicked == "NO"
            {
                imageForCompany.image = UIImage(named: "plusOrganization44")
                labelForCompany.attributedText = changeStringToBold("TAP HERE TO CHOOSE A COMPANY",textBold: "")
                labelForCompany.font = UIFont(name: labelForCompany.font.fontName, size: 14)
            }
            else if selectedIndex == 1 && self.sharedDataModel.checkForAgreementClicked == "YES"
            {
                imageForCompany.image = UIImage(named: "addList44")
                labelForCompany.attributedText = changeStringToBold("TAP HERE TO CREATE A NEW AGREEMENT",textBold: "")
                labelForCompany.font = UIFont(name: labelForCompany.font.fontName, size: 14)
            }
            else
            {
                imageForCompany.image = UIImage(named: "add_user_white")
                labelForCompany.attributedText = changeStringToBold("TAP HERE TO CHOOSE A CONTACT",textBold: "")
                labelForCompany.font = UIFont(name: labelForCompany.font.fontName, size: 14)
            }
            
            if sharedDataModel.checkForCollapseButton == "NO"
            {
                imageFingerForCompany.hidden = false
                imageForCompany.hidden = false
                labelForCompany.hidden = false
            }
            else
            {
                imageFingerForCompany.hidden = true
                imageForCompany.hidden = true
                labelForCompany.hidden = true
            }

        }
        
        else
        {
            imageFingerForCompany.hidden = true
            imageForCompany.hidden = true
            labelForCompany.hidden = true
        }
        
        if selectedIndex == 3 || selectedIndex == 4 || self.sharedDataModel.checkForAgreementClicked == "YES"
        {
            imageForBackwardArrow.hidden = true
            imageForForwardArrow.hidden = true
            labelForBackward.hidden = true
            labelForForward.hidden = true
        }
        else
        {
            imageForBackwardArrow.hidden = false
            imageForForwardArrow.hidden = false
            labelForBackward.hidden = false
            labelForForward.hidden = false
        }
        
    }

    /// this method determines the help icons to be shown based on the true statuses accordingly
    func showIcons(sender: UIButton)
    {
        
        
        var iconAction = ""
        if sharedDataModel.currentTransaction.transactionStatus == "Draft"  {
            if indexForicons == 0
            {
                self.imageForNewDraft.hidden = false
                self.imageForNewDraft.alpha = 1.0
                iconAction = "NEW DRAFT"
            }
            else if indexForicons == 1
            {
                self.imageForDeleteDraft.hidden = false
                self.imageForDeleteDraft.alpha = 1.0
                iconAction = "DELETE DRAFT"
            }
            else if indexForicons == 2
            {
                self.imageForsaveDraft.hidden = false
                self.imageForsaveDraft.alpha = 1.0
                iconAction = "SAVE DRAFT"
            }
            else if indexForicons == 3
            {
                self.imageForsubmitDeal.hidden = false
                self.imageForsubmitDeal.alpha = 1.0
                iconAction = "SUBMIT DEAL"
            }
            else
            {
                self.imageForHelp.hidden = false
                self.imageForHelp.alpha = 1.0
                iconAction = "HELP"
            }

            
        } else if sharedDataModel.currentTransaction.transactionStatus == "Pending Review" || sharedDataModel.currentTransaction.transactionStatus == "Cleared" {
            if indexForicons == 0
            {
                self.imageForNewDraft.hidden = false
                self.imageForNewDraft.alpha = 1.0
                iconAction = "NEW DRAFT"
                self.imageForNewDraft.frame = CGRectMake(self.imageForsaveDraft.frame.origin.x, self.imageForNewDraft.frame.origin.y, self.imageForNewDraft.frame.size.width, self.imageForNewDraft.frame.size.width)
            }
            else if indexForicons == 1
            {
                self.imageForsubmitDeal.hidden = false
                self.imageForsubmitDeal.alpha = 1.0
                iconAction = "SUBMIT DEAL"
            }
            else
            {
                self.imageForHelp.hidden = false
                self.imageForHelp.alpha = 1.0
                iconAction = "HELP"
            }

            
        } else if sharedDataModel.currentTransaction.transactionStatus == "Completed" || sharedDataModel.currentTransaction.transactionStatus == "Terminated" || sharedDataModel.currentTransaction.transactionStatus == "Fatal Conflicts" ||
            sharedDataModel.currentTransaction.transactionStatus == "Duplicate" {
                if indexForicons == 0
                {
                    self.imageForNewDraft.hidden = false
                    self.imageForNewDraft.alpha = 1.0
                    iconAction = "NEW DRAFT"
                    self.imageForNewDraft.frame = CGRectMake(self.imageForsubmitDeal.frame.origin.x, self.imageForNewDraft.frame.origin.y, self.imageForNewDraft.frame.size.width, self.imageForNewDraft.frame.size.width)
                }
                else
                {
                    self.imageForHelp.hidden = false
                    self.imageForHelp.alpha = 1.0
                    iconAction = "HELP"
                }
                
        } else { // Template
            if indexForicons == 0
            {
                self.imageForNewDraft.hidden = false
                self.imageForNewDraft.alpha = 1.0
                iconAction = "NEW DRAFT"
                self.sameTransactionFromHelp = self.sharedDataModel.currentTransaction.transactionId
                
                if iconPosition == 0 && self.sameTransactionFromDismiss != self.sameTransactionFromHelp
                {
                    self.imageForNewDraft.frame = CGRectMake(self.imageForsaveDraft.frame.origin.x, self.imageForNewDraft.frame.origin.y, self.imageForNewDraft.frame.size.width, self.imageForNewDraft.frame.size.width)
                }
                else
                {
                    if showhelpScreenActive == "YES" && helpScreenRotated == "YES"
                    {
                        self.imageForNewDraft.frame = CGRectMake(self.imageForsaveDraft.frame.origin.x, self.imageForNewDraft.frame.origin.y, self.imageForNewDraft.frame.size.width, self.imageForNewDraft.frame.size.width)
                        helpScreenRotated = "NO"
                    }
                    else
                    {
                        self.imageForNewDraft.frame = CGRectMake(self.imageForNewDraft.frame.origin.x, self.imageForNewDraft.frame.origin.y, self.imageForNewDraft.frame.size.width, self.imageForNewDraft.frame.size.width)
                        
                    }
                }
                
            }
            else if indexForicons == 1
            {
                
                if showhelpScreenActive == "YES" && helpScreenRotated == "YES"
                {
                    self.imageForNewDraft.frame = CGRectMake(self.imageForsaveDraft.frame.origin.x, self.imageForNewDraft.frame.origin.y, self.imageForNewDraft.frame.size.width, self.imageForNewDraft.frame.size.width)
                    helpScreenRotated = "NO"
                }
                self.imageForsaveDraft.hidden = false
                self.imageForsaveDraft.alpha = 1.0
                iconAction = "SAVE DRAFT"
                self.imageForsaveDraft.frame = CGRectMake(self.imageForsubmitDeal.frame.origin.x, self.imageForsaveDraft.frame.origin.y, self.imageForsaveDraft.frame.size.width, self.imageForsaveDraft.frame.size.width)
                self.iconPosition = 1
                

            }
            else
            {
                self.imageForHelp.hidden = false
                self.imageForHelp.alpha = 1.0
                iconAction = "HELP"
            }
        }

        
        UIView.animateWithDuration(0.5, delay: 0.8, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            
             if self.sharedDataModel.currentTransaction.transactionStatus == "Draft"  {
                if self.indexForicons == 0
                {
                    self.imageForNewDraft.alpha = 0.0
                    self.indexForicons = self.indexForicons + 1
                }
                else if self.indexForicons == 1
                {
                    self.imageForDeleteDraft.alpha = 0.0
                    self.indexForicons = self.indexForicons + 1
                }
                else if self.indexForicons == 2
                {
                    self.imageForsaveDraft.alpha = 0.0
                    self.indexForicons = self.indexForicons + 1
                }
                else if self.indexForicons == 3
                {
                    self.imageForsubmitDeal.alpha = 0.0
                    self.indexForicons = self.indexForicons + 1
                }
                else
                {
                    self.imageForHelp.alpha = 0.0
                    self.indexForicons = 0
                }
            }
            
             else if self.sharedDataModel.currentTransaction.transactionStatus == "Pending Review" || self.sharedDataModel.currentTransaction.transactionStatus == "Cleared" {
                if self.indexForicons == 0
                {
                    self.imageForNewDraft.alpha = 0.0
                    self.indexForicons = self.indexForicons + 1
                }
                else if self.indexForicons == 1
                {
                    self.imageForsubmitDeal.alpha = 0.0
                    self.indexForicons = self.indexForicons + 1
                }
                else
                {
                    self.imageForHelp.alpha = 0.0
                    self.indexForicons = 0
                }
            }
             else if self.sharedDataModel.currentTransaction.transactionStatus == "Completed" || self.sharedDataModel.currentTransaction.transactionStatus == "Terminated" || self.sharedDataModel.currentTransaction.transactionStatus == "Fatal Conflicts" ||
                self.sharedDataModel.currentTransaction.transactionStatus == "Duplicate" {
                    if self.indexForicons == 0
                    {
                        self.imageForNewDraft.alpha = 0.0
                        self.indexForicons = self.indexForicons + 1
                    }
                    else
                    {
                        self.imageForHelp.alpha = 0.0
                        self.indexForicons = 0
                    }
            }
            else
            {
                if self.indexForicons == 0
                {
                    self.imageForNewDraft.alpha = 0.0
                    self.indexForicons = self.indexForicons + 1

                }
                else if self.indexForicons == 1
                {
                    
                    self.imageForsaveDraft.alpha = 0.0
                    self.indexForicons = self.indexForicons + 1

                }
                else
                {
                    self.imageForHelp.alpha = 0.0
                    self.indexForicons = 0
                }
                
            }

            self.labelForDealOperation.setAttributedTitle(self.changeStringToBold(iconAction,textBold: "A"), forState: UIControlState.Normal)
            }, completion:{(Bool finished) in
                if(finished)
                {
                self.labelForDealOperation.setAttributedTitle(self.changeStringToBold("TAP HERE FOR ICONS",textBold: "A"), forState: UIControlState.Normal)
                }
        })

         
    }
    
    /// this method converts the string to bold and appends with other string
    func changeStringToBold(normalText:String, textBold:String)->NSAttributedString
    {
        let attributedString = NSMutableAttributedString(string:textBold)
        if textBold == "A"
        {
            let attrs = [NSFontAttributeName : UIFont.boldSystemFontOfSize(14)]
            let boldString = NSMutableAttributedString(string:normalText, attributes:attrs)
            boldString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: NSMakeRange(0, normalText.characters.count))
            return boldString
        }
        else
        {
            let attrs = [NSFontAttributeName : UIFont.boldSystemFontOfSize(22)]
            let boldString = NSMutableAttributedString(string:normalText, attributes:attrs)
            
            boldString.appendAttributedString(attributedString)
            return boldString
        }
       
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        self.debugUtil.printLog("selectItem", msg: "BEGIN")
        if tabBar.selectedItem!.title == "Companies" {
              //  let appDel = UIApplication.sharedApplication().delegate! as! AppDelegate
                vcCon.masterViewController.performSegueWithIdentifier("showCompanies", sender: nil)
            /*    if self.sharedDataModel.currentTransaction.transactionCompanies.count == 0 {
                    self.changeToAddCompanyVC()
                } else {
                    self.changeToMaterialityVC()
                }
              */  
        }
        
        else if tabBar.selectedItem!.title == "Contacts" {
                //  let appDel = UIApplication.sharedApplication().delegate! as! AppDelegate
                vcCon.masterViewController.performSegueWithIdentifier("showContacts", sender: nil)
                /*    if self.sharedDataModel.currentTransaction.transactionCompanies.count == 0 {
                self.changeToAddCompanyVC()
                } else {
                self.changeToMaterialityVC()
                }
                */
        }
        
        else
        {
            vcCon.masterNavigationController.popToRootViewControllerAnimated(true)
        }
        
        self.debugUtil.printLog("selectItem", msg: "selected Index " + String(self.selectedIndex))
        self.debugUtil.printLog("selectItem", msg: "END")
    
    }
    /*
    func hideController() {
        let selfHeight:CGFloat = 40
        //shrink container
        self.headerContainerView.hidden = true
        self.headerNoShowContainerView.hidden = false
        self.addCompaniesContainerView.transform = CGAffineTransformMakeTranslation(0, -selfHeight)
        self.companiesContainerView.transform = CGAffineTransformMakeTranslation(0, -selfHeight)
        self.transactionDetailContainerView.transform = CGAffineTransformMakeTranslation(0, -selfHeight)
        self.businessSelectionContainerView.transform = CGAffineTransformMakeTranslation(0, -selfHeight)
        self.contactsContainerView.transform = CGAffineTransformMakeTranslation(0, -selfHeight)
        self.summaryContainerView.transform = CGAffineTransformMakeTranslation(0, -selfHeight)
        
        let bounds = contactsContainerView.bounds
        let smallFrame = CGRectInset(contactsContainerView.frame, contactsContainerView.frame.size.width / 4, contactsContainerView.frame.size.height / 4)
        let finalFrame = CGRectOffset(smallFrame, 0, bounds.size.height)
        
        //  UIView.animateWithDuration(appAttributes.fadeInDuration, delay: 0.0, options: .CurveEaseOut, animations:{self.companiesContainerView.transform = CGAffineTransformMakeTranslation(0, -selfHeight)}, completion: nil)
        self.headerHidden = true
        
    }
    func showController() {
        let selfHeight:CGFloat = 40
        //expand container
        self.headerContainerView.hidden = false
        self.headerNoShowContainerView.hidden = true
        self.addCompaniesContainerView.transform = CGAffineTransformMakeTranslation(0, 0)
        self.companiesContainerView.transform = CGAffineTransformMakeTranslation(0, 0)
        self.transactionDetailContainerView.transform = CGAffineTransformMakeTranslation(0, 0)
        self.businessSelectionContainerView.transform = CGAffineTransformMakeTranslation(0, 0)
        self.contactsContainerView.transform = CGAffineTransformMakeTranslation(0, 0)
        self.summaryContainerView.transform = CGAffineTransformMakeTranslation(0, 0)
        self.headerHidden = false
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: UIPopoverPresentationControllerDelegate {
    func showHeaderViewContainer(sender: UIBarButtonItem) {
      /*
        var popoverContent = embeddedHeaderViewController
//        popoverContent.preferredContentSize = CGSizeMake(1024,80)
        popoverContent.preferredContentSize = CGSizeMake(1024,800)
        
        var nav = popoverContent//UINavigationController(rootViewController: popoverContent)
//        nav.modalPresentationStyle = UIModalPresentationStyle.Popover
        nav.modalPresentationStyle = UIModalPresentationStyle.FullScreen
        var popover = nav.popoverPresentationController
        popover!.delegate = self
        popover!.sourceView = self.view
        //popover!.sourceRect = CGRectMake(0,-50,50,-80)
        popover!.sourceRect = CGRectMake(0,-50,50,-80)

        self.presentViewController(nav, animated: true, completion: nil)
*/
        self.performSegueWithIdentifier("showDealSummary", sender: self)
        //show the modal for deal summary
        
        
    }
}
extension UIImage {
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext() as CGContextRef!
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        
        let rect = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
        CGContextClipToMask(context, rect, self.CGImage)
        tintColor.setFill()
        CGContextFillRect(context, rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
