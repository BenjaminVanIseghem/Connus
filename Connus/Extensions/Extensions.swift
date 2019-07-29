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
