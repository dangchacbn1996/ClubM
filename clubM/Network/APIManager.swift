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
    @objc optional func apiDoneGetListData(data: ClubMData)
}

class APIManager {
    static func getListData(callback : APIManagerFunction) {
        let apiCore = "https://onlyu.xyz/mobile/api/clubm.json"
        Alamofire.request(apiCore).responseJSON {
            response in
            switch response.result {
            case .success:
//                do {
                    if let data = response.data, let resultStr = String.init(data: data, encoding: .utf8) {
                        if let records = [ClubMOfferInfo].deserialize(from: resultStr) {
                            
                            let allData = ClubMData(records as! [ClubMOfferInfo])
                            callback.apiDoneGetListData!(data: allData)
                        }
                    }
                    
//                    let responseEx = try JSONDecoder().decode([ClubMOfferInfo].self, from: response.data!)
//                    let allData = ClubMData(responseEx)
//                    callback.apiDoneGetListData!(data: allData)
                    
//                } catch let jsonErr {
//                    print("Error: \(jsonErr)")
//                }
            case .failure:
                print("Fail to connect")
            }
        }
    }
}
