//
//  GenerateFamilyCellTableViewCell.swift
//  iGenFamilyTree
//
//  Created by Achid Farooq on 26-07-17.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit

class GenerateFamilyCellTableViewCell: UITableViewCell {
    var delegate: SetNumberOfFamilyMembers?
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.contentView.autoresizingMask = UIViewAutoresizing.flexibleWidth

        //UIViewAutoresizing.flexibleHeight
        let rectShapeBottom = CAShapeLayer()
        //        rectShapeBottom.bounds = self.OutletGenerateTree.frame
        rectShapeBottom.bounds = self.frame.insetBy(dx: 10.0, dy: 10.0)
        rectShapeBottom.position = self.center
        rectShapeBottom.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.allCorners ], cornerRadii: CGSize(width: 10, height: 10)).cgPath
//        self.layoutMargins = UIEdgeInsetsMake(0, 10, 0, 10)
        self.layer.mask = rectShapeBottom
        self.layoutSubviews()

        // Initialization code
    }

    @IBAction func generateTree(_ sender: Any) {
        delegate?.generateTree()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.autoresizingMask = UIViewAutoresizing.flexibleWidth

    }
    
}
