//
//  iGenself.swift
//  iGenFamilyTree
//
//  Created by Paul Geurts on 03/07/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit
@IBDesignable

class iGenCell: UICollectionViewCell {
    
    @IBOutlet weak var bgImg: UIImageView!
    
    @IBOutlet weak var ring: UIView!
    @IBOutlet weak var infoVerified: UIImageView!
    @IBOutlet weak var diseaseImg1Color: UIImageView!
    @IBOutlet var diseaseImg2Colors: [UIImageView]!
    @IBOutlet var diseaseImg3Colors: [UIImageView]!
    @IBOutlet var diseaseLabel: [UILabel]!
    @IBOutlet weak var patientAge: UILabel!
    @IBOutlet weak var genderImg: UIImageView!
    @IBOutlet weak var patientName: UILabel!
    
    let diseasesColorArray: [UIColor] = [UIColor(red:0.32, green:0.71, blue:0.62, alpha:1.0),/*1*/
        UIColor(red:1.00, green:0.87, blue:0.58, alpha:1.0),/*2*/
        UIColor(red:0.77, green:0.89, blue:0.89, alpha:1.0),/*3*/
        UIColor(red:0.94, green:0.61, blue:0.02, alpha:1.0),/*4*/
        UIColor(red:0.60, green:0.52, blue:0.74, alpha:1.0),/*5*/
        UIColor(red:0.76, green:0.63, blue:0.51, alpha:1.0),/*6*/
        UIColor(red:0.89, green:0.54, blue:0.58, alpha:1.0),/*7*/
        UIColor(red:0.96, green:0.76, blue:0.79, alpha:1.0),/*8*/
        UIColor(red:0.49, green:0.89, blue:0.89, alpha:1.0),/*9*/
        UIColor(red:1.00, green:0.95, blue:0.48, alpha:1.0),/*10*/
    ]
    
    override func prepareForReuse() {
        // initialize the cell
        self.bgImg.image = UIImage()
        self.bgImg.layer.removeAllAnimations()
        self.bgImg.layer.borderColor = UIColor.clear.cgColor
        self.genderImg.image = UIImage()
        self.ring.layer.removeAllAnimations()
        self.ring.layer.borderWidth = 0
        self.infoVerified.image = UIImage()
        //self.ring.layer.borderColor = UIColor.clear.cgColor
        self.diseaseImg1Color.backgroundColor = UIColor.clear
        self.diseaseImg2Colors[0].backgroundColor = UIColor.clear
        self.diseaseImg2Colors[1].backgroundColor = UIColor.clear
        for i in 0 ... 2 {
            self.diseaseLabel[i].backgroundColor = UIColor.clear
            self.diseaseLabel[i].text = ""
            self.diseaseImg3Colors[i].backgroundColor = UIColor.clear
        }
        self.infoVerified.backgroundColor = UIColor.clear
        //self.infoVerified.text = ""
        self.patientName.text = ""
        self.patientAge.text = ""
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //process a cell for a Human
    func processHumanCellFor(_ currentHuman: Human, userID: ID) {
        print("currentHuman:", currentHuman.name)
        self.patientName.text = currentHuman.name
        self.patientAge.text = currentHuman.dob
        self.diseaseImg1Color.backgroundColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
        // pulsating animation for loginHumanID
        if currentHuman.id == userID {
            self.ring.layer.cornerRadius = 25
            self.ring.layer.borderColor = UIColor(red:0.17, green:0.60, blue:0.75, alpha:1.0).cgColor
            self.ring.layer.borderWidth = 1
            
            let pulseAnimation = CABasicAnimation(keyPath: "opacity")
            pulseAnimation.duration = 1.5
            pulseAnimation.fromValue = 0
            pulseAnimation.toValue = 0.5
            pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            pulseAnimation.autoreverses = true
            pulseAnimation.repeatCount = .greatestFiniteMagnitude
            self.ring.layer.add(pulseAnimation, forKey: nil)
            
            if currentHuman.id == currentHuman.editInfoID {
                
                //self.infoVerified.isHidden = false
                self.infoVerified.alpha = 1.0
            } else {
                //self.infoVerified.isHidden = true
                self.infoVerified.alpha = 0.0
            }
        }
    }
    
    // process a Human with Diseases
    // we can only show the first 3 diseases and we show them in different colors
    func processDiseaseCellFor(_ currentDisease: Disease) {
        
        // CODE TO PROCESS DISEASES BY COUNT
        print("currentDisease:", currentDisease.diseaseList)
        let diseaseCount = min(currentDisease.diseaseList.count, 3)
        if diseaseCount > 0 {
            for diseaseIndex in 0 ... diseaseCount - 1 {
                print("diseaseindex", diseaseIndex, currentDisease.diseaseList[diseaseIndex])
                
                if Int(currentDisease.diseaseList[diseaseIndex]) != nil {
                    let diseaseNumber = Int(currentDisease.diseaseList[diseaseIndex])! - 1
                    self.diseaseLabel[diseaseIndex].backgroundColor = diseasesColorArray[diseaseNumber]
                    self.diseaseLabel[diseaseIndex].text = String(currentDisease.diseaseList[diseaseIndex])
                    switch diseaseCount {
                    case 1:
                        self.diseaseImg1Color.backgroundColor = diseasesColorArray[diseaseNumber]
                    case 2:
                        self.diseaseImg2Colors[diseaseIndex].backgroundColor = diseasesColorArray[diseaseNumber]
                    case 3:
                        self.diseaseImg3Colors[diseaseIndex].backgroundColor = diseasesColorArray[diseaseNumber]
                    default:
                        break
                    }
                }
            }
        }
    }
    
}
