//
//  User.swift
//  InstrIUMental
//
//  Created by Giacomo Meloni on 06/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import Foundation
import UIKit

public class User {
    private var name : String!
    private var surname : String!
    private var username : String!
    private var email : String!
    private var password : String!
    private var URLimage : String?
    private var ads : [Ad]?
    private var logged : Bool!
    private var phoneNumber : String?
    private var favorites : [Ad]?
    
    init (name : String, surname : String, username : String, email : String, password : String) {
        self.name = name
        self.surname = surname
        self.username = username
        self.email = email
        self.password = password
        self.logged = false
        
        self.URLimage = ""
        self.ads = []
        self.phoneNumber = ""
        self.favorites = []
    }
    
    init (name : String, surname : String, username : String, email : String, password : String, URLimage: String) {
        self.name = name
        self.surname = surname
        self.username = username
        self.email = email
        self.password = password
        self.logged = false
        
        self.URLimage = URLimage
        self.ads = []
        self.phoneNumber = ""
        self.favorites = []
    }
    
    init () {
        self.name = ""
        self.surname = ""
        self.username = ""
        self.email = ""
        self.password = ""
        self.logged = false
        
        self.URLimage = ""
        self.ads = []
        self.phoneNumber = ""
        self.favorites = []
    }
    
    func getName() -> String {
        return name
    }
    
    func setName(name : String) {
        self.name = name
    }
    
    func getSurname() -> String {
        return surname
    }
    
    func setSurname(surname : String) {
        self.surname = surname
    }
    
    func getUsername() -> String {
        return username
    }
    
    func setUsername(username : String) {
        self.username = username
    }
    
    func getEmail() -> String {
        return email
    }
    
    func getPhoneNumber() -> String {
        return phoneNumber!
    }
    
    func setEmail(email : String) {
        self.email = email
    }
    
    func getPassword() -> String {
        return password
    }
    
    func setPassword(password : String) {
        self.password = password
    }
    
    func getURLimage() -> String {
        return URLimage!
    }
    
    func setURLimage(URLimage : String) {
        self.URLimage = URLimage
    }
    
    func getAds() -> [Ad] {
        return ads!
    }
    
    func setAds(ads : [Ad]) {
        self.ads = ads
    }
    
    func isLogged() -> Bool {
        return self.logged
    }
    
    func setLogState(logged : Bool) {
        self.logged = logged
    }
    
    func setPhoneNumber(phoneNumber : String) {
        self.phoneNumber = phoneNumber
    }
    
    func getFavorites() -> [Ad] {
        return self.favorites!
    }
    
    func setFavorites(favorites : [Ad]) {
        self.favorites = favorites
    }
    
    func addFavorite(ad : Ad) {
        var fvrs = self.getFavorites()
        fvrs.append(ad)
        self.setFavorites(favorites: fvrs)
    }
    
    // This function returns true if the specified ad is already present in the user's favorites list, false otherwise
    func isFavoritePresente(ad : Ad) -> Bool {
        for currentAd in self.getAds() {
            if currentAd.getId() == ad.getId() {
                return true
            }
        }
        
        return false
    }
}

