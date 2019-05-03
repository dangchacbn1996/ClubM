//
//  APIManager.swift
//  clubM
//
//  Created by ChacND_HAV on 4/26/19.
//  Copyright © 2019 VPS SECURITIES. All rights reserved.
//

import UIKit
import Alamofire

@objc protocol APIManagerFunction {
    @objc optional func apiDoneGetListData()
}

class APIManager {
    static func getListData(callback : APIManagerFunction) {
        var apiCore = "https://onlyu.xyz/mobile/api/clubm.json"
        Alamofire.request(apiCore).responseJSON{
            response in
            switch response.result {
            case .success:
                do {
                    let responseEx = try JSONDecoder().decode([DataServiceInfo].self, from: response.data!)
                    let data = ModelServiceInfo(listData: responseEx)
                    DataManager.modelService = ModelListService(data)
                    callback.apiDoneGetListData!()
                } catch let jsonErr {
                    print("Error: \(jsonErr)")
                }
            case .failure:
                print("Fail to connect")
            }
        }
    }
}
