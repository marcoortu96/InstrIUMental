//
//  Ad.swift
//  InstrIUMental
//
//  Created by batcave on 06/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import Foundation
import UIKit


public class Ad {
    
    // Attributes
    
    private var id : Int!
    private var title : String!
    private var text : String!
    private var price : Float!
    private var category : String!
    private var author : String!
    private var img : [String]!
    private var date : String!
    private var region : String!
    
    //init function
    
    init(id : Int, title : String, text : String, price : Float, category : String, author : String, img : [String], date: String, region : String){
        self.id = id
        self.title = title
        self.text = text
        self.price = price
        self.category = category
        self.author = author
        self.img = img
        self.date = date
        self.region = region
    }
    
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
    
    func getAuthor() -> String {
        return self.author
    }
    
    func getImg() -> [String]{
        return self.img
    }
    
    func getDate() -> String{
        return self.date
    }
    
    func getRegion() -> String {
        return self.region
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
    
    func setAuthor(author : String) -> Void {
        self.author = author
    }
    
    func setImg(img : [String]) -> Void {
        self.img = img
    }
    
    func setDate(date : String) -> Void {
        self.date = date
    }
    
    func setRegion(region : String) -> Void {
        self.region = region
    }
}

