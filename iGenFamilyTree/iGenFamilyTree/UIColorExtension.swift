//
//  UIColorExtension.swift
//  iGenFamilyTree
//
//  Created by Ton on 2017-07-20.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    struct Colors {
        static let noDisease = UIColor.darkGray
    }
    
    class func diseaseColor(_ num: Int) -> UIColor {
        switch num {
        case 0:
            return UIColor(red:0.32, green:0.71, blue:0.62, alpha:1.0)
        case 1:
            return UIColor(red:1.00, green:0.87, blue:0.58, alpha:1.0)
        case 2:
            return UIColor(red:0.77, green:0.89, blue:0.89, alpha:1.0)
        default:
            return UIColor.black
        }
    }
}
