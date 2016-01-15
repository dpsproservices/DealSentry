//
//  ContactsQuestionsTableViewCell.swift
//  DealSentry
//
//  Created by Temp on 4/27/15.
//  Copyright (c) 2015 . All rights reserved.
//
import UIKit

class ContactsQuestionsCollectionViewCell: UICollectionViewCell {
    
    var debugUtil = DebugUtility(thisClassName: "ContactsQuestionsTableViewCell", enabled: false)
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var roleTextField: UITextField!
    @IBOutlet weak var departmentLabel: UILabel!
    
    @IBOutlet weak var employeeBackgroundView: UIView!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    @IBOutlet weak var crossSellButton: UIButton!
    @IBOutlet weak var crossSellSwitch: UISwitch!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var avatarRoleButton: UIButton!
    override func awakeFromNib() {
        debugUtil.printLog("awakeFromNib", msg: "BEGIN")
        super.awakeFromNib()
        // Initialization code
        
        debugUtil.printLog("awakeFromNib", msg: "END")
    }
   /*
    override func setSelected(selected: Bool, animated: Bool) {
        debugUtil.printLog("setSelected", msg: "BEGIN")
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        debugUtil.printLog("setSelected", msg: "END")
    }*/
    
}
