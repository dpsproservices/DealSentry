//
//  TransactionFilterTableViewController.swift
//

import UIKit

class TransactionFilterTableViewController: UITableViewController {
    var debugUtil = DebugUtility(thisClassName: "TransactionFilterTVC", enabled: false)
    let sharedDataModel = SharedDataModel.sharedInstance
    let appAttributes = AppAttributes()

    var detailViewController: DetailViewController!
    let sectionTitles = ["", "Active", "Archived", "  "]
    let cats = ["All", "Draft", "Pending Review", "Cleared", "Completed", "Terminated", "Fatal Conflicts", "Duplicate", "Template"]
    let appImgs = ["opened_folder", "create_new", "data_pending", "ok", "checkeredflag", "final_state", "cancel_2", "copy", "document"]

    class FilterDataCell: NSObject {
        var dealStr: String = ""
        var countStr: String = ""
        var isBold: Bool = false
    }
    var sections = [TableData]()
    struct TableData {
        var data = [FilterDataCell]()
    }
    func initData() {
        
        var sect:TableData =  TableData()
        
        
        sect.data.append(getCatCell(0))
        self.sections.append(sect)
        
        
        sect = TableData()
        sect.data.append(getCatCell(1))
        sect.data.append(getCatCell(2))
        sect.data.append(getCatCell(3))
        self.sections.append(sect)
        
        sect = TableData()
        sect.data.append(getCatCell(4))
        sect.data.append(getCatCell(5))
        sect.data.append(getCatCell(6))
        sect.data.append(getCatCell(7))
        self.sections.append(sect)
        
        sect = TableData()
        sect.data.append(getCatCell(8))
        self.sections.append(sect)
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTitles[section]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func getCatCell(index : Int) -> FilterDataCell {
        let catLabel:FilterDataCell = FilterDataCell()
        var str = ""
        var countStr = ""
        var isBold = false
        str = cats[index]
        if self.sharedDataModel.getTransactionCountByCategory(cats[index]) > 0 {
            if index != 8 {
                countStr +=  " (" + String(self.sharedDataModel.getTransactionCountByCategory(cats[index])) + ")"
            }
            isBold = true
        }
        catLabel.dealStr = str
        catLabel.countStr = countStr
        catLabel.isBold = isBold
        return catLabel
    }
    
    /// this will launch the appropriate category of transactionStatuses
    /// - Parameter indexPath: selected row in tableview
    func launchDeal(indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            self.sharedDataModel.prepareTransactionListModel(cats[0])
        } else if indexPath.section == 1 && indexPath.row == 0 {
            self.sharedDataModel.prepareTransactionListModel(cats[1])
        } else if indexPath.section == 1 && indexPath.row == 1 {
            self.sharedDataModel.prepareTransactionListModel(cats[2])
        } else if indexPath.section == 1 && indexPath.row == 2 {
            self.sharedDataModel.prepareTransactionListModel(cats[3])
        } else if indexPath.section == 2 && indexPath.row == 0 {
            self.sharedDataModel.prepareTransactionListModel(cats[4])
        } else if indexPath.section == 2 && indexPath.row == 1 {
            self.sharedDataModel.prepareTransactionListModel(cats[5])
        } else if indexPath.section == 2 && indexPath.row == 2 {
            self.sharedDataModel.prepareTransactionListModel(cats[6])
        } else if indexPath.section == 2 && indexPath.row == 3 {
            self.sharedDataModel.prepareTransactionListModel(cats[7])
        } else if indexPath.section == 3 && indexPath.row == 0 {
            self.sharedDataModel.prepareTransactionListModel(cats[8])
        }
        if sharedDataModel.selectedTransactionArray.count > 0 {
            
        
            self.detailViewController.vcCon.masterViewController.tableView.reloadData()
            //select a default row
            
            self.detailViewController.vcCon.masterViewController.reselectLastSelectedRow()
            self.detailViewController.vcCon.masterViewController.performSegueWithIdentifier("showQuestionaire", sender: self)
            self.detailViewController.vcCon.masterViewController.setNavigationItemTitle()
        }
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return sections[section].data.count
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TransactionFilterTableViewCell", forIndexPath: indexPath) as! TransactionFilterTableViewCell
        let cellTxn = sections[indexPath.section].data[indexPath.row]
        if (cellTxn.isBold) {
            cell.dealTypeLabel.text = cellTxn.dealStr
            cell.dealTypeLabel.font = UIFont.boldSystemFontOfSize(20.0)

            cell.dealCount.text = cellTxn.countStr
            cell.dealCount.font = UIFont.boldSystemFontOfSize(20.0)
          //  if cellTxn.dealStr == self.cats[1] {//Draft
           //     cell.dealCount.textColor = UIColor(CGColor: appAttributes.colorOcean)
          //  } else {
                cell.dealCount.textColor = UIColor(CGColor: appAttributes.colorOcean)
          //  }
        } else {
            cell.dealTypeLabel.text = cellTxn.dealStr
            cell.dealTypeLabel.font = UIFont.systemFontOfSize(17.0)
            cell.dealCount.text = ""
        }
        
        //Now style the type of folder
        if cellTxn.dealStr == self.cats[0] {// All
            cell.folderIconView.image = UIImage( named: appImgs[0] + ".png")
            cell.folderIconView.highlightedImage = UIImage( named: appImgs[0] + "_filled.png")
        } else if cellTxn.dealStr == self.cats[1] {//Draft
            cell.folderIconView.image = UIImage( named: appImgs[1] + ".png")
            cell.folderIconView.highlightedImage = UIImage( named: appImgs[1] + "_filled.png")
        } else if cellTxn.dealStr == self.cats[2] {// Pending
            cell.folderIconView.image = UIImage( named: appImgs[2] + ".png")
            cell.folderIconView.highlightedImage = UIImage( named: appImgs[2] + "_filled.png")
        } else if cellTxn.dealStr == self.cats[3] {// Cleared
            cell.folderIconView.image = UIImage( named: appImgs[3] + ".png")
            cell.folderIconView.highlightedImage = UIImage( named: appImgs[3] + "_filled.png")
        } else if cellTxn.dealStr == self.cats[4] {// Completed
            cell.folderIconView.image = UIImage( named: appImgs[4] + ".png")
            cell.folderIconView.highlightedImage = UIImage( named: appImgs[4] + "_filled.png")
        } else if cellTxn.dealStr == self.cats[5] {// Terminated
            cell.folderIconView.image = UIImage( named: appImgs[5] + ".png")
            cell.folderIconView.highlightedImage = UIImage( named: appImgs[5] + "_filled.png")
        } else if cellTxn.dealStr == self.cats[6] {// Fatal Conflict
            cell.folderIconView.image = UIImage( named: appImgs[6] + ".png")
            cell.folderIconView.highlightedImage = UIImage( named: appImgs[6] + "_filled.png")
        } else if cellTxn.dealStr == self.cats[7] {// Duplicate
            cell.folderIconView.image = UIImage( named: appImgs[7] + ".png")
            cell.folderIconView.highlightedImage = UIImage( named: appImgs[7] + "_filled.png")
        } else if cellTxn.dealStr == self.cats[8] {// Template
            cell.folderIconView.image = UIImage( named: appImgs[8] + ".png")
            cell.folderIconView.highlightedImage = UIImage( named: appImgs[8] + "_filled.png")
        }
        if let image = cell.folderIconView.image {
            cell.folderIconView.image = image.imageWithColor(UIColor(CGColor: appAttributes.colorOcean)).imageWithRenderingMode(.AlwaysOriginal)
        }
        if let image = cell.folderIconView.highlightedImage {
            cell.folderIconView.highlightedImage = image.imageWithColor(UIColor(CGColor: appAttributes.colorOcean)).imageWithRenderingMode(.AlwaysOriginal)
        }
        return cell
    }

    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        //
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //
        debugUtil.printLog("didSelectRowIndexPath", msg: "BEGIN")
        debugUtil.printLog("didSelectRowIndexPath", msg: String(indexPath.section)  + " " + String(indexPath.row))
        debugUtil.printLog("didSelectRowIndexPath", msg: "END")
        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! TransactionFilterTableViewCell
        if(cell.dealCount.text != "")
        {
            self.launchDeal(indexPath)
        }
        else
        {
            if(cell.dealTypeLabel.text == "Template")
            {
                self.launchDeal(indexPath)
            }
            else
            {
                tableView.deselectRowAtIndexPath(indexPath, animated:true)
            }
        }
    }

}
