//
//  GenerateFamilyCellTableViewCell.swift
//  iGenFamilyTree
//
//  Created by Achid Farooq on 26-07-17.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit

class GenerateFamilyCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var buttonOutlet: UIView!
    
    
    var delegate: SetNumberOfFamilyMembers?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layoutSubviews()
    }

    @IBAction func generateTree(_ sender: Any) {
        delegate?.generateTree()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
}
