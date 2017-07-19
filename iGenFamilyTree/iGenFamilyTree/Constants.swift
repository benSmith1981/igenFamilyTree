//
//  Constants.swift
//  iGenFamilyTree
//
//  Created by Paul Geurts on 04/07/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let gridSize = 30
}

enum JsonKeys: String {
    case male
    case female
    case name
    case id
    case patientID
    case gender
    case dob
    case race
    case processed
    case showDiseaseInfo
    case spouses
    case parents
    case grandparents
    case children
    case siblings
    case humanID
    case diseaseList
    case canEditList
    case editInfoID
    case editInfoTimestamp
    case editInfoField
    case deleted
}

enum Segues: String {
    case familytreeSegue
    case createFamilyTreeSegue
}

enum CustomCellIdentifiers: String {
    case CreatePatientTreeID
    case iGenCellID
}

enum CustomCellNames: String {
    case CreatePatientTree
    case iGenCell
}

enum NotificationIDs: String {
    case iGenData
    case iGenDiseaseData
}

extension UIColor {
    class func diseaseColor(_ num: Int) -> UIColor {
        switch num {
        case 1:
            return UIColor(red:0.32, green:0.71, blue:0.62, alpha:1.0)
        case 2:
            return UIColor(red:1.00, green:0.87, blue:0.58, alpha:1.0)
        case 3:
            return UIColor(red:0.77, green:0.89, blue:0.89, alpha:1.0)
        default:
            return UIColor.black
        }
    }
}
