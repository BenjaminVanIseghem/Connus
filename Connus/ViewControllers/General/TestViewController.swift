//
//  TestViewController.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 07/08/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let view = (Bundle.main.loadNibNamed("TestView", owner: self, options: nil)?.first as? TestView)!
        view.logoImageView.tintColor = whiteColor
        self.view = view
    }
}
