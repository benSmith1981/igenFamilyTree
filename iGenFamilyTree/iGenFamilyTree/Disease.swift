//
//  Disease.swift
//  iGenFamilyTree
//
//  Created by Ton on 2017-07-12.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation

//  Disease is an object linked to a Human (by the id) to be able to store information about the diseaseList seperately

struct Disease {
    var id: ID
    var diseaseList: [String] = []
    var canEditList: [ID] = []
    var editInfoID: ID?
    var editInfoTimestamp: String?
    var editInfoField: String?
    var deleted: Bool = false
    
    init(id: ID, editInfoID: ID, editInfoTimestamp: String, editInfoField: String) {
        self.id = id
        self.editInfoID = editInfoID
        self.editInfoTimestamp = editInfoTimestamp
        self.editInfoField = editInfoField
    }
    
    init(dictionary: NSDictionary) {
        
        self.init(id: (dictionary[JsonKeys.id.rawValue] as? ID)!,
                  editInfoID: (dictionary[JsonKeys.editInfoID.rawValue] as? ID)!,
                  editInfoTimestamp: (dictionary[JsonKeys.editInfoTimestamp.rawValue] as? String)!,
                    editInfoField: (dictionary[JsonKeys.editInfoField.rawValue] as? String)!)

        self.deleted = dictionary[JsonKeys.deleted.rawValue] as! Bool
    
        let diseaseListParsed = dictionary[JsonKeys.diseaseList.rawValue] as! NSArray
        diseaseList = diseaseListParsed as! [String]
        
        let canEditListParsed = dictionary[JsonKeys.canEditList.rawValue] as! NSArray
        canEditList = canEditListParsed as! [ID]
        
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
    
    mutating func logChangesBy(_ human: ID, _ fields: String) {
        editInfoID = human
        editInfoTimestamp = String(describing: Date())
        editInfoField = fields
    }

}
