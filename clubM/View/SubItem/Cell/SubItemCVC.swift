//
//  SubItemCVC.swift
//  clubM
//
//  Created by DC on 4/25/19.
//  Copyright © 2019 VPS SECURITIES. All rights reserved.
//

import UIKit
import Kingfisher

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
        //        imageItem.downloaded(from: data?.img_grid ?? "")
        //        imageWide.downloaded(from: data?.img_list ?? "")
        
        if let gridIcon = data?.img_grid, !gridIcon.isEmpty {
            let url = URL(string: gridIcon)
            imageItem.kf.setImage(with: url) { result in
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
            self.layoutIfNeeded()
        }
        
        if let wideIcon = data?.img_list, !wideIcon.isEmpty {
            let url = URL(string: wideIcon)
            imageWide.kf.setImage(with: url) { result in
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
        
        self.setNeedsLayout()
    }
    
    func changeStyle(_ isShow : Bool) {
        isShowGrid = isShow
        viewWide.alpha = isShowGrid ? 1 : 0
        viewItem.alpha = !isShowGrid ? 1 : 0
    }
    
}
