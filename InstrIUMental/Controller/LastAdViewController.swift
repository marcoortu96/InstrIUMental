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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ads.getAds().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdsTableViewCell") as! AdsTableViewCell
        
        let adSort = ads.getAds().sorted() {$0.getDate() > $1.getDate()}
        
        //let ad: Ad = ads.getAds() [indexPath.row]
        let ad: Ad = adSort [indexPath.row]
        
        cell.adImageView?.image = UIImage(named: ad.getImg()[0])
        cell.adTitleLabel?.text = ad.getTitle()
        cell.adDescrLabel?.text = ad.getText()
        cell.nameUserLabel?.text = "di " + ad.getAuthor()
        cell.adDateLabel?.text = ad.getDate()
        cell.adPriceLabel?.text = String(ad.getPrice()) + "€"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        let currentAd = ads.getAds() [indexPath.row]
        
        //send ad data to next view
        let vc = storyboard?.instantiateViewController(withIdentifier: "AdDetailViewController") as? AdDetailViewController
        vc?.adTitle = currentAd.getTitle()
        vc?.adText = currentAd.getText()
        vc?.category = "Categoria: " + currentAd.getCategory()
        vc?.price = String(currentAd.getPrice()) + "€"
        vc?.author = currentAd.getAuthor()
        vc?.date = currentAd.getDate()
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    

}
