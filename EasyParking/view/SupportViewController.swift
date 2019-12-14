//
//  SupportViewController.swift
//  EasyParking
//
//  Created by Jun K on 2019-12-13.
//  Copyright © 2019 The Coders. All rights reserved.
//
import Foundation

import UIKit
import CallKit
import MessageUI

class ContactDetail: UIViewController {
    var currentContact : mContact!
        
        @IBOutlet var lblName: UILabel!
    @IBOutlet var btnNumber : UIButton!
    @IBOutlet var btnEmail : UIButton!
        override func viewDidLoad() {
            super.viewDidLoad()
            self.currentContact = mContact()
           
           //Set the buttons to the phone number and email extracted from the object
            btnNumber.setTitle(currentContact.phoneNo, for: .normal)
            btnEmail.setTitle(currentContact.emailID, for: .normal)
            
            //Enables the ability to go back with some customized configuration
            self.navigationItem.hidesBackButton = true
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(self.goToContacts))
            
            //display current contact given name and family name
            if self.currentContact != nil{
                self.navigationItem.title = "Contact"
                
                self.lblName.text = "\(self.currentContact.givenName) \(self.currentContact.familyName)"
                print(lblName!)
                
                
            }
            
        }
        
        @objc func goToContacts(){
           //Go back to the previous page
            self.navigationController?.popViewController(animated: true)
        }

    @IBAction func makeCall(){
        print("Trying to call...")
        
        let phoneNumber : String = self.currentContact.phoneNo.replacingOccurrences(of: "[() -]", with: "", options: .regularExpression)
        
        // URL format tel://1234567890
        let callString : String = "tel://\(phoneNumber)"
        
        //convert string into URL
        let url = URL(string: callString)
        
        print("URL : \(url!)")
        
        //check if any application is available to execute the created URL
        if UIApplication.shared.canOpenURL(url!){
            
            //check the version of iOS on the device on which the app is running
            if #available(iOS 10, *){
                //for all the version of iOS 10 onwards
                //if app is available open the URL
                UIApplication.shared.open(url!)
            }else{
                //for iOS version 9 and older
                UIApplication.shared.openURL(url!)
            }
        }else{
            print("Can't place call")
        }
    }
        
        
        @IBAction func doEmail(){
            print("Trying to send email...")
    
            
            //any app that can send an email
            if MFMailComposeViewController.canSendMail(){
               
                let emailPicker = MFMailComposeViewController()
                
                emailPicker.mailComposeDelegate = self
               
               //Sets the email interface to the following default values and can also be changed by the user
                emailPicker.setToRecipients([currentContact.emailID])
                emailPicker.setSubject("Test Email")
                emailPicker.setMessageBody("Hello there!, This is a test message", isHTML: true)
                
                self.present(emailPicker, animated: true, completion: nil)
            }
            
        }
        
       
       

    }
    extension ContactDetail: MFMailComposeViewControllerDelegate{
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            //operations to perform when mail composer finished with the results
            controller.dismiss(animated: true, completion: nil)
        }
    }
