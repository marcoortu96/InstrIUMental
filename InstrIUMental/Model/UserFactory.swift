//
//  UserFactory.swift
//  InstrIUMental
//
//  Created by Giacomo Meloni on 06/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import Foundation
import UIKit

public class UserFactory {
    private static var instance : UserFactory?
    private var users : [User]! = []
    
    // Private constructor
    private init () {
        
        users.append(User(name : "Marco", surname : "Ortu", username : "sora", email : "sora004@ium.it", password : "0000", URLimage: "sora", ads: AdFactory.getAdByAuthor(username: "sora"), image: UIImage(named: "sora")!))
        
        users.append(User(name: "Andrea", surname: "Re", username: "king", email: "blugori@ium.it", password: "shisonson", URLimage: "king", ads: AdFactory.getAdByAuthor(username: "king"), image: UIImage(named: "king")!))
        
        users.append(User(name : "Emanuele", surname: "Spano", username : "ramino", email : "manu@ium.it", password : "aimech", URLimage: "ramino", ads: AdFactory.getAdByAuthor(username: "ramino"), image: UIImage(named: "ramino")!))
        
        users.append(User(name : "Giacomo", surname : "Meloni", username : "colonnello", email : "giacomo@ium.it", password : "1234", URLimage: "colonnello", ads: AdFactory.getAdByAuthor(username: "colonnello"), image: UIImage(named: "colonnello")!))
    }
    
    // The constructor, which is private, is called just in here
    public static func getInstance() -> UserFactory {
        if (UserFactory.instance == nil) {
            UserFactory.instance = UserFactory()
        }
        
        return UserFactory.instance!
    }
    
    // Getters and Setters methods
    public func getUsers() -> [User] {
        return users
    }
    
    public func setUsers(usrs : [User]) {
        self.users = usrs
    }
    
    // The function returns the user with the specified username if present, nil otherwise
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
    
    public static func getUserByUsername(username : String, usrs : [User]) -> User! {
        if UserFactory.instance != nil {
            for user in usrs {
                if user.getUsername().elementsEqual(username) {
                    return user
                }
            }
        }
        else {
            return nil
        }
        
        return nil
    }
    
    // The function returns true if the given username is found, false otherwise
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
    
    // The function adds the given user to the array of users
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
    
    // Prints the given user
    public static func printUser(usr : User) {
        print(usr.getName(), " - ", usr.getSurname(), " - ", usr.getUsername(), " - ", usr.getEmail(), " - ", usr.getPassword(), "\n")
    }
    
    // Prints all the users
    public static func printUsers(usrs : [User]) {
        for user in usrs {
            printUser(usr : user)
        }
    }
    
    // The function returns true if the user is valid, false otherwise
    public static func isUserValid(usr : User) -> Bool {
        if usr.getName().count > 1 && usr.getSurname().count > 1 && usr.getPassword().count > 5 && usr.getEmail().count > 4 && usr.getUsername().count > 1 {
            return true
        }
        else {
            return false
        }
    }
    
    public static func getLoggedUser(usrs : [User]) -> User! {
        for user in usrs {
            if user.isLogged() {
                return user
            }
        }
        
        return nil
    }
    
    // This function allows to add a new favorite ad to the specify user
    public static func addFavorite(ad : Ad, username : String) {
        let usrs = UserFactory.getInstance().getUsers()
        let usr = UserFactory.getUserByUsername(username: username, usrs: usrs)
        usr?.addFavorite(ad: ad)
    }
    
    // This function allows to remove a favorite ad to the specify user
    public static func removeFavorite(ad : Ad, username : String) {
        let usrs = UserFactory.getInstance().getUsers()
        let usr = UserFactory.getUserByUsername(username: username, usrs: usrs)
        usr?.removeFavorite(ad: ad)
    }
    
    // This function allows to remove an ad to the specify user
    public static func removeAd(ad : Ad, username : String) {
        let usrs = UserFactory.getInstance().getUsers()
        let usr = UserFactory.getUserByUsername(username: username, usrs: usrs)
        usr?.removeAd(ad: ad)
    }
    
    // This function performes the logout of the specified user
    public static func logout(username : String) {
        UserFactory.getUserByUsername(username: username, usrs: UserFactory.getInstance().getUsers())?.setLogState(logged: false)
    }
    
    // This function deletes the specified user
    public static func deleteUser(username : String) {
        var usrs : [User] = []
        
        for usr in UserFactory.getInstance().getUsers() {
            if !usr.getUsername().elementsEqual(username) {
                usrs.append(usr)
            }
        }
        
        var ads : [Ad] = []
        
        for ad in AdFactory.getInstance().getAds() {
            if !ad.getAuthor().elementsEqual(username) {
                ads.append(ad)
            }
        }
        
        AdFactory.getInstance().setAds(ads: ads)
        UserFactory.getInstance().setUsers(usrs: usrs)
    }
}
