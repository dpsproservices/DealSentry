//
// ContactsSearchTableViewCell.swift
//  DealSentry
//
//  Created by Temp on 4/27/15.
//  Copyright (c) 2015 . All rights reserved.

import UIKit

class ContactsSearchTableViewCell: UITableViewCell {
    
    var debugUtil = DebugUtility(thisClassName: "ContactsSearchTableViewCell", enabled: false)
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var gocDescriptionLabel: UILabel!
    
    
    
    
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
