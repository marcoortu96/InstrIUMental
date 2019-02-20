//
//  InsertAdController.swift
//  InstrIUMental
//
//  Created by Giacomo Meloni on 13/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import UIKit

class InsertAdController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate {
    
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
    
    var ad : [Ad] = []
    
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
    
    struct newImage {
        var image: UIImage
        var index: Int
    }
    
    var newImages: [newImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() //func for hide keyboard
        
        if AdFactory.getAdById(id: adId, adsSet: AdFactory.getInstance().getAds())?.getImage() != nil {
            var i = 0
            for img in (AdFactory.getAdById(id: adId, adsSet: AdFactory.getInstance().getAds())?.getImage())! {
                newImages.append(newImage(image: img, index: i+1))
                i = i+1
            }
        }
        
        descriptionText.layer.borderWidth = 1
        descriptionText.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        descriptionText.layer.cornerRadius = 5
        
        //insert border to buttons
        btnImg1.layer.borderWidth = 1
        btnImg2.layer.borderWidth = 1
        btnImg3.layer.borderWidth = 1
        
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
        
        let actionSheet = UIAlertController(title: "Scegli un opzione", message: "", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Fotocamera", style: .default, handler: { (action: UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                image.sourceType = .camera
                image.allowsEditing = false
                
                self.present(image, animated: true)
            } else {
                print("Non hai accesso alla fotocamera")
            }
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Galleria", style: .default, handler: { (action: UIAlertAction) in
            image.sourceType = .photoLibrary
            image.allowsEditing = false
            
            self.present(image, animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func img2Pressed(_ sender: UIButton) {
        flag = 2
        
        let image = UIImagePickerController()
        image.delegate = self
        
        let actionSheet = UIAlertController(title: "Scegli un opzione", message: "", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Fotocamera", style: .default, handler: { (action: UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                image.sourceType = .camera
                image.allowsEditing = false
                
                self.present(image, animated: true)
            } else {
                print("Non hai accesso alla fotocamera")
            }
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Galleria", style: .default, handler: { (action: UIAlertAction) in
            image.sourceType = .photoLibrary
            image.allowsEditing = false
            
            self.present(image, animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func img3Pressed(_ sender: UIButton) {
        flag = 3
        
        let image = UIImagePickerController()
        image.delegate = self
        
        let actionSheet = UIAlertController(title: "Scegli un opzione", message: "", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Fotocamera", style: .default, handler: { (action: UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                image.sourceType = .camera
                image.allowsEditing = false
                
                self.present(image, animated: true)
            } else {
                print("Non hai accesso alla fotocamera")
            }
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Galleria", style: .default, handler: { (action: UIAlertAction) in
            image.sourceType = .photoLibrary
            image.allowsEditing = false
            
            self.present(image, animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let theInfo : NSDictionary = info as NSDictionary
        let image: UIImage = theInfo.object(forKey: UIImagePickerController.InfoKey.originalImage) as! UIImage
            
            if flag == 1 {
                btnImg1.setBackgroundImage(image, for: .normal)
                
             
                if newImages.count == 3 {
                    var i = 0
                    for img in newImages {
                        if img.index == 1 {
                            newImages[i].image = image
                        }
                        i += 1
                    }
                } else {
                    newImages.append(newImage(image: image, index: 1))
                }
                
                
                adImages.append(image)
        
            } else if flag == 2 {
                btnImg2.setBackgroundImage(image, for: .normal)
                
                if newImages.count == 3 {
                    var i = 0
                    for img in newImages {
                        if img.index == 2 {
                            newImages[i].image = image
                        }
                        i += 1
                    }
                } else {
                    newImages.append(newImage(image: image, index: 2))
                }
                
                adImages.append(image)

            } else if flag == 3 {
                btnImg3.setBackgroundImage(image, for: .normal)
                
                if newImages.count == 3 {
                    var i = 0
                    for img in newImages {
                        if img.index == 3 {
                            newImages[i].image = image
                        }
                        i += 1
                    }
                } else {
                    newImages.append(newImage(image: image, index: 3))
                }
                adImages.append(image)
            }
        
        
        for img in adImages {
            print(img)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelInsert(_ sender: Any) {
        if self.title == "Modifica annuncio" {
            UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.lastAdsFlag = false
            
            UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.myAdsFlag = true
            
            UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.favoritesAdFlag = false
            
            _ = navigationController?.popViewController(animated: true)
            
        } else {
            dismiss(animated: true, completion: reloadInputViews)
        }
        
        for item in ad {
            AdFactory.removeFromLastAd(ad: item)
        }
    }
    
    @IBAction func previewInsert(_ sender: Any) {
        _ = AdFactory.getAdById(id: adId, adsSet: AdFactory.getInstance().getAds())
        
        //get current date
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        
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
        
        if newImages.count != 3 {
            displayAlertMessage(title: "Errore di inserimento", userMessage: "Bisogna inserire 3 immagini")
            btnImg1.layer.borderWidth = 1
            btnImg1.layer.borderColor = UIColor.red.cgColor
            btnImg2.layer.borderWidth = 1
            btnImg2.layer.borderColor = UIColor.red.cgColor
            btnImg3.layer.borderWidth = 1
            btnImg3.layer.borderColor = UIColor.red.cgColor
            imgLabel.textColor = UIColor.red
            isValid = false
        }
        else {
            btnImg1.layer.borderWidth = 0
            btnImg2.layer.borderWidth = 0
            btnImg3.layer.borderWidth = 0
            imgLabel.textColor = UIColor.black
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
        
        if categoryTxt.text == "" {
            displayAlertMessage(title: "Errore di inserimento", userMessage: "Selezionare una categoria")
            categoryTxt.layer.borderWidth = 1
            categoryTxt.layer.borderColor = UIColor.red.cgColor
            categoryLabel.textColor = UIColor.red
            isValid = false
        }
        else {
            categoryTxt.layer.borderWidth = 0
            categoryLabel.textColor = UIColor.black
        }
        
        if regionTxt.text == "" {
            displayAlertMessage(title: "Errore di inserimento", userMessage: "Selezionare una regione")
            regionTxt.layer.borderWidth = 1
            regionTxt.layer.borderColor = UIColor.red.cgColor
            regionLabel.textColor = UIColor.red
            isValid = false
        }
        else {
            regionTxt.layer.borderWidth = 0
            regionLabel.textColor = UIColor.black
        }
        
        if descriptionText.text!.count < 20 {
            displayAlertMessage(title: "Errore di inserimento", userMessage: "La descrizione deve avere almeno 20 caratteri")
            descriptionText.layer.borderWidth = 1
            descriptionText.layer.borderColor = UIColor.red.cgColor
            descriptionLabel.textColor = UIColor.red
            isValid = false
        }
        else {
            let myColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
            descriptionText.layer.borderColor = myColor.cgColor
            descriptionText.layer.cornerRadius = 5
            descriptionText.layer.borderWidth = 1
        }
        if isValid {
            //send ad data to next view
            ad.append(Ad(id: Ad.nextId(), title: titleText.text!, text: descriptionText.text!, price: temp!, category: categoryTxt.text!, author: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!, image: [newImages[0].image, newImages[1].image, newImages[2].image], date: result, region : regionTxt.text!))
            
            AdFactory.insertAd(ad: ad[ad.count-1])
            
            var currentPrice = String(ad[ad.count-1].getPrice())
            if (currentPrice.components(separatedBy: ".")[1]).count == 1 {
                currentPrice = currentPrice + "0 €"
            }
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "AdDetailViewController") as? AdDetailViewController
            vc?.adTitle = ad[ad.count-1].getTitle()
            vc?.adText = ad[ad.count-1].getText()
            vc?.category = ad[ad.count-1].getCategory()
            vc?.price = currentPrice
            vc?.author = ad[ad.count-1].getAuthor()
            vc?.date = (ad[ad.count-1].getDate().components(separatedBy: "-")[2]) + "-" + (ad[ad.count-1].getDate().components(separatedBy: "-")[1]) + "-" + (ad[ad.count-1].getDate().components(separatedBy: "-")[0])
            vc?.adId = ad[ad.count-1].getId()
            vc?.region = ad[ad.count-1].getRegion()
            
            vc?.title = "Anteprima annuncio"
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    @IBAction func insertBtn(_ sender: Any) {
        
        //get current date
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        
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
        
            if newImages.count != 3 {
                 displayAlertMessage(title: "Errore di inserimento", userMessage: "Bisogna inserire 3 immagini")
                 btnImg1.layer.borderWidth = 1
                 btnImg1.layer.borderColor = UIColor.red.cgColor
                 btnImg2.layer.borderWidth = 1
                 btnImg2.layer.borderColor = UIColor.red.cgColor
                 btnImg3.layer.borderWidth = 1
                 btnImg3.layer.borderColor = UIColor.red.cgColor
                 imgLabel.textColor = UIColor.red
                 isValid = false
            
             }
             else {
                 btnImg1.layer.borderWidth = 0
                 btnImg2.layer.borderWidth = 0
                 btnImg3.layer.borderWidth = 0
                 imgLabel.textColor = UIColor.black
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
        
        if categoryTxt.text == "" {
            displayAlertMessage(title: "Errore di inserimento", userMessage: "Selezionare una categoria")
            categoryTxt.layer.borderWidth = 1
            categoryTxt.layer.borderColor = UIColor.red.cgColor
            categoryLabel.textColor = UIColor.red
            isValid = false
        }
        else {
            categoryTxt.layer.borderWidth = 0
            categoryLabel.textColor = UIColor.black
        }
        
        if regionTxt.text == "" {
            displayAlertMessage(title: "Errore di inserimento", userMessage: "Selezionare una regione")
            regionTxt.layer.borderWidth = 1
            regionTxt.layer.borderColor = UIColor.red.cgColor
            regionLabel.textColor = UIColor.red
            isValid = false
        }
        else {
            regionTxt.layer.borderWidth = 0
            regionLabel.textColor = UIColor.black
        }
        
        if descriptionText.text!.count < 20 {
            displayAlertMessage(title: "Errore di inserimento", userMessage: "La descrizione deve avere almeno 20 caratteri")
            descriptionText.layer.borderWidth = 1
            descriptionText.layer.borderColor = UIColor.red.cgColor
            descriptionLabel.textColor = UIColor.red
            isValid = false
        }
        else {
            descriptionText.layer.borderWidth = 1
            descriptionText.layer.borderColor = UIColor.black.cgColor
            descriptionLabel.textColor = UIColor.black
        }
        
        if isValid {
            
            if AdFactory.getAdById(id: adId, adsSet: AdFactory.getInstance().getAds()) != nil {
                
                let newAd : Ad = Ad(id: adId, title: titleText.text!, text: descriptionText.text!, price: temp!, category: categoryTxt.text!, author: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!, image: [newImages[0].image, newImages[1].image, newImages[2].image], date: result, region : regionTxt.text!)
                
                AdFactory.modifyAd(ad: newAd)
                
                for item in ad {
                    AdFactory.removeFromLastAd(ad: item)
                }
                
                showAlert1()
                
                Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (timer) in
                    _ = self.navigationController?.popToRootViewController(animated: true)
                }
            }
            else {
                
                let newAd : Ad = Ad(id: Ad.nextId(), title: titleText.text!, text: descriptionText.text!, price: temp!, category: categoryTxt.text!, author: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!, image: [newImages[0].image, newImages[1].image, newImages[2].image], date: result, region : regionTxt.text!)
                
                AdFactory.insertAd(ad: newAd)
                UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers()).addAd(ad: newAd)
                
                for item in ad {
                    AdFactory.removeFromLastAd(ad: item)
                }
                
                showAlert()
                
                Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (timer) in
                    self.dismiss(animated: true, completion: self.reloadInputViews)
                }
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

    
}


