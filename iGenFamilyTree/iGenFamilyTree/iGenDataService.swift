//
//  iGenDataService.swift
//  iGenFamilyTree
//
//  Created by Achid Farooq on 28-06-17.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation
import Alamofire

struct ServerResponse {
    var response: Bool
    var message: String
    var familyTree: NSArray
    var loginDetails: NSDictionary
    var userID: String
    var patientID: String

}
class iGenDataService {
    
    // login - get a loginID and familytree (a number of Human objects) by patientID
    public static func login(username: String, password: String) {
        let login: Parameters = [
            "username": username,
            "password": password
        ]
        print("login \(username)")
        Alamofire.request("\(Constants.herokuAPI)login",
            method: .post,
            parameters: login,
            encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result {
                case .success:
                    print("login successful")
                    var humans: [ID : Human] = [:]
                    if let jsonResponse = response.result.value as? NSDictionary {
                        let loginID = jsonResponse["userid"] as! String
                        let defaults = UserDefaults.standard
                        defaults.set(loginID, forKey: "loginID")
                        let jsonHumans = jsonResponse["familyTree"] as! NSArray
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
//    public static func register(username: String, password: String) {
//        let register: Parameters = [
//            "username": username,
//            "password": password
//        ]
//        print("register \(username)")
//        Alamofire.request("\(Constants.herokuAPI)register",
//            method: .post,
//            parameters: register,
//            encoding: JSONEncoding.default).responseJSON { (response) in
//                switch response.result {
//                case .success(let jsonData):
//                    print("success \(jsonData)")
//                    
//                case .failure(let error):
//                    print("error \(error)")
//                }
//        }
//    }
    
    // get a familytree (a number of Human objects) by patientID
    public static func parseiGenData(jsonName: String){
        //let pathURL = Bundle.main.url(forResource: jsonName, withExtension: "json")
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
    public static func saveHuman(_ human: Human, loginID: ID) {
        human.logChangesBy(loginID, "name, dob, gender")
        let humanUpdate: Parameters = [
            "name": human.name,
            "dob": human.dob ?? "",
            "gender": human.gender,
            "editInfoID" : human.editInfoID!,
            "editInfoTimestamp" : human.editInfoTimestamp!,
            "editInfoField" : human.editInfoField!
        ]
        print("saveHuman \(humanUpdate)")
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
    public static func saveDisease(_ disease: Disease, loginID: ID) {
        disease.logChangesBy(loginID, "diseaseList")
        let diseaseUpdate: Parameters = [
            "id":disease.id,
            "diseaseList": disease.diseaseList,
            "canEditList": disease.canEditList,
            "editInfoID" : disease.editInfoID!,
            "editInfoTimestamp" : disease.editInfoTimestamp!,
            "editInfoField" : disease.editInfoField!,
            "deleted": disease.deleted
        ]
        print("saveDisease \(diseaseUpdate)")
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
    
    //Only to update the patient who just registered a new tree so their ID equals the Patiend ID (or the family tree id)
    public static func verifyMember(with details: VerifyMember) {
        let verifyDetails: Parameters = [
            "email" : details.email,
            "patientID" : details.patientID,
            "userID" : details.userID,
            "patientName" : details.patientName,
            "name" : details.name,
            "sendersEmail" : details.sendersEmail
        ]
        if details.email.isValidEmail() && details.sendersEmail.isValidEmail(){
            print("verifymember \(verifyDetails)")
            Alamofire.request("\(Constants.herokuAPI)verifymember/",
                method: .post,
                parameters: verifyDetails,
                encoding: JSONEncoding.default).responseJSON { (response) in
                    switch response.result {
                    case .success(let jsonData):
                        print("success \(jsonData)")
                        
                    case .failure(let error):
                        print("error \(error)")
                    }
            }
        } else {
            print("Need a valid EMAILs")
            
        }
    }
    
    //Only to update the patient who just registered a new tree so their ID equals the Patiend ID (or the family tree id)
    public static func updateThePatientID(withLogin login: Login) {
        let loginDetails: Parameters = [
            "username":login.username,
            "patientID": login.familyTreeID
        ]
        if login.username.isValidEmail(){
            print("loginDetails \(login)")
            Alamofire.request("\(Constants.herokuAPI)addpatientsid/",
                method: .put,
                parameters: loginDetails,
                encoding: JSONEncoding.default).responseJSON { (response) in
                    switch response.result {
                    case .success(let jsonData):
                        print("success \(jsonData)")
                        
                    case .failure(let error):
                        print("error \(error)")
                    }
            }
        } else {
            print("Need a valid EMAIL")
            
        }
    }
    
    public static func login(_ login: Login) {
        let loginDetailsParams: Parameters = [
            "username":login.username,
            "password": login.password
        ]
        if login.username.isValidEmail(){
        print("loginDetails \(login)")
            Alamofire.request("\(Constants.herokuAPI)login/",
                method: .post,
                parameters: loginDetailsParams,
                encoding: JSONEncoding.default).responseJSON { (response) in
                    switch response.result {
                    case .success(let jsonData):
                        if let jsonDict = response.result.value as? NSDictionary,
                            let success = jsonDict["success"] as? Bool,
                            let message = jsonDict["message"] as? String,
                            let familyTree = jsonDict["familyTree"] as? NSArray,
                            let userID = jsonDict["userID"] as? String,
                            let patientID = jsonDict["patientID"] as? String{
                            
                                let res = ServerResponse.init(response: success,
                                                              message: message,
                                                              familyTree: familyTree,
                                                              loginDetails: [:],
                                                              userID: userID,
                                                              patientID: patientID)
                                let responseLogin = ["response": res]
                                NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationIDs.loginNotificationID.rawValue),
                                                                object: self,
                                                                userInfo: responseLogin)
                                print("success \(jsonDict)")
                        }
                        
                        print("success \(jsonData)")
                        
                    case .failure(let error):
                        if let jsonDict = response.result.value as? NSDictionary {
                            let message = jsonDict["message"]
                            let responseLogin = ["message": "\(error) \(message)"]
                            NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationIDs.loginNotificationID.rawValue),
                                                            object: self,
                                                            userInfo: responseLogin)
                            print("success \(jsonDict)")
                        }
                        
                        print("error \(error)")
                    }
            }
        } else {
            print("Need a valid EMAIL")
        
        }
    }

    public static func register(_ login: Login) {
        let loginDetails: Parameters = [
            "username":login.username,
            "password": login.password
        ]
        if login.username.isValidEmail(){
            print("loginDetails \(login)")
            Alamofire.request("\(Constants.herokuAPI)login/",
                method: .post,
                parameters: loginDetails,
                encoding: JSONEncoding.default).responseJSON { (response) in
                    switch response.result {
                    case .success(let jsonData):
                        if let jsonDict = response.result.value as? NSDictionary,
                            let success = jsonDict["success"] as? Bool,
                            let message = jsonDict["message"] as? String,
                            let loginDetails = jsonDict["details"] as? NSDictionary{
                            
                            
                                var res = ServerResponse.init(response: success,
                                                              message: message,
                                                              familyTree: [],
                                                              loginDetails: loginDetails,
                                                              userID: "",
                                                              patientID: "")
                                var responseLogin = ["response": res]
                                NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationIDs.registerNotificationID.rawValue),
                                                                object: self,
                                                                userInfo: responseLogin)
//                            print("success \(jsonData)")
                        }
                        
                    case .failure(let error):
                        if let jsonDict = response.result.value as? NSDictionary,
                            let success = jsonDict["success"] as? Bool,
                            let message = jsonDict["message"] as? String{
                            var res = ServerResponse.init(response: success,
                                                          message: "\(error) \(message)",
                                                        familyTree: [],
                                                        loginDetails: [:],
                                                        userID: "",
                                                        patientID: "")
                                var responseLogin = ["response": res]

                                NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationIDs.registerNotificationID.rawValue),
                                                                object: self,
                                                                userInfo: responseLogin)
//                            print("success \(jsonData)")
                        }
                    }
            }
        } else {
            print("Need an EMAIL")

        }

    }
}
