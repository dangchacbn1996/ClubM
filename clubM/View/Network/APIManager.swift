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
//        Alamofire.request(apiCore,
//                          method: HTTPMethod.get,
//                          parameters: [:],
//                          encoding: param,
//                          headers: [:])
//            .responseJSON{
//                response in
//                switch response.result {
//                case .success:
//                    do {
//                        let responseEx = try JSONDecoder().decode(ModelServiceInfo.self, from: response.data!)
//                        DataManager.modelService = responseEx
//                        callback.apiDoneGetListData! (data: responseEx)
////                        callBack.apiOnDidGetBankList!(data : responseEx)
//                    } catch let jsonErr {
//                        print("Error: \(jsonErr)")
////                        callBack.apiOnDidFail(mess: jsonErr as! String)
//                    }
//                case .failure:
//                    print("Fail to connect")
////                    callBack.apiOnDidFail(mess: "Error: \(String(describing: response.response?.statusCode))")
//                }
//        }
        Alamofire.request(apiCore).responseJSON{
            response in
            switch response.result {
            case .success:
                do {
                    let responseEx = try JSONDecoder().decode([DataServiceInfo].self, from: response.data!)
                    DataManager.modelService = ModelServiceInfo(listData: responseEx)
                    callback.apiDoneGetListData!()
                    //                        callBack.apiOnDidGetBankList!(data : responseEx)
                } catch let jsonErr {
                    print("Error: \(jsonErr)")
                    //                        callBack.apiOnDidFail(mess: jsonErr as! String)
                }
            case .failure:
                print("Fail to connect")
                //                    callBack.apiOnDidFail(mess: "Error: \(String(describing: response.response?.statusCode))")
            }
        }
    }
}
