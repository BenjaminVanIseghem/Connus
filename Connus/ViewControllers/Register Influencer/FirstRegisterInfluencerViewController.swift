//
//  FirstRegisterInfluencerViewController.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 14/08/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import UIKit

class FirstRegisterInfluencerViewController: UIViewController {
    
    //Text Views
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var birthdateTxtField: UITextField!
    @IBOutlet weak var sexTxtField: UITextField!
    
    //Picker views
    var sexPicker = UIPickerView()
    var birthdatePicker = UIPickerView()
    
    //Data sources
    let sexPickerData = [String](arrayLiteral: "Male", "Female", "Other")

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hide back button
        self.navigationItem.hidesBackButton = true
        
        //Set picker delegate
        sexPicker.delegate = self
        birthdatePicker.delegate = self
        
        //Set the tags of the picker views as to be able to differentiate between them
        self.setPickerViewTags()
        //Add PickerViews to appropriate text fields
        self.addPickerViewsToTextFields()

        //Back button tint
        self.navigationController?.navigationBar.tintColor = whiteColor
    }
    
    //Set the tags of the picker views as to be able to differentiate between them
    private func setPickerViewTags() {
        self.birthdatePicker.tag = 1
        self.sexPicker.tag = 2
    }
    
    //Add PickerViews to appropriate text fields
    private func addPickerViewsToTextFields() {
        self.birthdateTxtField.inputView = self.birthdatePicker
        self.sexTxtField.inputView = self.sexPicker
    }
}

extension FirstRegisterInfluencerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 2 {
            return sexPickerData.count
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 2 {
            return sexPickerData[row]
        } else {
            return "Test"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 2 {
            sexTxtField.text = sexPickerData[row]
        } else {
            birthdateTxtField.text = "Test"
        }
        
        self.view.endEditing(true)
    }
    
    
}
