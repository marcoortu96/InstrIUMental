//
//  LastAdViewController.swift
//  InstrIUMental
//
//  Created by Marco Ortu on 07/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import UIKit

class LastAdViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView?
    let ads = AdFactory.getInstance()
    
    //use for index the ads
    var myIndex = 0
    
    //variables for the side menu
    var showMenu = false
    
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
        for subview in (tableView?.subviews)! {
            subview.removeFromSuperview()
        }
        showMenu = !showMenu
        leadingConstraint.constant = -240
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        tableView?.isUserInteractionEnabled = true
        tableView?.reloadData()
    }
    
    //func that controls the side menu
    @IBAction func openMenu(_ sender: Any) {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        if(showMenu) {
            leadingConstraint.constant = -240
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
            
            tableView?.isUserInteractionEnabled = true
            
            for subview in (tableView?.subviews)! {
                subview.removeFromSuperview()
            }
            
            tableView?.reloadData()
            
        } else {
            leadingConstraint.constant = 0
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
            tableView?.isUserInteractionEnabled = false
            
            blurEffectView.frame = tableView!.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurEffectView.alpha = 0.7
            
            tableView!.addSubview(blurEffectView)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.lastAdsFlag == true {
            self.title = "Ultimi Annunci"
            return ads.getAds().count
        }
        else if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.myAdsFlag == true {
            self.title = "I Miei Annunci"
            return (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getAds().count)!
        }
        else if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.favoritesAdFlag == true {
            self.title = "Preferiti"
            return (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getFavorites().count)!
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdsTableViewCell") as! AdsTableViewCell
        
        if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.lastAdsFlag == true {
            let adSort = ads.getAds().sorted() {$0.getDate() > $1.getDate()}
            
            //let ad: Ad = ads.getAds() [indexPath.row]
            let ad: Ad = adSort [indexPath.row]
            
            cell.adImageView?.image = UIImage(named: ad.getImg()[0])
            cell.adTitleLabel?.text = ad.getTitle()
            cell.adDescrLabel?.text = ad.getText()
            cell.nameUserLabel?.text = "di " + ad.getAuthor()
            cell.adDateLabel?.text = ad.getDate()
            cell.adPriceLabel?.text = String(ad.getPrice()) + "0 €"
        }
        else if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.myAdsFlag == true {
            let adSort = UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getAds().sorted() {$0.getDate() > $1.getDate()}
            
            //let ad: Ad = ads.getAds() [indexPath.row]
            let ad: Ad = adSort! [indexPath.row]
            
            cell.adImageView?.image = UIImage(named: ad.getImg()[0])
            cell.adTitleLabel?.text = ad.getTitle()
            cell.adDescrLabel?.text = ad.getText()
            cell.nameUserLabel?.text = "di " + ad.getAuthor()
            cell.adDateLabel?.text = ad.getDate()
            cell.adPriceLabel?.text = String(ad.getPrice()) + "0 €"
        }
        else if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.favoritesAdFlag == true {
            let adSort = UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getFavorites().sorted() {$0.getDate() > $1.getDate()}
            
            //let ad: Ad = ads.getAds() [indexPath.row]
            let ad: Ad = adSort! [indexPath.row]
            
            cell.adImageView?.image = UIImage(named: ad.getImg()[0])
            cell.adTitleLabel?.text = ad.getTitle()
            cell.adDescrLabel?.text = ad.getText()
            cell.nameUserLabel?.text = "di " + ad.getAuthor()
            cell.adDateLabel?.text = ad.getDate()
            cell.adPriceLabel?.text = String(ad.getPrice()) + "0 €"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        
        if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.lastAdsFlag == true {
            let adSort = ads.getAds().sorted() {$0.getDate() > $1.getDate()}
            let currentAd = adSort [indexPath.row]
            
            //send ad data to next view
            let vc = storyboard?.instantiateViewController(withIdentifier: "AdDetailViewController") as? AdDetailViewController
            vc?.adTitle = currentAd.getTitle()
            vc?.adText = currentAd.getText()
            vc?.category = currentAd.getCategory()
            vc?.price = String(currentAd.getPrice()) + "0 €"
            vc?.author = currentAd.getAuthor()
            vc?.date = currentAd.getDate()
            vc?.adId = currentAd.getId()
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.myAdsFlag == true {
            let adSort = UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getAds().sorted() {$0.getDate() > $1.getDate()}
            let currentAd = adSort! [indexPath.row]
            
            //send ad data to next view
            let vc = storyboard?.instantiateViewController(withIdentifier: "AdDetailViewController") as? AdDetailViewController
            vc?.adTitle = currentAd.getTitle()
            vc?.adText = currentAd.getText()
            vc?.category = currentAd.getCategory()
            vc?.price = String(currentAd.getPrice()) + "0 €"
            vc?.author = currentAd.getAuthor()
            vc?.date = currentAd.getDate()
            vc?.adId = currentAd.getId()
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.favoritesAdFlag == true {
            let adSort = UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getFavorites().sorted() {$0.getDate() > $1.getDate()}
            let currentAd = adSort! [indexPath.row]
            
            //send ad data to next view
            let vc = storyboard?.instantiateViewController(withIdentifier: "AdDetailViewController") as? AdDetailViewController
            vc?.adTitle = currentAd.getTitle()
            vc?.adText = currentAd.getText()
            vc?.category = currentAd.getCategory()
            vc?.price = String(currentAd.getPrice()) + "0 €"
            vc?.author = currentAd.getAuthor()
            vc?.date = currentAd.getDate()
            vc?.adId = currentAd.getId()
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else {
            let adSort = ads.getAds().sorted() {$0.getDate() > $1.getDate()}
            let currentAd = adSort [indexPath.row]
            
            //send ad data to next view
            let vc = storyboard?.instantiateViewController(withIdentifier: "AdDetailViewController") as? AdDetailViewController
            vc?.adTitle = currentAd.getTitle()
            vc?.adText = currentAd.getText()
            vc?.category = currentAd.getCategory()
            vc?.price = String(currentAd.getPrice()) + "0 €"
            vc?.author = currentAd.getAuthor()
            vc?.date = currentAd.getDate()
            vc?.adId = currentAd.getId()
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    
    @IBAction func logoutBtn(_ sender: Any) {
        UserFactory.logout(username: ((UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers()))?.getUsername())!)
    }
    
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
