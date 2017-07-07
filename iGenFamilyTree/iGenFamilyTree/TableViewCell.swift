//
//  TableViewCell.swift
//  iGenFamilyTree
//
//  Created by Achid Farooq on 05-07-17.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell, UITextFieldDelegate{
    
    var setNumberDelegate: SetNumberOfFamilyMembers!
    var cellType: QuestionType?
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var numberOfMembers: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        setNumberDelegate.sendNumber(number: Int(textField.text!)!)
        if (textField.text?.isEmpty)! == false{
            setNumberDelegate.sendNumber(number: Int(textField.text!)!,cellType: cellType!)
        }
        else {
            print("Error: Please fill in all questions!")
        }
//        setNumberDelegate.sendNumber(number: Int(textField.text!)!,
//                                     cellType: cellType!)

        
    }
}
