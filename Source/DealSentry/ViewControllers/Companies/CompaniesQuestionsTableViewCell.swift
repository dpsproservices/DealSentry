//
// CompaniesTableViewCell.swift
//

import UIKit

class CompaniesQuestionsTableViewCell: UITableViewCell {
    
    var debugUtil = DebugUtility(thisClassName: "CompaniesQuestionsTableViewCell", enabled: false)
        
    @IBOutlet weak var companyBackgroundView: UIView!
    @IBOutlet weak var companyNameLabel: UILabel!
    
    @IBOutlet weak var roleTextField: UITextField!
    
    @IBOutlet weak var gfcid: UILabel!
    @IBOutlet weak var levelOneParentLabel: UILabel!
      
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var countryFlagImage: UIImageView!
    @IBOutlet weak var tickerLabel: UILabel!
    
    @IBOutlet weak var industryLabel: UILabel!
    @IBOutlet weak var segmentLabel: UILabel!
    @IBOutlet weak var parentNameLabel: UILabel!
    @IBOutlet weak var exchangeLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var marketLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var agreementButton: UIButton!
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
