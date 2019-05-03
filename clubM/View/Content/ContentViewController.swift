//
//  ContentViewController.swift
//  clubM
//
//  Created by DC on 4/25/19.
//  Copyright © 2019 VPS SECURITIES. All rights reserved.
//

import UIKit
import WebKit

class ContentViewController: UIViewController {
    
    static let ID_Identify = "ContentViewController"

    @IBOutlet weak var webKit : WKWebView!
    var content : String = ""
    var image = UIImage()
    var isShowContent = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webKit.load(URLRequest(url: URL(string: content)!))
    }
    
    @IBAction func goBack(){
        self.dismiss(animated: true, completion: nil)
    }

}
