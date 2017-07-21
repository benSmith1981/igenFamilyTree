//
//  HeaderCell.swift
//  iGenFamilyTree
//
//  Created by Paul Geurts on 18/07/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell, UITableViewDelegate {

    var delegate: closeDetails?
    
    @IBAction func dismissPopover(_ sender: Any) {
        delegate?.closeView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
        //HeaderCell.layer.cornerRadius = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
