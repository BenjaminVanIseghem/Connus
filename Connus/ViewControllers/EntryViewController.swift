//
//  EntryViewController.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 26/04/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import UIKit
import FirebaseUI

class EntryViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func RegisterInfluencer(_ sender: UIButton) {
        
    }
    
    
    @IBAction func registerCompany(_ sender: UIButton) {
    }
    
    @IBAction func LoginPressed(_ sender: UIButton) {
        let authUI = FUIAuth.defaultAuthUI()
        
        guard authUI != nil else{
            return
        }
        
        authUI?.delegate = self
        
        let authViewController = authUI!.authViewController()
        
        present(authViewController, animated: false, completion: nil)
    }
    
}
extension EntryViewController : FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if error != nil {
            return
        }
        
        performSegue(withIdentifier: "homeInfluencer", sender: self)
    }
    
}
