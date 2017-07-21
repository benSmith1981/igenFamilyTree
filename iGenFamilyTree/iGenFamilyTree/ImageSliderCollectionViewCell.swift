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
        
    }
}
