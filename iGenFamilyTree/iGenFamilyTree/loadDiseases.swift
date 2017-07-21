//
//  loadDiseases.swift
//  iGenFamilyTree
//
//  Created by Ton on 2017-07-13.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation

extension FamilyTreeGenerator {
    
    func loadDiseases() {
        for human in familyTree.values {
            if human.showDiseaseInfo {
                iGenDataService.parseiGenDiseaseData(jsonName: "disease_\(human.id)")
//                iGenDataService.parseiGenDiseaseData(jsonName: human.id) // need also family id???
           }
        }
    }
}
