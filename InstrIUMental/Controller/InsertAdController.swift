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
    var adImages = [UIImage()]
    var adAuthor = String()
    
    
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
    
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var galleryBtn: UIButton!
    let myColor = UIColor(displayP3Red: 213, green: 174, blue: 72, alpha: 1)
    
    @IBOutlet weak var titleText: DesignableTextField!
    @IBOutlet weak var priceText: DesignableTextField!
    @IBOutlet weak var categoryTxt: DesignableTextField!
    @IBOutlet weak var regionTxt: DesignableTextField!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var addBtn: DesignableButton!
    
    var isValid = true
    var price : String = ""
    var alert:UIAlertController!
    
    var newImages : [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() //func for hide keyboard
        
        //insert border to buttons
        btnImg1.layer.borderWidth = 1
        btnImg2.layer.borderWidth = 1
        btnImg3.layer.borderWidth = 1
        
        cameraBtn.layer.cornerRadius = 15
        galleryBtn.layer.cornerRadius = 15

        
        if AdFactory.getAdById(id: adId, adsSet: AdFactory.getInstance().getAds()) != nil {
            addBtn.setTitle("Modifica", for: UIControl.State.normal)
        }
        else {
            addBtn.setTitle("Aggiungi", for: UIControl.State.normal)
        }
        
        //insert data of ad
        titleText.text = adTitle
        
        if self.title == "Modifica annuncio" {
            btnImg1.setBackgroundImage(adImages[0], for: .normal)
            btnImg2.setBackgroundImage(adImages[1], for: .normal)
            btnImg3.setBackgroundImage(adImages[2], for: .normal)
        }
        
        priceText.text = adPrice
        categoryTxt.text = adCategory
        regionTxt.text = adRegion
        descriptionText.text = adText
        
    }
    
    @IBAction func img1Pressed(_ sender: UIButton) {
        flag = 1
        
        let image = UIImagePickerController()
        
        image.delegate = self
        
        image.sourceType = .photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true) {
            
        }
    }
    
    @IBAction func img2Pressed(_ sender: UIButton) {
        flag = 2
        
        let image = UIImagePickerController()
        
        image.delegate = self
        
        image.sourceType = .photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true) {
            
        }
    }
    
    @IBAction func img3Pressed(_ sender: UIButton) {
        flag = 3
        
        let image = UIImagePickerController()
        
        image.delegate = self
        
        image.sourceType = .photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true) {
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let theInfo : NSDictionary = info as NSDictionary
        let image: UIImage = theInfo.object(forKey: UIImagePickerController.InfoKey.originalImage) as! UIImage
            
            if flag == 1 {
                btnImg1.setBackgroundImage(image, for: .normal)
                adImages.append(image)
                newImages.append(image)
            } else if flag == 2 {
                btnImg2.setBackgroundImage(image, for: .normal)
                adImages.append(image)
                newImages.append(image)
            } else if flag == 3 {
                btnImg3.setBackgroundImage(image, for: .normal)
                adImages.append(image)
                newImages.append(image)
            }
        
        
        for img in adImages {
            print(img)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelInsert(_ sender: Any) {
        dismiss(animated: true, completion: reloadInputViews)
    }
    
    @IBAction func previewInsert(_ sender: Any) {
        let id = AdFactory.getAdById(id: adId, adsSet: AdFactory.getInstance().getAds())
        
        //send ad data to next view
        let vc = storyboard?.instantiateViewController(withIdentifier: "AdDetailViewController") as? AdDetailViewController
        vc?.adTitle = titleText.text!
        vc?.adText = descriptionText.text!
        vc?.category = categoryTxt.text!
        vc?.price = priceText.text!
        vc?.author = adAuthor
        vc?.date = "17/02/2019"
        vc?.adId = adId
        //id?.setImage(image: [adImages[0], adImages[1], adImages[2]])
        
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func cameraBtnPressed(_ sender: Any) {
        if cameraBtn.titleLabel?.textColor == UIColor.white {
            cameraBtn.titleLabel?.textColor = UIColor.black
            cameraBtn.layer.backgroundColor = UIColor.white.cgColor
            
            galleryBtn.titleLabel?.textColor = UIColor.white
            galleryBtn.layer.backgroundColor = myColor.cgColor
        } else if cameraBtn.titleLabel?.textColor == UIColor.black {
            cameraBtn.titleLabel?.textColor = UIColor.white
            cameraBtn.layer.backgroundColor = myColor.cgColor
            
            galleryBtn.titleLabel?.textColor = UIColor.black
            galleryBtn.layer.backgroundColor = UIColor.white.cgColor
        }
    }
    
    @IBAction func galleryBtnPressed(_ sender: Any) {
        if galleryBtn.titleLabel?.textColor == UIColor.white {
            galleryBtn.titleLabel?.textColor = UIColor.black
            galleryBtn.layer.backgroundColor = UIColor.white.cgColor
            
            cameraBtn.titleLabel?.textColor = UIColor.white
            cameraBtn.layer.backgroundColor = myColor.cgColor
        } else if galleryBtn.titleLabel?.textColor == UIColor.black {
            galleryBtn.titleLabel?.textColor = UIColor.white
            galleryBtn.layer.backgroundColor = myColor.cgColor
            
            cameraBtn.titleLabel?.textColor = UIColor.black
            cameraBtn.layer.backgroundColor = UIColor.white.cgColor
        }
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
                let ad : Ad = Ad(id: adId, title: titleText.text!, text: descriptionText.text!, price: temp!, category: adCategory, author: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!, image: adImages, date: date, region : adRegion)
                
                AdFactory.modifyAd(ad: ad)
                showAlert1()
            }
            else {
                
                let ad : Ad = Ad(id: Ad.nextId(), title: titleText.text!, text: descriptionText.text!, price: temp!, category: "categoria1", author: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!, image: [newImages[0], newImages[1], newImages[2]], date: "2019-02-14", region : "regione1")
                
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


