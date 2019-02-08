//
//  LoginViewController.swift
//  InstrIUMental
//
//  Created by Marco Ortu on 07/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameText: DesignableTextField!
    @IBOutlet weak var passwordText: DesignableTextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() //func for hide keyboard
        

        // Do any additional setup after loading the view.
    }
    
    //press login button
    @IBAction func loginBtn(_ sender: Any) {
        let usrs : UserFactory = UserFactory.getInstance()
        
        if UserFactory.getUser(username: usernameText.text!, password: passwordText.text!, usrs : usrs.getUsers()) == nil {
            
            if UserFactory.isUsernamePresent(username: usernameText.text!, usrs: usrs.getUsers()) {
                print("Password error")
            }
            else {
                print("Username error")
            }
        }
        else {
            print(usernameText.text!, " ", passwordText.text!)
        }
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
