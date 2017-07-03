//
//  Model.swift
//  iGenFamilyTree
//
//  Created by ben on 03/07/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation

//  Model is a 2D matrix for building the family tree and connecting the nodes
//  we build this from the Patient structure

struct Model {
    static var minLevel = 1
    static var maxLevel = 1
    static var cell: [[String]] = Array(repeating: Array(repeating: "", count: 20), count: 20)
}
