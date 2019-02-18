//
//  MapFilterViewController.swift
//  InstrIUMental
//
//  Created by batcave on 18/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import UIKit

class MapFilterViewController:  UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var distanceValue: UILabel!
    @IBOutlet weak var priceValue: UILabel!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var categoryTextfield: UITextField!
    let picker = UIPickerView()
    
    let myPickerData = [String](arrayLiteral: "Bassi", "Batterie", "Chitarre", "Fiati")
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        confirmButton.layer.cornerRadius = 15
        categoryTextfield.inputView = picker
        
        picker.delegate = self
        
    }
    
    @IBAction func distanceSlider(_ sender: UISlider) {
        distanceValue.text = String(Int(sender.value))
    }
    
    @IBAction func priceSlider(_ sender: UISlider) {
        priceValue.text = String(Int(sender.value))
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerData.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerData[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextfield.text = myPickerData[row]
    }
    
    
    
    
    
}
