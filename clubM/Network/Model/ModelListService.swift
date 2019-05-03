//
//  ModelListService.swift
//  clubM
//
//  Created by ChacND_HAV on 5/3/19.
//  Copyright © 2019 VPS SECURITIES. All rights reserved.
//

import UIKit

struct ServiceGroup{
    var group_name : String?
    var group_thumbnail : String?
    var img_list : String?
    var img_grid : String?
    var link_detail : String?
}

struct ServiceMenu{
    var link_detail : String?
    var menu_name : String?
    var listGroup : [ServiceGroup]?
}

struct ModelListService{
    var listMenu : [ServiceMenu]
    
    init(){
        listMenu = [ServiceMenu]()
    }
    
    init(_ model : ModelServiceInfo) {
        listMenu = [ServiceMenu]()
        if (model.listData == nil) {
            return
        }
        for item in model.listData! {
            var isHas = false
            for index in 0..<listMenu.count {
//                var avai = listMenu[index]
                if (item.menu_name == listMenu[index].menu_name) {
                    listMenu[index].listGroup!.append(ServiceGroup(group_name: item.group_name,
                                                        group_thumbnail: item.group_thumbnail,
                                                        img_list: item.img_list,
                                                        img_grid: item.img_grid,
                                                        link_detail: item.link_detail))
                    isHas = true
                    break
                }
            }
            if (!isHas) {
                if (item.group_name == nil) {
                    listMenu.append(ServiceMenu(link_detail: item.link_detail,
                                                menu_name: item.menu_name,
                                                listGroup: nil))
                } else {
                    listMenu.append(ServiceMenu(link_detail: nil,
                                                menu_name: item.menu_name,
                                                listGroup: [ServiceGroup(group_name: item.group_name,
                                                                         group_thumbnail: item.group_thumbnail,
                                                                         img_list: item.img_list,
                                                                         img_grid: item.img_grid,
                                                                         link_detail: item.link_detail)]))
                }
            }
        }
    }
}
