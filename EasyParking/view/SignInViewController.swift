//
//  SignInViewController.swift
//  EasyParking
//
//  Created by Jeffrey Jaca on 2019-11-12.
//  Copyright © 2019 The Coders. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet var txtEmail : UITextField!
    @IBOutlet var txtPassword : UITextField!
    @IBOutlet var swtRemember : UISwitch!
    
    var controller : UserController = UserController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignInClick(_ sender : UIButton){
        self.signIn()
    }
    
    func signIn(){
        controller.getAllUsers(){ (allUsers) in
            if allUsers!.count > 0{
                for u in allUsers! {
                    let user = allUsers![u.key] as! [String:Any]?
                    
                    let enteredEmail = self.txtEmail.text
                    let enteredPassword = self.txtPassword.text
                    //print(user!["name"] ?? "No Name")
                    let userName : String = user!["name"] as! String
                    let userEmail : String = user!["email"] as! String
                    let userPassword : String = user!["password"] as! String
                    let userContact : String = user!["contact_number"] as! String
                    let userPlate : String = user!["plate_number"] as! String
                    let userCredit : String = user!["credit_card"] as! String
                    let userCardName : String = user!["card_name"] as! String
                    let userExpiry : String = user!["card_expiration"] as! String
                    let userCVV : Int = user!["CVV"] as! Int
                    
                    //self.controller.getUser(id: u.key){ (logging_in) in
                      //  print("printing user details")
                        //print(logging_in.name)
                    //}
                    
                    if  (userEmail == enteredEmail) && (userPassword == enteredPassword){
                        print("Successful Login")
                        let authenticatedUser = User(name: userName, email: userEmail, password: userPassword, contact_number: userContact, plate_number: userPlate, credit_card: userCredit, card_name: userCardName, expiry_date: userExpiry, cvv: userCVV)
                        //TODO: send to the home page
                    }
                }
            }
        }
    }
    
    @IBAction func onSignUp(){
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let SignUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpScene") as! SignUpViewController
        navigationController?.pushViewController(SignUpVC, animated: true)
    }
    
    @IBAction func onForgotPassword(){
        
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
