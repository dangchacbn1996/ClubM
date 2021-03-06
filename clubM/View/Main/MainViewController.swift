//
//  ViewController.swift
//  clubM
//
//  Created by ChacND_HAV on 4/24/19.
//  Copyright © 2019 VPS SECURITIES. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, APIManagerFunction{
    @IBOutlet weak var collectionView : UICollectionView!
    fileprivate var _sectionsState = [Int : Bool]()
    let headerID = "collectionHeader"
    var itemID = SubItemCollectionViewCell.ID_Identify
    var data = ClubMData()
    var dataExpand = [Bool]()
    var colHeight : CGFloat = 0
    var selectedRow = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager.getListData(callback: self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: itemID, bundle: nil), forCellWithReuseIdentifier: itemID)
    }
    
    func apiDoneGetListData(data: ClubMData) {
        self.data = data
        dataExpand = [Bool]()
        for _ in self.data.listMenu{
            dataExpand.append(false)
        }
        collectionView.reloadData()
    }
    
    @IBAction func showMembership(){
        (UIApplication.shared.delegate as! AppDelegate).showMembership(viewController : self)
    }
}

//Quan li collectionView
extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView.bounds.width / 5
        colHeight = width * 5 / 4
        return CGSize(width: width, height: colHeight)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.listMenu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (dataExpand[section]) {
            return data.listMenu[section].listGroup.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemID, for: indexPath) as! SubItemCollectionViewCell
        cell.setData(data.listMenu[indexPath.section].listGroup[indexPath.item])
        cell.imageView.layer.cornerRadius = cell.contentView.frame.height * 0.6 / 2
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 48)
    }
    
    //Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID, for: indexPath) as! CollectionHeader
        cell.lbHeader.tag = indexPath.section
        cell.lbHeader.setTitle(data.listMenu[indexPath.section].menu_name, for: UIControl.State.normal)
        cell.lbHeader.addTarget(self, action: #selector(changeSectionState(header:)), for: UIControl.Event.touchUpInside)
        
        return cell
    }
    
    @objc func changeSectionState(header : UIButton) {
        if !data.listMenu[header.tag].link_detail.isEmpty {
            let controller = UIStoryboard(name: "ClubM", bundle: nil).instantiateViewController(withIdentifier: ContentViewController.ID_Identify) as! ContentViewController
            controller.content = data.listMenu[header.tag].link_detail
            controller.modalTransitionStyle = .crossDissolve
            self.present(controller, animated: true, completion: nil)
            return
        }
        dataExpand[header.tag] = !dataExpand[header.tag]
        collectionView.reloadSections(IndexSet(integer: header.tag))
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menuData = data.listMenu[indexPath.section]
        if menuData.hasGroup {
            let groupData = menuData.listGroup[indexPath.row]
            if groupData.hasOffer {
                openGroupView(groupData: groupData)
            } else {
                openContentView(linkDetail: groupData.link_detail)
            }
        } else {
            openContentView(linkDetail: menuData.link_detail)
        }
    }
    
    func openContentView(linkDetail: String){
        let controller = UIStoryboard(name: "ClubM", bundle: nil).instantiateViewController(withIdentifier: ContentViewController.ID_Identify) as! ContentViewController
        controller.content = linkDetail
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true, completion: nil)
    }
    
    func openGroupView(groupData : ServiceGroup) {
        let controller = UIStoryboard(name: "ClubM", bundle: nil).instantiateViewController(withIdentifier: SubOfferViewController.ID_Identify) as! SubOfferViewController
        controller.data = groupData
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true, completion: nil)
    }
}
