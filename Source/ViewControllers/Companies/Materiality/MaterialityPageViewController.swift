//
// MaterialityPageViewController.swift
//

import UIKit

class MaterialityPageViewController: UIViewController {
    
    var detailViewController: DetailViewController!

    var materialityViewController: MaterialityViewController! // parent class
    
    var pageNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailViewController = materialityViewController.detailViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

