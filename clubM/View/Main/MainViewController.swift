//
//  ViewController.swift
//  clubM
//
//  Created by ChacND_HAV on 4/24/19.
//  Copyright © 2019 VPS SECURITIES. All rights reserved.
//

import UIKit
//import Coll

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, APIManagerFunction{
    @IBOutlet weak var tableView : UITableView!
    fileprivate var _sectionsState = [Int : Bool]()
    let itemID = MainItemTableViewCell.ID_Identify
    var subItem = SubItemCollectionViewCell.ID_Identify
    var listData = [MainItemModel]()
//    var listData = [MainItemModel(title: "Membership Card", subItem: ["SubItem1",
//                                                                      "SubItem2",
//                                                                      "SubItem2",
//                                                                      "SubItem2",
//                                                                      "SubItem2",
//                                                                      "SubItem2",
//                                                                      "SubItem2"]),
//                    MainItemModel(title: "Hot Offers", subItem: ["SubItem1",
//                                                                 "SubItem2"]),
//                    MainItemModel(title: "Offers", subItem: ["SubItem1",
//                                                             "SubItem2"]),
//                    MainItemModel(title: "Emigration", subItem: ["SubItem1",
//                                                                 "SubItem2"]),
//                    MainItemModel(title: "About Us", subItem: ["SubItem1",
//                                                               "SubItem2"]),
//                    MainItemModel(title: "Contact Us", subItem: [])]

    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager.getListData(callback: self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: itemID, bundle: nil),
                           forCellReuseIdentifier: itemID)
    }
    
    func apiDoneGetListData() {
        bindData()
        tableView.reloadData()
    }
    
    func bindData(){
        listData = [MainItemModel]()
        if DataManager.modelService == nil {
            return
        }
        if DataManager.modelService.listData == nil {
           return
        }
        for data in DataManager.modelService!.listData! {
            if (listData.count == 0) {
                listData.append(MainItemModel(title: data.menu_name ?? "Subject", subItem: [data.group_name ?? "group"]))
                continue
            }
            for index in 0..<listData.count {
                if (data.menu_name != listData[index].title) {
                    listData.append(MainItemModel(title: data.menu_name ?? "Subject", subItem: [data.group_name ?? "group"]))
                } else {
                    listData[index].subItem.append(data.group_name ?? "group")
                }
            }
        }
    }
    
    @IBAction func showMembership(){
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ContentViewController.ID_Identify) as! ContentViewController
        controller.showContent(showContentOrMember: false)
        controller.modalTransitionStyle = .partialCurl
        self.present(controller, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: itemID, for: indexPath) as! MainItemTableViewCell
        cell.setData(listData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (listData[indexPath.row].subItem.count == 0) {
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SubOfferViewController.ID_Identify) as! SubOfferViewController
            controller.modalTransitionStyle = .crossDissolve
            self.present(controller, animated: true, completion: nil)
            return
        }
        let cell = tableView.cellForRow(at: indexPath) as! MainItemTableViewCell
        cell.setCollapsed(!cell.isCollapsed)
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? MainItemTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
}

//Quan li collectionView
extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
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
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true, completion: nil)
    }
    
}
