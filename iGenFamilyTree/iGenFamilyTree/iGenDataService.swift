//
//  iGenDataService.swift
//  iGenFamilyTree
//
//  Created by Achid Farooq on 28-06-17.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation
import Alamofire

class iGenDataService {
    
    public static func parseiGenData(){
        if let pathURL = Bundle.main.url(forResource: "iGen", withExtension: "json"){
            Alamofire.request(pathURL).validate().responseJSON { (response) in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    var temp: [String : Humans] = [:]
                    if let jsonDict = response.result.value as? NSDictionary {
                        let topkey = jsonDict.allKeys
                        for (key, humanDict) in jsonDict[topkey[0]] as! NSDictionary {
                            print(humanDict0)
                            let humanobject = Humans.init(dictionary: humanDict as! NSDictionary)
                            print(humanobject)
                            temp[key as! String] = humanobject
                        }
                        print(temp)
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "iGenData"),
                                                        object: self,
                                                        userInfo: temp)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
