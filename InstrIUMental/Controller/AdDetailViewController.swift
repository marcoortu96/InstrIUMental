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
    
    
    
    //Outlet storyboard
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var categotyLabel: UILabel!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var adPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = adTitle
        descriptionLabel.text = adText
        categotyLabel.text = category
        nameUser.text = author
        dateLabel.text = date
        adPriceLabel.text = price
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
