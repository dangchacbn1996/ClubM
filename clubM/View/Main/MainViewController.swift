//
//  MainViewController.swift
//  clubM
//
//  Created by ChacND_HAV on 4/24/19.
//  Copyright © 2019 VPS SECURITIES. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    public static let ID_Identify = "MainViewController"
    
    @IBOutlet weak var tableView : UITableView!
    let itemID = MainItemTableViewCell.ID_Identify
    var selected = -1
    var listData = [MainItemModel(title: "Membership Card", subItem: ["SubItem1",
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cell = tableView.cellForRow(at: indexPath) as! MainItemTableViewCell
        if (indexPath.row == selected) {
//            cell.selected(true)
            return 198
        }
//        cell.selected(false)
        return 48
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: itemID, for: indexPath) as! MainItemTableViewCell
//        cell.setData(data: listData[indexPath.row])
        cell.setData(listData[indexPath.row])
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if (selected == indexPath.row) {
//            selected = -1
//            (tableView.cellForRow(at: indexPath) as! MainItemTableViewCell).selected(false)
//            tableView.reloadData()
//            return
//        }
//        if (selected != -1) {
//            (tableView.cellForRow(at: IndexPath(row: selected, section: 0)) as! MainItemTableViewCell).selected(false)
//        }
//        selected = indexPath.row
//        (tableView.cellForRow(at: indexPath) as! MainItemTableViewCell).selected(true)
//        tableView.reloadData()
//    }
}
