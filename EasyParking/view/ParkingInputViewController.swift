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
     var selectedTime: String = "1"
     var charge: Int! = 4
     var count: Int! = 0
     var monthCount: Int! = 0
    var userId: String = ""
    var user :User = User()!
    
     
     var parkingList = [Parking]()
    
    var controller : ParkingController = ParkingController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.populatePickers()
        self.checkMonthParking()
        // Do any additional setup after loading the view.
    }
    
    func openHomePageScene(){
       let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
       let HomeVC = storyboard.instantiateViewController(identifier: "HomePageScene") as! HomePageViewController
        HomeVC.userId = self.userId
        HomeVC.user = self.user
        navigationController?.pushViewController(HomeVC, animated: true)
    }
    
    // assigns all the input values to variable, create instance of parking and add it to the parking collection by calling add parking method in parking controller
       //when adding, since it compares by minutes, wait a minute before adding new parking to make the dateAndTime different by at least 1 minute
      @IBAction func onAddParking(_ sender: UIButton) {
     
        var userCharge: Int = 0
        var userBuildingCode: String = ""
        var userCarPlateNumber: String = ""
        var userSuitNumber: String = ""
   
        let date = Date()
        let dateFormatter = DateFormatter()
               
        dateFormatter.dateFormat = "MMM dd, yyyy hh:mm a"
      
        //verifies the user inputs
        if (buildingCode.text!.count < 4){
            print("Building Code has to be at least 1 character")
        }
        
        else if (carPlateNumber.text!.count != 7){
            print("Car Plate Number has to be exactly 7 characters")
        }
        
        else if (suitNumber.text!.count < 3){
            print("Suit Number has to be at least 1 character")
        }
        
        else{
            
            userBuildingCode = buildingCode.text! as String
             userCarPlateNumber = carPlateNumber.text! as String
             userSuitNumber = suitNumber.text! as String
            let dateString = dateFormatter.string(from: date) as String
            let  userTimeAmount = selectedTime
            
            if (monthCount >= 3) {
                userCharge = self.charge!
            }
            
            
            //creating parking object with model and fetched values
            let newParking = Parking(buildingCode : userBuildingCode , timeAmount: userTimeAmount , carPlateNumber: userCarPlateNumber, suitNumber: userSuitNumber , dateAndTime: dateString , charge: userCharge)
            
            
            controller.addNewParking(newParking: newParking, userId: self.userId)
            
            let errorAlert = UIAlertController(title: "Parking Added", message: "Parking Added Succesfully!", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "ok", style: .default, handler:{_ in
                self.openHomePageScene()}))
            self.present(errorAlert,animated: true,completion: nil)
            
        }
          
       }
    
    //get the count of all parkings this month and assign it to monthCount
    func checkMonthParking(){
        
        controller.getParkingsByMonth(userId: self.userId){(monthParkings) in
            
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
         }
   

    
}
