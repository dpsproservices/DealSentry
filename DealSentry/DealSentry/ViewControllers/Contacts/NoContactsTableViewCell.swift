//
// NoCompaniesTableViewCell.swift
//

import UIKit

class NoCompaniesTableViewCell: UITableViewCell {
    
    var debugUtil = DebugUtility(thisClassName: "NoCompaniesTableViewCell", enabled: false)
   
    override func awakeFromNib() {
        debugUtil.printLog("awakeFromNib", msg: "BEGIN")
        super.awakeFromNib()
        // Initialization code
        debugUtil.printLog("awakeFromNib", msg: "END")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        debugUtil.printLog("setSelected", msg: "BEGIN")
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        debugUtil.printLog("setSelected", msg: "END")
    }

}
