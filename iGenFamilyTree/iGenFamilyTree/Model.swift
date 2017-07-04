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

enum cellState {
    case son(id: String)
    case daughter(id: String)
    case malePatient(id: String)
    case femalePatient(id: String)
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
            
        case .son:
            return imageRotatedByDegrees(oldImage: #imageLiteral(resourceName: "paths-male-1-connector"), deg: 180)
        case .daughter:
            return #imageLiteral(resourceName: "paths-TEST-female-daughter")
        case .malePatient:
            return #imageLiteral(resourceName: "paths-male-corner-2-connectors")
        case .femalePatient:
            return #imageLiteral(resourceName: "paths-female-corner-2-connectors")
        case .maleSpouse:
            return imageRotatedByDegrees(oldImage: #imageLiteral(resourceName: "paths-male-corner-2-connectors"), deg: 90)
        case .femaleSpouse:
            return imageRotatedByDegrees(oldImage: #imageLiteral(resourceName: "paths-female-1-connector"), deg: -90)
        case .aunt:
            return imageRotatedByDegrees(oldImage: #imageLiteral(resourceName: "paths-female-1-connector"), deg: 180)
        case .uncle:
            return imageRotatedByDegrees(oldImage: #imageLiteral(resourceName: "paths-male-1-connector"), deg: 180)
        case .father:
            return imageRotatedByDegrees(oldImage: #imageLiteral(resourceName: "paths-male-1-connector"), deg: 90)
        case .mother:
            return imageRotatedByDegrees(oldImage: #imageLiteral(resourceName: "paths-female-1-connector"), deg: -90)
        case .spouseConnector:
            return #imageLiteral(resourceName: "paths-T-3-connectors")
        case .patientParentConnector:
            return imageRotatedByDegrees(oldImage: #imageLiteral(resourceName: "paths-T-3-connectors"), deg: -90)
        case .cornerLeftBottom:
            return imageRotatedByDegrees(oldImage: #imageLiteral(resourceName: "paths-corner"), deg: 90)
        case .cornerLeftTop:
            return imageRotatedByDegrees(oldImage: #imageLiteral(resourceName: "paths-corner"), deg: 180)
        case .cornerRightBottom:
            return #imageLiteral(resourceName: "paths-corner")
        case .cornerRightTop:
            return imageRotatedByDegrees(oldImage: #imageLiteral(resourceName: "paths-corner"), deg: -90)
        case .straightHorizontal:
            return #imageLiteral(resourceName: "paths-straight")
        case .straightVertical:
            return imageRotatedByDegrees(oldImage: #imageLiteral(resourceName: "paths-straight"), deg: 90)
        case .emptyCell:
            return UIImage()
        }
    }

    func imageRotatedByDegrees(oldImage: UIImage, deg degrees: CGFloat) -> UIImage {
        //Calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: oldImage.size.width, height: oldImage.size.height))
        let t: CGAffineTransform = CGAffineTransform(rotationAngle: degrees * CGFloat.pi / 180)
        rotatedViewBox.transform = t
        let rotatedSize: CGSize = rotatedViewBox.frame.size
        //Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap: CGContext = UIGraphicsGetCurrentContext()!
        //Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        //Rotate the image context
        bitmap.rotate(by: (degrees * CGFloat.pi / 180))
        //Now, draw the rotated/scaled image into the context
        bitmap.scaleBy(x: 1.0, y: -1.0)
        bitmap.draw(oldImage.cgImage!, in: CGRect(x: -oldImage.size.width / 2, y: -oldImage.size.height / 2, width: oldImage.size.width, height: oldImage.size.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    // Complete function for persons with id
    
    func getID() -> ID {
        switch self {
        
        case .son(let id):
            return id
        case .daughter(let id):
            return id
        case .malePatient(let id):
            return id
        case .femalePatient(let id):
            return id
        case .aunt(let id):
            return id
        case .uncle(let id):
            return id
        case .father(let id):
            return id
        case .mother(let id):
            return id
        default:
            return ""
        }
    }
    
}

struct Model {
    var minLevel = 1
    var maxLevel = 1
    var cell: [[cellState]]?
    
    init(){
        self.cell = Array(repeating: Array(repeating: cellState.emptyCell, count: gridSize), count: gridSize)
    }
}
