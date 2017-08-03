//
//  TableViewCell.swift
//  iGenFamilyTree
//
//  Created by Achid Farooq on 05-07-17.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit

class CreatePatientTree: UITableViewCell, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var setNumberDelegate: SetNumberOfFamilyMembers!
    var cellType: QuestionType?

    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var numberOfMembers: UITextField!
    
    var pickOption = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

    let pickerView = UIPickerView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
        numberOfMembers.delegate = self
        numberOfMembers.tag = 0
        numberOfMembers.returnKeyType = UIReturnKeyType.next
        pickerView.delegate = self
        numberOfMembers.inputView = pickerView
        pickerView.backgroundColor = UIColor.white
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let str = pickOption[row]
        return str
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberOfMembers.text = String(pickOption[row])
    }
    
    func pickerViewEndEditing() {
        numberOfMembers.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if let nextField = numberOfMembers.superview?.viewWithTag(numberOfMembers.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            numberOfMembers.resignFirstResponder()
            return true;
        }
        return false
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
//        numberOfMembers.text = ""
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


