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
    
    @IBOutlet weak var headerBg: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
        self.layer.cornerRadius = 10
        
        
        headerBg.layer.cornerRadius = 10
       headerBg.layer.masksToBounds = true
 
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
