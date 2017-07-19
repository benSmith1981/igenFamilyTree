//
//  iGenCell.swift
//  iGenFamilyTree
//
//  Created by Paul Geurts on 03/07/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit
@IBDesignable

class iGenCell: UICollectionViewCell {
    
    @IBOutlet weak var bgImg: UIImageView!
    
    @IBOutlet weak var diseaseImg1Color: UIImageView!
    @IBOutlet weak var diseaseImg2ColorsTop: UIImageView!
    @IBOutlet weak var diseaseImg2ColorsBottom: UIImageView!
    @IBOutlet weak var diseaseImg3ColorsTop: UIImageView!
    @IBOutlet weak var diseaseImg3ColorsMiddle: UIImageView!
    @IBOutlet weak var diseaseImg3ColorsBottom: UIImageView!
    
    @IBOutlet weak var diseaseLabel1: UILabel!
    @IBOutlet weak var diseaseLabel2: UILabel!
    @IBOutlet weak var diseaseLabel3: UILabel!
    
    @IBOutlet weak var patientAge: UILabel!
    @IBOutlet weak var genderImg: UIImageView!
    @IBOutlet weak var patientName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
            func setup() {
                //self.layer.borderWidth = 0.5
                //self.layer.borderColor = UIColor.lightGray.cgColor
                //self.layer.cornerRadius = 0.0
            }
        setup()
        
    }
    
    
}
