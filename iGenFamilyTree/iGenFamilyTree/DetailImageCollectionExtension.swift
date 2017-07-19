
//
//  DetailImageCollectionExtension.swift
//  FestivalParkApp
//
//  Created by Ivo  Nederlof on 27-02-17.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher

extension  DetailmageSliderCell {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCellID",for: indexPath) as! ImageSliderCollectionViewCell
        
        enum cellState {
            case male
            case female
            
            func showGenderIcon() -> UIImage {
                switch self {
                case .male:
                    return #imageLiteral(resourceName: "slider-icons-male")
                case .female:
                    return #imageLiteral(resourceName: "slider-icons-female")
                default:
                    return UIImage()
                }
            }
        }
        
        //let media = [#imageLiteral(resourceName: "slider-icons-male"), #imageLiteral(resourceName: "slider-icons-female")]

        //let media = festival?.media?[indexPath.row]
        //let url = URL(string: (media?.url)!)
 
        //cell.imageVIew.kf.setImage(with: url)
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.15
        cell.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.layer.shadowRadius = 2
        cell.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
        cell.layer.shouldRasterize = true
        cell.layer.masksToBounds = false
        
        return cell
    }

}
