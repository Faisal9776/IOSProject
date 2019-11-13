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
        let name = txtName.text!
        let email = txtEmail.text!
        let pass = txtPassword.text!
        let confirmPass = txtConfirmPassword.text!
        let contact = txtContact.text!
        let plate = txtPlate.text!
        let credit = txtCredit.text!
        let cardName = txtCardName.text!
        let expiryDate = txtExpiry.text!
        let cvv = Int(txtCVV.text!) ?? 0
        if pass == confirmPass{
            controller.addNewUser(name: name, email: email, password: pass, contact: contact, plate : plate, credit_card: credit, expiry: expiryDate, card_name: cardName, CVV: cvv)
            
            //head to after sign in screen
        }
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
