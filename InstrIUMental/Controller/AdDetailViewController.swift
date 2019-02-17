//
//  AdDetailViewController.swift
//  InstrIUMental
//
//  Created by Marco Ortu on 09/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import UIKit
import MessageUI

class AdDetailViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var adTitle = String()
    var adText = String()
    var price = String()
    var category = String()
    var author = String()
    var date = String()
    var adId = Int()
    
    let factory = AdFactory.getInstance()
    let factoryUser = UserFactory.getInstance()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    //Outlet storyboard
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    //outlet for next and previous image button
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = adTitle
        descriptionLabel.text = adText
        categoryLabel.text = category
        userNameLabel.text = author
        dateLabel.text = date
        priceLabel.text = price
        
        if UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername() == userNameLabel.text {
            favoriteBtn.isHidden = true
        }
        
        if (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.isFavoriteAdPresent(adId: adId))! {
            favoriteBtn.setImage(UIImage(named: "favoriteFull"), for: UIControl.State.normal)
        } else if (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.isFavoriteAdPresent(adId: adId))! == false {
            favoriteBtn.setImage(UIImage(named: "favorite"), for: UIControl.State.normal)
        }
        
        //change image with next and previous button
        nextBtn.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        prevBtn.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        
        //don't change the image from page control
        pageControl.isEnabled = false
    }
    
    //func for change to next image
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage+1, 2)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    //func for change to previous image
    @objc private func handlePrev() {
        let nextIndex = max(pageControl.currentPage-1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func PressFavoritesBtn(_ sender: Any) {
        
        if favoriteBtn.imageView?.image == UIImage(named: "favorite") {
            UserFactory.addFavorite(ad: AdFactory.getAdById(id: adId, adsSet: AdFactory.getInstance().getAds()), username: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!)
            
            favoriteBtn.setImage(UIImage(named: "favoriteFull"), for: UIControl.State.normal)
            
            showAlert(title: "Aggiunto ai preferiti", color: UIColor.white)
            
        } else if favoriteBtn.imageView?.image == UIImage(named: "favoriteFull") {
            UserFactory.removeFavorite(ad: AdFactory.getAdById(id: adId, adsSet: AdFactory.getInstance().getAds()), username: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!)
            
            favoriteBtn.setImage(UIImage(named: "favorite"), for: UIControl.State.normal)
            showAlert(title: "Rimosso dai preferiti", color: UIColor.white)
            
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
    
    //Button to contact the seller
    @IBAction func sendEmail(_ sender: Any) {
        let mailComposeViewController = configureMailController()
        
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            showEmailError()
        }
    }
    
    func configureMailController() -> MFMailComposeViewController {
        let id = AdFactory.getAdById(id: adId, adsSet: factory.getAds())
        let user = UserFactory.getUserByUsername(username: (id?.getAuthor())!, usrs: factoryUser.getUsers())
        
        let mailComposerVC = MFMailComposeViewController()
        
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([(user?.getEmail())!])
        mailComposerVC.setSubject("[info]" + (id?.getTitle())!)
        
        return mailComposerVC
    }
    
    func showEmailError() {
        let sendEmailErrorAlert = UIAlertController(title: "Non puoi inviare la mail", message: "Il tuo dispositivo non è connesso a nessuna mail", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
        sendEmailErrorAlert.addAction(dismiss)
        self.present(sendEmailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}

//Extension of this class for pick the imageView from UICollection view
extension AdDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DataCollectionViewCell
        
        //take ads image
        //let factory = AdFactory.getInstance()
        let id = AdFactory.getAdById(id: adId, adsSet: factory.getAds())
        let adImages = id?.getImage()
        
        cell?.slideImageView.image = adImages?[indexPath.row]
        
        return cell!
    }
}

extension AdDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds
        
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

