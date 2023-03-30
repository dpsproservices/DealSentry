//
//  TransactionTableViewCell.swift
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    var debugUtil = DebugUtility(thisClassName: "TransactionTableViewCell", enabled: false)
    
    // concatenated labels
    @IBOutlet weak var IdTransactionStatusLbl: UILabel!
    
    @IBOutlet weak var savedOnDateLbl: UILabel!
    
    @IBOutlet weak var ProductSubDealStatusLbl: UILabel!
    
    @IBOutlet weak var conditionLabel: UILabel!
    
    @IBOutlet weak var primaryClientLbl: UILabel!
    
    @IBOutlet weak var counterpartyLbl: UILabel!
    
    @IBOutlet weak var indicatorImageView: UIImageView!
    
    override func setSelected(selected: Bool, animated: Bool) {
        //debugUtil.printLog("setSelected", msg: "BEGIN")

        if ( selected ) {
            debugUtil.printLog("setSelected", msg: "selected = " + selected.description )
        }
        
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        //debugUtil.printLog("setSelected", msg: "END")
    }

}
