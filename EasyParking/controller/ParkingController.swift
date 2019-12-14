//
//  ParkingController.swift
//  EasyParking
//
//  Created by Jun K on 2019-11-19.
//  Copyright © 2019 The Coders. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

public class ParkingController{
    var db : Firestore!
    
    //initialize firestore setting
    init() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
    
    //add new parking as a document to firestore parking collection
    //uses parking model as format
    func addNewParking(newParking: Parking, userId:String){
        var ref : DocumentReference? = nil
        ref = self.db.collection("users").document(userId) .collection("parkings").addDocument(data: [
            "buildingCode" : newParking.buildingCode,
            "carPlateNumber" : newParking.carPlateNumber,
            "charge" : newParking.charge,
            "dateAndTime" : newParking.dateAndTime,
            "suitNumber" : newParking.suitNumber,
            "timeAmount" : newParking.timeAmount,
        ]){ err in
            if let err = err{
                print("Error adding parking: \(err)")
            }else{
                print("parking added with Id: \(ref!.documentID)")
            }
        }
    }
    
    //get latest parking by ordering it through collection of parking
    //by 'dateAndTime' and getting the last one
    //however, for eg. limit(10) doesn't return an ordered documents
    //only the the last 10 parkings of documents
    //that is why I couldn't implement this way in ParkingTVC to display list sorted by array
    //also it compares by minutes, wait a minute before adding new parking to make the dateAndTime different by at least 1 minute
    func getLatestParking(userId:String, completion: @escaping (Dictionary<String,Any>?) -> Void )
              {
    var parkings : Dictionary<String, Any>? = Dictionary<String, Any>()
             
            db.collection("users").document(userId) .collection("parkings").order(by: "dateAndTime", descending: true).limit(to:1).getDocuments(){ (QuerySnapshot,err) in
              if let err = err{
                  print("error getting users: \(err)")
                  parkings = nil
              }else{
                  //return parkings
                  for doc in QuerySnapshot!.documents{
                      parkings![doc.documentID] = doc.data()
                  }
              }

              completion(parkings)
                    
          }
      }
    
    //return number of parking that is made this month
    //check if month(eg. Nov.) is contained in the date of all documents
    func getParkingsByMonth(userId:String, completion: @escaping (Int) -> Void)
                {
                    
                    let date = Date()
                    let dateFormatter = DateFormatter()
                           
                    dateFormatter.dateFormat = "MMM"

                    let dateString = dateFormatter.string(from: date) as String
                    var parking : Int = Int()
                    var current: String = ""
  
                    db.collection("users").document(userId) .collection("parkings").getDocuments(){ (QuerySnapshot,err) in
                if let err = err{
                    print("error getting users: \(err)")
                    
                }else{
                   
                    for doc in QuerySnapshot!.documents{
                        current = doc.data()["dateAndTime"] as! String
                        
                        if current.contains(dateString){
                            parking += 1
                        }
                                      
                }

                completion(parking)
                   
                        
            }
                    
                    }
    }
    
    //gets all the documents in parking collection
    func getAllParking(userId:String, completion: @escaping (Dictionary<String,Any>?) -> Void)
            {
                
                
                var parkings : Dictionary<String, Any>? = Dictionary<String, Any>()

                db.collection("users").document(userId) .collection("parkings").getDocuments(){ (QuerySnapshot,err) in
            if let err = err{
                print("error getting users: \(err)")
                parkings = nil
            }else{
                //return parkings
               //let k = QuerySnapshot!.documents.reversed()
                for doc in QuerySnapshot!.documents{
                    parkings![doc.documentID] = doc.data()
                   // print(parkings)
                    
                }
            }

            completion(parkings)
        }
    }
}





