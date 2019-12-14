//
//  HomePageViewController.swift
//  EasyParking
//
//  Created by Jeffrey Jaca on 2019-11-23.
//  Copyright © 2019 The Coders. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBOutlet var lblWelcomeBanner : UILabel!
    
    var controller : ParkingController = ParkingController()
    
    var user : User = User()!
    var userId : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblWelcomeBanner.text = "Welcome " + user.name!
    }
    
    @IBAction func onAddParking(_ sender:UIBarButtonItem){
        //TODO: Send to the add parking view
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let ParkingInputVC = storyboard.instantiateViewController(withIdentifier: "ParkingInputScene") as! ParkingInputViewController
        ParkingInputVC.userId = self.userId
        ParkingInputVC.user = self.user
        navigationController?.pushViewController(ParkingInputVC, animated: true)
    }
    
    @IBAction func onFindNearbyParking(_ sender: UIBarButtonItem){
        //TODO: Send to find nearby parking view
    }
    
    @IBAction func onParkingReceiptList(_ sender: UIBarButtonItem){
        //TODO: send to parking receipt list view
        controller.getAllParking(userId: self.userId){ (allParkings) in
                   if allParkings!.count > 0{
                      
                       let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                       let ParkingInputVC = storyboard.instantiateViewController(withIdentifier: "ParkingListScene") as! ParkingTVC
                       ParkingInputVC.userId = self.userId
                    self.navigationController?.pushViewController(ParkingInputVC, animated: true)
                   }
                       
                   else{
                       let errorAlert = UIAlertController(title: "Navigation Error", message: "No parkings exist in the record yet", preferredStyle: .alert)
                       errorAlert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                       self.present(errorAlert,animated: true,completion: nil)            }
               
               
               }
       
        
    }
    
    @IBAction func onParkingManual(_ sender: UIBarButtonItem){
        //TODO: send to parking app manual view
    }
    
    @IBAction func onCustomerSupport(_ sender: UIBarButtonItem){
        //TODO: send to customer support view
    }
    
    @IBAction func onUserSettings(_ sender: UIBarButtonItem){
        //TODO: send to user settings view
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let SettingsVC = storyboard.instantiateViewController(withIdentifier: "SettingsScene") as! UserSettingsViewController
        SettingsVC.user = user
        SettingsVC.userId = self.userId
        self.navigationController?.pushViewController(SettingsVC, animated: true)
    }
    
    @IBAction func onLatestReceipt(_ sender: UIBarButtonItem){
        controller.getAllParking(userId: self.userId){ (allParkings) in
            if allParkings!.count > 0{
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let ParkingInputVC = storyboard.instantiateViewController(withIdentifier: "ParkingReceiptScene") as! ParkingReceiptViewController
                ParkingInputVC.userId = self.userId
                self.navigationController?.pushViewController(ParkingInputVC, animated: true)
                
            }
                
            else{
                let errorAlert = UIAlertController(title: "Navigation Error", message: "No parkings exist in the record yet", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                self.present(errorAlert,animated: true,completion: nil)            }
        
        
        }
        
    }
    
    @IBAction func onSignOut(_ sender: UIButton){
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let SignInVC = storyboard.instantiateViewController(identifier: "SignInScene") as! SignInViewController
        navigationController?.pushViewController(SignInVC, animated: true)
    }
    @IBAction func onAppManual(){
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let ManualVC = storyboard.instantiateViewController(withIdentifier: "IndexScene") as! IndexViewController
                            navigationController?.pushViewController(ManualVC, animated: true)
         
    }
    
    @IBAction func onContact(){
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
               let ContactVC = storyboard.instantiateViewController(withIdentifier: "ContactScene") as! ContactDetail
               navigationController?.pushViewController(ContactVC, animated: true)
        
    }
    
    @IBAction func onFindParkingSpot(){
           let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let MapVC = storyboard.instantiateViewController(withIdentifier: "map_scene") as! MapViewController
                        navigationController?.pushViewController(MapVC, animated: true)
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
