//
//  ContentViewController.swift
//  clubM
//
//  Created by DC on 4/25/19.
//  Copyright © 2019 VPS SECURITIES. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    static let ID_Identify = "ContentViewController"

    @IBOutlet weak var viewBack : UIView!
    @IBOutlet weak var stackInfo : UIStackView!
    @IBOutlet weak var icContent : UIImageView!
    var image = UIImage()
    var isShowContent = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        icContent.image = image
        stackInfo.isHidden = isShowContent
        viewBack.backgroundColor = isShowContent ? UIColor.white : UIColor.clear
    }
    
    @IBAction func goBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func showContent(showContentOrMember : Bool) {
        self.isShowContent = showContentOrMember
        if (showContentOrMember) {
            image = UIImage(named: "ic_content")!
        } else {
            image = UIImage(named: "ic_membership")!
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
