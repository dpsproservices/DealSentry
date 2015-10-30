//
//  SortFilterTxnTableViewCell.swift
//

import UIKit

class SortFilterTxnTableViewCell: UITableViewCell {
    
    var debugUtil = DebugUtility(thisClassName: "SortFilterTxnTableViewCell", enabled: false)

    @IBOutlet weak var sortByButton: UIButton!
    
    @IBOutlet weak var sortDirectionButton: UIButton!

    //@IBOutlet weak var contentView: UIView!
    override func awakeFromNib() {
        debugUtil.printLog("awakeFromNib", msg: "BEGIN")
        super.awakeFromNib()
        // Initialization code

        //self.sortByButton.titleLabel?.text = "By Date"
        //self.sortDirectionButton.titleLabel?.text = "▽"
        
        debugUtil.printLog("awakeFromNib", msg: "END")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        //debugUtil.printLog("setSelected", msg: "BEGIN")

        //debugUtil.printLog("setSelected", msg: "selected = " + selected.description )
        
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        //debugUtil.printLog("setSelected", msg: "END")
    }
    
}
