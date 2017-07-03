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
    var id: ID?
    var gender: String
    var dob : String?
    var race : String?
    var processed: Bool = false
    var spouses: [ID] = []
    var parents: [ID] = []
    var children: [ID] = []
    var siblings: [ID] = []
    
    init(name: String, gender: String) {
        self.name = name
        self.gender = gender
    }
    
    convenience init(id: ID, dictionary: NSDictionary) {
        
        self.init(name: (dictionary["name"] as? String)!,
                  gender: (dictionary["gender"] as? String)!)
        self.id = id
        self.dob = dictionary["dob"] as? String
        self.race = dictionary["race"] as? String
        let parentsParsed = dictionary["parents"] as! NSArray
        
        for parent in parentsParsed {
            if let parent = parent as? NSDictionary, let parentID = parent["id"] as? ID {
                self.parents.append(parentID)
            }
        }
        
        let siblingsParsed = dictionary["siblings"] as! NSArray
        for sibling in siblingsParsed {
            if let sibling = sibling as? NSDictionary, let siblingID = sibling["id"] as? ID {
                siblings.append(siblingID)
            }
        }
        
        let childrenParsed = dictionary["children"] as! NSArray
        for child in childrenParsed {
            if let child = child as? NSDictionary, let childID = child["id"] as? ID {
                children.append(childID)
            }
        }
        
        let partnersParsed = dictionary["partners"] as! NSArray
        for partner in partnersParsed {
            if let partner = partner as? NSDictionary, let partnerID = partner["id"] as? ID {
                spouses.append(partnerID)
            }
        }
        
    }
    
    func modelsFromDictionaryArray(array:NSArray) -> [Human]
    {
        var models:[Human] = []
        for item in array
        {
            models.append(Human(id: "", dictionary: item as! NSDictionary))
        }
        return models
    }
}
