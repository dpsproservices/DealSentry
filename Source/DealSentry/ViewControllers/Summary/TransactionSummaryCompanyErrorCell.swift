//
// CompaniesTableViewCell.swift
//

import UIKit

class TransactionSummaryCompanyErrorCell: UITableViewCell {
    
    @IBOutlet weak var transField: UILabel!
    
    
    @IBOutlet weak var warningImageView: UIButton!
    @IBOutlet weak var transValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
