//
//  IndexViewController.swift
//  EasyParking
//
//  Created by Jun K on 2019-12-13.
//  Copyright © 2019 The Coders. All rights reserved.
//

import UIKit
import WebKit



class IndexViewController: UIViewController, WKUIDelegate{
    
     var webView: WKWebView!
    
    override func loadView() {
        
        //the view configuration after load method is called
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

     override func viewDidLoad() {
       
        super.viewDidLoad()
        
        // set the title of the view
        self.title = "App Manual"
        
        //gets the URL and stores it
        let myURL = URL(string:"file:///Users/junk/Desktop/IOSProject-master%202/EasyParking/index.html")
        
        //Stores the string as URL request
               let myRequest = URLRequest(url: myURL!)
        //Loads the view
               webView.load(myRequest)
        
     
    

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


