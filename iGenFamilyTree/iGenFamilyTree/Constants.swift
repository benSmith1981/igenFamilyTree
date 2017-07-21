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
    static let squareCellSize = 50.0
}

struct DetailViewSections {
    static let numberOfSections = 3
    static let numberOfStaticSections = 4
    static let numberOfVerifyFamilySections = 1
    
    static let noSection = 0
    static let noDisease = 0
    
    static let staticSections = 0
    static let dynamicSection = 1
    static let firstDiseaseRow = 0
    static let secondDiseaseRow = 1
    static let thirdDiseaseRow = 2
    
    static let verifyWithFamilySection = 2
    
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
