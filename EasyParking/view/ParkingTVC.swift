//
//  ParkingTVC.swift
//  EasyParking
//
//  Created by Jun K on 2019-11-19.
//  Copyright © 2019 The Coders. All rights reserved.
//

import UIKit

class ParkingTVC: UITableViewController {
    
    //unsorted parking list
    var parkingList = [Parking]()
    //sorted parking list
    var newparkingList = [Parking]()
    var userId: String = ""
    
    var controller : ParkingController = ParkingController()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.retrieveParkings()
       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        //  return the number of sections
        return 1    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  return the number of rows
        return newparkingList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "parking_cell", for: indexPath) as! ParkingCell

        // Configure the cell...
        //display date and time of each parking in each cell
        let parking = newparkingList[indexPath.row]
        cell.title?.text = parking.dateAndTime


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mainSB = UIStoryboard(name:"Main", bundle:nil)
        let parkingDetail = mainSB.instantiateViewController(identifier: "ParkingDetailScene") as! ParkingDetailViewController
     
        //open scene with passing current selected parking
        parkingDetail.currentParking = self.newparkingList[indexPath.row]; self.navigationController?.pushViewController(parkingDetail, animated: true)

    }
    
    //gets all the parkings and appends it to parkingList first. Then it is sorted in decesding order by date and appended into sorted array newParkingList
    //not efficient but firestore doesn't have a way to return ordered documents, therefore, it had to be implemented manually
    //also explained the order(by:) and limit() methods in getLatestParking method which doesn't actually return sorted documents
    func retrieveParkings(){
        controller.getAllParking(userId: self.userId){ (allParkings) in
    if allParkings!.count > 0{
        for element in allParkings!{
            
               let parking = allParkings![element.key] as! [String:Any]?
                
                let buildingCode = parking!["buildingCode"] as? String
                let timeAmount = parking!["timeAmount"] as? String
                let carPlateNumber = parking!["carPlateNumber"] as? String
                let suitNumber = parking!["suitNumber"] as? String
                let dateAndTime = parking!["dateAndTime"] as? String
                let charges = parking!["charge"] as? Int
           
           
           //creating parking object with model and fetched values
                let newParking = Parking(buildingCode : buildingCode as! String, timeAmount: timeAmount as! String, carPlateNumber: carPlateNumber as! String, suitNumber: suitNumber as! String, dateAndTime: dateAndTime as! String, charge: charges as! Int)
                      
           self.parkingList.append(newParking)
            
           
           
            }
            
           
           
            }
        
        var count : Int = 0
        var parking = self.parkingList[0]
        
        
        while (self.parkingList.count != 1){
           
            while(count != self.parkingList.count - 1){
               
                if(self.parkingList[count].dateAndTime > self.parkingList[count+1].dateAndTime){
                    if(self.parkingList[count].dateAndTime > parking.dateAndTime){
                        parking = self.parkingList[count]
                       
                    }
                    
                        
                    }
                    else  if(self.parkingList[count+1].dateAndTime > self.parkingList[count].dateAndTime){
                    if(self.parkingList[count+1].dateAndTime > parking.dateAndTime){
                        parking = self.parkingList[count+1]
                       
                    }
                       
                        
                }
                count += 1
                
            }
            
            self.newparkingList.append(parking)
            print(self.parkingList.count)
            if let index = self.parkingList.firstIndex(where: { $0 === parking }) {
                self.parkingList.remove(at: index)
            
           }
          
            if(self.parkingList.count != 0){
                parking = self.parkingList[0]
                
            }
            
            count=0
            
        }
        self.newparkingList.append(self.parkingList[0])
        self.tableView.reloadData()
        
        
        }
    }
        
    }

  


