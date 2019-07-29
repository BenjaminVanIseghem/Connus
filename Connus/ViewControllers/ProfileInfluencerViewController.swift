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
    var imageUrl = ""
    var listener : ListenerRegistration?
    let currentUID = Auth.auth().currentUser?.uid
    
    //UI Items
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var regionLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.setRounded()
        bioTextView.layer.cornerRadius = 20
        
        loadData()
    }
    
    //Log out button
    @IBAction func logOutBtnPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            //remove snapshot listener
            listener?.remove()
            self.performSegue(withIdentifier: "logOutInfluencer", sender: self)
        }
        catch{
            print("Error with signing out user")
        }
    }
    
    //Load personal information from user into view
    func loadData(){
        //Check current user
        guard let uid = currentUID else {
            print("No current user")
            return
        }
        //Create ref for influencer
        let influencerRef = db.collection(INFLUENCERPATH).document(uid)
        //Get data from ref
        listener = influencerRef.addSnapshotListener{ (snapshot, error) in
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
                
                //Calculate age and set label
                let age = self.calculateAge(birthdateTimestamp: birthTimestamp)
                self.ageLbl.text = String(age)
                
                self.bioTextView.text = bio
                self.regionLbl.text = country
                
                if let profileURL = data![PROFILEURL] as? String {
                    self.downloadImage(url: profileURL)
                }
                else {
                    print("profileURL is nil")
                }
            }
        }
    }
    
    func downloadImage(url : String) {
        //Create reference for given url
        let storageRef = storage.reference(forURL: url)
        
        //Download images from reference
        storageRef.downloadURL { url, error in
            //Set data from url as NSData object
            let data = NSData(contentsOf: url!)
            //Convert data object to image
            let image = UIImage(data: data! as Data)
            
            //Create CIImage from image
            let ciImage = CIImage(image: image!)
            //Convert CIImage to CGImage
            let cgImage = self.convertCIImageToCGImage(inputImage: ciImage!)
            //Create new UIImage from given CGImage with upside down orientation
            let profileImage = UIImage(cgImage: cgImage! as CGImage, scale: CGFloat(integerLiteral: 1), orientation: .down)
            //Set image
            self.profileImageView.image = profileImage
        }
    }
    
    func convertCIImageToCGImage(inputImage: CIImage) -> CGImage! {
        let context = CIContext(options: nil)
        return context.createCGImage(inputImage, from: inputImage.extent)
    }
    
    
    //TODO Add button to change data -> new screen or current screen with text instead of labels
    
}
