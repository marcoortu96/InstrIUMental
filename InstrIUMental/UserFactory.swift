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
    private var users : [User]! = []
    
    private init () {
        users.append(User(name : "Marco", surname : "Ortu", username : "sora", email : "sora004@ium.it", password : "0000"))
        users.append(User(name: "Andrea", surname: "Re", username: "king", email: "blugori@ium.it", password: "shisonson"))
        users.append(User(name : "Emanuele", surname: "Spano", username : "ramino", email : "manu@ium.it", password : "aimech"))
        users.append(User(name : "Giacomo", surname : "Meloni", username : "colonnello", email : "giacomo@ium.it", password : "1234"))
    }
    
    public static func getInstance() -> UserFactory {
        if (UserFactory.instance == nil) {
            UserFactory.instance = UserFactory()
        }
        
        return UserFactory.instance!
    }
    
    public func getUsers() -> [User] {
        return users
    }
    
    public func setUsers(usrs : [User]) {
        self.users = usrs
    }
    
    public static func getUser(username : String, password : String, usrs : [User]) -> User! {
        if UserFactory.instance != nil {
            for user in usrs {
                if user.getUsername().elementsEqual(username) && user.getPassword().elementsEqual(password)  {
                    return user
                }
            }
        }
        else {
            return nil
        }
        
        return nil
    }
    
    public static func isUsernamePresent(username : String, usrs : [User]) -> Bool {
        if UserFactory.instance != nil {
            for user in usrs {
                if user.getUsername().elementsEqual(username) {
                    return true
                }
            }
        }
        else {
            return false
        }
        
        return false
    }
    
    public static func addUser(newUser : User, usrs : [User]) {
        //var listOfUsers : [User] = usrs
        
        if UserFactory.instance != nil {
            if !UserFactory.isUsernamePresent(username: newUser.getUsername(), usrs: usrs) {
                //listOfUsers.append(newUser)
                //instance?.setUsers(usrs: listOfUsers)
                UserFactory.instance?.users.append(newUser)
            }
        }
    }
    
    public static func printUser(usr : User) {
        print(usr.getUsername(), " ")
    }
    
    public static func printUsers(usrs : [User]) {
        for user in usrs {
            printUser(usr : user)
        }
    }
    
}
