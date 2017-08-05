//
//  Model.swift
//  iGenFamilyTree
//
//  Created by ben on 03/07/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation
import UIKit
//  Model is a 2D matrix for building the family tree and connecting the nodes
//  we build this from the Patient structure



struct Model {
    var minLevel = 1
    var maxLevel = 1
    var cell: [[cellState]]?
    
    init(){
        self.cell = Array(repeating: Array(repeating: cellState.emptyCell, count: Constants.gridSize), count: Constants.gridSize)
    }
}
