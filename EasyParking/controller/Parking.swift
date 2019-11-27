//
//  Parking.swift
//  EasyParking
//
//  Created by Jun K on 2019-11-19.
//  Copyright © 2019 The Coders. All rights reserved.
//

import UIKit

class Parking {
    var buildingCode: String = ""
    var carPlateNumber: String = ""
    var suitNumber : String = ""
    var timeAmount: String = ""
    var charge: Int = 0
    var dateAndTime: String = ""
    
    init (buildingCode : String, timeAmount: String, carPlateNumber: String, suitNumber: String, dateAndTime: String, charge: Int){
        self.buildingCode = buildingCode
        self.timeAmount = timeAmount
        self.carPlateNumber = carPlateNumber
        self.suitNumber = suitNumber
        self.dateAndTime = dateAndTime
        self.charge = charge
    }
    
    
    
}



