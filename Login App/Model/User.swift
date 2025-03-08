//
//  User.swift
//  Transportyni App
//
//  Created by HAMZAMONDHER on 16/11/2022.
//  Copyright © 2022 Balaji. All rights reserved.
//

import Foundation


class Users : Codable{
    var users: [User]?
}

class User: Codable {
    
    
    
 //   var userPassword: String?
    var firstName : String?
    var IsUserLoggedIn : Bool?
    var email: String?
    var Adresse: String?
    var mobile: String?
    var lastName: String?
    var profilPic: String?
    var activationCode: String?
    var verified: Bool?
    var _id: String?
    var __v : Int?


    
    init(firstName: String, email: String, Adresse: String,lastName: String,mobile: String,profilPic: String,ConfirmationCode: String,id:String,__v:Int) {
        self.firstName = firstName
        self.email = email
        self.lastName = lastName
        self.Adresse = Adresse
        self.mobile = mobile
        self.profilPic = profilPic
        self.activationCode = ConfirmationCode
        self._id = id
        self.__v = 0


    }
    
    
    init(firstName: String, email: String,lastName: String,mobile: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.mobile = mobile

    }
    
    
}
