//
//  SignUpViewController.swift
//  InstrIUMental
//
//  Created by Marco Ortu on 07/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var nameText: DesignableTextField!
    @IBOutlet weak var surnameText: DesignableTextField!
    @IBOutlet weak var usernameText: DesignableTextField!
    @IBOutlet weak var emailText: DesignableTextField!
    @IBOutlet weak var passwordText: DesignableTextField!
    
    //Storyboard outlet
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var confirmPassTxt: DesignableTextField!
    
    //var for bottom constraint of password text field
    @IBOutlet weak var txtBC: NSLayoutConstraint!
    
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
                
                UIView.animate(withDuration: 0.5) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    //func for fix textfield position when open keyboard
    @objc func keyBoardWillHide(notification: Notification) {
        self.txtBC.constant = 150.0
        
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



