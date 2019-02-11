//
//  AdFactory.swift
//  InstrIUMental
//
//  Created by batcave on 06/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import Foundation


public class AdFactory {
    
    private static var instance : AdFactory?
    private var  ads : [Ad]! = []
    
    init() {
        ads.append(Ad(id: 1, title: "FENDER TELECASTER BAJA", text: "Vendo come da titolo Fender Telecaster Baja colore butterscotch blonde. La chitarra è in eccellenti condizioni estetiche e funzionali, i tasti sono in perfetto stato e tutta l' elettronica è completamente originale. Vendo per passaggio a uno strumento di livello superiore. È compresa nel prezzo una custodia rigida d' annata ma che svolge perfettamente il suo compito. Per maggiori informazioni è possibile contattarmi al 899899899 (Mattia). Non accetto scambi.", price: 650.00, category: "Chitarre", author: "sora", img: ["img1","img2","img3"], date: "2018-04-23"))
    
        ads.append(Ad(id: 2, title: "CORT GB75",text: "Vendo basso cort gb 75 5 corde in ottime condizioni. Disponibile a qualsiasi prova.",price: 350.00, category:"Bassi", author: "ramino", img: ["img4","img5","img6"], date: "2017-12-24"))
        
        ads.append(Ad(id: 3, title: "PEARL FORUM SERIES",text: "Vendo batteria Pearl compresa di piatti e kit pelli nuove. Disponibile a qualsiasi prova non spedisco.",price: 1350.00, category:"Batterie", author: "colonello", img: ["img7","img8","img9"], date: "2019-01-02"))
        
        ads.append(Ad(id: 4, title: "UFIP RIDE/PING",text: "Vendo piatto UFIP Ping/ride (52cm)come da foto(asta non inclusa),vintage anni 80 suono pulito e brillante a euro100 escluso spese di spedizione a carico del compratore! (NO PERMUTE NON TRATTABILI).",price: 100.00, category:"Batterie", author: "colonello", img: ["img10","img11","img12"], date: "2018-10-07"))
        
        ads.append(Ad(id: 5, title: "ROLAND V DRUMS SESSION TD10 + SCHEDATDW- 1",text: "Vendo Roland V session perfetta e funzionante, dinamiche realistiche. Ottimo uso per studi di registrazioni,in casa, e in situazioni live per pub e locali...incluso nel prezzo ci sono extra accessori.",price: 1000.00, category:"Batterie", author: "king", img: ["img13","img14","img15"], date: "2019-02-09"))
        
        ads.append(Ad(id: 6, title: "M AUDIO OXYGEN 49",text: "Vendo per inutilizzo M-Audio Oxygen 49. Usata molto in casa, ambiente non fumatori. Ottime condizioni di funzionamento. Presenta alcuni graffietti causati dall'uso che non pregiudicano la condizione estetica. Il 49esimo tasto è lievemente ingiallito, come da foto. Cavo usb incluso.",price: 65.00, category:"Tastiere", author: "sora", img: ["img16","img17","img18"], date: "2018-11-22"))
        
        ads.append(Ad(id: 7, title: "SAX CONTRALTO UNIVERSAL PARIS (STENCIL DOLNET)",text: "Vendo sax contralto Universal Paris (stencil Dolnet), argentato, vintage anni ’70. Tamponi in ottime condizioni, revisionato da “Centro fiati e percussioni”. Suono molto caldo e dolce. Meccanica vintage, no fa diesis acuto. Custodia, tracolla, ance e bocchino Yamaha 5C nuovo. Con 50 euro in più aggiungo bocchino Bari HR 82 come nuovo",price: 450.00, category:"Fiati", author: "king", img: ["img19","img20","img21"], date: "2018-12-18"))
        
        ads.append(Ad(id: 8, title: "FENDER TELECASTER ROAD WORN 50",text: "Stupenda Tele dal look e dal suono spettacolare, nulla da invidiare alle custom shop. Una chitarra davvero ben costruita. Completa di custodia morbida certificati e masherine di riserva anche di colore vintage white. prezzo leggermente trattabile.",price: 990.00, category:"Batterie", author: "ramino", img: ["img22","img23","img24"], date: "2019-01-28"))
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

}
