//
//  UserSettingsViewController.swift
//  EasyParking
//
//  Created by Jeffrey Jaca on 2019-11-29.
//  Copyright © 2019 The Coders. All rights reserved.
//

import UIKit

class UserSettingsViewController: UIViewController {

    @IBOutlet var txtSettingsName : UITextField!
    @IBOutlet var txtSettingsEmail : UITextField!
    @IBOutlet var txtSettingsPass : UITextField!
    @IBOutlet var txtSettingsConfirm : UITextField!
    @IBOutlet var txtSettingsContact : UITextField!
    @IBOutlet var txtSettingsPlate : UITextField!
    @IBOutlet var txtSettingsCredit : UITextField!
    @IBOutlet var txtSettingsCardName : UITextField!
    @IBOutlet var txtSettingsExpiry : UITextField!
    @IBOutlet var txtSettingsCVV : UITextField!
    
    var user : User = User()!
    var userId : String = ""
    
    var controller : UserController = UserController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadData()
    }
    
    func loadData() -> Void {
        txtSettingsName.text = user.name
        txtSettingsEmail.text = user.email
        txtSettingsPass.text = user.pass
        txtSettingsContact.text = user.contact
        txtSettingsPlate.text = user.plate
        txtSettingsCredit.text = user.credit
        txtSettingsCardName.text = user.cardName
        txtSettingsExpiry.text = user.expiryDate
        txtSettingsCVV.text = String(user.cvv!)
    }
    
    @IBAction func onSaveSettings(){
        //TODO: implement
        let name = txtSettingsName.text ?? ""
        let email = txtSettingsEmail.text ?? ""
        let pass = txtSettingsPass.text ?? ""
        let confirmPass = txtSettingsConfirm.text ?? ""
        let contact = txtSettingsContact.text ?? ""
        let plate = txtSettingsPlate.text ?? ""
        let credit = txtSettingsCredit.text ?? ""
        let cardName = txtSettingsCardName.text ?? ""
        let expiry = txtSettingsExpiry.text ?? ""
        let cvv = Int(txtSettingsCVV.text!) ?? 0
        
        //checks for empty values in all fields
        if (name == "" || email == "" || pass == "" || confirmPass == "" || contact == ""
            || plate == "" || credit == "" || cardName == "" || expiry == "" || cvv == 0){
            
            let errorAlert = UIAlertController(title: "Data Error", message: "Please fill all fields", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self.present(errorAlert,animated: true,completion: nil)
            
            return
        }
        
        if (pass == confirmPass){
            //check proper data formats
            if (verifyEmail(email:email) && verifyContactNumber(contact: contact) && verifyExpiryDate(expiry: expiry) && verifyLicensePlate(plate: plate) && verifyCVV(cvv: cvv)){
                let updatedUser = User(name: name, email: email, password: pass, contact_number: contact, plate_number: plate, credit_card: credit, card_name: cardName, expiry_date: expiry, cvv: cvv)!
            
                controller.updateUser(id: userId, userData: updatedUser)
                
                openHomeScreen(user: updatedUser)
            }else{
                let errorAlert = UIAlertController(title: "Verification Error", message: "Please enter data in the right format", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                self.present(errorAlert,animated: true,completion: nil)
            }
            
        }else{
            
        }
        
    }
    
    func verifyEmail(email: String) -> Bool{
        let emailLength = NSRange(location: 0, length: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: "[A-Za-z]+@{1}[A-Za-z]+.[com|ca]")
        return regex.firstMatch(in: email, options: [], range: emailLength) != nil
    }
    
    func verifyContactNumber(contact:String) -> Bool{
        let contactLength = NSRange(location: 0, length: contact.utf16.count)
        let regex = try! NSRegularExpression(pattern: "[0-9]{3}-?[0-9]{3}-?[0-9]{4}")
        return regex.firstMatch(in: contact, options: [], range: contactLength) != nil
    }
    
    func verifyLicensePlate(plate : String) -> Bool{
        let plateLength = NSRange(location: 0, length: plate.utf16.count)
        let regex = try! NSRegularExpression(pattern: "[A-Za-z]{4}[0-9]{3}")
        return regex.firstMatch(in: plate, options: [], range: plateLength) != nil
    }
    
    func verifyExpiryDate(expiry : String) -> Bool{
        let expiryLength = NSRange(location: 0, length: expiry.utf16.count)
        let regex = try! NSRegularExpression(pattern: "[0-9]{2}/[0-9]{2}")
        
        return regex.firstMatch(in: expiry, options: [], range: expiryLength) != nil
    }
    
    func verifyCVV(cvv: Int) -> Bool{
        let StringifiedCVV = String(cvv)
        let cvvLength = StringifiedCVV.count
        if cvvLength == 3 {
            return true //verified GOOD
        }else{
            return false //verified BAD AND DUMB
        }
    }
    
    func openHomeScreen(user : User){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let HomePageVC = storyBoard.instantiateViewController(identifier: "HomeScene") as! HomePageViewController
        HomePageVC.userId = userId
        HomePageVC.user = user
        self.navigationController?.pushViewController(HomePageVC, animated: true)
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
