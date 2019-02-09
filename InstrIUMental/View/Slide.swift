//
//  Slide.swift
//  InstrIUMental
//
//  Created by Marco Ortu on 09/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import UIKit

class Slide:  AdDetailViewController {
    @IBOutlet weak var scrollImageView: UIImageView!
    
    func createSlide() -> [Slide] {
        //let imgArray: [UIImage] = []
        let slides:[Slide] = [Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide]
        
      
        return slides
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
