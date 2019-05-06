//
//  SubItemCollectionViewCell.swift
//  clubM
//
//  Created by ChacND_HAV on 4/25/19.
//  Copyright © 2019 VPS SECURITIES. All rights reserved.
//

import UIKit
import Kingfisher

struct SubItemModel {
    var content : String
    var iconUrl : String
}


class SubItemCollectionViewCell: UICollectionViewCell {
    
    static let ID_Identify = "SubItemCollectionViewCell"
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var lbContent : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbContent.numberOfLines = 0
        lbContent.lineBreakMode = .byWordWrapping
        //imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    func setData(_ model : ServiceGroup) {
        //        lbContent.text = model.content
        lbContent.text = model.group_name ?? " "
        if let groupIcon = model.group_thumbnail, !groupIcon.isEmpty {
            let url = URL(string: groupIcon)
            imageView.kf.setImage(with: url) { result in
                switch result {
                case .success(let value):
                    // The image was set to image view:
                    print(value.image)
                    
                    // From where the image was retrieved:
                    // - .none - Just downloaded.
                    // - .memory - Got from memory cache.
                    // - .disk - Got from disk cache.
                    print(value.cacheType)
                    
                    // The source object which contains information like `url`.
                    print(value.source)
                    
                case .failure(let error):
                    print(error) // The error happens
                }
            }
            //imageView.downloaded(from: groupIcon, contentMode: .scaleAspectFill)
            self.layoutIfNeeded()
        }
        
        print("w = \(imageView.frame.size.width) ; h = \(imageView.frame.size.height)")
        self.setNeedsLayout()
    }
    
    func setData(_ model : String) {
        lbContent.text = model
//        self.setNeedsLayout()
    }

}
