//
//  Enums.swift
//  iGenFamilyTree
//
//  Created by Achid Farooq on 05-07-17.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation

enum QuestionType: Int {
    case brother = 0
    case sister = 1
    case sons = 2
    case daughters = 3
    case brotherMother = 4
    case sisterMother = 5
    case brotherFather = 6
    case sisterFather = 7
    
    
    func selectQuestion() -> String {
        
        switch self {
        case .brother:
            return NSLocalizedString("numberBrothers", comment: "")
        case .sister:
            return NSLocalizedString("numberSisters", comment: "")
        case .sons:
            return NSLocalizedString("numberSons", comment: "")
        case .daughters:
            return NSLocalizedString("numberDaughters", comment: "")
        case .brotherMother:
            return NSLocalizedString("numberBrotherfromMother", comment: "")
        case .sisterMother:
            return NSLocalizedString("numberSistersfromMother", comment: "")
        case .brotherFather:
            return NSLocalizedString("numberBrothersfromFather", comment: "")
        case .sisterFather:
            return NSLocalizedString("numberSistersfromFather", comment: "")
        }
    }
}
