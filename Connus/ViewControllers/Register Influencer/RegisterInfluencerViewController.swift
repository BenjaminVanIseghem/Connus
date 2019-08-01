//
//  registerInfluencerController.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 28/04/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import Foundation
import FirebaseUI


class RegisterInfluencerViewController : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    
    //Variables to be used when going back from next screen
    var name: String?
    var lastname: String?
    var country: String?
    var birthdate: Timestamp?
    var gender: String?
    var profilePic: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCountryPicker()
        createToolbar()
        showDatePicker()
        imageView.setRounded()
        setVariables()
        self.setNewImage(btn: maleButton)
        self.setNewImage(btn: femaleButton)
        self.setNewImage(btn: otherButton)
        genderArr = [maleButton, femaleButton, otherButton]
    }
    //Set all variables if returning from next screen
    func setVariables() {
        if name != nil && lastname != nil && country != nil && birthdate != nil && gender != nil {
            nameTextField.text = name
            lastnameTextField.text = lastname
            countryTextField.text = country
            birthDateTextField.text = ""
            if profilePic != nil {
                imageView.image = profilePic
            }
            switch gender {
            case "male":
                maleButton.isSelected = true
                femaleButton.isSelected = false
                otherButton.isSelected = false
            case "female":
                maleButton.isSelected = false
                femaleButton.isSelected = true
                otherButton.isSelected = false
            case "other":
                maleButton.isSelected = false
                femaleButton.isSelected = false
                otherButton.isSelected = true
            case .none: break
                //do something
            case .some(_): break
                //do something
            }
        }
    }
    //Radiobuttons for gender--------------------------
    // Images
    let checkedImage = UIImage(named: "radiochecked")! as UIImage
    let uncheckedImage = UIImage(named: "checkbox-off-512")! as UIImage
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    var genderArr:Array<UIButton>?
    var selectedGender: String?
    
    @IBAction func maleButtonPressed(_ sender: Any) {
        if femaleButton.isSelected || otherButton.isSelected {
            maleButton.isSelected = !maleButton.isSelected
            self.setNewImage(btn: maleButton)
            if femaleButton.isSelected {
                femaleButton.isSelected = false
                //set checked image
                self.setNewImage(btn: femaleButton)
            }
            if otherButton.isSelected {
                otherButton.isSelected = false
                //set checked image
                self.setNewImage(btn: otherButton)
            }
        } else {
            maleButton.isSelected = !maleButton.isSelected
            self.setNewImage(btn: maleButton)
        }
    }
    @IBAction func femaleButtonPressed(_ sender: Any) {
        if maleButton.isSelected || otherButton.isSelected {
            femaleButton.isSelected = !femaleButton.isSelected
            self.setNewImage(btn: femaleButton)
            if maleButton.isSelected {
                maleButton.isSelected = false
                //set checked image
                self.setNewImage(btn: maleButton)
            }
            if otherButton.isSelected {
                otherButton.isSelected = false
                //set checked image
                self.setNewImage(btn: otherButton)
            }
        } else {
            femaleButton.isSelected = !femaleButton.isSelected
            self.setNewImage(btn: femaleButton)
        }
    }
    @IBAction func otherButtonPressed(_ sender: Any) {
        if femaleButton.isSelected || maleButton.isSelected {
            otherButton.isSelected = !otherButton.isSelected
            self.setNewImage(btn: otherButton)
            if femaleButton.isSelected {
                femaleButton.isSelected = false
                //set checked image
                self.setNewImage(btn: femaleButton)
            }
            if maleButton.isSelected {
                maleButton.isSelected = false
                //set checked image
                self.setNewImage(btn: maleButton)
            }
        } else {
            otherButton.isSelected = !otherButton.isSelected
            self.setNewImage(btn: otherButton)
        }
    }
    
    func setNewImage(btn: UIButton){
        if btn.isSelected {
            btn.setImage(checkedImage, for: UIControl.State.normal)
        } else {
            btn.setImage(uncheckedImage, for: UIControl.State.normal)
        }
    }
    //-------------------------------------------------
    //Image view and picker ---------------------------
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func setProfilePicture(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true){
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            imageView.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    //----------------------------------------------
    
    
    //UIPickers country and birthdate---------------
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var birthDateTextField: UITextField!
    let datePicker = UIDatePicker()
    
    let countries = NSLocale.isoCountryCodes.map { (code:String) -> String in
        let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
        return NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
    }
    var selectedCountry: String?
    
    func countryPickerDidSelectRow(country: String?) {
        countryTextField!.text = country
    }
    
    
    func createCountryPicker() {
        
        let countryPicker = UIPickerView()
        countryPicker.delegate = self
        
        countryTextField.inputView = countryPicker
        
        //Customizations
//        countryPicker.backgroundColor = .black
    }
    
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //Customizations
//        toolBar.barTintColor = .black
//        toolBar.tintColor = .white
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(RegisterInfluencerViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        countryTextField.inputAccessoryView = toolBar
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        birthDateTextField.inputAccessoryView = toolbar
        birthDateTextField.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        birthDateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    //-------------------------------------------------
    
    //Go to next register screen-----------------------
    
    @IBAction func goToNextScreen(_ sender: Any) {
        if checkFilledIn() {
            performSegue(withIdentifier: "goToSecondRegisterInfluencer", sender: self)
        } else {
            notFilledInWarning()
        }
        
    }
    //-------------------------------------------------
    //Check if one of the buttons is selected
    func checkButtonSelected() -> Bool {
        if maleButton.isSelected || femaleButton.isSelected || otherButton.isSelected {
            return true
        }
        return false
    }
    //Check if every field is filled in
    func checkFilledIn() -> Bool{
        if birthDateTextField.text != nil && countryTextField.text != nil && nameTextField.text != nil && lastnameTextField.text != nil {
            if checkButtonSelected() {
                return true
            }
            return false
        }
        return false
    }
    //Get current selected gender
    func getSelectedGender() -> String {
        if maleButton.isSelected {
            return "male"
        }
        if femaleButton.isSelected {
            return "female"
        }
        if otherButton.isSelected {
            return "other"
        }
        return ""
    }
    //Prepare segue to pass data into next ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSecondRegisterInfluencer" {
            let controller = segue.destination as! SecondRegisterInfluencerViewController
            //Extract Date from birthdateTextField
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            guard let date = formatter.date(from: self.birthDateTextField.text!) else {
                print("Error extracting date from UI")
                return
            }
            controller.birthdate = Timestamp(date: date)
            controller.country = self.countryTextField.text!
            controller.name = self.nameTextField.text!
            controller.lastname = self.lastnameTextField.text!
            controller.gender = self.getSelectedGender()
            if imageView.image != nil {
                controller.profilePic = self.imageView.image!
            }
        }
    }
    
    //Warning alert when not everything is filled in
    func notFilledInWarning() {
        let alertController = UIAlertController(title: "Oops!", message:
            "Please fill in all necessary fields", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension RegisterInfluencerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedCountry = countries[row]
        countryTextField.text = selectedCountry
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        label.textAlignment = .center
        
        label.text = countries[row]
        
        return label
    }
}
