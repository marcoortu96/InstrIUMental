//
//  AdDetailViewController.swift
//  InstrIUMental
//
//  Created by Marco Ortu on 09/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import UIKit

class AdDetailViewController: UIViewController {
    
    var adTitle = String()
    var adText = String()
    var price = String()
    var category = String()
    var author = String()
    var date = String()
    var adId = Int()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //Outlet storyboard
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = adTitle
        descriptionLabel.text = adText
        categoryLabel.text = category
        userNameLabel.text = author
        dateLabel.text = date
        priceLabel.text = price
    }
    
    @IBAction func PressFavoritesBtn(_ sender: Any) {
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

//Extension of this class for pick the imageView from UICollection view
extension AdDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DataCollectionViewCell
        
        //take ads image
        let factory = AdFactory.getInstance()
        let id = AdFactory.getAdById(id: adId, adsSet: factory.getAds())
        let adImages = id?.getImg()
        
        cell?.slideImageView.image = UIImage(named: (adImages?[indexPath.row])!)
       
        return cell!
    }
}

extension AdDetailViewController: UICollectionViewDelegateFlowLayout {
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

