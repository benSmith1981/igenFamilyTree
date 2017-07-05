//
//  Patient.swift
//  iGenFamilyTree
//
//  Created by ben on 03/07/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation

//  Patient for whom we have to maintain a family tree
//  row and col are starting points for the modelling of the family tree
//  we build this structure from the humans array, which contains all humans in this family

struct Patient {
    var id: ID?
    var row = 5
    var col = 5
    var mySpousesIDs: [ID] = []
    var myParentsIDs: [ID] = []
    var myChildrenIDs: [ID] = []
    var mySiblingsIDs: [ID] = []
    var fatherSiblingsIDs: [ID] = []
    var motherSiblingsIDs: [ID] = []
    
    init(id: ID) {
        self.id = id
    }
}
