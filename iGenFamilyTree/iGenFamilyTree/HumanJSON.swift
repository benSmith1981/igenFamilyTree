//
//  HumanJSON.swift
//  iGenFamilyTree
//
//  Created by Achid Farooq on 04-07-17.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation

struct Parent: JSONSerializable {
    var id: String
}
struct Child: JSONSerializable {
    var id: String
}
struct Sibling: JSONSerializable {
    var id: String
}
struct Spouse: JSONSerializable {
    var id: String
}
struct Twin: JSONSerializable {
    var id: String
}

struct HumanJSON: JSONSerializable {
    var name: String
    var UUID: ID
    var gender: String
    var dob: String
    var race: String
    var processed: Bool = false
    var modificationdate = String()
    var adopted = String()
    var height = String()
    var weight = String()
    var ethnicity = String()
    var smoker = String()
    var workout = String()
    var disease = String()
    
    var parents:[JSONSerializable]
    var children:[JSONSerializable]
    var siblings:[JSONSerializable]
    var spouse:[JSONSerializable]
    var twin:[JSONSerializable]
}
