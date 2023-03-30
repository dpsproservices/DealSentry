//
//  DebugUtility.swift
//

import Foundation

class DebugUtility {

    var enabled = false
    
    var className = ""
    
    var timestamp: String {
        get {
            return "\(NSDate().timeIntervalSince1970 * 1000)"
        }
    }

    
    init(thisClassName: String, enabled: Bool) {
        self.className = thisClassName
        self.enabled = enabled
    }
    
    init(thisClassName: String) {
        self.className = thisClassName
        self.enabled = false
    }
    
    func printLog(msg: String) {
        
        if self.enabled {
            let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .LongStyle)
                print(timestamp + " [" + self.className + "] " + msg)
        }
    }

    func printLog(fname: String, msg: String) {
        
        if self.enabled {
            var debugMsg = ""
            
            //let dateTime = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .LongStyle)
            
            //debugMsg = dateTime + "." + self.timestamp + " "
            debugMsg += "[" + self.className + "]"
            debugMsg += " [" + fname + "] "
            debugMsg += msg
            
            //println(debugMsg)
            NSLog(debugMsg)
        }
    }
}
