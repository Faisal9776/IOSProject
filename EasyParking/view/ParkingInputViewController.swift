//
//  ParkingInputViewController.swift
//  EasyParking
//
//  Created by Jun K on 2019-11-19.
//  Copyright © 2019 The Coders. All rights reserved.
//

import UIKit

class ParkingInputViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var buildingCode: UITextField!
     @IBOutlet var carPlateNumber: UITextField!
     @IBOutlet var suitNumber: UITextField!
     @IBOutlet var timePicker : UIPickerView!
     
     var timeAmount: [String] = [String]()
     var chargeAmount: [Int] = [Int]()
     var selectedTime: String = "0"
     var charge: Int! = 4
     var count: Int! = 0
     var monthCount: Int! = 0
    
     
     var parkingList = [Parking]()
    
    var controller : ParkingController = ParkingController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.populatePickers()
        self.checkMonthParking()
        // Do any additional setup after loading the view.
    }
    func openReceiptScene(){
       let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
       let ParkingInputVC = storyboard.instantiateViewController(withIdentifier: "ParkingReceiptScene") as! ParkingReceiptViewController
       navigationController?.pushViewController(ParkingInputVC, animated: true)
    }
    
      @IBAction func onAddParking(_ sender: UIButton) {
     
        var userCharge: String = "0"
   
        let date = Date()
        let dateFormatter = DateFormatter()
               
        dateFormatter.dateFormat = "MMM dd,yyyy hh:mm a"

        let dateString = dateFormatter.string(from: date) as String
        let userBuildingCode = buildingCode.text! as String
        let  userTimeAmount = selectedTime
        let userCarPlateNumber = carPlateNumber.text! as String
        let userSuitNumber = suitNumber.text! as String
        
        if (monthCount > 3) {
            userCharge = String(self.charge!)
        }
        
        
        //creating parking object with model and fetched values
        let newParking = Parking(buildingCode : userBuildingCode , timeAmount: userTimeAmount , carPlateNumber: userCarPlateNumber, suitNumber: userSuitNumber , dateAndTime: dateString , charge: userCharge)
        
        
        controller.addNewParking(newParking: newParking)
        
        
         openReceiptScene()
          
           
       }
    
    func checkMonthParking(){
        
        controller.getParkingsByMonth(){(monthParkings) in
            
            self.monthCount = monthParkings
     
        }
    }
       
       func populatePickers(){
       //initialize array data
          timeAmount = ["1","3","10","24"]
           chargeAmount = [4,8,12,20]
           
           self.timePicker.delegate = self
           self.timePicker.dataSource = self
           
       }
       
       //number of columns in Pickerview
          func numberOfComponents(in pickerView: UIPickerView) -> Int {
              return 1
          }
       
       //number of rows in Pickerview
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return self.timeAmount.count
       }
       //assign data from array to picker
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
              return self.timeAmount[row]
          }
       //fetch selected item from pickers
         func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
             self.selectedTime = self.timeAmount[row]
           self.charge = self.chargeAmount[row]
            print(selectedTime)
           print(charge)
         }
   

    
}
