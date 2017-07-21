//
//  InfoCell.swift
//  OMDB
//
//  Created by Ivo  Nederlof on 31-01-17.
//  Copyright © 2017 Dutch Melon. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {
    
    @IBOutlet var titleInfo: UILabel!
    @IBOutlet var titleValue: UILabel!
    @IBOutlet weak var textfieldValue: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
