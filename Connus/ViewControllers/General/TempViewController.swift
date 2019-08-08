//
//  TempViewController.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 07/08/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import UIKit

class TempViewController: UIViewController {
    @IBOutlet weak var loadingView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.loadingView.isHidden = false
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            sleep(4)
            // Bounce back to the main thread to update the UI
            DispatchQueue.main.async {
                self.loadingView.isHidden = true
            }
        }
        
    }

}
