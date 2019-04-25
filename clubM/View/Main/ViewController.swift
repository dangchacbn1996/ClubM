//
//  ViewController.swift
//  clubM
//
//  Created by ChacND_HAV on 4/24/19.
//  Copyright © 2019 VPS SECURITIES. All rights reserved.
//

import UIKit
import CollapsibleTableSectionViewController
//import Coll

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: itemID, for: indexPath) as! MainItemTableViewCell
        cell.setData(listData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // <- Your Desired Height
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let height = UITableView.automaticDimension
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MainItemTableViewCell
        cell.setCollapsed(!cell.isCollapsed)
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? MainItemTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    @IBOutlet weak var tableView : UITableView!
    public var delegate: CollapsibleTableSectionDelegate?
    fileprivate var _sectionsState = [Int : Bool]()
    let itemID = MainItemTableViewCell.ID_Identify
    var subItem = SubItemCollectionViewCell.ID_Identify
    var listData = [MainItemModel(title: "Membership Card", subItem: ["SubItem1",
                                                                      "SubItem2",
                                                                      "SubItem2",
                                                                      "SubItem2",
                                                                      "SubItem2",
                                                                      "SubItem2",
                                                                      "SubItem2"]),
                    MainItemModel(title: "Hot Offers", subItem: ["SubItem1",
                                                                 "SubItem2"]),
                    MainItemModel(title: "Offers", subItem: ["SubItem1",
                                                             "SubItem2"]),
                    MainItemModel(title: "Emigration", subItem: ["SubItem1",
                                                                 "SubItem2"]),
                    MainItemModel(title: "About Us", subItem: ["SubItem1",
                                                               "SubItem2"]),
                    MainItemModel(title: "Contact Us", subItem: [])]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: itemID, bundle: nil),
                           forCellReuseIdentifier: itemID)
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.tableView.bounds.width / 5
        return CGSize(width: width, height: width * 5 / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listData[collectionView.tag].subItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: subItem, for: indexPath) as! SubItemCollectionViewCell
        cell.setData(listData[collectionView.tag].subItem[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell: Click(\((collectionView.cellForItem(at: indexPath) as! SubItemCollectionViewCell).lbContent.text))")
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SubOfferViewController.ID_Identify) as! SubOfferViewController
//        controller.showContent(showContentOrMember: true)
        self.present(controller, animated: true, completion: nil)
    }
    
}
