//
//  DismissModalSegue.swift
//

import UIKit

class DismissModalSegue: UIStoryboardSegue {
 
    override func perform() {
        // dismiss the modal controller
        
        let sourceViewController = self.sourceViewController 
        
        sourceViewController.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
