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
    @IBOutlet weak var imageWide : UIImageView!
    @IBOutlet weak var viewItem : UIView!
    @IBOutlet weak var imageItem : UIImageView!
    var data : ServiceGroup?
    var isShowGrid = true

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(_ model : ServiceGroup) {
        self.data = model
        imageItem.downloaded(from: data?.img_grid ?? "")
        imageWide.downloaded(from: data?.img_list ?? "")
    }
    
    func changeStyle(_ isShow : Bool) {
        isShowGrid = isShow
        viewWide.alpha = isShowGrid ? 1 : 0
        viewItem.alpha = !isShowGrid ? 1 : 0
    }

}
