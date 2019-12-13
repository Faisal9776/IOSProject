//
//  indexViewController.swift
//  EasyParking
//
//  Created by Faisal Eamani on 2019-12-13.
//  Copyright © 2019 The Coders. All rights reserved.
//

import UIKit
import WebKit



class indexViewController: UIViewController, WKUIDelegate{
     var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

     override func viewDidLoad() {
       
        super.viewDidLoad()
        self.title = "App Manual"
        let myURL = URL(string:"file:///Users/faisaleamani/Desktop/Courses/Advanced%20mobile%20computing/IOSProject/EasyParking/index.html")
               let myRequest = URLRequest(url: myURL!)
               webView.load(myRequest)
        
     
    

}
}
