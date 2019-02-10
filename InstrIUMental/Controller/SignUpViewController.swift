//
//  SignUpViewController.swift
//  InstrIUMental
//
//  Created by Marco Ortu on 07/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    //Storyboard outlet
    
    // Text fields
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var nameText: DesignableTextField!
    @IBOutlet weak var surnameText: DesignableTextField!
    @IBOutlet weak var usernameText: DesignableTextField!
    @IBOutlet weak var emailText: DesignableTextField!
    @IBOutlet weak var passwordText: DesignableTextField!
    @IBOutlet weak var confirmPassTxt: DesignableTextField!
    
    // Labels
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var surnameLabel : UILabel!
    @IBOutlet weak var usernameLabel : UILabel!
    @IBOutlet weak var emailLabel : UILabel!
    @IBOutlet weak var passwordLabel : UILabel!
    @IBOutlet weak var confirmPassLabel : UILabel!
    
    //var for bottom constraint of password text field
    @IBOutlet weak var txtBC: NSLayoutConstraint!
    @IBOutlet weak var btnBC: NSLayoutConstraint!
    @IBOutlet weak var btnTC: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() //func for hide keyboard
        imageProfile.setRounded() //rounded image
        
        //fix textfield position when open keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        //fix textfield position when hide keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //textifield return to original position
        confirmPassTxt.delegate = self
        
        
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
                //self.btnBC.constant = (keyboardHeight - 56)
                
                
                UIView.animate(withDuration: 0.5) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    //func for fix textfield position when hide keyboard
    @objc func keyBoardWillHide(notification: Notification) {
        self.txtBC.constant = 150.0
        self.btnTC.constant = 58.0
        self.btnBC.constant = 36.0
        
        UIView.animate(withDuration: 0.6) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    // press camera button
    @IBAction func photoBtnClicked(_ sender: Any) {
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
        imageProfile.image = img
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signupBtnClicked (_ sender : Any) {
        let usrs : UserFactory = UserFactory.getInstance()
        
        let newUser : User = User()
        newUser.setName(name: nameText.text!)
        newUser.setSurname(surname: surnameText.text!)
        newUser.setUsername(username: usernameText.text!)
        newUser.setEmail(email: emailText.text!)
        newUser.setPassword(password: passwordText.text!)
        
        if UserFactory.isUserValid(usr: newUser) && newUser.getPassword().elementsEqual(confirmPassTxt.text!) && !UserFactory.isUsernamePresent(username: newUser.getUsername(), usrs: usrs.getUsers()) {
            UserFactory.addUser(newUser: newUser, usrs: usrs.getUsers())
            self.performSegue(withIdentifier: "seageFromAtoB", sender: self)
        }
        else {
            if newUser.getName().count < 2 {
                displayAlertMessage(title: "Dati errati", userMessage: "Il nome deve avere almeno 2 caratteri")
                nameText.layer.borderWidth = 1
                nameText.layer.borderColor = UIColor.red.cgColor
                nameLabel.textColor = UIColor.red
            }
            else {
                nameText.layer.borderWidth = 0
                nameLabel.textColor = UIColor.white
            }
            
            if newUser.getSurname().count < 2 {
                displayAlertMessage(title: "Dati errati", userMessage: "Il cognome deve avere almeno 2 caratteri")
                surnameText.layer.borderWidth = 1
                surnameText.layer.borderColor = UIColor.red.cgColor
                surnameLabel.textColor = UIColor.red
            }
            else {
                surnameText.layer.borderWidth = 0
                surnameLabel.textColor = UIColor.white
            }
            
            if newUser.getUsername().count < 2 {
                displayAlertMessage(title: "Dati errati", userMessage: "Lo username deve avere almeno 2 caratteri")
                usernameText.layer.borderWidth = 1
                usernameText.layer.borderColor = UIColor.red.cgColor
                usernameLabel.textColor = UIColor.red
            }
            else {
                if UserFactory.isUsernamePresent(username: newUser.getUsername(), usrs: usrs.getUsers()) {
                    displayAlertMessage(title: "Dati errati", userMessage: "Username già esistente")
                    usernameText.layer.borderWidth = 1
                    usernameText.layer.borderColor = UIColor.red.cgColor
                    usernameLabel.textColor = UIColor.red
                }
                else {
                    usernameText.layer.borderWidth = 0
                    usernameLabel.textColor = UIColor.white
                }
            }
            
            if newUser.getEmail().count < 7 {
                displayAlertMessage(title: "Dati errati", userMessage: "La email inserita non è valida")
                emailText.layer.borderWidth = 1
                emailText.layer.borderColor = UIColor.red.cgColor
                emailLabel.textColor = UIColor.red
            }
            else {
                emailText.layer.borderWidth = 0
                emailLabel.textColor = UIColor.white
            }
            
            if newUser.getPassword().count < 6 {
                displayAlertMessage(title: "Dati errati", userMessage: "La password deve avere almeno 6 caratteri")
                passwordText.layer.borderWidth = 1
                passwordText.layer.borderColor = UIColor.red.cgColor
                passwordLabel.textColor = UIColor.red
                
                confirmPassTxt.layer.borderWidth = 1
                confirmPassTxt.layer.borderColor = UIColor.red.cgColor
                confirmPassLabel.textColor = UIColor.red
                print("*************************************************************")
            }
            else {
                if !newUser.getPassword().elementsEqual(confirmPassTxt.text!) {
                    displayAlertMessage(title: "Dati errati", userMessage: "Le password non corrispondono")
                    passwordText.layer.borderWidth = 1
                    passwordText.layer.borderColor = UIColor.red.cgColor
                    passwordLabel.textColor = UIColor.red
                    
                    confirmPassTxt.layer.borderWidth = 1
                    confirmPassTxt.layer.borderColor = UIColor.red.cgColor
                    confirmPassLabel.textColor = UIColor.red
                }
                else {
                    passwordText.layer.borderWidth = 0
                    passwordLabel.textColor = UIColor.white
                    
                    confirmPassTxt.layer.borderWidth = 0
                    confirmPassLabel.textColor = UIColor.white
                }
            }
        }
    }
    
    // The function shows an alert message with the given message
    func displayAlertMessage(title: String, userMessage : String) {
        let myAlert = UIAlertController(title: title, message : userMessage, preferredStyle : UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title : "Ok", style : UIAlertAction.Style.default, handler : nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated : true, completion : nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



