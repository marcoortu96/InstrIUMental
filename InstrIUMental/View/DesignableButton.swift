//
//  DesignableButton.swift
//  InstrIUMental
//
//  Created by Marco Ortu on 06/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableButton: UIButton {
    
    //rounded border
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    

    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
