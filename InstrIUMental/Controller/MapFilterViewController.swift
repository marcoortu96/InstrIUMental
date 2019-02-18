//
//  MapFilterViewController.swift
//  InstrIUMental
//
//  Created by batcave on 18/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import UIKit

class MapFilterViewController: UIViewController {


    @IBOutlet weak var distanceValue: UILabel!
    @IBOutlet weak var priceValue: UILabel!
    @IBAction func distanceSlider(_ sender: UISlider) {
         distanceValue.text = String(Int(sender.value))
    }
    
    @IBAction func priceSlider(_ sender: UISlider) {
         priceValue.text = String(Int(sender.value))
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
