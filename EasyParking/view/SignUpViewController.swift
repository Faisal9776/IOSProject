//
//  SignUpViewController.swift
//  EasyParking
//
//  Created by Jeffrey Jaca on 2019-11-13.
//  Copyright © 2019 The Coders. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var txtName : UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword : UITextField!
    @IBOutlet var txtConfirmPassword : UITextField!
    @IBOutlet var txtContact : UITextField!
    @IBOutlet var txtPlate : UITextField!
    @IBOutlet var txtCredit : UITextField!
    @IBOutlet var txtCardName : UITextField!
    @IBOutlet var txtExpiry : UITextField!
    @IBOutlet var txtCVV : UITextField!
    
    var controller : UserController = UserController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignUp(){
        let name = txtName.text ?? ""
        let email = txtEmail.text ?? ""
        let pass = txtPassword.text ?? ""
        let confirmPass = txtConfirmPassword.text ?? ""
        let contact = txtContact.text ?? ""
        let plate = txtPlate.text ?? ""
        let credit = txtCredit.text ?? ""
        let cardName = txtCardName.text ?? ""
        let expiryDate = txtExpiry.text ?? ""
        let cvv = Int(txtCVV.text!) ?? 0
        
        //checks for empty values in all fields
        if (name == "" || email == "" || pass == "" || confirmPass == "" || contact == ""
            || plate == "" || credit == "" || cardName == "" || expiryDate == "" || cvv == 0){
            
            let errorAlert = UIAlertController(title: "Data Error", message: "Please fill all fields", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self.present(errorAlert,animated: true,completion: nil)
            
            return
        }
        
        if pass == confirmPass{
            //newUser holds user data sent to the homepage
            let newUser = User(name: name, email: email, password: pass, contact_number: contact, plate_number: plate, credit_card: credit, card_name: cardName, expiry_date: expiryDate, cvv: cvv)
            
            //check proper data formats
            if (verifyEmail(email:email) && verifyContactNumber(contact: contact)){
                controller.addNewUser(name: name, email: email, password: pass, contact: contact, plate : plate, credit_card: credit, expiry: expiryDate, card_name: cardName, CVV: cvv)
                //TODO: head to after sign in screen
                
            }else{
                let errorAlert = UIAlertController(title: "Verification Error", message: "Please enter data in the right format", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                self.present(errorAlert,animated: true,completion: nil)
            }
            
            
        }
    }
    
    func verifyEmail(email: String) -> Bool{
        let emailLength = NSRange(location: 0, length: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: "[A-Za-z]+@{1}.[com|ca]")
        return regex.firstMatch(in: email, options: [], range: emailLength) != nil
    }
    
    func verifyContactNumber(contact:String) -> Bool{
        let contactLength = NSRange(location: 0, length: contact.utf16.count)
        let regex = try! NSRegularExpression(pattern: "[0-9]{3}-?[0-9]{3}-?[0-9]{4}")
        return regex.firstMatch(in: contact, options: [], range: contactLength) != nil
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
