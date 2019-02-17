//
//  InsertAdController.swift
//  InstrIUMental
//
//  Created by Giacomo Meloni on 13/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import UIKit

class InsertAdController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //Array for region picker
    let regions = ["Abruzzo","Basilicata","Calabria","Campania","Emilia-Romagna",
                   "Friuli-Venezia-Giulia","Lazio","Liguria","Lombardia","Marche",
                   "Molise","Piemonte","Puglia","Sardegna", "Sicilia","Toscana",
                   "Trentino-Alto Adige","Umbria","Valle d’Aosta","Veneto"]
    
    //Array for category picker
    let categories = ["Bassi","Batterie","Chitarre","Fiati"]
    
    var currentTextField = DesignableTextField()
    var pickerView = UIPickerView()
    
    var adTitle = String()
    var adText = String()
    var adPrice = String()
    var adCategory = String()
    var adRegion = String()
    var date = String()
    var adId = Int()
    var adImages = [String()]
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //button for insert the 3 image for ad
    var flag = 0 //Flag to understand which image was selected
    @IBOutlet weak var btnImg1: UIButton!
    @IBOutlet weak var btnImg2: UIButton!
    @IBOutlet weak var btnImg3: UIButton!
    
    
    @IBOutlet weak var titleText: DesignableTextField!
    @IBOutlet weak var priceText: DesignableTextField!
    @IBOutlet weak var categoryTxt: DesignableTextField!
    @IBOutlet weak var regionTxt: DesignableTextField!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var addBtn: DesignableButton!
    
    var isValid = true
    var price : String = ""
    var alert:UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() //func for hide keyboard
        
        
        if AdFactory.getAdById(id: adId, adsSet: AdFactory.getInstance().getAds()) != nil {
            addBtn.setTitle("Modifica", for: UIControl.State.normal)
        }
        else {
            addBtn.setTitle("Aggiungi", for: UIControl.State.normal)
        }
        
        //insert data of ad
        titleText.text = adTitle
        priceText.text = adPrice
        categoryTxt.text = adCategory
        regionTxt.text = adRegion
        descriptionText.text = adText
        
    }
    
    @IBAction func img1Pressed(_ sender: Any) {
        let image = UIImagePickerController()
        
        flag = 1
        
        image.delegate = self
        
        image.sourceType = .photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true) {
            
        }
    }
    
    @IBAction func img2Pressed(_ sender: Any) {
        let image = UIImagePickerController()
        
        flag = 2
        
        image.delegate = self
        
        image.sourceType = .photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true) {
            
        }
    }
    
    @IBAction func img3Pressed(_ sender: Any) {
        let image = UIImagePickerController()
        
        flag = 3
        
        image.delegate = self
        
        image.sourceType = .photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true) {
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            if flag == 1 {
                btnImg1.setImage(image, for: .normal)
            } else if flag == 2 {
                btnImg2.setImage(image, for: .normal)
            } else if flag == 3 {
                btnImg3.setImage(image, for: .normal)
            }
        }
        
        self.dismiss(animated: true, completion: nil)
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
            
            if AdFactory.getAdById(id: adId, adsSet: AdFactory.getInstance().getAds()) != nil {
                // TOCHANGE
                let ad : Ad = Ad(id: adId, title: titleText.text!, text: descriptionText.text!, price: temp!, category: adCategory, author: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!, img: adImages, date: date, region : adRegion)
                
                AdFactory.modifyAd(ad: ad)
                showAlert1()
            }
            else {
                
                let ad : Ad = Ad(id: Ad.nextId(), title: titleText.text!, text: descriptionText.text!, price: temp!, category: "categoria1", author: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!, img: ["","",""], date: "2019-02-14", region : "regione1")
                
                AdFactory.insertAd(ad: ad)
                UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers()).addAd(ad: ad)
                
                showAlert()
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == regionTxt {
            return regions.count
        } else if currentTextField == categoryTxt {
            return categories.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == regionTxt {
            return regions[row]
        } else if currentTextField == categoryTxt {
            return categories[row]
        } else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == regionTxt {
            regionTxt.text = regions[row]
            self.view.endEditing(true)
        } else if currentTextField == categoryTxt {
            categoryTxt.text = categories[row]
            self.view.endEditing(true)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        currentTextField = textField as! DesignableTextField
        
        if currentTextField == regionTxt {
            currentTextField.inputView = pickerView
        } else if currentTextField == categoryTxt {
            currentTextField.inputView = pickerView
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
    
    func showAlert1() {
        let alert = UIAlertController(title: "Annuncio modificato", message: "", preferredStyle: .alert)
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


