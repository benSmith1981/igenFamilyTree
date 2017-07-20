//
//  InviteCell.swift
//  iGenFamilyTree
//
//  Created by Paul Geurts on 18/07/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit

class InviteCell: UITableViewCell {
    
    
    @IBOutlet weak var inviteButtonBg: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        inviteButtonBg.layer.masksToBounds = true
        inviteButtonBg.layer.cornerRadius = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
