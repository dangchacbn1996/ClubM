//
//  SubItemCVC.swift
//  clubM
//
//  Created by DC on 4/25/19.
//  Copyright © 2019 VPS SECURITIES. All rights reserved.
//

import UIKit

class SubItemCVC: UICollectionViewCell {
    
    static let ID_Identify = "SubItemCVC"
    
    @IBOutlet weak var viewWide : UIView!
    @IBOutlet weak var viewItem : UIView!
//    @IBOutlet weak var lbTitle
    var isShowItem = true

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func changeStyle(_ isShow : Bool) {
        isShowItem = isShow
        viewWide.alpha = isShowItem ? 1 : 0
        viewItem.alpha = !isShowItem ? 1 : 0
    }

}
