//
//  Model.swift
//  iGenFamilyTree
//
//  Created by ben on 03/07/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation
struct Model {
    var minLevel = 1
    var maxLevel = 1
    var cell: [[ID]]?
    
    init(){
       self.cell = Array(repeating: Array(repeating: "", count: 20), count: 20)
    }
}
