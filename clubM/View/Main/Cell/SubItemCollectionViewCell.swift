//
//  SubItemCollectionViewCell.swift
//  clubM
//
//  Created by ChacND_HAV on 4/25/19.
//  Copyright © 2019 VPS SECURITIES. All rights reserved.
//

import UIKit

struct SubItemModel {
    var content : String
    var iconUrl : String
}

class SubItemCollectionViewCell: UICollectionViewCell {
    
    static let ID_Identify = "SubItemCollectionViewCell"
    @IBOutlet weak var imageView : CustomImageView!
    @IBOutlet weak var lbContent : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(_ model : ServiceGroup) {
//        lbContent.text = model.content
        lbContent.text = model.group_name ?? "Group"
        imageView.downloaded(from: model.group_thumbnail ?? "")
    }
    
    func setData(_ model : String) {
        lbContent.text = model
//        self.setNeedsLayout()
    }

}
