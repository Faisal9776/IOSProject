//
//  UserController.swift
//  EasyParking
//
//  Created by Jeffrey Jaca on 2019-11-13.
//  Copyright © 2019 The Coders. All rights reserved.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

public class UserController{
    var db : Firestore!
    
    init() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
    
    func addNewUser(name: String, email:String,password:String, contact:String,plate : String, credit_card:String, expiry:String,card_name:String,CVV:Int) -> String{
        var newId = "null"
        
        //dispatch group to wait for retrieval of data
        let group = DispatchGroup()
        group.enter()
        
        //add user to firebase
        Auth.auth().createUser(withEmail: email, password: password){ authResult, error in
            
            //adds user data to db
            var ref : DocumentReference? = nil
            DispatchQueue.main.async {
                ref = self.db.collection("users").addDocument(data: [
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
                                newId = ref!.documentID
                            
                            
                            
                        }
                    }
                    
                }
            }
            
        
        return newId
    }
    
    func updateUser(id:String, userData:User){
        let updatedName = userData.name ?? ""
        let updatedEmail = userData.email ?? ""
        let updatedPassword = userData.pass ?? ""
        let updatedPlate = userData.plate ?? ""
        let updatedContact = userData.contact ?? ""
        let updatedCreditCard = userData.credit ?? ""
        let updatedCardName = userData.cardName ?? ""
        let updatedExpiry = userData.expiryDate ?? ""
        let updatedCVV = userData.cvv ?? 0
        
        db.collection("users").document(id).updateData([
            "name" : updatedName,
            "email" : updatedEmail,
            "password" : updatedPassword,
            "plate_number" : updatedPlate,
            "contact_number" : updatedContact,
            "credit_card" : updatedCreditCard,
            "card_name" : updatedCardName,
            "card_expiration" : updatedExpiry,
            "CVV" : updatedCVV
        ]){ err in
            if err != nil{
                print("Error updating document: \(id)")
            }else{
                print("document updated: \(id)")
            }
        }
        
    }
    
    func updatePassword(email:String,password:String){
        db.collection("users").whereField("email", isEqualTo: email).getDocuments(){ (querySnapshot, err) in
            if let err = err{
                print("Error getting data: \(err)")
            }else{
                let userData = querySnapshot!.documents.first
                
                userData?.reference.updateData([
                    "password" : password
                ])
            }
            
        }
    }
    
    func getUser(id:String, completion: @escaping (User) -> Void){
        var user : User?
        
        db.collection("users").document(id).getDocument{ (document,err) in
            if let document = document, document.exists{
                //let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                let docData = document.data()!
                user = User(name: docData["name"] as! String, email: docData["email"] as! String, password: docData["password"] as! String, contact_number: docData["contact_number"] as! String, plate_number: docData["plate_number"] as! String, credit_card: docData["credit_card"] as! String, card_name: docData["card_name"] as! String, expiry_date: docData["card_expiration"] as! String, cvv: docData["CVV"] as! Int)
                //print("document data: \(dataDescription)")
                completion(user!)
            }else{
                print("document does not exist")
                user = nil
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
