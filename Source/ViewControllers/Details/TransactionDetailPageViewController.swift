//
//  TransactionDetailPageViewController.swift
//

import UIKit

class TransactionDetailPageViewController: UIViewController {
    
    let appAttributes = AppAttributes()
    var detailViewController: DetailViewController!
    
    var transactionDetailViewController: TransactionDetailViewController! // parent class
    
    var pageNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailViewController = transactionDetailViewController.detailViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

