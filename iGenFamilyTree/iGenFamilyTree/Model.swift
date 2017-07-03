//
//  Model.swift
//  iGenFamilyTree
//
//  Created by ben on 03/07/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation
struct Model {
    static var minLevel = 1
    static var maxLevel = 1
    static var cell: [[ID]] = Array(repeating: Array(repeating: "", count: 20), count: 20)
}
