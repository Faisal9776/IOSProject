//
//  ParkingDetailViewController.swift
//  EasyParking
//
//  Created by Jun K on 2019-11-19.
//  Copyright © 2019 The Coders. All rights reserved.
//

import UIKit

class ParkingDetailViewController: UIViewController {
    
    @IBOutlet var buildingCode: UILabel!
        @IBOutlet var timeAmount: UILabel!
        @IBOutlet var carPlateNumber: UILabel!
        @IBOutlet var suitNumber: UILabel!
        @IBOutlet var dateAndTime: UILabel!
        @IBOutlet var charges: UILabel!
    
    // set currentParking from passed data from PakingTVC
    var currentParking : Parking!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //set each labels from currentPakring detail
        buildingCode.text = currentParking.buildingCode
        
        timeAmount.text = currentParking.timeAmount
        
        carPlateNumber.text = currentParking.carPlateNumber
        
        suitNumber.text = currentParking.suitNumber
        
        dateAndTime.text = currentParking.dateAndTime
        
        charges.text = String(currentParking.charge)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
