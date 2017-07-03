//
//  Patient.swift
//  iGenFamilyTree
//
//  Created by ben on 03/07/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation
struct Patient {
    var id: ID?
    var row = 10
    var col = 10
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
