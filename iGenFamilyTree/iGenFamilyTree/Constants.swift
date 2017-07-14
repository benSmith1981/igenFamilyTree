//
//  Constants.swift
//  iGenFamilyTree
//
//  Created by Paul Geurts on 04/07/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation

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
