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
    static let squareCellSize = 50.0
    static let herokuAPI = "https://fierce-gorge-29081.herokuapp.com/api/"
}

struct DetailViewSections {
    static let numberOfSections = 2
    static let numberOfStaticRows = 3
    
    static let noSection = 0
    static let noDisease = 0
    
    static let staticSections = 0
    static let dynamicSection = 1
    
    static let firstDiseaseRow = 0
    static let secondDiseaseRow = 1
    static let thirdDiseaseRow = 2
    static let fourthDiseaseRow = 3
    static let fifthDiseaseRow = 4
    

    
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
    case infoVerified
    case spouses
    case parents
    case grandparents
    case children
    case siblings
    case diseaseList
    case canEditList
    case editInfoID
    case editInfoTimestamp
    case editInfoField
    case deleted
}

enum Segues: String {
    case familytreeSegue
    case createFamilytreeSegue
}

enum CustomCellIdentifiers: String {
    case CreatePatientTreeID
    case iGenCellID
    case GenerateCellID
    case CreatePatientGender
    case detailImageCellID
    case infoCellID
    case descriptionTableViewCellID

}

enum CustomCellNames: String {
    case CreatePatientTree
    case iGenCell
}

enum NotificationIDs: String {
    case iGenData
    case loginNotificationID
    case registerNotificationID
    case verifyNotificationID
    case iGenDiseaseData
}

