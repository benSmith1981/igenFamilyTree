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
    
    // get a familytree (a number of Human objects) by patientID
    public static func parseiGenData(jsonName: String){
        //        if let pathURL = Bundle.main.url(forResource: jsonName, withExtension: "json"){
        let pathURL = "\(Constants.herokuAPI)gettree?patientID=\(jsonName)"
        Alamofire.request(pathURL).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                print("Validation Successful")
                var humans: [ID : Human] = [:]
                if let jsonHumans = response.result.value as? NSArray {
                    for humanDict in jsonHumans {
                        let humanObject = Human.init(dictionary: humanDict as! NSDictionary)
                        humans[humanObject.id] = humanObject
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
    
    // get a Disease object by id
    // it is possible and acceptable that Disease data is not available for a Human.id
    public static func parseiGenDiseaseData(jsonName: String){
        //        if let pathURL = Bundle.main.url(forResource: jsonName, withExtension: "json"){
        let pathURL = "\(Constants.herokuAPI)getdiseases?id=\(jsonName)"
        Alamofire.request(pathURL).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                print("Validation Successful")
                if let jsonDict = response.result.value as? NSDictionary {
                    let key = jsonDict.allKeys[0]
                    let diseaseDict = jsonDict[key] as! NSDictionary
                    let diseaseObject = Disease.init(dictionary: diseaseDict)
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
    
    // post a familytree (a number of Human objects)
    public static func saveFamilyTree(_ familyTree: [ID: Human]) {
        //    if let itemsFromModel = self.familyTreeGenerator?.familyTree{
        var familyID = ""
        var allDictionaries: [String: Any] = [:]
        for (key, human) in familyTree{
            let dictionary = [
                "name" : human.name,
                "id" : human.id,
                "patientID" : human.patientID,
                "gender" : human.gender,
                "dob" : human.dob ?? "",
                "race" : human.race ?? "",
                "processed" : human.processed,
                "showDiseaseInfo" : human.showDiseaseInfo,
                "editInfoID" : human.editInfoID!,
                "editInfoTimestamp" : human.editInfoTimestamp!,
                "editInfoField" : human.editInfoField!,
                "spouses" : human.spouses,
                "parents" : human.parents,
                "children" : human.children,
                "siblings" : human.siblings
                ] as [String: Any]
            
            allDictionaries[key as ID] = dictionary as [String: Any]
            familyID = human.patientID
        }
        
        var familyDictionary: [String:Any] = [:]
        familyDictionary[familyID] = allDictionaries
        print("saveFamilyTree \(familyDictionary)")
        
        Alamofire.request("\(Constants.herokuAPI)savetree/",
            method: .post,
            parameters: familyDictionary,
            encoding: JSONEncoding.default) .responseJSON { (response) in
                switch response.result {
                case .success(let jsonData):
                    print("Success \(jsonData)")
                case .failure(let error):
                    print("error \(error)")
                }
        }
    }
    
    // put a Human object by id
    public static func saveHuman(_ human: Human) {
        human.logChangesBy(human.id, "name, dob, gender")
        let humanUpdate: Parameters = [
            "name": human.name,
            "dob": human.dob ?? "",
            "gender": human.gender,
            "editInfoID" : human.editInfoID!,
            "editInfoTimestamp" : human.editInfoTimestamp!,
            "editInfoField" : human.editInfoField!
        ]
        print("saveHuman \(human)")
        Alamofire.request("\(Constants.herokuAPI)edithuman?id=\(human.id)",
            method: .put,
            parameters: humanUpdate,
            encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result {
                case .success(let jsonData):
                    print("success \(jsonData)")
                    
                case .failure(let error):
                    print("error \(error)")
                }
        }
    }
    
    // put a Disease object by id
    public static func saveDisease(_ disease: Disease) {
        disease.logChangesBy(disease.id, "DiseaseList")
        let diseaseUpdate: Parameters = [
            "diseaseList": disease.diseaseList,
            "canEditList": disease.canEditList,
            "editInfoID" : disease.editInfoID!,
            "editInfoTimestamp" : disease.editInfoTimestamp!,
            "editInfoField" : disease.editInfoField!,
            "deleted": disease.deleted
        ]
        print("saveDisease \(disease)")
        Alamofire.request("\(Constants.herokuAPI)adddiseases?id=\(disease.id)",
            method: .put,
            parameters: diseaseUpdate,
            encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result {
                case .success(let jsonData):
                    print("success \(jsonData)")
                    
                case .failure(let error):
                    print("error \(error)")
                }
        }
    }

    // delete a familytree (a number of Human objects) by id
    public static func deleteFamilyTree(patientID: ID) {
        print("deleteFamilyTree \(patientID)")
        Alamofire.request("\(Constants.herokuAPI)deletetree?id=\(patientID)",
            method: .get,
//            parameters: diseaseUpdate,
            encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result {
                case .success(let jsonData):
                    print("success \(jsonData)")
                    
                case .failure(let error):
                    print("error \(error)")
                }
        }
    }

    // delete a Disease by id
    public static func deleteDisease(id: ID) {
        print("deleteDisease \(id)")
        Alamofire.request("\(Constants.herokuAPI)deletediseases?id=\(id)",
            method: .get,
            //            parameters: diseaseUpdate,
            encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result {
                case .success(let jsonData):
                    print("success \(jsonData)")
                    
                case .failure(let error):
                    print("error \(error)")
                }
        }
    }
}
