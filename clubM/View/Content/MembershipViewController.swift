//
//  MembershpwViewController.swift
//  clubM
//
//  Created by ChacND_HAV on 5/3/19.
//  Copyright © 2019 VPS SECURITIES. All rights reserved.
//

import UIKit

class MembershipViewController: UIViewController {
    
    static let ID_Identify = "MembershipViewController"
    
    @IBOutlet weak var viewBack : UIView!
    @IBOutlet weak var icContent : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        icContent.image = UIImage(named: "ic_membership")!
    }
    
    @IBAction func goBack(){
        self.dismiss(animated: true, completion: nil)
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
