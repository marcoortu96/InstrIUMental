//
//  ProfileViewController.swift
//  InstrIUMental
//
//  Created by batcave on 11/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var showMenu = false
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var menu: UIView!
    
    //username of the logged user
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userLogged: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var telephoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareMenu()
        prepareUser()
    }
    
    @IBAction func openMenu(_ sender: Any) {
        if(showMenu) {
            leadingConstraint.constant = -240
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        } else {
            leadingConstraint.constant = 0
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
        showMenu = !showMenu
    }
    
    func prepareUser() {
        let usrs = UserFactory.getInstance()
        
        profileImage.image = UIImage(named: UserFactory.getLoggedUser(usrs: usrs.getUsers()).getURLimage())
        profileImage.setRounded()
        nameLabel.text =  UserFactory.getLoggedUser(usrs: usrs.getUsers())?.getName()
        surnameLabel.text =  UserFactory.getLoggedUser(usrs: usrs.getUsers())?.getSurname()
        usernameLabel.text =  UserFactory.getLoggedUser(usrs: usrs.getUsers())?.getUsername()
        emailLabel.text =  UserFactory.getLoggedUser(usrs: usrs.getUsers())?.getEmail()
        telephoneLabel.text =  /*MARK: - DA MODIFICARE*/"Telefono mancante"
        
    }
    
    func prepareMenu() {
        menu.backgroundColor = UIColor.init(red: 0.813, green: 0.689, blue: 0.353, alpha: 0.95)
        
        let usrs = UserFactory.getInstance()
        
        userLogged.text = UserFactory.getLoggedUser(usrs: usrs.getUsers())?.getName()
        userImage.image = UIImage(named: UserFactory.getLoggedUser(usrs: usrs.getUsers()).getURLimage())
        userImage.setRounded()
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
