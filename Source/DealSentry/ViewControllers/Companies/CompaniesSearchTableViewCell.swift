//
// CompanyTableViewCell.swift
//

import UIKit

class CompaniesSearchTableViewCell: UITableViewCell {
    
    var debugUtil = DebugUtility(thisClassName: "CompaniesSearchTableViewCell", enabled: false)
    
    @IBOutlet weak var companyNameLabel: UILabel!
    
    @IBOutlet weak var tickerLabel: UILabel!
    
    @IBOutlet weak var countryFlag: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var gfcidLabel: UILabel!
    
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var exchangeLabel: UILabel!
    
    @IBOutlet weak var marketSegmentLabel: UILabel!
    
    
    @IBOutlet weak var industryLabel: UILabel!
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
