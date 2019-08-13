//
//  FirstViewController.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 26/04/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import UIKit
import Firebase
import Koloda

class SwipeViewController: UIViewController {
    
    @IBOutlet var kolodaView: KolodaView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        //        DispatchQueue.global(qos: .userInitiated).async {
        //            sleep(4)
        //            // Bounce back to the main thread to update the UI
        //            DispatchQueue.main.async {
        //            }
        //        }
    }
    
    @IBAction func likeBtnPressed(_ sender: UIButton) {
        kolodaView.swipe(.right)
    }
    @IBAction func dislikeBtnPressed(_ sender: UIButton) {
        kolodaView.swipe(.left)
    }
    
}

extension SwipeViewController : KolodaViewDelegate {
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
    }
    
    //When card gets selected
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        let alert = UIAlertController(title: "Congratulation!", message: "You pressed the card", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
}

extension SwipeViewController : KolodaViewDataSource {
    //Select view to load for card at index
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let view = (Bundle.main.loadNibNamed("CompanyCardView", owner: self, options: nil)?.first as? CompanyCardView)!
        view.companyNameLbl.text = "Connus"
        view.yearLbl.text = "2019"
        view.locationLbl.text = "Zottegem"
        view.sectorLbl.text = "App development"
        view.sizeLbl.text = "3"
        view.quoteTxtView.text = "Work hard, play hard"

        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        
        return view
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        //Number of companies
        //Make firebase connection and load companies which aren't swiped by the user
        return 3
    }
    
    //Like or dislike overlay
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("LikeOverlayView", owner: self, options: nil)?[0] as? OverlayView
    }
}

