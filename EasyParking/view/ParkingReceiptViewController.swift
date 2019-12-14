//
//  ParkingReceiptViewController.swift
//  EasyParking
//
//  Created by Jun K on 2019-11-19.
//  Copyright © 2019 The Coders. All rights reserved.
//

import UIKit

class ParkingReceiptViewController: UIViewController {

    @IBOutlet var buildingCode: UILabel!
    @IBOutlet var carPlateNumber: UILabel!
    @IBOutlet var suitNumber: UILabel!
    @IBOutlet var dateAndTime: UILabel!
    @IBOutlet var timeAmount: UILabel!
    @IBOutlet var charges: UILabel!
    var userId: String = ""
    
    var parkingList = [Parking]()
    
    var controller : ParkingController = ParkingController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
      
        
     
    }
    //gets the latest parking by calling get latest parking method in parking controller and assigns the labels with its values
    //compares by minutes, wait a minute before adding new parking to make the dateAndTime different by at least 1 minute
    func retrieveData(){
        controller.getLatestParking(userId: self.userId){ (allParkings) in
                  if allParkings!.count > 0{
                      for element in allParkings! {
                         // if idx == allParkings!.count-1{
                              let parking = allParkings![element.key] as! [String:Any]?
                              
                              self.buildingCode.text = parking!["buildingCode"] as? String
                              self.timeAmount.text = parking!["timeAmount"] as? String
                              self.carPlateNumber.text = parking!["carPlateNumber"] as? String
                              self.suitNumber.text = parking!["suitNumber"] as? String
                              self.dateAndTime.text = parking!["dateAndTime"] as? String
                        
                             let charge = parking!["charge"] as! Int
                              self.charges.text = String(charge)
                          }
                      }
                  }
        
    }
    
    
    /*
    @IBAction func onSign(_ sender : UIButton){
       let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
       let ParkingInputVC = storyboard.instantiateViewController(withIdentifier: "ParkingListScene") as! ParkingTVC
       navigationController?.pushViewController(ParkingInputVC, animated: true)
    }*/

}
