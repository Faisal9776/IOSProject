//
//  ParkingTVC.swift
//  EasyParking
//
//  Created by Jun K on 2019-11-19.
//  Copyright © 2019 The Coders. All rights reserved.
//

import UIKit

class ParkingTVC: UITableViewController {
    
    var parkingList = [Parking]()
    
    var controller : ParkingController = ParkingController()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.retrieveParkings()
       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return parkingList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "parking_cell", for: indexPath) as! ParkingCell

        // Configure the cell...
        //display date and time of each parking in each cell
        let parking = parkingList[indexPath.row]
        cell.title?.text = parking.dateAndTime


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mainSB = UIStoryboard(name:"Main", bundle:nil)
        let parkingDetail = mainSB.instantiateViewController(identifier: "ParkingDetailScene") as! ParkingDetailViewController
     
        //open scene with passing current selected parking
        parkingDetail.currentParking = self.parkingList[indexPath.row]; self.navigationController?.pushViewController(parkingDetail, animated: true)

    }
    
    func retrieveParkings(){
    controller.getAllParking(){ (allParkings) in
    if allParkings!.count > 0{
        for element in allParkings!{
            
               let parking = allParkings![element.key] as! [String:Any]?
                
                let buildingCode = parking!["buildingCode"] as? String
                let timeAmount = parking!["timeAmount"] as? String
                let carPlateNumber = parking!["carPlateNumber"] as? String
                let suitNumber = parking!["suitNumber"] as? String
                let dateAndTime = parking!["dateAndTime"] as? String
                let charges = parking!["charge"] as? String
           
           //creating parking object with model and fetched values
                let newParking = Parking(buildingCode : buildingCode as! String, timeAmount: timeAmount as! String, carPlateNumber: carPlateNumber as! String, suitNumber: suitNumber as! String, dateAndTime: dateAndTime as! String, charge: charges as! String)
                      
           self.parkingList.append(newParking)
          //  self.parkingList.sort(by: dateAndTime)
           
           
            }
        self.tableView.reloadData()
        }
    }
        
    }

  

}
