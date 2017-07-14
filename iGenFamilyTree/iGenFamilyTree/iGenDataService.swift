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
    
    public static func parseiGenData(jsonName: String){
        //if let pathURL = Bundle.main.url(forResource: "iGen", withExtension: "json"){
        //if let pathURL = Bundle.main.url(forResource: "smith", withExtension: "json"){
        if let pathURL = Bundle.main.url(forResource: jsonName, withExtension: "json"){
            Alamofire.request(pathURL).validate().responseJSON { (response) in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    var humans: [ID : Human] = [:]
                    if let jsonDict = response.result.value as? NSDictionary {
                        let topkey = jsonDict.allKeys
                        for (key, humanDict) in jsonDict[topkey[0]] as! NSDictionary {
                            let humanObject = Human.init(dictionary: humanDict as! NSDictionary)
                            print(humanObject)
                            humans[key as! ID] = humanObject
                        }
                        print(humans)
                        NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationIDs.iGenData.rawValue),
                                                        object: self,
                                                        userInfo: humans)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    
    // it is possible and acceptable that Disease data is not available for a Human.id
    public static func parseiGenDiseaseData(jsonName: String){
        if let pathURL = Bundle.main.url(forResource: jsonName, withExtension: "json"){
            Alamofire.request(pathURL).validate().responseJSON { (response) in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    if let jsonDict = response.result.value as? NSDictionary {
                        let key = jsonDict.allKeys[0]
                        let diseaseDict = jsonDict[key] as! NSDictionary
                        let diseaseObject = Disease.init(dictionary: diseaseDict)
                        print(diseaseObject)
                        var diseases: [ID : Disease] = [:]
                        diseases[key as! ID] = diseaseObject
                        print(diseases)
                        NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationIDs.iGenDiseaseData.rawValue),
                                                        object: self,
                                                        userInfo: diseases)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
}
