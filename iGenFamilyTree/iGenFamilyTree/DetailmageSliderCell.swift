//
//  DetailmageSliderCell.swift
//  FestivalParkApp
//
//  Created by Ivo  Nederlof on 27-02-17.
//  Copyright © 2017 Ben Smith. All rights reserved.


import UIKit

class DetailmageSliderCell: UITableViewCell,
                            UICollectionViewDataSource,
                            UICollectionViewDelegate,
                            UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView!
    weak var delegate: updateParametersDelegate?
    var humanGender: String?
    var cellType: detailRows?
    var indexPath: IndexPath = IndexPath.init()

    var imageArray = [UIImage(named: "slider-icons-male"),UIImage(named: "slider-icons-female")]
    
    let itemsPerRow: CGFloat = 1
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 20.0, right: 10.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()
    }
    
    override func layoutSubviews() {
//        configureCollectionView()

    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scroll")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func configureCollectionView() {
        //register
        let featuredCell = UINib(nibName: "ImageSliderCollectionViewCell", bundle: nil)
        collectionView.register(featuredCell, forCellWithReuseIdentifier: "imageCellID")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
//        var visibleRect = CGRect()
//        
//        visibleRect.origin = collectionView.contentOffset
//        visibleRect.size = collectionView.bounds.size
//        
//        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
//        
//        var visibleIndexPath: IndexPath = collectionView.indexPathForItem(at: visiblePoint)!
//        if visibleIndexPath.row == 0 {
//            print("man")
//            delegate?.getHumanUpdates(value: JsonKeys.male.rawValue, cellType: .genderRow, indexPath: indexPath)
//            //delegate?.getHumanUpdates(value: JsonKeys.male.rawValue, cellType: .nameRow)
//        } else {
//            print("woman")
//            delegate?.getHumanUpdates(value: JsonKeys.female.rawValue, cellType: .genderRow, indexPath: indexPath)
//            //delegate?.getHumanUpdates(value: JsonKeys.female.rawValue, cellType: .nameRow)
//        }
    }

}
