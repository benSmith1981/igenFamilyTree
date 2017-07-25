//
//  InfoCell.swift
//  OMDB
//
//  Created by Ivo  Nederlof on 31-01-17.
//  Copyright © 2017 Dutch Melon. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell, UITextFieldDelegate {
    

    @IBOutlet var titleInfo: UILabel!
    @IBOutlet weak var textfieldValue: UITextField!
    
    weak var delegate: updateParametersDelegate?
    
    
    var editingHuman: Human?
    var cellType: detailRows?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textfieldValue.layer.borderWidth = 0
        textfieldValue.layer.cornerRadius = 8
        textfieldValue.borderStyle = .none
        textfieldValue.layer.borderColor = UIColor.red.cgColor
        textfieldValue.setLeftPaddingPoints(10)
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        delegate?.getHumanUpdates(value: textField.text ?? "" , cellType: cellType!)

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        delegate?.getHumanUpdates(value: textField.text ?? "" , cellType: cellType!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
}
