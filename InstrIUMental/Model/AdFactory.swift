//
//  AdFactory.swift
//  InstrIUMental
//
//  Created by batcave on 06/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import Foundation
import UIKit


public class AdFactory {
    
    private static var instance : AdFactory?
    private var  ads : [Ad]! = []
    
    init() {
        
        ads.append(Ad(id: 1, title: "FENDER TELECASTER BAJA", text: "Vendo come da titolo Fender Telecaster Baja colore butterscotch blonde. È compresa nel prezzo una custodia rigida d'annata ma che svolge perfettamente il suo compito. Per maggiori informazioni è possibile contattarmi al 899899899 (Mattia).", price: 650.00, category: "Chitarre", author: "sora", image: [UIImage(named: "img1")!, UIImage(named: "img2")!, UIImage(named: "img3")!], date: "2018-04-23", region : "Sardegna", latitude: 40.551161, longitude: 8.322996))
        
        ads.append(Ad(id: 2, title: "CORT GB75",text: "Vendo basso cort gb 75 5 corde in ottime condizioni. Disponibile a qualsiasi prova.",price: 350.00, category:"Bassi", author: "ramino", image: [UIImage(named: "img4")!, UIImage(named: "img5")!, UIImage(named: "img6")!], date: "2017-12-24", region : "Lombardia", latitude: 45.452082, longitude: 9163186))
        
        ads.append(Ad(id: 3, title: "PEARL FORUM SERIES",text: "Vendo batteria Pearl compresa di piatti e kit pelli nuove. Disponibile a qualsiasi prova non spedisco.",price: 1350.00, category:"Batterie", author: "colonnello", image: [UIImage(named: "img7")!, UIImage(named: "img8")!, UIImage(named: "img9")!], date: "2019-01-02", region : "Valle d'Aosta", latitude: 45.737816, longitude: 7.322430))
        
        ads.append(Ad(id: 4, title: "UFIP RIDE/PING",text: "Vendo piatto UFIP Ping/ride come da foto a euro 100 escluso spese di spedizione a carico del compratore! (NO PERMUTE NON TRATTABILI).",price: 100.00, category:"Batterie", author: "colonnello", image: [UIImage(named: "img10")!, UIImage(named: "img11")!, UIImage(named: "img12")!], date: "2018-10-07", region : "Sicilia", latitude: 45.737816, longitude: 7.322430))
        
        ads.append(Ad(id: 5, title: "ROLAND V DRUMS SESSION TD10 + SCHEDATDW- 1",text: "Vendo Roland V session perfetta e funzionante, dinamiche realistiche. Ottimo uso per studi di registrazioni e in situazioni live per pub e locali. Incluso nel prezzo ci sono extra accessori.",price: 1000.00, category:"Batterie", author: "king", image: [UIImage(named: "img13")!, UIImage(named: "img14")!, UIImage(named: "img15")!], date: "2019-02-09", region : "Sardegna", latitude: 39.300658, longitude: 9.092362))
        
        ads.append(Ad(id: 6, title: "M AUDIO OXYGEN 49",text: "Vendo per inutilizzo M-Audio Oxygen 49. Presenta alcuni graffietti causati dall'uso che non pregiudicano la condizione estetica.",price: 65.00, category:"Tastiere", author: "sora", image: [UIImage(named: "img16")!, UIImage(named: "img17")!, UIImage(named: "img18")!], date: "2018-11-22", region : "Toscana", latitude: 43.781650, longitude: 11.227736))
        
        ads.append(Ad(id: 7, title: "SAX CONTRALTO UNIVERSAL PARIS (STENCIL DOLNET)",text: "Vendo sax contralto Universal Paris, argentato, vintage anni ’70. Custodia, tracolla, ance e bocchino Yamaha 5C nuovo.",price: 450.00, category:"Fiati", author: "king", image: [UIImage(named: "img19")!, UIImage(named: "img20")!, UIImage(named: "img21")!], date: "2018-12-18", region : "Calabria", latitude: 39.489900, longitude: 16.382958))
        
        ads.append(Ad(id: 8, title: "FENDER TELECASTER ROAD WORN 50",text: "Stupenda Tele dal look e dal suono spettacolare. Completa di custodia morbida certificati. prezzo leggermente trattabile.",price: 990.00, category:"Chitarre", author: "ramino", image: [UIImage(named: "img22")!, UIImage(named: "img23")!, UIImage(named: "img24")!], date: "2019-01-28", region : "Sardegna", latitude: 40.745431, longitude: 8.520454))

    }
    
    public static func getInstance() -> AdFactory {
        if (AdFactory.instance == nil) {
            AdFactory.instance = AdFactory()
        }
        return AdFactory.instance!
    }
    
    // Getters and Setters
    
    public func getAds() -> [Ad] {
        return ads!
    }
    
    public func setAds(ads : [Ad]) {
        self.ads = ads
    }
    
    // This function finds and return the searched ad if it finds it, nil otherwise
    public static func getAdById(id : Int, adsSet : [Ad]) -> Ad! {
        for ad in adsSet {
            if ad.getId() == id {
                return ad
            }
        }
        
        return nil
    }
    
    // This function returns an array of ads which title matches with the given one
    public static func getAdsByTitle(title : String, adsSet : [Ad]) -> [Ad]! {
        var adsToReturn : [Ad]! = []
        
        for ad in adsSet {
            if ad.getTitle().lowercased().contains(title.lowercased()) {
                adsToReturn.append(ad)
            }
        }
        
        return adsToReturn
    }
    
    // This function returns an array of ads which category matches with the given one
    public static func getAdsByCategory(category : String, adsSet : [Ad]) -> [Ad]! {
        var adsToReturn : [Ad]! = []
        
        for ad in adsSet {
            if ad.getCategory().lowercased().elementsEqual(category.lowercased()) {
                adsToReturn.append(ad)
            }
        }
        
        return adsToReturn
    }
    
    // This function returns an array of ads which price stays between the lowestPrice and the highestPrice
    public static func getAdsByPrice(lowestPrice : Float, highestPrice : Float, adsSet : [Ad]!) -> [Ad]! {
        var adsToReturn : [Ad]! = []
        
        for ad in adsSet {
            if ad.getPrice() >= lowestPrice && ad.getPrice() <= highestPrice {
                adsToReturn.append(ad)
            }
        }
        
        return adsToReturn
    }
    
    // This function adds the specified ad
    public static func insertAd(ad : Ad) {
        var ads = AdFactory.getInstance().getAds()
        ad.setId(id: Ad.nextId())
        ads.append(ad)
        AdFactory.getInstance().setAds(ads: ads)
    }
    
    //func for remove one ad from last ads
    public static func removeFromLastAd(ad : Ad) {
        var ads = AdFactory.getInstance().getAds()
        for a in ads {
            if a.getId() == ad.getId() {
                ads = ads.filter {$0.getId() != ad.getId()}
            }
        }
        AdFactory.getInstance().setAds(ads: ads)
    }
    
    public static func getAdByAuthor(username : String) -> [Ad] {
        let ads = AdFactory.getInstance().getAds()
        var adsToReturn : [Ad] = []
        
        for ad in ads {
            if ad.getAuthor().elementsEqual(username) {
                adsToReturn.append(ad)
            }
        }
        
        return adsToReturn
    }
    
    public static func modifyAd(ad : Ad) {
        var updatedAds : [Ad] = []
        var updatedUserAds : [Ad] = []
        
        updatedAds.append(ad)
        updatedUserAds.append(ad)
        
        for currentAd in AdFactory.getInstance().getAds() {
            if currentAd.getId() != ad.getId() {
                updatedAds.append(currentAd)
            }
        }
        
        for currentAd in (UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getAds())! {
            if currentAd.getId() != ad.getId() {
                updatedUserAds.append(currentAd)
            }
        }
        
        AdFactory.getInstance().setAds(ads: updatedAds)
        UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.setAds(ads: updatedUserAds)
    }
}
