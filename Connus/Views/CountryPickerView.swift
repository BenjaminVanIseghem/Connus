//
//  CountryPickerView.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 28/04/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import UIKit

class CountryPickerView: UIPickerView {
//    var countryTextField: UITextField!
    
//    let countries = NSLocale.isoCountryCodes.map { (code:String) -> String in
//        let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
//        return NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
//    }
    let countries = [
        "Belgium",
        "France"
    ]
    var selectedCountry: String?
    
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
//        countryTextField!.text = selectedCountry
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.textColor = .green
        label.textAlignment = .center
        //        label.font = UIFont(name: "Menlo-Regular", size: 17)
        
        label.text = countries[row]
        
        return label
    }

}

//extension CountryPickerView: UIPickerViewDelegate, UIPickerViewDelegate {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return countries.count
//    }
//    
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return countries[row]
//    }
//    
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        
//        selectedCountry = countries[row]
//        countryTextField.text = selectedCountry
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        
//        var label: UILabel
//        
//        if let view = view as? UILabel {
//            label = view
//        } else {
//            label = UILabel()
//        }
//        
//        //        label.textColor = .green
//        label.textAlignment = .center
//        //        label.font = UIFont(name: "Menlo-Regular", size: 17)
//        
//        label.text = countries[row]
//        
//        return label
//    }
//}
