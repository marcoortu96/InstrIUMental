//
//  ProfileViewController.swift
//  InstrIUMental
//
//  Created by batcave on 11/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    var showMenu = false
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var menu: UIView!
    @IBOutlet weak var containerView: UIScrollView!
    @IBOutlet weak var closeMenu: UIView!
    
    //sidemenu outlet
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userLogged: UILabel!
    
    //profile outlet
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var surnameLabel: UITextField!
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var changePassLabel: UILabel!
    @IBOutlet weak var changePassTxt: UITextField!
    @IBOutlet weak var newPassLabel: UILabel!
    @IBOutlet weak var newPassTxt: UITextField!
    
    //outlet modify button (pencil)
    @IBOutlet weak var modifyNameBtn: UIButton!
    @IBOutlet weak var modifySurnameBtn: UIButton!
    @IBOutlet weak var modifyUsernameBtn: UIButton!
    @IBOutlet weak var modifyEmailBtn: UIButton!
    @IBOutlet weak var modifyPassBtn: UIButton!
    @IBOutlet weak var saveChangeProfile: UIButton!
    @IBOutlet weak var deleteProfileBtn: UIButton!
    
    //constraints for fix textfield
    @IBOutlet weak var txtBC: NSLayoutConstraint!
    @IBOutlet weak var btnTC: NSLayoutConstraint!
    @IBOutlet weak var btnBC: NSLayoutConstraint!
    @IBOutlet weak var deletePBC: NSLayoutConstraint!
    @IBOutlet weak var deletePTC: NSLayoutConstraint!
    
    var imgBtn : UIImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //func for hide keyboard
        self.hideKeyboardWhenTappedAround()
        
        profileImage.setRounded()
        
        //disable textfield for modify profile
        nameLabel.isEnabled = false
        surnameLabel.isEnabled = false
        usernameLabel.isEnabled = false
        emailLabel.isEnabled = false
        changePassTxt.isEnabled = false
        
        //set constraint for delete user button
        deletePTC.constant = -40
        deletePBC.constant = 160

        
        
        //fix textfield position when open keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        //fix textfield position when hide keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //textifield return to original position
        newPassTxt.delegate = self
        
        prepareMenu()
        prepareUser()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        
        closeMenu.addGestureRecognizer(tap)
        closeMenu.isHidden = true
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
        closeMenu.isHidden = true
        containerView.isUserInteractionEnabled = true
        self.view.layoutIfNeeded()
    }
    
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
            closeMenu.isHidden = true
            
            for subview in (containerView.subviews) {
                if subview.tag == 100 {
                    subview.removeFromSuperview()
                }
            }
            
        } else {
            leadingConstraint.constant = 0
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
            containerView.isUserInteractionEnabled = false
            closeMenu.isHidden = false
            
            blurEffectView.frame = containerView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurEffectView.alpha = 0.7
            
            containerView.addSubview(blurEffectView)
        }
        showMenu = !showMenu
    }
    
    //modify profile photo
    @IBAction func pressPhotoBtn(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary;
        image.allowsEditing = false
        
        self.present(image, animated: true, completion: nil)
    }
    
    //take photo from photo gallery
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let theInfo : NSDictionary = info as NSDictionary
        let img: UIImage = theInfo.object(forKey: UIImagePickerController.InfoKey.originalImage) as! UIImage
        profileImage.image = img
        imgBtn = img
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.setImage(image: img)
        
        prepareMenu()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //action for modify textfield of profile
    @IBAction func modifyName(_ sender: Any) {
        modifyNameBtn.isHidden = true
        nameLabel.isEnabled = true
        nameLabel.becomeFirstResponder()
        nameLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        nameLabel.layer.cornerRadius = 15
        nameLabel.setLeftPaddingPoints(10)
        nameLabel.layer.borderWidth = 1
        nameLabel.layer.borderColor = UIColor.lightGray.cgColor
        
        deleteProfileBtn.isHidden = true
        saveChangeProfile.isHidden = false
    }
    
    @IBAction func modifySurname(_ sender: Any) {
        modifySurnameBtn.isHidden = true
        surnameLabel.isEnabled = true
        surnameLabel.becomeFirstResponder()
        surnameLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        surnameLabel.layer.cornerRadius = 15
        surnameLabel.setLeftPaddingPoints(10)
        surnameLabel.layer.borderWidth = 1
        surnameLabel.layer.borderColor = UIColor.lightGray.cgColor
        
        deleteProfileBtn.isHidden = true
        saveChangeProfile.isHidden = false
    }
    
    @IBAction func modifyUsername(_ sender: Any) {
        modifyUsernameBtn.isHidden = true
        usernameLabel.isEnabled = true
        usernameLabel.becomeFirstResponder()
        usernameLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        usernameLabel.layer.cornerRadius = 15
        usernameLabel.setLeftPaddingPoints(10)
        usernameLabel.layer.borderWidth = 1
        usernameLabel.layer.borderColor = UIColor.lightGray.cgColor
        
        deleteProfileBtn.isHidden = true
        saveChangeProfile.isHidden = false
    }
    
    @IBAction func modifyEmail(_ sender: Any) {
        emailLabel.isEnabled = true
        emailLabel.becomeFirstResponder()
        modifyEmailBtn.isHidden = true
        emailLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        emailLabel.layer.cornerRadius = 15
        emailLabel.setLeftPaddingPoints(10)
        emailLabel.layer.borderWidth = 1
        emailLabel.layer.borderColor = UIColor.lightGray.cgColor
        
        deleteProfileBtn.isHidden = true
        saveChangeProfile.isHidden = false
    }
    
    @IBAction func modifyPassword(_ sender: Any) {
        btnBC.constant = 57
        btnTC.constant = 30

        modifyPassBtn.isHidden = true
        changePassTxt.isEnabled = true
        changePassTxt.becomeFirstResponder()
        changePassTxt.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        changePassTxt.layer.cornerRadius = 15
        changePassTxt.setLeftPaddingPoints(10)
        changePassTxt.layer.borderWidth = 1
        changePassTxt.layer.borderColor = UIColor.lightGray.cgColor
        changePassLabel.text = "Vecchia password"
        
        newPassLabel.isHidden = false
        newPassTxt.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        newPassTxt.setLeftPaddingPoints(10)
        newPassTxt.layer.borderWidth = 1
        newPassTxt.layer.borderColor = UIColor.lightGray.cgColor
        newPassTxt.layer.cornerRadius = 15
        newPassTxt.isHidden = false
        
        deleteProfileBtn.isHidden = true
        saveChangeProfile.isHidden = false
    }
    
    //func for return textfield at the original position
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //func for fix textfield position when open keyboard
    @objc func keyBoardWillShow(notification: Notification) {
        if let userInfo = notification.userInfo as? Dictionary<String, AnyObject> {
            let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
            let keyboardRect = frame?.cgRectValue
            
            if let keyboardHeight = keyboardRect?.height {
                self.txtBC.constant = keyboardHeight
                self.btnTC.constant = (keyboardHeight - 56)
                
                
                UIView.animate(withDuration: 0.5) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    //func for fix textfield position when hide keyboard
    @objc func keyBoardWillHide(notification: Notification) {
        
        if modifyPassBtn.isHidden == false {
            self.txtBC.constant = 142
            self.btnTC.constant = -40
            self.btnBC.constant = 125
        }else {
            self.txtBC.constant = 142
            self.btnTC.constant = 58
            self.btnTC.constant = 36
        }
        
        UIView.animate(withDuration: 0.6) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    //save changes
    @IBAction func saveProfileChanges(_ sender: Any) {
        btnBC.constant = 130
        btnTC.constant = -40
        
        nameLabel.isEnabled = false
        nameLabel.textColor = UIColor.black
        nameLabel.layer.borderWidth = 0
        nameLabel.setLeftPaddingPoints(0)
        modifyNameBtn.isHidden = false
        
        surnameLabel.isEnabled = false
        surnameLabel.textColor = UIColor.black
        surnameLabel.layer.borderWidth = 0
        surnameLabel.setLeftPaddingPoints(0)
        modifySurnameBtn.isHidden = false
        
        usernameLabel.isEnabled = false
        usernameLabel.textColor = UIColor.black
        usernameLabel.layer.borderWidth = 0
        usernameLabel.setLeftPaddingPoints(0)
        modifyUsernameBtn.isHidden = false
        
        emailLabel.isEnabled = false
        emailLabel.textColor = UIColor.black
        emailLabel.layer.borderWidth = 0
        emailLabel.setLeftPaddingPoints(0)
        modifyEmailBtn.isHidden = false
        
        changePassTxt.isEnabled = false
        changePassTxt.textColor = UIColor.black
        changePassTxt.layer.borderWidth = 0
        changePassTxt.setLeftPaddingPoints(0)
        modifyPassBtn.isHidden = false
        changePassLabel.text = "Modifica password"
        newPassLabel.isHidden = true
        newPassTxt.isHidden = true
        
        saveChangeProfile.isHidden = true
        deleteProfileBtn.isHidden = false
        
        let usr = User()
        usr.setName(name: nameLabel.text!)
        usr.setSurname(surname: surnameLabel.text!)
        usr.setUsername(username: usernameLabel.text!)
        usr.setEmail(email: emailLabel.text!)
        usr.setPassword(password: newPassTxt.text!)
        usr.setURLimage(URLimage: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getURLimage())!)
        usr.setAds(ads: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getAds())!)
        usr.setFavorites(fvrts: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getFavorites())!)
        usr.setImage(image: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getImage())!)
        
        var isValid = true
        
        if nameLabel.text!.count < 2 {
            nameLabel.layer.borderWidth = 1
            nameLabel.layer.borderColor = UIColor.red.cgColor
            isValid = false
            displayAlertMessage(userMessage: "Il nome deve avere almeno 2 caratteri")
        }
        else {
            nameLabel.layer.borderWidth = 0
        }
        
        if surnameLabel.text!.count < 2 {
            surnameLabel.layer.borderWidth = 1
            surnameLabel.layer.borderColor = UIColor.red.cgColor
            isValid = false
            displayAlertMessage(userMessage: "Il cognome deve avere almeno 2 caratteri")
        }
        else {
            surnameLabel.layer.borderWidth = 0
        }
        
        if usernameLabel.text!.count < 2 {
            surnameLabel.layer.borderWidth = 1
            surnameLabel.layer.borderColor = UIColor.red.cgColor
            isValid = false
            displayAlertMessage(userMessage: "Lo username deve avere almeno 2 caratteri")
        }
        else {
            if UserFactory.isUsernamePresent(username: usernameLabel.text!, usrs: UserFactory.getInstance().getUsers()) && !usr.getUsername().elementsEqual(UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers()).getUsername()) {
                displayAlertMessage(userMessage: "Username già esistente")
                surnameLabel.layer.borderWidth = 1
                surnameLabel.layer.borderColor = UIColor.red.cgColor
                isValid = false
            }
            else {
                surnameLabel.layer.borderWidth = 0
            }
        }
        
        if isValid {
            
            var listOfAds0 : [Ad] = []
            
            for item in AdFactory.getInstance().getAds() {
                if item.getAuthor().elementsEqual((UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!) {
                    item.setAuthor(author: usr.getUsername())
                }
                
                listOfAds0.append(item)
            }
                
            var listOfAds1 : [Ad] = []
            
            for item in (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getAds())! {
                if item.getAuthor().elementsEqual((UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!) {
                    item.setAuthor(author: usr.getUsername())
                }
                
                listOfAds1.append(item)
            }
            
            var listOfAds2 : [Ad] = []
            
            for item in (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getFavorites())! {
                if item.getAuthor().elementsEqual((UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!) {
                    item.setAuthor(author: usr.getUsername())
                }
                
                listOfAds2.append(item)
            }
            
            UserFactory.deleteUser(username: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!)
            
            AdFactory.getInstance().setAds(ads: listOfAds0)
            usr.setAds(ads: listOfAds1)
            usr.setFavorites(fvrts: listOfAds2)
            
            UserFactory.addUser(newUser: usr, usrs: UserFactory.getInstance().getUsers())
            usr.setLogState(logged: true)
            
            showAlert()
            prepareMenu()
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Modifica effettuata con successo", message: "", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
        alert.view.backgroundColor = UIColor.green
        alert.view.layer.borderWidth = 0
        alert.view.layer.cornerRadius = 15
    }
    
    // The function shows an alert message with the given message
    func displayAlertMessage(userMessage : String) {
        let myAlert = UIAlertController(title: "Dati errati", message : userMessage, preferredStyle : UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title : "Ok", style : UIAlertAction.Style.default, handler : nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated : true, completion : nil)
    }
    
    //delte profile
    @IBAction func deleteUserBtn(_ sender: Any) {
        let myAlert = UIAlertController(title: "Elimina profilo", message : "Sei sicuro di voler eliminare il profilo?", preferredStyle : UIAlertController.Style.alert)
        
        let backAction = UIAlertAction(title : "Indietro", style : UIAlertAction.Style.cancel, handler : nil)
        myAlert.addAction(backAction)
        
        let confirmAction = UIAlertAction(title: "Conferma", style: UIAlertAction.Style.destructive) { (confirmAction) in
            UserFactory.deleteUser(username: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!)
            
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginNavigationController")
            self.present(loginViewController!, animated: true, completion: nil)
        }
    
        myAlert.addAction(confirmAction)
        
        self.present(myAlert, animated : true, completion : nil)
        
    }
    
    func prepareUser() {
        let usrs = UserFactory.getInstance()
        
        profileImage.image = UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getImage()
        profileImage.contentMode = .scaleAspectFill
        profileImage.contentScaleFactor = 2.5
        profileImage.setRounded()
        nameLabel.text =  UserFactory.getLoggedUser(usrs: usrs.getUsers())?.getName()
        surnameLabel.text =  UserFactory.getLoggedUser(usrs: usrs.getUsers())?.getSurname()
        usernameLabel.text =  UserFactory.getLoggedUser(usrs: usrs.getUsers())?.getUsername()
        emailLabel.text =  UserFactory.getLoggedUser(usrs: usrs.getUsers())?.getEmail()
        /*telephoneLabel.text =  /*MARK: - DA MODIFICARE*/"Telefono mancante"*/
        
    }
    
    func prepareMenu() {
        let usrs = UserFactory.getInstance()
        
        userLogged.text = UserFactory.getLoggedUser(usrs: usrs.getUsers())?.getName()
        userImage.image = UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getImage()
        userImage.contentMode = .scaleAspectFill
        userImage.contentScaleFactor = 2.5
        userImage.setRounded()
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        UserFactory.logout(username: ((UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers()))?.getUsername())!)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func lastAdsBtn(_ sender: Any) {
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.lastAdsFlag = true
        
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.myAdsFlag = false
        
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.favoritesAdFlag = false
    }
    
    @IBAction func myAdsBtn(_ sender: Any) {
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.lastAdsFlag = false
        
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.myAdsFlag = true
        
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.favoritesAdFlag = false
    }
    
    @IBAction func favoritesAdBtn(_ sender: Any) {
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.lastAdsFlag = false
        
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.myAdsFlag = false
        
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.favoritesAdFlag = true
    }
    
    
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    
}
