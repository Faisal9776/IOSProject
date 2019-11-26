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
    
    init() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
    
    func addNewParking(newParking: Parking){
        var ref : DocumentReference? = nil
        ref = db.collection("users").document("6gen0gQdPOJ91k8tTbe6") .collection("parkings").addDocument(data: [
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
    
    func getLatestParking(completion: @escaping (Dictionary<String,Any>?) -> Void)
              {
    var parkings : Dictionary<String, Any>? = Dictionary<String, Any>()
                  db.collection("users").document("6gen0gQdPOJ91k8tTbe6") .collection("parkings").order(by: "dateAndTime", descending: true).limit(to:1).getDocuments(){ (QuerySnapshot,err) in
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
    
    func getParkingsByMonth(completion: @escaping (Int) -> Void)
                {
                    
                    let date = Date()
                    let dateFormatter = DateFormatter()
                           
                    dateFormatter.dateFormat = "MMM"

                    let dateString = dateFormatter.string(from: date) as String
                    var parking : Int = Int()
                    var k: String = ""
                        
     // var parkings : Dictionary<String, Any>? = Dictionary<String, Any>()
                    db.collection("users").document("6gen0gQdPOJ91k8tTbe6") .collection("parkings").getDocuments(){ (QuerySnapshot,err) in
                if let err = err{
                    print("error getting users: \(err)")
                    
                }else{
                    //return parkings
                    print(QuerySnapshot?.documents.count)
                    for doc in QuerySnapshot!.documents{
                        k = doc.data()["dateAndTime"] as! String
                        
                        if k.contains(dateString){
                            parking += 1
                        }
                                      
                }

                completion(parking)
                    print("hhhe")
                    print(parking)
                        
            }
                    
                    }
    }
    
    func getAllParking(completion: @escaping (Dictionary<String,Any>?) -> Void)
            {
                var parkings : Dictionary<String, Any>? = Dictionary<String, Any>()
                db.collection("users").document("6gen0gQdPOJ91k8tTbe6") .collection("parkings").order(by: "dateAndTime", descending: true).getDocuments(){ (QuerySnapshot,err) in
            if let err = err{
                print("error getting users: \(err)")
                parkings = nil
            }else{
                //return parkings
                for doc in QuerySnapshot!.documents{
                    parkings![doc.documentID] = doc.data()
                    print(parkings)
                    
                }
            }

            completion(parkings)
        }
    }
}





