//
//  MapFilterViewController.swift
//  InstrIUMental
//
//  Created by batcave on 18/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import UIKit

class MapFilterViewController:  UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //outlet of textfields
    @IBOutlet weak var distanceValue: UILabel!
    @IBOutlet weak var minPriceTxt: UITextField!
    @IBOutlet weak var maxPrice: UITextField!
    @IBOutlet weak var categoryTextfield: UITextField!
    
    //outlet for confirm button
    @IBOutlet weak var confirmButton: UIButton!
    
    let picker = UIPickerView()
    
    //array of categories
    let myPickerData = [String](arrayLiteral: "-", "Bassi", "Batterie", "Chitarre", "Fiati", "Tastiere")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        confirmButton.layer.cornerRadius = 15
        categoryTextfield.inputView = picker
        
        picker.delegate = self
        
    }
    
    //distance slider for filter map TODO
    @IBAction func distanceSlider(_ sender: UISlider) {
        distanceValue.text = String(Int(sender.value))
    }
    
  
    
    //func for set picker view
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
        if categoryTextfield.text == "-" {
            categoryTextfield.text = ""
        }
        categoryTextfield.text = myPickerData[row]
    }
    
    
    
    
    
}
