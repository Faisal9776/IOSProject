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
        let allUsers = controller.getAllUsers()
        
        if allUsers!.capacity > 0{
            for u in allUsers! {
                let user = allUsers![u.key] as! [String:Any]?
                print(user!["name"] ?? "No Name")
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
