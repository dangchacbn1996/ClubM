
//
//  SubOfferViewController.swift
//  clubM
//
//  Created by DC on 4/25/19.
//  Copyright © 2019 VPS SECURITIES. All rights reserved.
//

import UIKit
//import

class SubOfferViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    static let ID_Identify = "SubOfferViewController"
    let itemID = SubItemCVC.ID_Identify
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var btnChangeLayout : UIButton!
    var isGrid = false
    
    @IBAction func goBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (isGrid) {
            let width = self.collectionView.bounds.width - 5
            return CGSize(width: width,
                          height: width / 131 * 86)
        }
        let width = self.collectionView.bounds.width / 2 - 5
        return CGSize(width: width,
                      height: width)
    }
    
    @IBAction func showMembership(){
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ContentViewController.ID_Identify) as! ContentViewController
        controller.showContent(showContentOrMember: false)
        controller.modalTransitionStyle = .partialCurl
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func changeLayout(){
        isGrid = !isGrid
        btnChangeLayout.setImage(!isGrid ? UIImage(named: "ic_module")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate) : UIImage(named: "ic_list")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
//        collectionView.reload
        UIView.transition(with: collectionView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            //Do the data reload here
            self.collectionView.reloadData()
        }, completion: nil)
//        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionView?.collectionViewLayout = columnLayout
//        collectionView?.contentInsetAdjustmentBehavior = .always
        collectionView.register(UINib(nibName: itemID, bundle: nil), forCellWithReuseIdentifier: itemID)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemID, for: indexPath) as! SubItemCVC
        cell.changeStyle(isGrid)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ContentViewController.ID_Identify) as! ContentViewController
        controller.showContent(showContentOrMember: true)
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true, completion: nil)
    }
    
}
