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
    var row: Int = Constants.gridSize / 2
    var col: Int = Constants.gridSize / 2
    var mySpousesIDs: [ID] = []
    var myParentsIDs: [ID] = []
    var myChildrenIDs: [ID] = []
    var mySiblingsIDs: [ID] = []
    var fatherSiblingsIDs: [ID] = []
    var motherSiblingsIDs: [ID] = []
    var fatherParentsIDs: [ID] = []
    var motherParentsIDs: [ID] = []
    
    init(id: ID) {
        self.id = id
    }
}
