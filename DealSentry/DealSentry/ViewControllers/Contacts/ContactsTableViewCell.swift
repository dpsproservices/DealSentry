//
//  ContactsTableViewCell.swift
//  truemobile
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    
    var debugUtil = DebugUtility(thisClassName: "ContactsTableViewCell", enabled: false)
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactBackgroundView: UIView!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
       
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
