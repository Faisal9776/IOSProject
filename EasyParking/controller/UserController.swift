//
//  UserController.swift
//  EasyParking
//
//  Created by Jeffrey Jaca on 2019-11-13.
//  Copyright © 2019 The Coders. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

public class UserController{
    var db : Firestore!
    
    init() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
    
    func addNewUser(name: String, email:String,password:String, contact:String,plate : String, credit_card:String, expiry:String,card_name:String,CVV:Int){
        var ref : DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "name" : name,
            "email" : email,
            "password" : password,
            "contact_number" : contact,
            "plate_number" : plate,
            "credit_card" : credit_card,
            "card_expiration" : expiry,
            "card_name" : card_name,
            "CVV" : CVV,
        ]){ err in
            if let err = err{
                print("Error adding user: \(err)")
            }else{
                print("user added with Id: \(ref!.documentID)")
            }
        }
    }
    
    func getAllUsers(completion: @escaping (Dictionary<String,Any>?) -> Void){
        var users : Dictionary<String, Any>? = Dictionary<String, Any>()
        db.collection("users").getDocuments(){ (QuerySnapshot,err) in
            if let err = err{
                print("error getting users: \(err)")
                users = nil
            }else{
                //return users
                for doc in QuerySnapshot!.documents{
                    users![doc.documentID] = doc.data()
                }
            }
            completion(users)
        }
        
    }
}
