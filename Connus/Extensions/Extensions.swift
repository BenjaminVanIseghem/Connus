//
//  Extensions.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 01/05/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setRounded() {
        self.layer.cornerRadius = self.frame.height / 2 //(self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        
        self.clipsToBounds = true
        //        self.layer.masksToBounds = true
    }
}
