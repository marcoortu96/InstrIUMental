//
//  InsertAdController.swift
//  InstrIUMental
//
//  Created by Giacomo Meloni on 13/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import UIKit

class InsertAdController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var titleText: DesignableTextField!
    @IBOutlet weak var imgText: DesignableTextField!
    @IBOutlet weak var priceText: DesignableTextField!
    @IBOutlet weak var category: UIPickerView!
    @IBOutlet weak var region: UIPickerView!
    @IBOutlet weak var descriptionText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() //func for hide keyboard
    }

    @IBAction func insertBtn(_ sender: Any) {
        let ad : Ad = Ad(id: AdFactory.getInstance().getAds().count, title: titleText.text!, text: descriptionText.text!, price: Float(priceText.text!)!, category: "categoria1", author: (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername())!, img: ["","",""], date: "2019-02-14", region : "regione1")
        
        AdFactory.insertAd(ad: ad)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
