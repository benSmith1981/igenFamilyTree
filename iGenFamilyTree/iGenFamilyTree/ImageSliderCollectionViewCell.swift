//
//  ImageSliderCollectionViewCell.swift
//  FestivalParkApp
//
//  Created by Ivo  Nederlof on 27-02-17.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit

class ImageSliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageVIew: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        configureImages()
    }
    
    func configureImages() {
        // setup custom imageview
//        imageVIew.layer.masksToBounds = true
//        imageVIew.layer.cornerRadius = 2
//        contentView.layer.cornerRadius = 2
//        
//        
//        imageVIew.layer.shadowColor = UIColor.black.cgColor
//        //imageVIew.layer.shadowOffset = CGSize(width: 0, height: 0)
//        imageVIew.layer.shadowOpacity = 0.2
//        imageVIew.layer.shadowRadius = 2
        
    }
}
