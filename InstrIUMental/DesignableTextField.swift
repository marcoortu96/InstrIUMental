//
//  DesignableTextField.swift
//  InstrIUMental
//
//  Created by Marco Ortu on 06/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import UIKit

//This class allows you to change the design of text field
@IBDesignable
class DesignableTextField: UITextField {
    
    //rounded border
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    //insert the left image in text field
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    //costumize left padding of image
    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    
    //insert and costumize the frame for the image
    func updateView() {
        if let image = leftImage {
            leftViewMode = .always
            
            let imageView = UIImageView (frame: CGRect(x: 5, y: 12, width: 20, height: 20))
            imageView.image = image
            imageView.tintColor = tintColor
            
            var width = leftPadding + 20
            
            //border style of textfield
            if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                width = width + 15
            }
            
            //view for space the image
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            addSubview(imageView)
            
            leftView = view
        } else {
            //image is nill
            leftViewMode = .never
        }
        
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: tintColor])
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
