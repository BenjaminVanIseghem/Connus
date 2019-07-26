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
    var imageUrl = ""
    let db = Firestore.firestore()
    
    //UI Items
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var regionLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        profileImageView.setRounded()
        loadData()
        //Auth.auth().currentUser
    }
    
    override func viewDidDisappear(_ animated: Bool) {

    }
    
    //Log out button
    @IBAction func logOutBtnPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "logOutInfluencer", sender: self)
        }
        catch{
            print("Error with signing out user")
        }
    }
    
    //Load personal information from user into view
    func loadData(){
        //Fetch current user
        guard let currentUsr = Auth.auth().currentUser?.uid else {
            print("No current user")
            return
        }
        //Create ref for influencer
        let influencerRef = db.collection(collectionpath).document(currentUsr)
        //Get data from ref
        influencerRef.addSnapshotListener{ (snapshot, error) in
            if let err = error {
                debugPrint(err)
                print("Error with snapshot")
            } else {
                guard let snap = snapshot else {return}
                let data = snap.data()
                let name = data![FIRSTNAME] as? String ?? "Anonymous"
                let lastname = data![LASTNAME] as? String ?? "Anonymous"
                let birthTimestamp = data![BIRTHDAY] as? Timestamp ?? Timestamp()
                let bio = data![QUOTE] as? String ?? "No Quote"
                let country = data![COUNTRY] as? String ?? "Nowhere"
                
                self.nameLbl.text = name + " " + lastname
                
                let birthdate = birthTimestamp.dateValue()
                let ageComponents = Calendar.current.dateComponents([.year], from: birthdate, to: Date())
                let age = ageComponents.year!
                
                self.ageLbl.text = String(age)
                self.bioTextView.text = bio
                self.regionLbl.text = country
                print("HELLZ YEAH")
                
                //Load image from firebase
                let profilImageUrl = data![PROFILEURL] as? String
                print("HELLZ YEAH2")
                let imageUrl = NSURL(string: profilImageUrl!)
                URLSession.shared.dataTask(with: imageUrl! as URL, completionHandler: { (data, response, error) in
                    if error != nil {
                        print(error as Any)
                        return
                    }
                    self.profileImageView.image = UIImage(data: data!)
                    print("HELLZ YEAH3")
                })
                
            }
            
        }
    }
    
    //Load data from current user using Auth.auth().currentUser
    //Change labels to data from user
    //Add button to change data -> new screen or current screen with text instead of labels
    //Logout button has connection with firebase to log out current user
    
}
