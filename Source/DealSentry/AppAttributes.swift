//
//  AppAttributes.swift
//

import UIKit


class AppAttributes:NSObject {
    
    let textViewBorder:CGFloat = 1.0
    let textViewCornerRadius:CGFloat = 5.0
    let textBackgroundColor = UIColor(red: 255.0/255, green: 255.0/255, blue: 255.0/255, alpha: 1.0)
    let textViewBorderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 225.0/255, alpha: 1.0).CGColor
    
    let colorBackgroundColor = UIColor(red: 244.0/255, green: 244/255, blue: 244/255, alpha: 1.0)

    let fadeInDuration = 0.3
    
    let pickerBorder: CGFloat = 3.0
    let pickerCornerRadius:CGFloat = 5.0
    let pickerBackgroundColor = UIColor(red: 252.0/255, green: 252.0/255, blue: 252.0/255, alpha: 1.0)
    let pickerBorderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 235.0/255, alpha: 1.0).CGColor
    let grayColorForClosedDeals = UIColor(red: 190.0/255.0, green: 190.0/255.0, blue: 190.0/255.0, alpha: 0.5)
    
    let colorBackgroundColorTop = UIColor(red: 22.0/255.0, green: 179.0/255.0, blue: 245.0/255.0, alpha: 1.0).CGColor
    let colorBackgroundColorBottom = UIColor(red: 06.0/255.0, green: 62.0/255.0, blue: 125.0/255.0, alpha: 1.0).CGColor
    
    let colorSubTaskBackgroundColorTop = UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1.0).CGColor
    let colorSubTaskBackgroundColorBottom = UIColor(red: 215.0/255.0, green: 215.0/255.0, blue: 215.0/255.0, alpha: 1.0).CGColor
    
    let colorOcean = UIColor(red: 0/255.0, green: 140.0/255.0, blue: 230.0/255.0, alpha: 1.0).CGColor
    let colorForest = UIColor(red: 0/255.0, green: 132.0/255.0, blue: 61.0/255.0, alpha: 1.0).CGColor
    
  //  let colorBlue = UIColor(red: 0/255.0, green: 45/255.0, blue: 114/255.0, alpha: 1.0).CGColor
   // let colorBlue = UIColor(red: 0/255.0, green: 140.0/255.0, blue: 230.0/255.0, alpha: 1.0).CGColor
    
    let colorBlue = UIColor(red: 0/255.0, green: 189/255.0, blue: 242/255.0, alpha: 1.0).CGColor
    let colorCyan = UIColor(red: 0/255.0, green: 189/255.0, blue: 242/255.0, alpha: 1.0).CGColor
    
    
//    let colorHighlightRowColor = UIColor(red: 238.0/255, green: 238.0/255, blue: 238.0/255, alpha: 1.0)
//    let colorHighlightRowColor = UIColor(red: 254/255, green: 255.0/255, blue: 205.0/255, alpha: 0.25)
    let colorHighlightRowColor = UIColor(red: 239/255, green: 239.0/255, blue: 239.0/255, alpha: 1.0)

    func getcolorHighlightRowColor() -> UIView{
        let bgColorView = UIView()
        bgColorView.backgroundColor = colorHighlightRowColor
        return bgColorView
    }
    
    func getcolorSubTaskBackground() -> CAGradientLayer {
        let gl: CAGradientLayer = CAGradientLayer()
        gl.colors = [ colorSubTaskBackgroundColorTop, colorSubTaskBackgroundColorBottom]
        gl.locations = [ 0.0, 1.0]
        return gl
        
    }
    func getcolorCompHighlightSubTaskBackground() ->CAGradientLayer {
        let gl: CAGradientLayer = CAGradientLayer()
        gl.colors = [ colorOcean, colorOcean]
        gl.locations = [ 0.0, 1.0]
        return gl
        
    }

    func getcolorCompSubTaskBackground() -> CAGradientLayer {
        let gl: CAGradientLayer = CAGradientLayer()
        gl.colors = [ colorCyan, colorCyan]
        gl.locations = [ 0.0, 1.0]
        return gl
        
    }
    func getcolorBackground() -> CAGradientLayer {
        let gl: CAGradientLayer = CAGradientLayer()
        gl.colors = [ colorBackgroundColorTop, colorBackgroundColorBottom]
        gl.locations = [ 0.0, 1.0]
        return gl
    }
    
    func getcolorBackground2() -> CAGradientLayer {
        let gl: CAGradientLayer = CAGradientLayer()
        gl.colors = [ colorBackgroundColorTop, colorBackgroundColorBottom]
        gl.locations = [ 0.0, 1.0]
        return gl
    }
    
    func setColorAttributesTF(thisField:UITextField){
        thisField.layer.borderColor = self.colorCyan
        
     //   thisField.layer.borderColor = self.textViewBorderColor
        thisField.layer.borderWidth = self.textViewBorder
        thisField.layer.cornerRadius = self.textViewCornerRadius
        thisField.backgroundColor = self.textBackgroundColor
    }
    func setColorAttributesTV(thisField:UITextView){
        thisField.layer.borderColor = self.colorCyan //self.textViewBorderColor
        thisField.layer.borderWidth = self.textViewBorder
        thisField.layer.cornerRadius = self.textViewCornerRadius
        thisField.backgroundColor = self.textBackgroundColor
    }
    func setColorAttributesButton(thisField:UIButton) {
        thisField.layer.borderColor = self.textViewBorderColor
        thisField.layer.borderWidth = self.textViewBorder
        thisField.layer.cornerRadius = self.textViewCornerRadius
        thisField.backgroundColor = self.textBackgroundColor
    }
    func setColorAttributesSegmentControl(thisField:UISegmentedControl) {
        thisField.tintColor = UIColor(CGColor:colorBlue)
        thisField.backgroundColor = UIColor.whiteColor()        
    }
    func animateTable(tableView: UITableView) {
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
            
        for i in cells {
            let cell: UITableViewCell = i
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
            
        var index = 0.0
            
        for a in cells {
            let cell: UITableViewCell = a
            UIView.animateWithDuration(0.45, delay: (0.05 * Double(index)), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
            cell.transform = CGAffineTransformMakeTranslation(1.0, 0);
            }, completion: nil)

            
            index += 1.0
        }
    }
    func animateCollection(tableView: UICollectionView) {
        
        let cells = tableView.visibleCells()
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UICollectionViewCell = i 
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UICollectionViewCell = a 
            UIView.animateWithDuration(0.45, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransformMakeTranslation(1.0, 0);
                }, completion: nil)
            
            index += 1
        }
    }
   
    
}