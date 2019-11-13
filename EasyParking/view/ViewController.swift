//
//  ViewController.swift
//  EasyParking
//
//  Created by Jeffrey Jaca on 2019-11-10.
//  Copyright © 2019 The Coders. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let SignInVC = storyBoard.instantiateViewController(withIdentifier: "SignInScene") as! SignInViewController
        navigationController?.pushViewController(SignInVC, animated: true)
    }


}

