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
    var familyTree: [ID: Human]
    var username: String
    var userID: ID
    var patientID: ID
}

class iGenDataService {
    
    // get a Disease object by id
    // it is possible and acceptable that Disease data is not available for a Human.id
    public static func parseiGenDiseaseData(id: ID){
        //        if let pathURL = Bundle.main.url(forResource: jsonName, withExtension: "json"){
        let pathURL = "\(Constants.herokuAPI)getdiseases?id=\(id)"
        Alamofire.request(pathURL).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                if let jsonDict = response.result.value as? NSDictionary {
//                    let key = jsonDict.allKeys[0]
//                    let diseaseDict = jsonDict[key] as! NSDictionary
                    let diseaseObject = Disease.init(dictionary: jsonDict)
                    var diseases: [ID : Disease] = [:]
                    diseases[id] = diseaseObject
                    print("Get diseases", diseases)
                    NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationIDs.iGenDiseaseData.rawValue),
                                                    object: self,
                                                    userInfo: diseases)
                }
            case .failure(let error):
                print(error)
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
    public static func saveHuman(_ human: inout Human, userID: ID) {
        human.logChangesBy(userID, "name, dob, gender")
        let humanUpdate: Parameters = [
            "name": human.name,
            "dob": human.dob ?? "",
            "gender": human.gender,
            "showDiseaseInfo": human.showDiseaseInfo,
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
    public static func saveDisease(_ disease: inout Disease, userID: ID) {
        disease.logChangesBy(userID, "diseaseList")
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
    
    // post a verify request after invitation by a Patient
    public static func verifyMember(with details: VerifyMember) {
        let verifyDetails: Parameters = [
            "patientName" : details.patientName,
            "patientEmail" : details.patientEmail,
            "verifyName" : details.verifyName,
            "verifyEmail" : details.verifyEmail,
            "patientID" : details.patientID,
            "userID" : details.userID,
            "code" : details.code,
            "emailText" : details.emailText
        ]
        
        
        if details.verifyEmail.isValidEmail() && details.patientEmail.isValidEmail(){
            print("verifymember \(verifyDetails)")
            Alamofire.request("\(Constants.herokuAPI)verifymember/",
                method: .post,
                parameters: verifyDetails,
                encoding: JSONEncoding.default).responseJSON { (response) in
                    switch response.result {
                    case .success(let jsonData):
                        if let responseDict = jsonData as? NSDictionary{
                            NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationIDs.verifyNotificationID.rawValue),
                                                            object: self,
                                                            userInfo: responseDict as! [String : Any])
                            print("success \(responseDict)")
                        }
                    case .failure(let error):
                        print("error \(error)")
                    }
            }
        } else {
            let responseDict:[String : Any] = ["success": false, "message": "Enter a valid Email(s)" ]
            NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationIDs.verifyNotificationID.rawValue),
                                            object: self,
                                            userInfo: responseDict as! [String : Any])
            
        }
    }
    
    // update userID / patientID who just registered a new family tree
    public static func updateUserID(withLogin update: Login) {
        let updateDetails: Parameters = [
            "username": update.username,
            "patientID": update.PatientID
        ]
        print("updateUserIDDetails \(login)")
        guard update.username.isValidEmail() else {
            print("Need a valid EMAIL address")
            return
        }
        Alamofire.request("\(Constants.herokuAPI)addpatientsid/",
            method: .put,
            parameters: updateDetails,
            encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result {
                case .success(let jsonData):
                    print("success \(jsonData)")
                    
                case .failure(let error):
                    print("error \(error)")
                }
        }
    }
    
    // login - get a userID and familytree (a number of Human objects) by patientID
    public static func login(_ login: Login) {
        let loginDetailsParams: Parameters = [
            "username": login.username,
            "password": login.password
        ]
        print("loginDetails \(login)")
        guard login.username.isValidEmail() else {
            print("Need a valid EMAIL address")
            return
        }
        Alamofire.request("\(Constants.herokuAPI)login/",
            method: .post,
            parameters: loginDetailsParams,
            encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result {
                case .success(let jsonData):
                    if let jsonDict = response.result.value as? NSDictionary,
                        let success = jsonDict["success"] as? Bool,
                        let message = jsonDict["message"] as? String  {
                        if success {
                            if let familyTree = jsonDict["familyTree"] as? NSArray,
                                let userID = jsonDict["userID"] as? ID,
                                let patientID = jsonDict["patientID"] as? ID {
                                
                                // convert array into dictionary
                                var humans: [ID: Human] = [:]
                                for humanDict in familyTree {
                                    let humanObject = Human.init(dictionary: humanDict as! NSDictionary)
                                    humans[humanObject.id] = humanObject
                                }
                                print(humans)
                                
                                let res = ServerResponse.init(response: success,
                                                              message: message,
                                                              familyTree: humans,
                                                              username: login.username,
                                                              userID: userID,
                                                              patientID: patientID)
                                
                                let responseLogin = ["response": res]
                                NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationIDs.loginNotificationID.rawValue),
                                                                object: self,
                                                                userInfo: responseLogin)
                                print("success \(jsonDict)")
                            }
                            
                        } else {
                            let responseLogin = ["message": "\(message)"]
                            NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationIDs.loginNotificationID.rawValue),
                                                            object: self,
                                                            userInfo: responseLogin)
                            print("failure \(jsonDict)")
                        }
                    }
                    print("success \(jsonData)")
                    
                case .failure(let error):
                    print("error \(error)")
                }
        }
    }
    
    // register - post login details (username and password)
    public static func register(_ register: Login) {
        let registerDetails: Parameters = [
            "username": register.username,
            "password": register.password
        ]
        print("registerDetails \(register)")
        guard register.username.isValidEmail() else {
            print("Need a valid EMAIL address")
            return
        }
        Alamofire.request("\(Constants.herokuAPI)register/",
            method: .post,
            parameters: registerDetails,
            encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result {
                case .success(let jsonData):
                    if let jsonDict = response.result.value as? NSDictionary,
                        let success = jsonDict["success"] as? Bool,
                        let message = jsonDict["message"] as? String  {
                        if success {
                            let res = ServerResponse.init(response: success,
                                                          message: message,
                                                          familyTree: [:],
                                                          username: register.username,
                                                          userID: "",
                                                          patientID: "")
                            
                            let responseRegister = ["response": res]
                            NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationIDs.registerNotificationID.rawValue),
                                                            object: self,
                                                            userInfo: responseRegister)
                            print("success \(jsonDict)")
                            
                        } else {
                            let responseRegister = ["message": "\(message)"]
                            NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationIDs.registerNotificationID.rawValue),
                                                            object: self,
                                                            userInfo: responseRegister)
                            print("failure \(jsonDict)")
                        }
                    }
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
    
    // delete a familytree (a number of Human objects) by id
    public static func getFamilyTree(patientID: ID) {
        print("gettree \(patientID)")
        Alamofire.request("\(Constants.herokuAPI)gettree?patientID=\(patientID)",
            method: .get,
            //            parameters: diseaseUpdate,
            encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result {
                case .success(let jsonData):
                    if let jsonDict = response.result.value as? NSDictionary,
                        let success = jsonDict["success"] as? Bool,
                        let message = jsonDict["message"] as? String  {
                        if success {
                            if let familyTree = jsonDict["familyTree"] as? NSArray {
                                
                                // convert array into dictionary
                                var humans: [ID: Human] = [:]
                                for humanDict in familyTree {
                                    let humanObject = Human.init(dictionary: humanDict as! NSDictionary)
                                    humans[humanObject.id] = humanObject
                                }
                                print(humans)
                                
                                let responseLogin = ["response": humans]
                                NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationIDs.getTreeID.rawValue),
                                                                object: self,
                                                                userInfo: responseLogin)
                                print("success \(jsonDict)")
                            }
                            
                        } else {
                            let responseLogin = ["message": "\(message)"]
                            NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationIDs.getTreeID.rawValue),
                                                            object: self,
                                                            userInfo: responseLogin)
                            print("failure \(jsonDict)")
                        }
                    }
                    print("success \(jsonData)")
                    
                case .failure(let error):
                    print("error \(error)")
                }
        }
    }
    
}
