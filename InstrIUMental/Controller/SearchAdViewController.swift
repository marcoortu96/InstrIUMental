//
//  SearchAdViewController.swift
//  InstrIUMental
//
//  Created by batcave on 13/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import UIKit

class SearchAdViewController: UIViewController {

    @IBOutlet weak var priceValue: UILabel!
    var showMenu = false
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var closeMenu: UIView! //hidden view that manage the menu closing function
    @IBOutlet weak var menu: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    //username of the logged user
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userLogged: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preparemenu()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        
        closeMenu.addGestureRecognizer(tap)
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
        userImage.image = UIImage(named: UserFactory.getLoggedUser(usrs: usrs.getUsers()).getURLimage())
        userImage.contentMode = .scaleAspectFit
        userImage.backgroundColor = UIColor.white
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
