
//
//  DetailImageCollectionExtension.swift
//  FestivalParkApp
//
//  Created by Ivo  Nederlof on 27-02-17.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit
import Foundation

extension  DetailmageSliderCell {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        var visibleIndexPath: IndexPath = collectionView.indexPathForItem(at: visiblePoint)!
        if visibleIndexPath.row == 0 {
            print("man")
            delegate?.getHumanUpdates(value: JsonKeys.male.rawValue, cellType: .genderRow, indexPath: indexPath)
            //delegate?.getHumanUpdates(value: JsonKeys.male.rawValue, cellType: .nameRow)
        } else {
            print("woman")
            delegate?.getHumanUpdates(value: JsonKeys.female.rawValue, cellType: .genderRow, indexPath: indexPath)
            //delegate?.getHumanUpdates(value: JsonKeys.female.rawValue, cellType: .nameRow)
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCellID",for: indexPath) as! ImageSliderCollectionViewCell
        
        if humanGender == JsonKeys.female.rawValue {
            
            self.collectionView.scrollToItem(at:IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: false)
        }   
        
        
        
        cell.imageVIew.image = imageArray[indexPath.row]
    

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
