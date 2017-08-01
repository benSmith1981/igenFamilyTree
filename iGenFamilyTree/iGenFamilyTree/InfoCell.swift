//
//  InfoCell.swift
//  OMDB
//
//  Created by Ivo  Nederlof on 31-01-17.
//  Copyright © 2017 Dutch Melon. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell, UITextFieldDelegate {
    
    
    weak var delegate: updateParametersDelegate?
    var editingHuman: Human?
    var cellType: detailRows?
    var indexPath: IndexPath?

    
    @IBOutlet var titleInfo: UILabel!
    @IBOutlet weak var textfieldValue: UITextField!
    
    @IBOutlet weak var removeRowBut: UIButton!
    @IBOutlet weak var addRowBut: UIButton!
    
    @IBAction func removeRowButton(_ sender: Any) {
        if let indexPath = indexPath {
            delegate?.removeDisease(indexPath: indexPath)
        }
    }
   
    @IBAction func addRowButton(_ sender: Any) {
        delegate?.addDisease()
    }
    
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
        if let indexPath = indexPath , let cellType = cellType{
            delegate?.getHumanUpdates(value: textField.text ?? "" , cellType: cellType, indexPath: indexPath)
//            delegate?.hidePicker()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //        delegate?.getHumanUpdates(value: textField.text ?? "" , cellType: cellType!)
        
            delegate?.showPicker()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
