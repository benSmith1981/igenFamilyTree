//
//  NavBarExtension.swift
//  
//
//  Created by Paul Geurts on 03/08/2017.
//
//

import UIKit

extension UINavigationBar {
    
    func setGradientBackground(colors: [UIColor]) {
        
        var updatedFrame = bounds
        updatedFrame.size.height += 20
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
        
        setBackgroundImage(gradientLayer.creatGradientImage(), for: UIBarMetrics.default)
    }

}
