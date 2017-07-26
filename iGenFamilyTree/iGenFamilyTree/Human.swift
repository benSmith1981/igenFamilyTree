//
//  Human.swift
//  iGenFamilyTree
//
//  Created by ben on 03/07/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation
typealias ID = String

//  Human is a very generic structure of all relationships a human can have in this family
//  the processed boolean variable is used in function traverseTreeFor to prevent endless looping

struct Human {
    var name: String
    var id: ID
    var patientID: ID
    var gender: String
    var dob : String?
    var race : String?
    var processed: Bool = false
    var showDiseaseInfo: Bool = false
    var editInfoID: ID?
    var editInfoTimestamp: String?
    var editInfoField: String?
    var spouses: [ID] = []
    var parents: [ID] = []
    var children: [ID] = []
    var siblings: [ID] = []
    
    init(name: String, id: ID, patientID: ID, gender: String) {
        self.name = name
        self.id = id
        self.patientID = patientID
        self.gender = gender
    }
    
    init(dictionary: NSDictionary) {
        
        self.init(name: (dictionary[JsonKeys.name.rawValue] as? String)!,
                  id: (dictionary[JsonKeys.id.rawValue] as? String)!,
                  patientID: (dictionary[JsonKeys.patientID.rawValue] as? String)!,
                  gender: (dictionary[JsonKeys.gender.rawValue] as? String)!)
        
        self.dob = dictionary[JsonKeys.dob.rawValue] as? String
        self.race = dictionary[JsonKeys.race.rawValue] as? String
        self.processed = false
        self.showDiseaseInfo = dictionary[JsonKeys.showDiseaseInfo.rawValue] as! Bool
        self.editInfoID = dictionary[JsonKeys.editInfoID.rawValue] as? ID
        self.editInfoTimestamp = dictionary[JsonKeys.editInfoTimestamp.rawValue] as? String
        self.editInfoField = dictionary[JsonKeys.editInfoField.rawValue] as? String
        
        let parentsParsed = dictionary[JsonKeys.parents.rawValue] as! NSArray
        parents = parentsParsed as! [ID]
        
        let siblingsParsed = dictionary[JsonKeys.siblings.rawValue] as! NSArray
        siblings = siblingsParsed as! [ID]
        
        let childrenParsed = dictionary[JsonKeys.children.rawValue] as! NSArray
        children = childrenParsed as! [ID]
        
        let spousesParsed = dictionary[JsonKeys.spouses.rawValue] as! NSArray
        spouses = spousesParsed as! [ID]
    }
    
    
    func modelsFromDictionaryArray(array:NSArray) -> [Human]
    {
        var models:[Human] = []
        for item in array
        {
            models.append(Human(dictionary: item as! NSDictionary))
        }
        return models
    }
    
    func logChangesForFields(_ fields: String) {
        self.editInfoID = self.patientID   // this should be the ID of human that is logged in!
        self.editInfoTimestamp = String(describing: Date())
        self.editInfoField = fields
    }
    
}
