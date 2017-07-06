//
//  CellStates.swift
//  iGenFamilyTree
//
//  Created by Paul Geurts on 05/07/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation
import UIKit

enum cellState {
    case brother(id: String)
    case sister(id: String)
    case malePatient(id: String)
    case femalePatient(id: String)
    case motherWithSiblings(id: String)
    case maleSpouse(id: String)
    case femaleSpouse(id: String)
    case aunt(id: String)
    case uncle(id: String)
    case father(id: String)
    case mother(id: String)
    case spouseConnector
    case patientParentConnector
    case cornerLeftBottom
    case cornerLeftTop
    case cornerRightBottom
    case cornerRightTop
    case straightHorizontal
    case straightVertical
    case emptyCell
    
    
    
    func switchBG() -> UIImage {
        
        switch self {
            
        case .brother:
            return #imageLiteral(resourceName: "paths-son-1-connector")
        case .uncle:
            return #imageLiteral(resourceName: "paths-son-1-connector")
        case .sister:
            return #imageLiteral(resourceName: "paths-TEST-female-daughter")
        case .aunt:
            return #imageLiteral(resourceName: "paths-TEST-female-daughter")
        
        case .malePatient:
            return #imageLiteral(resourceName: "paths-male-corner-2-connectors")
        case .femalePatient:
            return #imageLiteral(resourceName: "paths-female-corner-2-connectors").imageRotatedByDegrees(deg: -90)
        case .motherWithSiblings:
            return #imageLiteral(resourceName: "paths-female-corner-2-connectors")
        case .maleSpouse:
            return #imageLiteral(resourceName: "paths-male-1-connector").imageRotatedByDegrees(deg: -90)
        case .femaleSpouse:
            return #imageLiteral(resourceName: "paths-female-1-connector").imageRotatedByDegrees(deg: -90)
        case .father:
            return #imageLiteral(resourceName: "paths-male-1-connector").imageRotatedByDegrees(deg: 90)
        case .mother:
            return #imageLiteral(resourceName: "paths-female-1-connector").imageRotatedByDegrees(deg: -90)
            
        case .spouseConnector:
            return #imageLiteral(resourceName: "paths-T-3-connectors")
        case .patientParentConnector:
            return #imageLiteral(resourceName: "paths-T-3-connectors").imageRotatedByDegrees(deg: -90)
        
        case .cornerLeftBottom:
            return #imageLiteral(resourceName: "paths-corner").imageRotatedByDegrees(deg: 90)
        case .cornerLeftTop:
            return #imageLiteral(resourceName: "paths-corner").imageRotatedByDegrees(deg: 180)
        case .cornerRightBottom:
            return #imageLiteral(resourceName: "paths-corner")
        case .cornerRightTop:
            return #imageLiteral(resourceName: "paths-corner").imageRotatedByDegrees(deg: -90)
        case .straightHorizontal:
            return #imageLiteral(resourceName: "paths-straight")
        case .straightVertical:
            return #imageLiteral(resourceName: "paths-straight").imageRotatedByDegrees(deg: 90)
        case .emptyCell:
            return UIImage()
        }
    }
    
    
    // Complete function for persons with id
    
    func getID() -> ID {
        switch self {
            
        case .brother(let id):
            return id
        case .sister(let id):
            return id
        case .malePatient(let id):
            return id
        case .femalePatient(let id):
            return id
        case .motherWithSiblings(let id):
            return id
        case .aunt(let id):
            return id
        case .uncle(let id):
            return id
        case .father(let id):
            return id
        case .mother(let id):
            return id
        case .femaleSpouse(let id):
            return id
        case .maleSpouse(let id):
            return id
        default:
            return ""
        }
    }
    
}
