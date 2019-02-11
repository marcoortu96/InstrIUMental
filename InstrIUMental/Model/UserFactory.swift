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
    
    // Private constructor
    private init () {
        users.append(User(name : "Marco", surname : "Ortu", username : "sora", email : "sora004@ium.it", password : "0000", URLimage: "sora"))
        users.append(User(name: "Andrea", surname: "Re", username: "king", email: "blugori@ium.it", password: "shisonson", URLimage: "king"))
        users.append(User(name : "Emanuele", surname: "Spano", username : "ramino", email : "manu@ium.it", password : "aimech", URLimage: "ramino"))
        users.append(User(name : "Giacomo", surname : "Meloni", username : "colonnello", email : "giacomo@ium.it", password : "1234", URLimage: "colonnello"))
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
}
