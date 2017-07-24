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
    @IBOutlet weak var textfieldValue: UITextField!
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textfieldValue.layer.borderWidth = 0
        textfieldValue.layer.cornerRadius = 8
        textfieldValue.borderStyle = .none
        textfieldValue.layer.borderColor = UIColor.red.cgColor
        textfieldValue.setLeftPaddingPoints(10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
}

/*
class TextField: UITextField {
    
    let padding = UIEdgeInsets(top: 5, left: 25, bottom: 5, right: 5);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}
 */
