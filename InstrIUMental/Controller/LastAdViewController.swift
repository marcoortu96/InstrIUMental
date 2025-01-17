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
    
    //var for searching ads in SearchAdViewController
    var stringFound = String()
    var minPrice = String()
    var maxPrice = String()
    var stringCategory = String()
    var stringRegion = String()
    
    
    @IBOutlet weak var closeMenu: UIView! //hidden view that manage the menu closing function
    @IBOutlet weak var menu: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    //username of the logged user
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userLogged: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preparemenu()
        menu.isHidden = true
        
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
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.menu.isHidden = true
            }
            
        } else {
            menu.isHidden = false
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
        userImage.image = UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getImage()
        userImage.contentMode = .scaleAspectFill
        userImage.contentScaleFactor = 2.5
        userImage.setRounded()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.lastAdsFlag == true {
            self.title = "Ultimi Annunci"
            self.navigationItem.rightBarButtonItem = nil
            
            return ads.getAds().count
        }
        else if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.myAdsFlag == true {
            self.title = "I Miei Annunci"
            
            
            return (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getAds().count)!
        }
        else if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.favoritesAdFlag == true {
            self.title = "Preferiti"
            self.navigationItem.rightBarButtonItem = nil
            
            return (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getFavorites().count)!
        }
        else if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.searchFlag == true {
            if stringFound != "" {
                self.title = "Risultati per ''" + stringFound + "''"
            }
            else if stringCategory != "" {
                self.title = "Risultati per ''" + stringCategory + "''"
            }
            else if stringRegion != "" {
                self.title = "Risultati per ''" + stringRegion + "''"
            }
            else if minPrice != "" && maxPrice != "" {
                self.title = "Risultati da " + minPrice + "€ a " + maxPrice + "€"
            } else {
                self.title = "Risultati"
            }
            
            self.navigationItem.leftBarButtonItem = nil
            self.navigationItem.rightBarButtonItem = nil
            
            var adSort: [Ad] = AdFactory.getInstance().getAds()
            
            if stringFound != "" {
                adSort = AdFactory.getAdsByTitle(title: stringFound, adsSet: adSort).sorted() {$0.getDate() > $1.getDate()}
            }
            
            if stringCategory != "" {
                adSort = AdFactory.getAdsByCategory(category: stringCategory, adsSet: adSort)
                
            }
            
            if stringRegion != "" {
                adSort = AdFactory.getAdsByRegion(region: stringRegion, adSet: adSort)
            }
            
            let min = Float(minPrice)
            let max = Float(maxPrice)
            
            if min != nil && max != nil {
                adSort = AdFactory.getAdsByPrice(lowestPrice: min!, highestPrice: max!, adsSet: adSort)
            }
            
            return adSort.count
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
            
            var currentPrice = String(Float(round(ad.getPrice() * 100) / 100))
            if (currentPrice.components(separatedBy: ".")[1]).count == 1 {
                currentPrice = currentPrice + "0"
            }
            
            cell.adImageView?.image = ad.getImage()[0]
            cell.adImageView.contentMode = .scaleAspectFill
            cell.adImageView.clipsToBounds = true
            cell.adTitleLabel?.text = ad.getTitle()
            cell.adDescrLabel?.text = ad.getText()
            cell.nameUserLabel?.text = "di " + ad.getAuthor()
            cell.adDateLabel?.text = (ad.getDate().components(separatedBy: "-")[2])+"-"+(ad.getDate().components(separatedBy: "-")[1])+"-"+(ad.getDate().components(separatedBy: "-")[0])
            cell.adPriceLabel?.text = currentPrice + " €"
            cell.adRegionLabel.text = ad.getRegion()
        }
        else if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.myAdsFlag == true {
            let adSort = UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getAds().sorted() {$0.getDate() > $1.getDate()}
            
            //let ad: Ad = ads.getAds() [indexPath.row]
            let ad: Ad = adSort! [indexPath.row]
            
            var currentPrice = String(Float(round(ad.getPrice() * 100) / 100))
            if (currentPrice.components(separatedBy: ".")[1]).count == 1 {
                currentPrice = currentPrice + "0"
            }
            
            cell.adImageView?.image = ad.getImage()[0]
            cell.adImageView.contentMode = .scaleAspectFill
            cell.adImageView.clipsToBounds = true
            cell.adTitleLabel?.text = ad.getTitle()
            cell.adDescrLabel?.text = ad.getText()
            cell.nameUserLabel?.text = "di " + ad.getAuthor()
            cell.adDateLabel?.text = (ad.getDate().components(separatedBy: "-")[2])+"-"+(ad.getDate().components(separatedBy: "-")[1])+"-"+(ad.getDate().components(separatedBy: "-")[0])
            cell.adPriceLabel?.text = currentPrice + " €"
            cell.adRegionLabel.text = ad.getRegion()
        }
            
        else if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.searchFlag == true {
            var adSort: [Ad] = AdFactory.getInstance().getAds().sorted() {$0.getDate() > $1.getDate()}
            
            if stringFound != "" {
                adSort = AdFactory.getAdsByTitle(title: stringFound, adsSet: adSort).sorted() {$0.getDate() > $1.getDate()}
            }
            
            if stringCategory != "" {
                adSort = AdFactory.getAdsByCategory(category: stringCategory, adsSet: adSort)
            }
            
            if stringRegion != "" {
                adSort = AdFactory.getAdsByRegion(region: stringRegion, adSet: adSort)
            }
            
            let min = Float(minPrice)
            let max = Float(maxPrice)
            
            if min != nil && max != nil {
                adSort = AdFactory.getAdsByPrice(lowestPrice: min!, highestPrice: max!, adsSet: adSort)
            }
            
            //let ad: Ad = ads.getAds() [indexPath.row]
            let ad: Ad = adSort [indexPath.row]
            
            var currentPrice = String(Float(round(ad.getPrice() * 100) / 100))
            if (currentPrice.components(separatedBy: ".")[1]).count == 1 {
                currentPrice = currentPrice + "0"
            }
            
            cell.adImageView?.image = ad.getImage()[0]
            cell.adImageView.contentMode = .scaleAspectFill
            cell.adImageView.clipsToBounds = true
            cell.adTitleLabel?.text = ad.getTitle()
            cell.adDescrLabel?.text = ad.getText()
            cell.nameUserLabel?.text = "di " + ad.getAuthor()
            cell.adDateLabel?.text = (ad.getDate().components(separatedBy: "-")[2])+"-"+(ad.getDate().components(separatedBy: "-")[1])+"-"+(ad.getDate().components(separatedBy: "-")[0])
            cell.adPriceLabel?.text = currentPrice + " €"
            cell.adRegionLabel.text = ad.getRegion()
        }
            
        else if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.favoritesAdFlag == true {
            let adSort = UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getFavorites().sorted() {$0.getDate() > $1.getDate()}
            
            //let ad: Ad = ads.getAds() [indexPath.row]
            let ad: Ad = adSort! [indexPath.row]
            
            var currentPrice = String(Float(round(ad.getPrice() * 100) / 100))
            if (currentPrice.components(separatedBy: ".")[1]).count == 1 {
                currentPrice = currentPrice + "0"
            }
            
            cell.adImageView?.image = ad.getImage()[0]
            cell.adImageView.contentMode = .scaleAspectFill
            cell.adImageView.clipsToBounds = true
            cell.adTitleLabel?.text = ad.getTitle()
            cell.adDescrLabel?.text = ad.getText()
            cell.nameUserLabel?.text = "di " + ad.getAuthor()
            cell.adDateLabel?.text = (ad.getDate().components(separatedBy: "-")[2])+"-"+(ad.getDate().components(separatedBy: "-")[1])+"-"+(ad.getDate().components(separatedBy: "-")[0])
            cell.adPriceLabel?.text = currentPrice + " €"
            cell.adRegionLabel.text = ad.getRegion()
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        
        if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.lastAdsFlag == true {
            let adSort = ads.getAds().sorted() {$0.getDate() > $1.getDate()}
            let currentAd = adSort [indexPath.row]
            
            var currentPrice = String(Float(round(currentAd.getPrice() * 100) / 100))
            if (currentPrice.components(separatedBy: ".")[1]).count == 1 {
                currentPrice = currentPrice + "0"
            }
            
            //send ad data to next view
            let vc = storyboard?.instantiateViewController(withIdentifier: "AdDetailViewController") as? AdDetailViewController
            vc?.adTitle = currentAd.getTitle()
            vc?.adText = currentAd.getText()
            vc?.category = currentAd.getCategory()
            vc?.price = currentPrice + " €"
            vc?.author = currentAd.getAuthor()
            vc?.date = (currentAd.getDate().components(separatedBy: "-")[2])+"-"+(currentAd.getDate().components(separatedBy: "-")[1])+"-"+(currentAd.getDate().components(separatedBy: "-")[0])
            vc?.adId = currentAd.getId()
            vc?.region = currentAd.getRegion()
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.myAdsFlag == true {
            let adSort = UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getAds().sorted() {$0.getDate() > $1.getDate()}
            let currentAd = adSort! [indexPath.row]
            
            var currentPrice = String(Float(round(currentAd.getPrice() * 100) / 100))
            if (currentPrice.components(separatedBy: ".")[1]).count == 1 {
                currentPrice = currentPrice + "0"
            }
            
            //send ad data to next view
            let vc = storyboard?.instantiateViewController(withIdentifier: "AdDetailViewController") as? AdDetailViewController
            vc?.adTitle = currentAd.getTitle()
            vc?.adText = currentAd.getText()
            vc?.category = currentAd.getCategory()
            vc?.price = currentPrice + " €"
            vc?.author = currentAd.getAuthor()
            vc?.date = (currentAd.getDate().components(separatedBy: "-")[2])+"-"+(currentAd.getDate().components(separatedBy: "-")[1])+"-"+(currentAd.getDate().components(separatedBy: "-")[0])
            vc?.adId = currentAd.getId()
            vc?.region = currentAd.getRegion()
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.favoritesAdFlag == true {
            let adSort = UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getFavorites().sorted() {$0.getDate() > $1.getDate()}
            let currentAd = adSort! [indexPath.row]
            
            //send ad data to next view
            let vc = storyboard?.instantiateViewController(withIdentifier: "AdDetailViewController") as? AdDetailViewController
            
            var currentPrice = String(Float(round(currentAd.getPrice() * 100) / 100))
            if (currentPrice.components(separatedBy: ".")[1]).count == 1 {
                currentPrice = currentPrice + "0"
            }
            
            vc?.adTitle = currentAd.getTitle()
            vc?.adText = currentAd.getText()
            vc?.category = currentAd.getCategory()
            vc?.price = currentPrice + " €"
            vc?.author = currentAd.getAuthor()
            vc?.date = (currentAd.getDate().components(separatedBy: "-")[2])+"-"+(currentAd.getDate().components(separatedBy: "-")[1])+"-"+(currentAd.getDate().components(separatedBy: "-")[0])
            vc?.adId = currentAd.getId()
            vc?.region = currentAd.getRegion()
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.searchFlag == true {
            var adSort: [Ad] = AdFactory.getInstance().getAds().sorted() {$0.getDate() > $1.getDate()}
            
            if stringFound != "" {
                adSort = AdFactory.getAdsByTitle(title: stringFound, adsSet: adSort).sorted() {$0.getDate() > $1.getDate()}
            }
            
            if stringCategory != "" {
                adSort = AdFactory.getAdsByCategory(category: stringCategory, adsSet: adSort)
            }
            
            if stringRegion != "" {
                adSort = AdFactory.getAdsByRegion(region: stringRegion, adSet: adSort)
            }
            
            let min = Float(minPrice)
            let max = Float(maxPrice)
            
            if min != nil && max != nil {
                adSort = AdFactory.getAdsByPrice(lowestPrice: min!, highestPrice: max!, adsSet: adSort)
            }
            
            let currentAd = adSort [indexPath.row]
            
            //send ad data to next view
            let vc = storyboard?.instantiateViewController(withIdentifier: "AdDetailViewController") as? AdDetailViewController
            
            var currentPrice = String(Float(round(currentAd.getPrice() * 100) / 100))
            if (currentPrice.components(separatedBy: ".")[1]).count == 1 {
                currentPrice = currentPrice + "0"
            }
            
            vc?.adTitle = currentAd.getTitle()
            vc?.adText = currentAd.getText()
            vc?.category = currentAd.getCategory()
            vc?.price = currentPrice + " €"
            vc?.author = currentAd.getAuthor()
            vc?.date = (currentAd.getDate().components(separatedBy: "-")[2])+"-"+(currentAd.getDate().components(separatedBy: "-")[1])+"-"+(currentAd.getDate().components(separatedBy: "-")[0])
            vc?.adId = currentAd.getId()
            vc?.region = currentAd.getRegion()
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else {
            let adSort = ads.getAds().sorted() {$0.getDate() > $1.getDate()}
            let currentAd = adSort [indexPath.row]
            
            //send ad data to next view
            var currentPrice = String(Float(round(currentAd.getPrice() * 100) / 100))
            if (currentPrice.components(separatedBy: ".")[1]).count == 1 {
                currentPrice = currentPrice + "0"
            }
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "AdDetailViewController") as? AdDetailViewController
            vc?.adTitle = currentAd.getTitle()
            vc?.adText = currentAd.getText()
            vc?.category = currentAd.getCategory()
            vc?.price = currentPrice + " €"
            vc?.author = currentAd.getAuthor()
            vc?.date = (currentAd.getDate().components(separatedBy: "-")[2])+"-"+(currentAd.getDate().components(separatedBy: "-")[1])+"-"+(currentAd.getDate().components(separatedBy: "-")[0])
            vc?.adId = currentAd.getId()
            vc?.region = currentAd.getRegion()
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    func showAlert(title: String, color: UIColor) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
        alert.view.backgroundColor = color
        alert.view.layer.borderWidth = 0
        alert.view.layer.cornerRadius = 15
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.lastAdsFlag == true {
            let adSort = ads.getAds().sorted() {$0.getDate() > $1.getDate()}
            let currentAd = adSort [indexPath.row]
            
            
            if currentAd.getAuthor() ==  UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername() {
                let dontFav = UITableViewRowAction(style: .normal, title: "♡") { (action, indexPath) in
                    self.showAlert(title: "Non puoi aggiungere un tuo annuncio tra i preferiti", color: UIColor.red)
                }
                
                return [dontFav]
                
            } else {
                let favorite = UITableViewRowAction(style: .normal, title: "♡") { (action, indexPath) in
                    // share item at indexPath
                    self.isEditing = false
                    print("fav at index \(indexPath.row)")
                    
                    if ((UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers()))?.isFavoriteAdPresent(adId: currentAd.getId()))! {
                        UserFactory.removeFavorite(ad: AdFactory.getAdById(id: currentAd.getId(), adsSet: AdFactory.getInstance().getAds()), username: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!)
                        self.showAlert(title: "Rimosso dai preferiti", color: UIColor.white)
                        tableView.reloadData()
                    } else {
                        UserFactory.addFavorite(ad: AdFactory.getAdById(id: currentAd.getId(), adsSet: AdFactory.getInstance().getAds()), username: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!)
                        self.showAlert(title: "Aggiunto ai preferiti", color: UIColor.white)
                    }
                }
                
                if ((UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers()))?.isFavoriteAdPresent(adId: currentAd.getId()))! {
                    favorite.title = "♥︎\nRimuovi"
                    
                }
                else {
                    favorite.title = "♡\nAggiungi"
                }
                
                favorite.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 1, alpha: 0.20)
                
                return [favorite]
            }
            
        }
        else if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.myAdsFlag == true {
            let adSort = UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getAds().sorted() {$0.getDate() > $1.getDate()}
            let currentAd = adSort! [indexPath.row]
            
            //delete row from my ad
            let delete = UITableViewRowAction(style: .destructive, title: "Elimina") { (action, indexPath) in
                
                self.isEditing = false
                
                let myAlert = UIAlertController(title: "Elimina annuncio", message : "Sei sicuro di voler eliminare questo annuncio?", preferredStyle : UIAlertController.Style.alert)
                
                let backAction = UIAlertAction(title : "Indietro", style : UIAlertAction.Style.cancel, handler : nil)
                myAlert.addAction(backAction)
                
                let confirmAction = UIAlertAction(title: "Conferma", style: UIAlertAction.Style.destructive) { (confirmAction) in
                    for myAd in (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getAds())! {
                        if myAd.getId() == currentAd.getId() {
                            UserFactory.removeAd(ad: myAd, username: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!)
                            self.showAlert(title: "Annuncio rimosso", color: UIColor.white)
                            tableView.reloadData()
                        }
                    }
                    
                    //remove ad from last ad view
                    for ad in AdFactory.getInstance().getAds() {
                        if ad.getId() == currentAd.getId() {
                            AdFactory.removeFromLastAd(ad: ad)
                        }
                    }
                }
                
                myAlert.addAction(confirmAction)
                
                self.present(myAlert, animated : true, completion : nil)
            }
            
            let modify = UITableViewRowAction(style: .normal, title: "Modifica") { (action, indexPath) in
                
                self.isEditing = false
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "InsertAdController") as! InsertAdController
                
                vc.title = "Modifica annuncio"
                
                var currentPrice = String(Float(round(currentAd.getPrice() * 100) / 100))
                if (currentPrice.components(separatedBy: ".")[1]).count == 1 {
                    currentPrice = currentPrice + "0"
                }
                
                vc.adTitle = currentAd.getTitle()
                vc.adText = currentAd.getText()
                vc.adCategory = currentAd.getCategory()
                vc.adPrice = currentPrice
                vc.adRegion = currentAd.getRegion()
                vc.adId = currentAd.getId()
                vc.adImages = currentAd.getImage()
                vc.adAuthor = currentAd.getAuthor()
                
                //self.present(vc, animated: true, completion: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            modify.backgroundColor = UIColor.init(displayP3Red: 0.9, green: 0.7, blue: 0.3, alpha: 0.9)
            
            return [delete, modify]
        }
        else if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.favoritesAdFlag == true {
            let adSort = UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getFavorites().sorted() {$0.getDate() > $1.getDate()}
            let currentAd = adSort! [indexPath.row]
            
            let favorite = UITableViewRowAction(style: .normal, title: "♥︎\nRimuovi") { (action, indexPath) in
                // share item at indexPath
                self.isEditing = false
                print("fav at index \(indexPath.row)")
                for fav in (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getFavorites())! {
                    if fav.getId() == currentAd.getId() {
                        
                    }
                }
                
                if ((UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers()))?.isFavoriteAdPresent(adId: currentAd.getId()))! {
                    UserFactory.removeFavorite(ad: AdFactory.getAdById(id: currentAd.getId(), adsSet: AdFactory.getInstance().getAds()), username: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!)
                    self.showAlert(title: "Rimosso dai preferiti", color: UIColor.white)
                    tableView.reloadData()
                } else {
                    UserFactory.addFavorite(ad: AdFactory.getAdById(id: currentAd.getId(), adsSet: AdFactory.getInstance().getAds()), username: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!)
                    self.showAlert(title: "Aggiunto ai preferiti", color: UIColor.white)
                }
            }
            
            favorite.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 1, alpha: 0.20)
            
            return [favorite]
        }
        else if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.searchFlag == true{
            var adSort: [Ad] = AdFactory.getInstance().getAds().sorted() {$0.getDate() > $1.getDate()}
            
            if stringFound != "" {
                adSort = AdFactory.getAdsByTitle(title: stringFound, adsSet: adSort).sorted() {$0.getDate() > $1.getDate()}
            }
            
            if stringCategory != "" {
                adSort = AdFactory.getAdsByCategory(category: stringCategory, adsSet: adSort)
            }
            
            if stringRegion != "" {
                adSort = AdFactory.getAdsByRegion(region: stringRegion, adSet: adSort)
            }
            
            let min = Float(minPrice)
            let max = Float(maxPrice)
            
            if min != nil && max != nil {
                adSort = AdFactory.getAdsByPrice(lowestPrice: min!, highestPrice: max!, adsSet: adSort)
            }
            
            let currentAd = adSort [indexPath.row]
            
            let favorite = UITableViewRowAction(style: .normal, title:"") { (action, indexPath) in
                // share item at indexPath
                self.isEditing = false
                print("fav at index \(indexPath.row)")
                for fav in (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getFavorites())! {
                    if fav.getId() == currentAd.getId() {
                        
                    }
                }
                
                if ((UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers()))?.isFavoriteAdPresent(adId: currentAd.getId()))! {
                    UserFactory.removeFavorite(ad: AdFactory.getAdById(id: currentAd.getId(), adsSet: AdFactory.getInstance().getAds()), username: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!)
                    self.showAlert(title: "Rimosso dai preferiti", color: UIColor.white)
                    tableView.reloadData()
                } else {
                    UserFactory.addFavorite(ad: AdFactory.getAdById(id: currentAd.getId(), adsSet: AdFactory.getInstance().getAds()), username: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!)
                    self.showAlert(title: "Aggiunto ai preferiti", color: UIColor.white)
                }
            }
            
            if ((UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers()))?.isFavoriteAdPresent(adId: currentAd.getId()))! {
                favorite.title = "♥︎\nRimuovi"
                
            }
            else {
                favorite.title = "♡\nAggiungi"
            }
            
            favorite.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 1, alpha: 0.20)
            
            return [favorite]
        }
            
        else {
            let adSort = ads.getAds().sorted() {$0.getDate() > $1.getDate()}
            let currentAd = adSort [indexPath.row]
            
            let favorite = UITableViewRowAction(style: .normal, title: "♡") { (action, indexPath) in
                // share item at indexPath
                self.isEditing = false
                print("fav at index \(indexPath.row)")
                for fav in (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getFavorites())! {
                    if fav.getId() == currentAd.getId() {
                        
                    }
                }
                
                if ((UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers()))?.isFavoriteAdPresent(adId: currentAd.getId()))! {
                    UserFactory.removeFavorite(ad: AdFactory.getAdById(id: currentAd.getId(), adsSet: AdFactory.getInstance().getAds()), username: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!)
                    self.showAlert(title: "Rimosso dai preferiti", color: UIColor.white)
                    tableView.reloadData()
                } else {
                    UserFactory.addFavorite(ad: AdFactory.getAdById(id: currentAd.getId(), adsSet: AdFactory.getInstance().getAds()), username: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!)
                    self.showAlert(title: "Aggiunto ai preferiti", color: UIColor.white)
                }
            }
            if ((UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers()))?.isFavoriteAdPresent(adId: currentAd.getId()))! {
                favorite.title = "♥︎\nRimuovi"
                
            }
            else {
                favorite.title = "♡\nAggiungi"
            }
            
            favorite.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 1, alpha: 0.20)
            
            return [favorite]
            
            
        }
        
        
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
    
    @IBAction func searchBtn(_ sender: Any) {
        
        
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
    
    @IBAction func favoritesAdBtn(_ sender: Any) {
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.lastAdsFlag = false
        
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.myAdsFlag = false
        
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.favoritesAdFlag = true
        
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.searchFlag = false
    }
    
    func searchBtn () {
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.lastAdsFlag = false
        
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.myAdsFlag = false
        
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.favoritesAdFlag = false
        
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.searchFlag = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView!.reloadData()
    }
}
