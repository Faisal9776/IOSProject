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
    
    var user : User = User()!
    var userId : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblWelcomeBanner.text = "Welcome " + user.name!
    }
    
    @IBAction func onAddParking(_ sender:UIBarButtonItem){
        //TODO: Send to the add parking view
    }
    
    @IBAction func onFindNearbyParking(_ sender: UIBarButtonItem){
        //TODO: Send to find nearby parking view
    }
    
    @IBAction func onParkingReceiptList(_ sender: UIBarButtonItem){
        //TODO: send to parking receipt list view
    }
    
    @IBAction func onParkingManual(_ sender: UIBarButtonItem){
        //TODO: send to parking app manual view
    }
    
    @IBAction func onCustomerSupport(_ sender: UIBarButtonItem){
        //TODO: send to customer support view
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
