//
//  ModelListService.swift
//  clubM
//
//  Created by ChacND_HAV on 5/3/19.
//  Copyright © 2019 VPS SECURITIES. All rights reserved.
//

import UIKit

class ServiceGroup: NSObject {
    var group_name = ""
    var group_thumbnail = ""
    var img_list  = ""
    var img_grid = ""
    var link_detail = ""
    var listOffers = [ClubMOfferInfo]()
    
    var hasOffer: Bool = false
    
    convenience init(_ groupName: String, _ groupIcon: String , _ itemsInGroup : [ClubMOfferInfo]) {
        self.init()
        self.group_name = groupName
        self.group_thumbnail = groupIcon
        
        // just has group level: eg : Emigration OR has only ONE element
        if itemsInGroup.count == 1 && itemsInGroup[0].img_grid.isEmpty && itemsInGroup[0].img_list.isEmpty{
            self.link_detail = itemsInGroup[0].link_detail
        } else {
            self.hasOffer = true
            listOffers.removeAll()
            //
            // - Menus
            //      - Groups
            //          - Offers
            self.listOffers = itemsInGroup
        }
        print("")
    }
}

class ServiceMenu : NSObject {
    var link_detail = ""
    var menu_name = ""
    var listGroup = [ServiceGroup]()
    var hasGroup: Bool = false
    
    convenience init(_ menuName: String, _ itemsInMenu : [ClubMOfferInfo]) {
        self.init()
        self.menu_name = menuName
        
        // just has menu level: eg : MemberShip => show detail
        if itemsInMenu.count == 1 && itemsInMenu[0].group_name.isEmpty {
            self.link_detail = itemsInMenu[0].link_detail
        } else {
            self.hasGroup = true
            listGroup.removeAll()
            //
            // - Menus
            //      - Groups
            //          - Offers
            let groupByGroup = itemsInMenu.grouped(by: { (item: ClubMOfferInfo) -> String in
                return item.group_name
            })
            
            for (groupName, offers) in groupByGroup {
                listGroup.append(ServiceGroup(groupName, offers[0].group_thumbnail, offers))
            }
        }
        print("")
    }
    
}

class ClubMData: NSObject {
    var listMenu = [ServiceMenu]()
    
    var plainItems = [ClubMOfferInfo]()
    
    convenience init(_ plainRecords : [ClubMOfferInfo]) {
        self.init()
        self.plainItems = plainRecords
        listMenu.removeAll()
        // - Menus
        //      - Groups
        //          - Offers
        let groupByMenu = plainItems.grouped(by: { (item: ClubMOfferInfo) -> String in
            return item.menu_name
        })
        
        for (menuName, groups) in groupByMenu {
            listMenu.append(ServiceMenu(menuName, groups))
        }
        
        print("")
    }
}

extension Array {
    func grouped<T>(by criteria: (Element) -> T) -> [T: [Element]] {
        var groups = [T: [Element]]()
        for element in self {
            let key = criteria(element)
            if groups.keys.contains(key) == false {
                groups[key] = [Element]()
            }
            groups[key]?.append(element)
        }
        return groups
    }
}


//struct ModelListService{
//    var listMenu : [ServiceMenu]
//
//    init(){
//        listMenu = [ServiceMenu]()
//    }
//
//    init(_ model : ModelServiceInfo) {
//        listMenu = [ServiceMenu]()
//        if (model.listData == nil) {
//            return
//        }
//        for item in model.listData! {
//            var isHas = false
//            for index in 0..<listMenu.count {
//                //                var avai = listMenu[index]
//                if (item.menu_name == listMenu[index].menu_name) {
//                    listMenu[index].listGroup!.append(ServiceGroup(group_name: item.group_name,
//                                                                   group_thumbnail: item.group_thumbnail,
//                                                                   img_list: item.img_list,
//                                                                   img_grid: item.img_grid,
//                                                                   link_detail: item.link_detail))
//                    isHas = true
//                    break
//                }
//            }
//            if (!isHas) {
//                if (item.group_name == nil) {
//                    listMenu.append(ServiceMenu(link_detail: item.link_detail,
//                                                menu_name: item.menu_name,
//                                                listGroup: nil))
//                } else {
//                    listMenu.append(ServiceMenu(link_detail: nil,
//                                                menu_name: item.menu_name,
//                                                listGroup: [ServiceGroup(group_name: item.group_name,
//                                                                         group_thumbnail: item.group_thumbnail,
//                                                                         img_list: item.img_list,
//                                                                         img_grid: item.img_grid,
//                                                                         link_detail: item.link_detail)]))
//                }
//            }
//        }
//    }
//}
