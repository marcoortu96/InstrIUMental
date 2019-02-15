//
//  LoginViewController.swift
//  InstrIUMental
//
//  Created by Marco Ortu on 07/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameText: DesignableTextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordText: DesignableTextField!
    
    //var for bottom constraint of password text field
    @IBOutlet weak var txtBC: NSLayoutConstraint!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() //func for hide keyboard
        
        //fix textfield position when open keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        //fix textfield position when hide keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //textifield return to original position
        passwordText.delegate = self
    
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
                
                UIView.animate(withDuration: 0.5) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    //func for fix textfield position when open keyboard
    @objc func keyBoardWillHide(notification: Notification) {
        self.txtBC.constant = 191.0
        
        UIView.animate(withDuration: 0.6) {
            self.view.layoutIfNeeded()
        }

    }
    
    //press login button
    @IBAction func loginBtn(_ sender: Any) {
        let usrs : UserFactory = UserFactory.getInstance()
        
        if UserFactory.getUser(username: usernameText.text!, password: passwordText.text!, usrs : usrs.getUsers()) == nil {
            
            if UserFactory.isUsernamePresent(username: usernameText.text!, usrs: usrs.getUsers()) {
                print("Password error")
                displayAlertMessage(userMessage: "Password errata")
                usernameLabel.textColor = UIColor.white
                usernameText.layer.borderWidth = 0
                usernameText.layer.borderColor = UIColor.white.cgColor
                passwordLabel.textColor = UIColor.red
                passwordText.layer.borderWidth = 1
                passwordText.layer.borderColor = UIColor.red.cgColor
            }
            else {
                print("Username error")
                displayAlertMessage(userMessage: "Username o Password errati")
                usernameLabel.textColor = UIColor.red
                usernameText.layer.borderWidth = 1
                usernameText.layer.borderColor = UIColor.red.cgColor
                passwordLabel.textColor = UIColor.red
                passwordText.layer.borderWidth = 1
                passwordText.layer.borderColor = UIColor.red.cgColor
            }
        }
        else {
            print(usernameText.text!, " ", passwordText.text!)
            (UserFactory.getUser(username: usernameText.text!, password: passwordText.text!, usrs: usrs.getUsers()))?.setLogState(logged: true)
            
            (UserFactory.getUser(username: usernameText.text!, password: passwordText.text!, usrs: usrs.getUsers()))?.lastAdsFlag = true
        }
    }
    
    // The function shows an alert message with the given message
    func displayAlertMessage(userMessage : String) {
        let myAlert = UIAlertController(title: "Credenziali errate", message : userMessage, preferredStyle : UIAlertController.Style.alert)
        
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
