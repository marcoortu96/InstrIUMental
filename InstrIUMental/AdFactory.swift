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
        ads.append(Ad(id: 1, title: "FENDER TELECASTER BAJA", text: "Vendo come da titolo Fender Telecaster Baja colore butterscotch blonde. La chitarra è in eccellenti condizioni estetiche e funzionali, i tasti sono in perfetto stato e tutta l' elettronica è completamente originale. Vendo per passaggio a uno strumento di livello superiore. È compresa nel prezzo una custodia rigida d' annata ma che svolge perfettamente il suo compito. Per maggiori informazioni è possibile contattarmi al 899899899 (Mattia). Non accetto scambi", price: 650.00, category: "Chitarre", author: "sora", img: ["img1","img2","img3"], date: "23-04-2018"))
    
        ads.append(Ad(id: 2, title: "CORT GB75",text: "Vendo basso cort gb 75 5 corde in ottime condizioni. Disponibile a qualsiasi prova",price: 350.00, category:"Bassi", author: "ramino", img: ["img4","img5","img6"], date: "24-12-2017"))
        
        ads.append(Ad(id: 3, title: "PEARL FORUM SERIES",text: "Vendo batteria Pearl compresa di piatti e kit pelli nuove. Disponibile a qualsiasi prova non spedisco",price: 1350.00, category:"Batterie", author: "colonello", img: ["img7","img8","img9"], date: "02-01-2019"))
    }
    
    
    public static func getInstance() -> AdFactory {
        if (AdFactory.instance == nil) {
            AdFactory.instance = AdFactory()
        }
        return AdFactory.instance!
    }
    
    func getAds() -> [Ad] {
        return ads!
    }

}
