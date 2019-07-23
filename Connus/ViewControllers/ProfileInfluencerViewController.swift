//
//  LogOuInfluencer.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 16/07/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import UIKit
import Firebase


class ProfileInfluencerViewController : UIViewController {
    //Variables
    let collectionpath = "influencers"
    
    //UI Items
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var regionLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.setRounded()
        //Auth.auth().currentUser
    }
    
    //Log out button
    @IBAction func logOutBtnPressed(_ sender: UIButton) {
        
    }
    
    //Load data from current user using Auth.auth().currentUser
    //Change labels to data from user
    //Add button to change data -> new screen or current screen with text instead of labels
    //Logout button has connection with firebase to log out current user
    
}
