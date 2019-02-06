//
//  ButtonStyle.swift
//  InstrIUMental
//
//  Created by Marco Ortu on 29/09/2018.
//  Copyright © 2018 Sora. All rights reserved.
//

import UIKit

/*
 This class is use for model the style of buttons
 */
class ButtonStyle: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //width of the button's border
        layer.borderWidth = 1
        
        //border color button
        layer.borderColor = UIColor.black.cgColor
        
        //add background color
        //layer.backgroundColor = tintColor.cgColor
        
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 13)
        
        //adapt font if user change font size on settings
        titleLabel?.adjustsFontForContentSizeCategory = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //dim of radius border
        layer.cornerRadius = frame.height/2
    }
}


