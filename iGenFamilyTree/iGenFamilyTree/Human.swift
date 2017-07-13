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

class Human {
    var name: String
    var id: ID
    var patientID: ID
    var gender: String
    var dob : String?
    var race : String?
    var processed: Bool = false
    var showDiseaseInfo: Bool = false
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
    
    convenience init(dictionary: NSDictionary) {
        
        self.init(name: (dictionary[JsonKeys.name.rawValue] as? String)!,
                  id: (dictionary[JsonKeys.id.rawValue] as? String)!,
                  patientID: (dictionary[JsonKeys.patientID.rawValue] as? String)!,
                  gender: (dictionary[JsonKeys.gender.rawValue] as? String)!)
        
        self.dob = dictionary[JsonKeys.dob.rawValue] as? String
        self.race = dictionary[JsonKeys.race.rawValue] as? String
        self.showDiseaseInfo = dictionary[JsonKeys.showDiseaseInfo.rawValue] as! Bool
        
        let parentsParsed = dictionary[JsonKeys.parents.rawValue] as! NSArray
        for parent in parentsParsed {
            if let parent = parent as? NSDictionary,
                let parentID = parent[JsonKeys.id.rawValue] as? ID {
                parents.append(parentID)
            }
        }
        
        let siblingsParsed = dictionary[JsonKeys.siblings.rawValue] as! NSArray
        for sibling in siblingsParsed {
            if let sibling = sibling as? NSDictionary,
                let siblingID = sibling[JsonKeys.id.rawValue] as? ID {
                siblings.append(siblingID)
            }
        }
        
        let childrenParsed = dictionary[JsonKeys.children.rawValue] as! NSArray
        for child in childrenParsed {
            if let child = child as? NSDictionary,
                let childID = child[JsonKeys.id.rawValue] as? ID {
                children.append(childID)
            }
        }
        
        let spousesParsed = dictionary[JsonKeys.spouses.rawValue] as! NSArray
        for spouse in spousesParsed {
            if let spouse = spouse as? NSDictionary,
                let spouseID = spouse[JsonKeys.id.rawValue] as? ID {
                spouses.append(spouseID)
            }
        }
        
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
    
}
