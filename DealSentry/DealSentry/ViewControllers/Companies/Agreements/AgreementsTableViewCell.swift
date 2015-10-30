//
//  AgreementsTableViewCell.swift
//
import UIKit

class AgreementsTableViewCell: UITableViewCell {
    
    var debugUtil = DebugUtility(thisClassName: "AgreementsTableViewCell", enabled: false)
    
    @IBOutlet weak var companyBackgroundView: UIView!
    @IBOutlet weak var companyNameLabel: UILabel!
    
    @IBOutlet weak var agreementTypeLabel: UILabel!
       
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
