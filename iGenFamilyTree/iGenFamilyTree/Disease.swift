//
//  Disease.swift
//  iGenFamilyTree
//
//  Created by Ton on 2017-07-12.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation

//  Disease is an object linked to a Human (by the humanID) to be able to store information about the diseaseList seperately

class Disease {
    var humanID: ID
    var diseaseList: [Int] = []
    var canEditList: [ID] = []
    var editInfoID: ID?
    var editInfoTimestamp: TimeInterval?
    var editInfoField: String?
    var deleted: Bool = false
    
    init(humanID: ID, editInfoID: ID, editInfoTimestamp: TimeInterval, editInfoField: String) {
        self.humanID = humanID
        self.editInfoID = editInfoID
        self.editInfoTimestamp = editInfoTimestamp
        self.editInfoField = editInfoField
    }
    
    convenience init(dictionary: NSDictionary) {
        
        self.init(humanID: (dictionary[JsonKeys.humanID.rawValue] as? ID)!,
                  editInfoID: (dictionary[JsonKeys.editInfoID.rawValue] as? ID)!,
                  editInfoTimestamp: (dictionary[JsonKeys.editInfoTimestamp.rawValue] as? TimeInterval)!,
                    editInfoField: (dictionary[JsonKeys.editInfoField.rawValue] as? String)!)

        self.deleted = dictionary[JsonKeys.deleted.rawValue] as! Bool
        
        let diseaseListParsed = dictionary[JsonKeys.diseaseList.rawValue] as! NSArray
        for disease in diseaseListParsed {
            if let disease = disease as? NSDictionary,
                let number = disease[JsonKeys.id.rawValue] as? Int {
                diseaseList.append(number)
            }
        }
        
        let canEditListParsed = dictionary[JsonKeys.canEditList.rawValue] as! NSArray
        for canEdit in canEditListParsed {
            if let canEdit = canEdit as? NSDictionary,
                let id = canEdit[JsonKeys.id.rawValue] as? ID {
                canEditList.append(id)
            }
        }
        
    }
    
    func modelsFromDictionaryArray(array:NSArray) -> [Disease]
    {
        var models:[Disease] = []
        for item in array
        {
            models.append(Disease(dictionary: item as! NSDictionary))
        }
        return models
    }
    
}
