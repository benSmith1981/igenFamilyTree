//
//  TableViewCell.swift
//  iGenFamilyTree
//
//  Created by Achid Farooq on 05-07-17.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit

class CreatePatientTree: UITableViewCell, UITextFieldDelegate{
    
    var setNumberDelegate: SetNumberOfFamilyMembers!
    var cellType: QuestionType?
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var numberOfMembers: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
        
        // Initialization code
    }
    
    override func layoutSubviews() {
        configureCell()
    }
    
    func configureCell(){
        if let text = numberOfMembers.text, let textNumber = Int(text),  let cellType = cellType {
            setNumberDelegate.sendNumber(number: textNumber, cellType: cellType)
        }
        else {
            print("Error: Please fill in all questions!")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("text changed \(textField.text ?? "")")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        numberOfMembers.text = ""
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = numberOfMembers.text, let textNumber = Int(text),  let cellType = cellType {
            setNumberDelegate.sendNumber(number: textNumber,cellType: cellType)
        }
        else {
            print("Error: Please fill in all questions!")
        }
    }
}
