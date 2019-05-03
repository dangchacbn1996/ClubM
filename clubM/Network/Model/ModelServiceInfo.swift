//
//  ServiceInfoModel.swift
//  clubM
//
//  Created by ChacND_HAV on 4/26/19.
//  Copyright © 2019 VPS SECURITIES. All rights reserved.
//

import UIKit

class DataServiceInfo : NSObject, Decodable {
    var menu_name : String?
    var group_name : String?
    var group_thumbnail : String?
    var img_list : String?
    var img_grid : String?
    var link_detail : String?
}

struct ModelServiceInfo{
    var listData : [DataServiceInfo]?
}
