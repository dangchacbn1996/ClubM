//
//  MainItemTableViewCell.swift
//  clubM
//
//  Created by ChacND_HAV on 4/25/19.
//  Copyright © 2019 VPS SECURITIES. All rights reserved.
//

import UIKit

struct MainItemModel {
    var title : String
    var subItem : [String]
    var isExpanded : Bool = false
    
    init(title : String, subItem : [String]) {
        self.title = title
        self.subItem = subItem
        isExpanded = false
    }
}

class MainItemTableViewCell: UITableViewCell{

    static let ID_Identify = "MainItemTableViewCell"
    
    @IBOutlet weak var lbTitle : UILabel!
    @IBOutlet weak var collectionView : UICollectionView!
    var isCollapsed = false
    var data : MainItemModel = MainItemModel(title: "", subItem: [])
    var itemId = SubItemCollectionViewCell.ID_Identify
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: itemId, bundle: nil), forCellWithReuseIdentifier: itemId)
    }
    
    func setData(_ data : MainItemModel) {
        lbTitle.text = data.title
        self.data = data
        collectionView.reloadData()
    }
    
    func setCollapsed(_ isCollapsed : Bool) {
        self.isCollapsed = isCollapsed
//        collectionView.isHidden = isCollapsed
        collectionView.reloadData()
        collectionView.performBatchUpdates(nil) { (update) in
            let constraint = isCollapsed ? 48 : 48 + self.collectionView.collectionViewLayout.collectionViewContentSize.height
            print("Cell: \(isCollapsed)")
            print("Cell: Height \(constraint)")
            self.collectionViewHeight.constant = constraint
            self.setNeedsLayout()
        }
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.reloadData()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
