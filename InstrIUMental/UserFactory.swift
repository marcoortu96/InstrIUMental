//
//  UserFactory.swift
//  InstrIUMental
//
//  Created by Giacomo Meloni on 06/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import Foundation

public class UserFactory {
    private static var instance : UserFactory?
    private var users : [User]!
    
    private init () {
        users.append(User(name : "Marco", surname : "Ortu", username : "sora", email : "sora004@ium.it", password : "0000"))
        users.append(User(name: "Andrea", surname: "Re", username: "king", email: "blugori@ium.it", password: "shisonson"))
        users.append(User(name : "Emanuele", surname: "Spano", username : "ramino", email : "manu@ium.it", password : "aimech"))
        users.append(User(name : "Giacomo", surname : "Meloni", username : "colonnello", email : "giacomo@ium.it", password : "1234"))
    }
    
    public func getInstance() -> UserFactory {
        if (UserFactory.instance == nil) {
            UserFactory.instance = UserFactory()
        }
        
        return UserFactory.instance!
    }
}
