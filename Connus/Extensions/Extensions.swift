//
//  Extensions.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 01/05/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import UIKit
import Firebase

extension UIImageView {
    
    func setRounded() {
        self.layer.cornerRadius = self.frame.size.width / 2 //(self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        
        self.clipsToBounds = true
        //        self.layer.masksToBounds = true
    }
}

extension UIViewController {
    
    func calculateAge(birthdateTimestamp : Timestamp) -> Int {
        //Convert Timestamp to Date
        let birthdate = birthdateTimestamp.dateValue()
        //Calculate years passed since birthdate to current date
        let ageComponents = Calendar.current.dateComponents([.year], from: birthdate, to: Date())
        //Extract year from date and return value
        return ageComponents.year!
    }
}

extension UIColor {
    convenience init(hexFromString:String, alpha:CGFloat = 1.0) {
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
