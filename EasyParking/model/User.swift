//
//  User.swift
//  EasyParking
//
//  Created by Jeffrey Jaca on 2019-11-15.
//  Copyright © 2019 The Coders. All rights reserved.
//

import Foundation
public class User{
    let name : String?
    let email : String?
    let pass : String?
    let contact : String?
    let plate : String?
    let credit : String?
    let cardName : String?
    let expiryDate : String?
    let cvv : Int?
    
    init?(){
        self.name = nil
        self.email = nil
        self.pass = nil
        self.contact = nil
        self.plate = nil
        self.credit = nil
        self.cardName = nil
        self.expiryDate = nil
        self.cvv = nil
    }
    
    init?(name: String, email: String, password: String, contact_number:String, plate_number:String,
        credit_card : String, card_name: String, expiry_date: String, cvv: Int) {
        self.name = name
        self.email = email
        self.pass = password
        self.contact = contact_number
        self.plate = plate_number
        self.credit = credit_card
        self.cardName = card_name
        self.expiryDate = expiry_date
        self.cvv = cvv
    }
}
