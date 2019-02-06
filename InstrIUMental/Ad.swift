//
//  Ad.swift
//  InstrIUMental
//
//  Created by batcave on 06/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import Foundation
import UIKit


class Ad {
    
    // Attributes
    
    var id : Int!
    var title : String!
    var text : String!
    var price : Float!
    var category : String!
    var author : User!
    var img : UIImage!
    
    // get functions
    
    func getId() -> Int {
        return self.id
    }
    
    func getTitle() -> String {
        return self.title
    }
    
    func getText() -> String {
        return self.text
    }
    
    func getPrice() -> Float {
        return self.price
    }
    
    func getCategory() -> String {
        return self.category
    }
    
    func getAuthor() -> User {
        return self.author
    }
    
    func getImg() -> UIImage {
        return self.img
    }
    
    // set functions
    
    func setId(id : Int) -> Void {
        self.id = id
    }

    func setTitle(title : String) -> Void {
        self.title = title
    }
    
    func settext(text : String) -> Void {
        self.text = text
    }
    
    func setPrice(price :Float) -> Void {
        self.price = price
    }
    
    func setCategory(category : String) -> Void {
        self.category = category
    }
    
    func setAuthor(author : User) -> Void {
        self.author = author
    }
    
    func setImg(img : UIImage) -> Void {
        self.img = img
    }
}

