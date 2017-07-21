//
//  InviteCell.swift
//  iGenFamilyTree
//
//  Created by Paul Geurts on 18/07/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit

class FooterCell: UITableViewCell {
    
    
    @IBOutlet weak var inviteButtonBg: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        inviteButtonBg.layer.cornerRadius = 10
        inviteButtonBg.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
