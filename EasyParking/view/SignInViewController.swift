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
            var signInStatus = false
            if allUsers!.count > 0{
                for u in allUsers! {
                    let id = u.key
                    
                    let user = allUsers![id] as! [String:Any]?
                    
                    let enteredEmail = self.txtEmail.text ?? ""
                    let enteredPassword = self.txtPassword.text ?? ""
                    
                    //checks for empty fields
                    if (enteredEmail == "" || enteredPassword == ""){
                        let errorAlert = UIAlertController(title: "Data Error", message: "Please fill all fields", preferredStyle: .alert)
                        errorAlert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                        self.present(errorAlert,animated: true,completion: nil)
                        
                        return
                    }
                    
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
                        signInStatus = true
                        let authenticatedUser = User(name: userName, email: userEmail, password: userPassword, contact_number: userContact, plate_number: userPlate, credit_card: userCredit, card_name: userCardName, expiry_date: userExpiry, cvv: userCVV)
                        //TODO: send to the home page
                        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let HomePageVC = storyboard.instantiateViewController(withIdentifier: "HomePageScene") as! HomePageViewController
                        HomePageVC.user = authenticatedUser!
                        HomePageVC.userId = id
                        self.navigationController?.pushViewController(HomePageVC, animated: true)
                        
                        break
                    }
                }
            }
            if(!signInStatus){
                let wrongSignInAlert = UIAlertController(title: "Incorrect Credentials", message: "Your email or password was incorrect, please try again", preferredStyle: .alert)
                wrongSignInAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(wrongSignInAlert,animated: true,completion: nil)
            }
            
        }
    }
    
    @IBAction func onSignUp(){
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let SignUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpScene") as! SignUpViewController
        navigationController?.pushViewController(SignUpVC, animated: true)
    }
    
    @IBAction func onForgotPassword(){
        let forgotAlert = UIAlertController(title: "Forgot Password?", message: "Enter your email and new password", preferredStyle: .alert)
        forgotAlert.addTextField{(textField : UITextField) in
            textField.placeholder = "Enter Email"
        }
        forgotAlert.addTextField{(textField : UITextField) in
            textField.placeholder = "Enter new password"
        }
        forgotAlert.addTextField{(textField : UITextField) in
            textField.placeholder = "Confirm new password"
        }
        
        forgotAlert.addAction(UIAlertAction(title: "Change Password", style: .default, handler: {
            _ in
            if let email = forgotAlert.textFields?[0].text{
                let newPassword = forgotAlert.textFields?[1].text
                let confirmNew = forgotAlert.textFields?[2].text
                
                if(newPassword == confirmNew){
                    self.controller.updatePassword(email:email,password:newPassword!)
                }
            }
        }))
        
        forgotAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(forgotAlert,animated: true,completion: nil)
    }
    
    func rememberLogin(){
        UserDefaults.standard.set(self.txtEmail.text, forKey: "EMAIL")
        UserDefaults.standard.set(self.txtPassword.text, forKey: "PASSWORD")
    }
    
    func getRememberedLogin(){
        if let email = UserDefaults.standard.value(forKey: "EMAIL"){
            self.txtEmail.text = email as? String
        }
        
        if let password = UserDefaults.standard.value(forKey: "PASSWORD"){
            self.txtPassword.text = password as? String
        }
    }
    
    func forgetLogin(){
        if let _ = UserDefaults.standard.value(forKey: "EMAIL"){
            UserDefaults.standard.removeObject(forKey: "EMAIL")
        }
        
        if let _ = UserDefaults.standard.value(forKey: "PASSWORD"){
            UserDefaults.standard.removeObject(forKey: "PASSWORD")
        }
    }
   

}
