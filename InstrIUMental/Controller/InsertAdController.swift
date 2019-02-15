//
//  InsertAdController.swift
//  InstrIUMental
//
//  Created by Giacomo Meloni on 13/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import UIKit

class InsertAdController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var titleText: DesignableTextField!
    @IBOutlet weak var imgText: DesignableTextField! // TO CHANGE
    @IBOutlet weak var priceText: DesignableTextField!
    @IBOutlet weak var category: UIPickerView!
    @IBOutlet weak var region: UIPickerView!
    @IBOutlet weak var descriptionText: UITextView!
    
    var isValid = true
    var price : String = ""
    var alert:UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() //func for hide keyboard
    }

    @IBAction func cancelInsert(_ sender: Any) {
        dismiss(animated: true, completion: reloadInputViews)
    }
    
    @IBAction func insertBtn(_ sender: Any) {
        
        price = priceText.text!
        isValid = true
        
        if titleText.text!.count < 6 {
            displayAlertMessage(title: "Errore di inserimento", userMessage: "Il titolo deve avere almeno 6 caratteri")
            titleText.layer.borderWidth = 1
            titleText.layer.borderColor = UIColor.red.cgColor
            titleLabel.textColor = UIColor.red
            isValid = false
        }
        else {
            titleText.layer.borderWidth = 0
            titleLabel.textColor = UIColor.black
        }
        
        if priceText.text!.components(separatedBy: ".").count == 2 || priceText.text!.components(separatedBy: ",").count == 2 || !priceText.text!.contains(".") || !priceText.text!.contains(","){
            
            price = priceText.text!
            
            if priceText.text!.components(separatedBy: ",").count == 2 {
                let tmp = priceText.text!.components(separatedBy: ",")[1]
                price = priceText.text!.components(separatedBy: ",")[0]
                price = price + "." + tmp
            }
            
            priceText.layer.borderWidth = 0
            priceLabel.textColor = UIColor.black
        }
        else {
            displayAlertMessage(title: "Errore di inserimento", userMessage: "Il prezzo inserito non è valido")
            priceText.layer.borderWidth = 1
            priceText.layer.borderColor = UIColor.red.cgColor
            priceLabel.textColor = UIColor.red
            isValid = false
        }
        
        let temp = Float(price)
        
        if temp == nil {
            displayAlertMessage(title: "Errore di inserimento", userMessage: "Il prezzo inserito non è valido")
            priceText.layer.borderWidth = 1
            priceText.layer.borderColor = UIColor.red.cgColor
            priceLabel.textColor = UIColor.red
            isValid = false
        }
        else {
            priceText.layer.borderWidth = 0
            priceLabel.textColor = UIColor.black
        }
        
        if descriptionText.text!.count < 20 {
            displayAlertMessage(title: "Errore di inserimento", userMessage: "La descrizione deve avere almeno 20 caratteri")
            descriptionText.layer.borderWidth = 1
            descriptionText.layer.borderColor = UIColor.red.cgColor
            descriptionLabel.textColor = UIColor.red
            isValid = false
        }
        else {
            descriptionText.layer.borderWidth = 0
            descriptionLabel.textColor = UIColor.black
        }
        
        if isValid {
            let ad : Ad = Ad(id: AdFactory.getInstance().getAds().count, title: titleText.text!, text: descriptionText.text!, price: temp!, category: "categoria1", author: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!, img: ["","",""], date: "2019-02-14", region : "regione1")
            
            AdFactory.insertAd(ad: ad)
            showAlert()
        }
    }
    
    // The function shows an alert message with the given message
    func displayAlertMessage(title: String, userMessage : String) {
        let myAlert = UIAlertController(title: title, message : userMessage, preferredStyle : UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title : "Ok", style : UIAlertAction.Style.default, handler : nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated : true, completion : nil)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Annuncio inserito", message: "", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
        alert.view.backgroundColor = UIColor.green
        alert.view.layer.borderWidth = 0
        alert.view.layer.cornerRadius = 15
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func LastAdsBtn(_ sender: Any) {
    }
    
}
