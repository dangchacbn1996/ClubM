//
//  ViewController.swift
//  clubM
//
//  Created by ChacND_HAV on 4/24/19.
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

class MainViewController: UIViewController, APIManagerFunction{
    @IBOutlet weak var collectionView : UICollectionView!
    fileprivate var _sectionsState = [Int : Bool]()
//    let itemID = MainItemTableViewCell.ID_Identify
    let headerID = "collectionHeader"
    var subItem = SubItemCollectionViewCell.ID_Identify
    var listData = [MainItemModel]()
    var colHeight : CGFloat = 0
    var selectedRow = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager.getListData(callback: self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: subItem, bundle: nil), forCellWithReuseIdentifier: subItem)
    }
    
    func apiDoneGetListData() {
        bindData()
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
        collectionView.reloadData()
    }
    
    @IBAction func showMembership(){
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ContentViewController.ID_Identify) as! ContentViewController
        controller.showContent(showContentOrMember: false)
        controller.modalTransitionStyle = .partialCurl
        self.present(controller, animated: true, completion: nil)
    }
}

//Quan li collectionView
extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView.bounds.width / 5
        colHeight = width * 5 / 4
        return CGSize(width: width, height: colHeight)
    }
    
//    func getCollectionHeight(cell : MainItemTableViewCell) -> (CGFloat) {
//        let count = listData[cell.collectionView.tag].subItem.count
//        let height = (CGFloat(Int(CGFloat(count))) / 4) * colHeight + 48
//        return height
//    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return listData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (listData[section].isExpanded) {
            return listData[section].subItem.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: subItem, for: indexPath) as! SubItemCollectionViewCell
        cell.setData(listData[collectionView.tag].subItem[indexPath.item])
        return cell
    }
    
//    headerView
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID, for: indexPath) as! CollectionHeader
//        selectedRow = indexPath.section
        cell.lbHeader.tag = indexPath.section
        cell.lbHeader.setTitle(listData[indexPath.section].title, for: UIControl.State.normal)
        cell.lbHeader.addTarget(self, action: #selector(changeSectionState(header:)), for: UIControl.Event.touchUpInside)
//        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeSectionState(header:))))
//        cell.lbHeader.text = listData[indexPath.section].title
        return cell
    }
    
    @objc func changeSectionState(header : UIButton) {
//        collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: <#T##IndexPath#>)
        listData[header.tag].isExpanded = !listData[header.tag].isExpanded
        collectionView.reloadSections(IndexSet(integer: header.tag))
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell: Click(\((collectionView.cellForItem(at: indexPath) as! SubItemCollectionViewCell).lbContent.text))")
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SubOfferViewController.ID_Identify) as! SubOfferViewController
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true, completion: nil)
    }
    
}
