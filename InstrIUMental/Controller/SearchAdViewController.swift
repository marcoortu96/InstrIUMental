//
//  SearchAdViewController.swift
//  InstrIUMental
//
//  Created by batcave on 13/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import UIKit

class SearchAdViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UISearchBarDelegate{
    
    let regions = ["Abruzzo","Basilicata","Calabria","Campania","Emilia Romagna",
                   "Friuli Venezia Giulia","Lazio","Liguria","Lombardia","Marche",
                   "Molise","Piemonte","Puglia","Sardegna", "Sicilia","Toscana",
                   "Trentino Alto Adige","Umbria","Valle d’Aosta","Veneto"]
    
    //Array for category picker
    let categories = ["Bassi","Batterie","Chitarre","Fiati", "Tastiere"]
    
    let ads = AdFactory.getInstance()
    
    var currentTextField = DesignableTextField()
    var pickerView = UIPickerView()
    
    var showMenu = false
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var closeMenu: UIView! //hidden view that manage the menu closing function
    @IBOutlet weak var menu: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    //username of the logged user
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userLogged: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var categoryTxt: DesignableTextField!
    @IBOutlet weak var regionTxt: DesignableTextField!
    @IBOutlet weak var minPriceTxt: UITextField!
    @IBOutlet weak var maxPriceTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        preparemenu()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        
        closeMenu.addGestureRecognizer(tap)
        closeMenu.isHidden = true
        
        confirmButton.layer.cornerRadius = 15
    }
    
    
    
    //tap to close the side menu
    @objc func handleTap (sender: UITapGestureRecognizer) {
        for subview in (containerView.subviews) {
            if subview.tag == 100 {
                subview.removeFromSuperview()
            }
        }
        showMenu = !showMenu
        leadingConstraint.constant = -240
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        self.view.isUserInteractionEnabled = true
        self.view.layoutIfNeeded()
    }
    
    //func that controls the side menu
    @IBAction func openMenu(_ sender: Any) {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.tag = 100
        
        if(showMenu) {
            leadingConstraint.constant = -240
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
            
            containerView.isUserInteractionEnabled = true
            closeMenu.isHidden = false
            
            for subview in (containerView.subviews) {
                if subview.tag == 100 {
                    subview.removeFromSuperview()
                }
            }
            
            containerView.layoutIfNeeded()
            
        } else {
            leadingConstraint.constant = 0
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
            
            containerView.isUserInteractionEnabled = false
            closeMenu.isHidden = false
            
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurEffectView.alpha = 0.7
            
            containerView.addSubview(blurEffectView)
        }
        showMenu = !showMenu
    }
    
    func preparemenu() {
        
        let usrs = UserFactory.getInstance()
        
        userLogged.text = UserFactory.getLoggedUser(usrs: usrs.getUsers())?.getName()
        userImage.image = UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getImage()
        userImage.contentMode = .scaleAspectFill
        userImage.contentScaleFactor = 2.5
        userImage.setRounded()
        
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
        } else if currentTextField == categoryTxt {
            categoryTxt.text = categories[row]
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
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() //keyboard disappear
        modifySearchFlag()
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "LastAdViewController") as? LastAdViewController
        vc?.stringFound = searchBar.text!
        vc?.stringRegion = regionTxt.text!
        vc?.stringCategory = categoryTxt.text!
        vc?.minPrice = minPriceTxt.text!
        vc?.maxPrice = maxPriceTxt.text!
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func searchButton(_ sender: Any) {
        print("sono nella action di conferma")
        
        modifySearchFlag()
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "LastAdViewController") as? LastAdViewController
        vc?.stringFound = searchBar.text!
        vc?.stringRegion = regionTxt.text!
        vc?.stringCategory = categoryTxt.text!
        vc?.minPrice = minPriceTxt.text!
        vc?.maxPrice = maxPriceTxt.text!
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        let myAlert = UIAlertController(title: "Stai effettuando il Logout", message : "Sei sicuro di voler procedere?", preferredStyle : UIAlertController.Style.alert)
        
        let backAction = UIAlertAction(title : "Indietro", style : UIAlertAction.Style.cancel, handler : nil)
        myAlert.addAction(backAction)
        
        let confirmAction = UIAlertAction(title: "Conferma", style: UIAlertAction.Style.destructive) { (confirmAction) in
            
            UserFactory.logout(username: ((UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers()))?.getUsername())!)
            
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginNavigationController")
            self.present(loginViewController!, animated: true, completion: nil)
        }
        
        myAlert.addAction(confirmAction)
        
        self.present(myAlert, animated : true, completion : nil)
    }
    
    @IBAction func lastAdsBtn(_ sender: Any) {
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.lastAdsFlag = true
        
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.myAdsFlag = false
        
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.favoritesAdFlag = false
        
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.searchFlag = false
    }
    
    @IBAction func myAdsBtn(_ sender: Any) {
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.lastAdsFlag = false
        
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.myAdsFlag = true
        
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.favoritesAdFlag = false
        
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.searchFlag = false
    }
    
    @IBAction func FavoritesAdBtn(_ sender: Any) {
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.lastAdsFlag = false
        
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.myAdsFlag = false
        
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.favoritesAdFlag = true
        
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.searchFlag = false
    }
    
    public func modifySearchFlag () {
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.lastAdsFlag = false
        
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.myAdsFlag = false
        
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.favoritesAdFlag = false
        
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.searchFlag = true
    }
    
    
}
