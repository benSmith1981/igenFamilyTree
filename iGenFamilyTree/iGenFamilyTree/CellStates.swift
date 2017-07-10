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
    case fatherWithSiblings(id: String)
    case motherWithSiblings(id: String)
    case maleSpouse(id: String)
    case femaleSpouse(id: String)
    case aunt(id: String)
    case uncle(id: String)
    case father(id: String)
    case mother(id: String)
    case spouseConnector
    case patientParentConnector
    case twoChilderenConnector
    case threeChilderenConnector
    case cornerLeftBottom
    case cornerLeftTop
    case cornerRightBottom
    case cornerRightTop
    case straightHorizontal
    case straightVertical
    case emptyCell
    
    func showGender() -> UIImage {
        switch self {
        case .brother, .uncle, .malePatient, .maleSpouse, .fatherWithSiblings, .father:
            return #imageLiteral(resourceName: "male")
        case .sister, .femaleSpouse, .femalePatient, .aunt, .motherWithSiblings, .mother:
            return #imageLiteral(resourceName: "female")
        default:
            return UIImage()
        }
    }
    
    func switchBG() -> UIImage {
        
        switch self {
            
        case .brother, .uncle, .sister, .aunt:
            return #imageLiteral(resourceName: "paths-1-connect-up")
        
        case .malePatient, .femalePatient:
            return #imageLiteral(resourceName: "paths-2-connect")
            
        case .motherWithSiblings:
            return #imageLiteral(resourceName: "paths-2-connect").imageRotatedByDegrees(deg: 90)
        case .fatherWithSiblings:
            return #imageLiteral(resourceName: "paths-2-connect")
        
        
        case .maleSpouse, .femaleSpouse, .mother:
            return #imageLiteral(resourceName: "paths-1-connect-down").imageRotatedByDegrees(deg: -90)
        case .father:
            return #imageLiteral(resourceName: "paths-1-connect-down").imageRotatedByDegrees(deg: 90)

        case .spouseConnector:
            return #imageLiteral(resourceName: "paths-T-3-connectors")
        case .patientParentConnector:
            return #imageLiteral(resourceName: "paths-T-right")
        case .twoChilderenConnector:
            return #imageLiteral(resourceName: "paths-T-up")
        case .threeChilderenConnector:
            return #imageLiteral(resourceName: "paths-cross-4-connectors")
            
            //corner cells
        case .cornerLeftBottom:
            return #imageLiteral(resourceName: "paths-corner-leftdown")
        case .cornerLeftTop:
            return #imageLiteral(resourceName: "paths-corner-leftup")
        case .cornerRightBottom:
            return #imageLiteral(resourceName: "paths-corner-rightdown")
        case .cornerRightTop:
            return #imageLiteral(resourceName: "paths-corner-rightup")
            
            //straight cells
        case .straightHorizontal:
            return #imageLiteral(resourceName: "paths-straight")
        case .straightVertical:
            return #imageLiteral(resourceName: "paths-straight-ver")
        
            //empty cell
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
        case .fatherWithSiblings(let id):
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
