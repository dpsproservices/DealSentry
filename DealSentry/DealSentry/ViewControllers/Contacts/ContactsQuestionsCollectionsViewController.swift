//
//  ContactsQuestionsTableViewController.swift
//  truemobile
//
//  Created by ed on 4/28/15.
//  Copyright (c) 2015 . All rights reserved.
//

import UIKit

class ContactsQuestionsCollectionsViewController: UICollectionViewController {
    var debugUtil = DebugUtility(thisClassName: "ContactsQuestionsTableViewController",enabled: false)
    
    var viewForDealSummary1:UIView = UIView()
    var agreementDescriptionLabel:UILabel = UILabel()
    let sharedDataModel = SharedDataModel.sharedInstance
    var detailViewController: DetailViewController!
    let appAttributes = AppAttributes()
    var contactSearchtableViewController : ContactsSearchTableViewController!
    var contactsTableViewController: ContactsTableViewController!
    @IBOutlet weak var noContactsLabel: UILabel!
    var currentContactIndex = 0
    var contactRolesArrayForContact = [ContactRoleData]()
    var selectedContact: TransactionContactData!
    var rolePicker: PopTextPicker?
    var collectionViewSelectedIndex = 0
    var sponsorMDImgWarning: Bool = false
    var crossSellImgWarning: Bool = false
    var deleteButtonClicked = "NO"
    var defaultRowSelected = "NO"
    var searchControllerActive = "NO"
    var addAgreementButton:UIButton = UIButton()

    //var toolBarCustom:UIToolbar = UIToolbar()
    
    
    ///this method is invoked only when user wants to delete a contact from transaction. delete button triggers this method and it is shown only if the user collapses the left side view.
    /// - Parameter sender: this paramater ensures that this method will be invoked only using button
     func deleteContactAction(sender: UIButton) {
        
        var contactName = ""
        
        if sharedDataModel.checkForCollapseButton == "YES"
        {
            let lastSelectedIndexPath1 = NSIndexPath(forRow: currentContactIndex, inSection: 0)
            [self.collectionView(self.collectionView!, didDeselectItemAtIndexPath: lastSelectedIndexPath1)]
            let lastSelectedIndexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
            collectionViewSelectedIndex = sender.tag
            [self.collectionView(self.collectionView!, didSelectItemAtIndexPath: lastSelectedIndexPath)]
            deleteButtonClicked = "YES"
            
            contactName = self.sharedDataModel.currentTransaction.transactionContacts[sender.tag].contact.firstName + " " + self.sharedDataModel.currentTransaction.transactionContacts[sender.tag].contact.lastName
            
            let alert = UIAlertController(title: "Delete Contact" , message: "Deleting company " + " Are you certain you wish to delete " + contactName + " from the deal team?", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            alert.addAction(UIAlertAction(title: "Delete", style: .Default, handler: { action in
                switch action.style{
                case .Default:
                    
                    
                        self.sharedDataModel.currentTransaction.transactionContacts.removeAtIndex(sender.tag)
                        self.contactsTableViewController.contactsArrayForSearch = [ContactData]()
                        self.contactsTableViewController.getContactFromCurrentTransaction()
                        self.contactsTableViewController.tableView.reloadData()
                        if sender.tag == self.currentContactIndex {
                            //set new row as the first row
                            self.contactsTableViewController.setSelectedRow(0)
                            self.contactsTableViewController.reselectRow()
                            
                            
                        } else {
                            //this else condition is when row is selected already but did not delete that row.
                            //lets reset the selected row
                            //there are two cases.
                            //1.  the row index is before delete
                            //2.  the row index is after delete
                            if self.currentContactIndex > sender.tag {
                                self.contactsTableViewController.setSelectedRow(self.currentContactIndex - 1)
                            } else {
                                self.contactsTableViewController.setSelectedRow(self.currentContactIndex)
                            }
                            self.contactsTableViewController.reselectRow()
                        }
                    
                    self.collectionView!.reloadData()
                    
                case .Cancel:
                    print("cancel")
                    
                case .Destructive:
                    print("destructive")
                }
            }))

        }
    }
    
    ///this method is invoked only when user wants to select a contact as cross sell designee for a transaction. if the left side view is collapsed then all contacts will be shown and changes made accordingly based on selection. if not, then only single contact will be shown in the right hand side and changes will be affected
    /// - Parameter sender: this paramater ensures that this method will be invoked only using button
    
    @IBAction func crossSellButtonTouchAction(sender: UIButton) {
      /*
        var v : UICollectionReusableView! = nil
        v = collectionView!.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier:"ContactsHeader", forIndexPath:NSIndexPath(forRow: 0, inSection: 0)) as! UICollectionReusableView
        let img1 = v.subviews[0] as! UIImageView
        let lab1 = v.subviews[1] as! UILabel
*/
        
        if sharedDataModel.checkForCollapseButton == "YES"
        {
            let lastSelectedIndexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
            collectionViewSelectedIndex = sender.tag
            [self.collectionView(self.collectionView!, didSelectItemAtIndexPath: lastSelectedIndexPath)]
            
        }
        if  !sender.selected {
            
            var indexForCurrentCrossSellDesignee = -1
            var designeeName = ""
            for contactDataForCrossSellDesignee in self.sharedDataModel.currentTransaction.transactionContacts
            {
                indexForCurrentCrossSellDesignee = indexForCurrentCrossSellDesignee + 1
                if contactDataForCrossSellDesignee.contact.crossSellDesignee
                {
                    designeeName = contactDataForCrossSellDesignee.contact.firstName + " " + contactDataForCrossSellDesignee.contact.lastName
                    break
                }
            }
            
            if designeeName.isEmpty
            {
                sender.selected = true
                if sharedDataModel.checkForCollapseButton == "YES"
                {
                    collectionViewSelectedIndex = sender.tag
                    self.sharedDataModel.currentTransaction.transactionContacts[collectionViewSelectedIndex].contact.crossSellDesignee = true
                    self.crossSellImgWarning = false
                    
                    self.selectedContact = self.sharedDataModel.currentTransaction.transactionContacts[collectionViewSelectedIndex]
                    self.contactsTableViewController.tableView.reloadData()
                    let lastSelectedIndexPath = NSIndexPath(forRow: self.collectionViewSelectedIndex, inSection: 0)
                    self.contactsTableViewController.tableView.selectRowAtIndexPath(lastSelectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
                    self.collectionView!.reloadData()
                }
                else
                {
                    self.selectedContact.contact.crossSellDesignee = true
                    self.crossSellImgWarning = false
                    
                    self.contactsTableViewController.tableView.reloadData()
                    let lastSelectedIndexPath = NSIndexPath(forRow: self.sharedDataModel.currentTransaction.currentTransactionContactIndex, inSection: 0)
                    self.contactsTableViewController.tableView.selectRowAtIndexPath(lastSelectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
                    self.collectionView!.reloadData()
                }
                
            }
            
            else
            {
                let alert = UIAlertController(title: "Cross Sell Designee", message: designeeName + " is currently the cross sell designee. Designate this deal team member instead?", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                    switch action.style{
                    case .Default:
                        
                        sender.selected = true
                        self.sharedDataModel.currentTransaction.transactionContacts[indexForCurrentCrossSellDesignee].contact.crossSellDesignee = false
                        
                        if self.sharedDataModel.checkForCollapseButton == "YES"
                        {
                            self.collectionViewSelectedIndex = sender.tag
                            self.sharedDataModel.currentTransaction.transactionContacts[self.collectionViewSelectedIndex].contact.crossSellDesignee = true
                            self.crossSellImgWarning = false
                            self.selectedContact = self.sharedDataModel.currentTransaction.transactionContacts[self.collectionViewSelectedIndex]
                            self.contactsTableViewController.tableView.reloadData()
                            let lastSelectedIndexPath = NSIndexPath(forRow: self.collectionViewSelectedIndex, inSection: 0)
                            self.contactsTableViewController.tableView.selectRowAtIndexPath(lastSelectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
                            self.collectionView!.reloadData()
                        }
                        else
                        {
                            self.selectedContact.contact.crossSellDesignee = true
                            self.crossSellImgWarning = false
                            
                            self.contactsTableViewController.tableView.reloadData()
                            let lastSelectedIndexPath = NSIndexPath(forRow: self.sharedDataModel.currentTransaction.currentTransactionContactIndex, inSection: 0)
                            self.contactsTableViewController.tableView.selectRowAtIndexPath(lastSelectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
                            self.collectionView!.reloadData()
                        }
                        
                    case .Cancel:
                        print("cancel")
                        
                    case .Destructive:
                        print("destructive")
                    }
                }))
            }

            
        } else {
            sender.selected = false

            if sharedDataModel.checkForCollapseButton == "YES"
            {
                collectionViewSelectedIndex = sender.tag
                self.sharedDataModel.currentTransaction.transactionContacts[collectionViewSelectedIndex].contact.crossSellDesignee = false
                self.crossSellImgWarning = true
                self.selectedContact = self.sharedDataModel.currentTransaction.transactionContacts[self.collectionViewSelectedIndex]
                self.contactsTableViewController.tableView.reloadData()
                let lastSelectedIndexPath = NSIndexPath(forRow: self.collectionViewSelectedIndex, inSection: 0)
                self.contactsTableViewController.tableView.selectRowAtIndexPath(lastSelectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
                self.collectionView!.reloadData()
            }
            else
            {
                self.selectedContact.contact.crossSellDesignee = false
                self.crossSellImgWarning = true
                
                self.contactsTableViewController.tableView.reloadData()
                let lastSelectedIndexPath = NSIndexPath(forRow: self.sharedDataModel.currentTransaction.currentTransactionContactIndex, inSection: 0)
                self.contactsTableViewController.tableView.selectRowAtIndexPath(lastSelectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
                self.collectionView!.reloadData()
            }
            
        }
        
        
        
    }

    ///this method is invoked only when user wants to select a role for a particular contact
    /// - Parameter sender: this paramater ensures that this method will be invoked only using button
    @IBAction func avatarRoleAction(sender: UIButton) {
        self.debugUtil.printLog("avatar", msg: "BEGIN")
        self.debugUtil.printLog("avatar", msg: String(sender.tag))
            self.contactRolesArrayForContact = self.sharedDataModel.contactRolesArray
            checkForRequestor()
        if sharedDataModel.checkForCollapseButton == "YES"
        {
            let lastSelectedIndexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
            collectionViewSelectedIndex = sender.tag
            [self.collectionView(self.collectionView!, didSelectItemAtIndexPath: lastSelectedIndexPath)]
        }

        
            let roleTxt = sender.superview?.subviews[1] as! UITextField
            
            var contactRole = self.contactRolesArrayForContact.map { (ContactRoleData) -> String in
                return ContactRoleData.roleDescription
            }
            contactRole = contactRole.sort({ $0 < $1 })
        
            self.rolePicker = PopTextPicker(forTextField: roleTxt, pickerItemsArray: contactRole)
            self.rolePicker?.delegate = self
            
            roleTxt.resignFirstResponder()
            
            let initText: String? = roleTxt.text
            
            self.rolePicker!.setSelection(initText!)
            
            let dataChangedCallback: PopTextPicker.PopTextPickerCallback = { (newText: String, forTextField: UITextField) -> () in
                // here we don't use self (no retain cycle)
                roleTxt.text = newText as String
            }
            self.rolePicker!.pick(self, dataChanged: dataChangedCallback)
        self.debugUtil.printLog("avatar", msg: "END")
    }
    // called by popup unwind segue
    

   
//    @IBAction func deleteContactAction(sender: UIBarButtonItem) {
//        
//        if selectedContact.count >= 1 {
//        
//            //show alert view "are you sure?"
//            
//            
//            var selectedIndexPath = self.collectionView?.indexPathsForSelectedItems()
//        
//            var selectedIndex = selectedIndexPath
//            if (selectedIndex != nil) {
//       //         self.sharedDataModel.currentTransaction.transactionContacts.removeAtIndex(selectedIndex)
//                self.collectionView!.reloadData()
//            }
//            self.deleteButton.enabled = false
//
//        } else {
//            //show  alert view "no contacts"
//
//        }
//        
//    }
//    func deleteContactFromIconAction(sender: UIBarButtonItem) {
//        var selectedIndexPath = self.collectionView!.indexPathsForSelectedItems()
//        
//        self.sharedDataModel.currentTransaction.transactionContacts.removeAtIndex(sender.tag)
//        self.collectionView!.reloadData()
// //       self.deleteButton.enabled = false
//
//    }
    
    ///this method provides data from the object to the view controller
    func initHeaderMsg() {
        
        agreementDescriptionLabel.attributedText = changeStringToBold("Contacts",textBold:"")
        
        if selectedContact == nil
        {
            selectedContact = self.sharedDataModel.currentTransaction.transactionContacts[self.sharedDataModel.currentTransaction.currentTransactionContactIndex]
        }

        var sponsFound:Bool = false
        var crossFound:Bool = false
            if selectedContact.contact.crossSellDesignee && !crossFound{
                crossFound = true
            }
            if (selectedContact.role == "Sponsoring MD" && !sponsFound) {
                sponsFound = true
            }

        if crossFound == true {
            crossSellImgWarning = false
        } else if self.sharedDataModel.currentTransaction.transactionDetail.product == "M&A" {
            crossSellImgWarning = true
        }
        if sponsFound == true {
            sponsorMDImgWarning = false
        } else {
            sponsorMDImgWarning = true
        }
        self.collectionView?.setNeedsDisplay()

    }
    
    ///this method pops up the contact search controller to choose contact from the list. if its a DDT restricted transaction then an alert will be thrown to inform the user that THEY CANT ADD CONTACT FOR THIS TRANSACTION
    /// - Parameter sender: this paramater ensures that this method will be invoked only using button
    func addContactAction(sender: UIButton) {
        
        if self.sharedDataModel.currentTransaction.ddtRestriction == "Yes"
        {
            let alert = UIAlertController(title: "DDT Restriction", message: "Ring fenced transaction.Additions to the deal team can only be done by contacting your local Control Group", preferredStyle: UIAlertControllerStyle.Alert)
            
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
        }
        else
        {
            self.performSegueWithIdentifier("addContactsSegue", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // self.debugUtil.printLog("prepareForSegue", msg: "BEGIN")
        
        if let segueId = segue.identifier {
            //    self.debugUtil.printLog("prepareForSegue", msg: "segueId = " + segueId)
            
            switch segueId {
                
            case "addContactsSegue" :
                let navigationController = segue.destinationViewController as! UINavigationController
                self.contactSearchtableViewController = navigationController.topViewController as! ContactsSearchTableViewController
            default:
                break
            }
            
        }
        
        //  self.debugUtil.printLog("prepareForSegue", msg: "END")
    }
    
    
    @IBAction func dismissSearchContactsView(unwindSeque: UIStoryboardSegue ){
        self.debugUtil.printLog("dismissSearchContactsView", msg: "BEGIN")
        if !self.sharedDataModel.currentTransaction.transactionContacts.isEmpty {
            
            // toggle to company questions tab
            
            self.contactsTableViewController.contactsArrayForSearch = [ContactData]()
            self.contactsTableViewController.currentContactIndex = self.sharedDataModel.currentTransaction.currentTransactionContactIndex
            currentContactIndex = self.contactsTableViewController.currentContactIndex

            self.contactsTableViewController.getContactFromCurrentTransaction()
            self.contactsTableViewController.tableView.reloadData()
            self.contactsTableViewController.setSelectedRow(currentContactIndex)
            self.contactsTableViewController.reselectRow()
            self.collectionView!.reloadData()
            
            let lastSelectedIndexPath = NSIndexPath(forRow: currentContactIndex, inSection: 0)
            self.collectionView?.selectItemAtIndexPath(lastSelectedIndexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.CenteredVertically)

            
            //            self.handleEditButtonState()
            //            self.handleDeleteButtonState()
        }
        self.debugUtil.printLog("dismissSearchContactsView", msg: "END")
    }
    
    override func viewWillAppear(animated: Bool) {
        checkForOrientationChange()
        //showToolBar()
        initHeaderMsg()
        self.collectionView!.reloadData()
        self.appAttributes.animateCollection(self.collectionView!)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "methodOfReceivedNotification:", name:"NotificationIdentifier", object: nil)
        notificationCheck()
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "NotificationIdentifier", object: nil)
        
    }
    
//    func showToolBar()
//    {
//        toolBarCustom.frame = CGRectMake( 0,  self.view.bounds.size.height - 44 ,  self.view.bounds.size.width, 44.00)
//        toolBarCustom.autoresizingMask = [.FlexibleWidth, .FlexibleBottomMargin]
//        self.view.addSubview(toolBarCustom)
//        
//        
//        var flexibleBarButton: UIBarButtonItem{
//            return UIBarButtonItem( barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
//        }
//        
//        var barButton1: UIBarButtonItem{
//            return UIBarButtonItem(
//                image: nil,
//                //title: "(+)",
//                style: UIBarButtonItemStyle.Plain,
//                target: self,
//                action: nil
//            )
//        }
//        
//        var barButton: UIBarButtonItem{
//            return UIBarButtonItem(
//                image: UIImage(named:"add_user_white.png"),
//                //title: "(+)",
//                style: UIBarButtonItemStyle.Done,
//                target: self,
//                action: "addContactAction:"
//            )
//        }
//        
//        let toolBarItems = [barButton1,flexibleBarButton, barButton]
//        toolBarCustom.setItems(toolBarItems, animated: true)
//    }
    
    func checkForOrientationChange()
    {
        if sharedDataModel.checkForOrientationChange == "landscape"
        {
            if sharedDataModel.checkForCollapseButton == "YES"
            {
                self.agreementDescriptionLabel.frame = CGRectMake(viewForDealSummary1.frame.origin.x , agreementDescriptionLabel.frame.origin.y, agreementDescriptionLabel.frame.size.width, agreementDescriptionLabel.frame.size.height)
                addAgreementButton.frame = CGRectMake( 800,  15,  22, 22)
            }
           
        }
        else
        {
            if sharedDataModel.checkForCollapseButton == "YES"
            {
                self.agreementDescriptionLabel.frame = CGRectMake(viewForDealSummary1.frame.origin.x - 150, agreementDescriptionLabel.frame.origin.y, agreementDescriptionLabel.frame.size.width, agreementDescriptionLabel.frame.size.height)
                addAgreementButton.frame = CGRectMake( 650,  15,  22, 22)

            }
        }
        
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue
        {
            if sharedDataModel.checkForCollapseButton == "YES"
            {
                self.agreementDescriptionLabel.frame = CGRectMake(viewForDealSummary1.frame.origin.x , agreementDescriptionLabel.frame.origin.y, agreementDescriptionLabel.frame.size.width, agreementDescriptionLabel.frame.size.height)
                addAgreementButton.frame = CGRectMake( 800,  15,  22, 22)
            }
           
        }
        else
        {
            if sharedDataModel.checkForCollapseButton == "YES"
            {
                self.agreementDescriptionLabel.frame = CGRectMake(viewForDealSummary1.frame.origin.x - 150, agreementDescriptionLabel.frame.origin.y, agreementDescriptionLabel.frame.size.width, agreementDescriptionLabel.frame.size.height)
                addAgreementButton.frame = CGRectMake( 650,  15,  22, 22)

            }
            
        }
        
    }

    override func viewDidLoad() {
        self.debugUtil.printLog("viewDidLoad", msg: "BEGIN")

        super.viewDidLoad()
        //
        let width  = 1100.0
        
        viewForDealSummary1.frame = CGRectMake( -5,  36,  CGFloat (width), 45.00)
        viewForDealSummary1.backgroundColor = UIColor(CGColor: appAttributes.colorOcean)
        self.view.addSubview(viewForDealSummary1)
        
        agreementDescriptionLabel.frame = CGRectMake( 250,  10,  CGFloat (width), 30.00)
        
        agreementDescriptionLabel.textColor = UIColor.whiteColor()
        agreementDescriptionLabel.textAlignment = NSTextAlignment.Natural
        agreementDescriptionLabel.font = UIFont(name: agreementDescriptionLabel.font.fontName, size: 15)
        viewForDealSummary1.addSubview(agreementDescriptionLabel)
        
        addAgreementButton = UIButton(type: UIButtonType.System)
        addAgreementButton.frame = CGRectMake( 800,  15,  22, 22)
        let image = UIImage(named: "add_user_filled")
        addAgreementButton.setImage(image, forState: .Normal)
        addAgreementButton.addTarget(self, action: "addContactAction:", forControlEvents: .TouchUpInside)
        viewForDealSummary1.addSubview(addAgreementButton)
        
        self.collectionView!.delegate = self
        self.collectionView!.dataSource = self
        //hides the empty gridlines at bottom of page
        //self.tableView.tableFooterView = UIView()
        self.rolePicker?.delegate = self
        self.handleDeleteButtonState()
        self.collectionView!.backgroundColor = appAttributes.colorBackgroundColor
        
        if sharedDataModel.currentTransaction.transactionStatus != "Draft" && sharedDataModel.currentTransaction.transactionStatus != "Pending Review" && sharedDataModel.currentTransaction.transactionStatus != "Cleared" && sharedDataModel.currentTransaction.transactionStatus != "Template"
        {
            addAgreementButton.userInteractionEnabled = false
        }
        
    }
    

    func changeStringToBold(normalText:String, textBold:String)->NSAttributedString
    {
        let attributedString = NSMutableAttributedString(string:textBold)
        
        if normalText == "Contacts"
        {
            let attrs = [NSFontAttributeName : UIFont.boldSystemFontOfSize(15)]
            let boldString = NSMutableAttributedString(string:normalText, attributes:attrs)
            boldString.appendAttributedString(attributedString)
            return boldString
        }
        else
        {
            let attrs = [NSFontAttributeName : UIFont.boldSystemFontOfSize(13)]
            let boldString = NSMutableAttributedString(string:normalText, attributes:attrs)
            boldString.appendAttributedString(attributedString)
            return boldString
            
        }
    }
    func notificationCheck()
    {
        
        var widthforScreen:CGFloat = 0.0
        
        //  var bounds = UIScreen.mainScreen().bounds
        let width  = 1100.0
        //  var height = bounds.size.height
        widthforScreen = CGFloat(width)
        //Take Action on Notification
        if sharedDataModel.checkForCollapseButton == "YES"
        {
            
            UIView.animateWithDuration(0.1, animations: {
                self.viewForDealSummary1.hidden = false
                let x = self.viewForDealSummary1.frame.origin.x
                let y = self.detailViewController.viewForDealSummary.frame.origin.y + 45
                let width = widthforScreen
                let height = self.viewForDealSummary1.frame.size.height
                
                let companyX = self.viewForDealSummary1.frame.origin.x
                let companyY = self.agreementDescriptionLabel.frame.origin.y
                let companyWidth =  self.agreementDescriptionLabel.frame.size.width
                let companyHeight = self.agreementDescriptionLabel.frame.size.height
                
                if self.sharedDataModel.checkForOrientationChange == "portrait"
                {
                    self.agreementDescriptionLabel.frame = CGRectMake(companyX - 150, companyY, companyWidth, companyHeight)
                    self.addAgreementButton.frame = CGRectMake( 650,  15,  22, 22)
                }
                else
                {
                    self.agreementDescriptionLabel.frame = CGRectMake(companyX, companyY, companyWidth, companyHeight)
                    self.addAgreementButton.frame = CGRectMake( 800,  15,  22, 22)
                }
                self.agreementDescriptionLabel.textAlignment = NSTextAlignment.Center
                
                
                
                self.viewForDealSummary1.frame = CGRectMake(x, y, width, height)
                self.viewForDealSummary1.backgroundColor = UIColor(CGColor: self.appAttributes.colorCyan)
                
            })
            //toolBarCustom.hidden = false
        }
        else
        {
            UIView.animateWithDuration(0.0, animations: {
                self.viewForDealSummary1.hidden = true
                let width = widthforScreen
                
                self.agreementDescriptionLabel.frame = CGRectMake( 150, 10,  width, 30.00)
                self.agreementDescriptionLabel.textAlignment = NSTextAlignment.Natural
            })
            self.sharedDataModel.currentTransaction.currentTransactionContactIndex = currentContactIndex
           // toolBarCustom.hidden = true
        }
        self.collectionView!.reloadData()
    }
    
    func methodOfReceivedNotification(notification: NSNotification){
        notificationCheck()
    }
    
    ///this method removes requestor from the picker as the user becomes the default requestor for the transaction
    func checkForRequestor()
    {
        var countForRequestor = -1
      //  var countForSponsoringMD = -1
        
        for contacRoleValue in self.sharedDataModel.currentTransaction.transactionContacts
        {
            if contacRoleValue.role == "Requestor"
            {
                for contactRoleValueInArray in contactRolesArrayForContact
                {
                    countForRequestor++
                    if contactRoleValueInArray.roleDescription == contacRoleValue.role
                    {
                        contactRolesArrayForContact.removeAtIndex(countForRequestor)
                        break
                    }
                }
            }
            
//            if contacRoleValue.role == "Sponsoring MD"
//            {
//                for contactRoleValueInArray in contactRolesArrayForContact
//                {
//                    countForSponsoringMD++
//                    if contactRoleValueInArray.roleDescription == contacRoleValue.role
//                    {
//                        contactRolesArrayForContact.removeAtIndex(countForSponsoringMD)
//                        break
//                    }
//                }
//            }
        }
        
        if countForRequestor == -1 /*&& countForSponsoringMD == -1*/
        {
            self.contactRolesArrayForContact = [ContactRoleData]()
            self.contactRolesArrayForContact = self.sharedDataModel.contactRolesArray
        }
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
    
    func handleDeleteButtonState(){
      //  let selectedIndexPath = self.collectionView?.indexPathsForSelectedItems()
        //let selectedIndex = selectedIndexPath
       }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  }
    // MARK: - Table view data source
extension ContactsQuestionsCollectionsViewController: PopTextPickerDelegate {
    func textDelegateCallBack(textField: UITextField) {
        if (textField.text == "Sponsoring MD") {
            sponsorMDImgWarning = false
           
        }
        //self.collectionView?.indexPathsForSelectedItems()
        if sharedDataModel.checkForCollapseButton == "YES"
        {
            self.sharedDataModel.currentTransaction.transactionContacts[collectionViewSelectedIndex].role = textField.text!
            self.selectedContact = self.sharedDataModel.currentTransaction.transactionContacts[self.collectionViewSelectedIndex]
            contactsTableViewController.tableView.reloadData()
            let lastSelectedIndexPath = NSIndexPath(forRow: self.collectionViewSelectedIndex, inSection: 0)
            contactsTableViewController.tableView.selectRowAtIndexPath(lastSelectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
            self.initHeaderMsg()
            self.collectionView!.reloadData()
        }
        else
        {
            self.selectedContact.role = textField.text!
            contactsTableViewController.tableView.reloadData()
            let lastSelectedIndexPath = NSIndexPath(forRow: self.sharedDataModel.currentTransaction.currentTransactionContactIndex, inSection: 0)
            contactsTableViewController.tableView.selectRowAtIndexPath(lastSelectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
            self.initHeaderMsg()
            self.collectionView!.reloadData()
        }
        
        self.debugUtil.printLog("textFieldBegin", msg: String(textField.tag))

    }
}
extension ContactsQuestionsCollectionsViewController: UITextFieldDelegate {
 /*   func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        self.rolePicker = PopTextPicker(forTextField: textField, pickerItemsArray: self.sharedDataModel.contactRolesArray)
        self.rolePicker?.delegate = self
     
        textField.resignFirstResponder()
        
        let initText: String? = textField.text
       
        self.rolePicker!.setSelection(initText!)
            
        let dataChangedCallback: PopTextPicker.PopTextPickerCallback = { (newText: String, forTextField: UITextField) -> () in
            // here we don't use self (no retain cycle)
            forTextField.text = newText as String
        }
        self.debugUtil.printLog("textFieldBeginEditing", msg: String(textField.tag))
        self.rolePicker!.pick(self, dataChanged: dataChangedCallback)
        self.debugUtil.printLog("textFieldBeginEditing", msg: String(textField.text))
        return false
            
      }*/
}
extension ContactsQuestionsCollectionsViewController {

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if sharedDataModel.checkForCollapseButton == "YES"
        {
            return sharedDataModel.currentTransaction.transactionContacts.count
        }
        else
        {
            return 1
        }

    }
    /*

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
   //     return self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
        return 85.0
    }
    */
    
//    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//        var v : UICollectionReusableView! = nil
//        if kind == UICollectionElementKindSectionHeader {
//            v = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier:"ContactsHeader", forIndexPath:indexPath) as! UICollectionReusableView
//            
//            let img1 = v.subviews[0] as! UIImageView
//            let lab1 = v.subviews[1] as! UILabel
//            lab1.text = "At least one Cross-Sell Designee is required"
//
//            if self.crossSellImgWarning {
//                img1.hidden = false
//                lab1.hidden = false
//            } else {
//                img1.hidden = true
//                lab1.hidden = true
//            
//            }
//
//            let img2 = v.subviews[2] as! UIImageView
//            let lab2 = v.subviews[3] as! UILabel
//            lab2.text = "At least one Sponsoring MD is required"
//
//            if self.sponsorMDImgWarning {
//                img2.hidden = false
//                lab2.hidden = false
//            } else {
//                img2.hidden = true
//                lab2.hidden = true
//                
//            }
//            
//
//        }
//        return v
//    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
       
        let index = String(indexPath.row)
        
        self.debugUtil.printLog("cellForRowAtIndexPath", msg: "BEGIN indexPath.row = " + index)


            //let cell2: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("ContactsQuestionsCollectionsViewCell", forIndexPath: indexPath) as! UICollectionViewCell
            
            let cell: ContactsQuestionsCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("ContactsQuestionCollectionsViewCell", forIndexPath: indexPath) as! ContactsQuestionsCollectionViewCell
            let cellContact:TransactionContactData!
            // var cellContact = self.sharedDataModel.selectedContactsArray[indexPath.row]
            if sharedDataModel.checkForCollapseButton == "YES"
            {
                cellContact = self.sharedDataModel.currentTransaction.transactionContacts[indexPath.row]
                cell.employeeBackgroundView.backgroundColor = UIColor(CGColor: appAttributes.colorCyan)

            }
            else
            {
                cellContact = self.selectedContact
                cell.employeeBackgroundView.backgroundColor = UIColor(CGColor: appAttributes.colorOcean)

            }
        
        if indexPath.row == currentContactIndex
        {
            cell.employeeBackgroundView.backgroundColor = UIColor(CGColor: appAttributes.colorOcean)
            defaultRowSelected = "YES"
        }
        else
        {
            if sharedDataModel.checkForCollapseButton == "NO"
            {
                cell.employeeBackgroundView.backgroundColor = UIColor(CGColor: appAttributes.colorOcean)
            }
            else
            {
                cell.employeeBackgroundView.backgroundColor = UIColor(CGColor: appAttributes.colorCyan)
            }
        }
            cell.nameLabel.text = cellContact.contact.firstName +  " " + cellContact.contact.lastName
        
        //    var bgLayer = appAttributes.getcolorSubTaskBackground()
          //  bgLayer.frame = cell.employeeBackgroundView.bounds
            //cell.employeeBackgroundView.layer.insertSublayer(bgLayer, atIndex: 0)

            cell.roleTextField.delegate = self
            cell.roleTextField.text = cellContact.role
            cell.roleTextField.tag = indexPath.row
            
            cell.gocDescriptionLabel.text = cellContact.contact.gocDescription
            cell.crossSellButton.tag = indexPath.row
            cell.emailLabel.text = cellContact.contact.email
            cell.telLabel.text = cellContact.contact.phone

            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: "deleteContactAction:", forControlEvents: .TouchUpInside)
        
        
            cell.avatarRoleButton.layer.borderWidth = appAttributes.textViewBorder
            cell.avatarRoleButton.layer.cornerRadius = appAttributes.textViewCornerRadius
            cell.avatarRoleButton.layer.borderColor = appAttributes.colorOcean
            cell.avatarRoleButton.tag = indexPath.row
        
            appAttributes.setColorAttributesButton(cell.crossSellButton)
            if (sharedDataModel.currentTransaction.transactionDetail.product == "M&A") {
                cell.crossSellButton.hidden = false
                if (cellContact.contact.crossSellDesignee) {
                    cell.crossSellButton.selected = true
                    cell.crossSellButton.backgroundColor = UIColor(CGColor: appAttributes.colorCyan)
                    cell.crossSellButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                    
                } else {
                    cell.crossSellButton.selected = false
                    cell.crossSellButton.backgroundColor = UIColor.whiteColor()
                    cell.crossSellButton.setTitleColor(UIColor(CGColor: appAttributes.colorCyan), forState: UIControlState.Normal)
                }

            } else {
                cell.crossSellButton.hidden = true
            }
            cell.crossSellButton.tag = indexPath.row
            
            self.debugUtil.printLog("cellForRowAtIndexPath", msg: "END")
            
            
            // Configure the cell...
            self.debugUtil.printLog("tableView index ", msg: String(indexPath.row))
            self.debugUtil.printLog("tableView count ", msg: String(self.sharedDataModel.currentTransaction.transactionContacts.count))

            
            
            cell.layer.borderColor = appAttributes.textViewBorderColor
            cell.layer.borderWidth = appAttributes.textViewBorder
            cell.layer.cornerRadius = appAttributes.textViewCornerRadius
            cell.backgroundColor = appAttributes.textBackgroundColor

            if sharedDataModel.currentTransaction.transactionStatus != "Draft" && sharedDataModel.currentTransaction.transactionStatus != "Pending Review" && sharedDataModel.currentTransaction.transactionStatus != "Cleared" && sharedDataModel.currentTransaction.transactionStatus != "Template"
            {
                cell.avatarRoleButton.userInteractionEnabled = false
                cell.roleTextField.userInteractionEnabled = false
                cell.crossSellButton.userInteractionEnabled = false
                cell.deleteButton.userInteractionEnabled = false
                cell.deleteButton.hidden = true
            }
        else
            {
                cell.avatarRoleButton.userInteractionEnabled = true
                cell.roleTextField.userInteractionEnabled = true
                cell.crossSellButton.userInteractionEnabled = true
                //cell.deleteButton.userInteractionEnabled = true
                //cell.deleteButton.hidden = false
        }
        
        if self.sharedDataModel.checkForCollapseButton == "YES"
        {
            if sharedDataModel.currentTransaction.transactionStatus != "Draft" && sharedDataModel.currentTransaction.transactionStatus != "Pending Review" && sharedDataModel.currentTransaction.transactionStatus != "Cleared" && sharedDataModel.currentTransaction.transactionStatus != "Template"
            {
                cell.deleteButton.userInteractionEnabled = false
                cell.deleteButton.hidden = true
            }
            else
            {
                cell.deleteButton.hidden = false
                cell.deleteButton.userInteractionEnabled = true
            }
        }
        else
        {
            cell.deleteButton.hidden = true
        }
        
        if  cellContact.role == "Requestor" || self.sharedDataModel.currentTransaction.ddtRestriction == "Yes"
        {
            cell.avatarRoleButton.userInteractionEnabled = false
            cell.roleTextField.userInteractionEnabled = false
            cell.deleteButton.hidden = true
            cell.deleteButton.userInteractionEnabled = false
        }
       
        
            return cell

            
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        self.debugUtil.printLog("didSelectRowAtIndexPath", msg: "BEGIN")
        let selectedIndexPath = self.collectionView?.indexPathsForSelectedItems()
        let selectedIndex = selectedIndexPath
        if (selectedIndex != nil){
            self.handleDeleteButtonState()
        }
        if sharedDataModel.checkForCollapseButton == "YES"
        {
            
            if deleteButtonClicked == "YES" || defaultRowSelected == "YES"
            {
                let lastSelectedIndexPath1 = NSIndexPath(forRow: currentContactIndex, inSection: 0)
                [self.collectionView(self.collectionView!, didDeselectItemAtIndexPath: lastSelectedIndexPath1)]
                deleteButtonClicked = "NO"
                defaultRowSelected = "NO"
            }
            
            let cell = self.collectionView?.cellForItemAtIndexPath(indexPath) as! ContactsQuestionsCollectionViewCell
            cell.employeeBackgroundView.backgroundColor = UIColor(CGColor: appAttributes.colorOcean)
            self.selectedContact = self.sharedDataModel.currentTransaction.transactionContacts[indexPath.row]
           // let lastSelectedIndexPath = NSIndexPath(forRow: self.collectionViewSelectedIndex, inSection: 0)
            if(searchControllerActive == "NO")
            {
                self.contactsTableViewController.tableView.reloadData()

                self.contactsTableViewController.tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
            }
            self.currentContactIndex = indexPath.row
           
        }
        
        self.debugUtil.printLog("didSelectRowAtIndexPath", msg: "END")
        

    }
    

    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        if sharedDataModel.checkForCollapseButton == "YES"
        {
         let paths = collectionView.indexPathsForVisibleItems()
        for indexPath in paths
        {

                let cell: ContactsQuestionsCollectionViewCell = self.collectionView?.cellForItemAtIndexPath(indexPath) as! ContactsQuestionsCollectionViewCell
                cell.employeeBackgroundView.backgroundColor = UIColor(CGColor: appAttributes.colorCyan)
        }
     
        }
    }
}


