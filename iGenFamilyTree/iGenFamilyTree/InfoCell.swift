//
//  InfoCell.swift
//  OMDB
//
//  Created by Ivo  Nederlof on 31-01-17.
//  Copyright © 2017 Dutch Melon. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    weak var delegate: updateParametersDelegate?
    var editingHuman: Human?
    var cellType: detailRows?
    var indexPath: IndexPath?
    var pickerView = UIPickerView()
    var diseaseArray = ["", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
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
        textfieldValue.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        pickerView.backgroundColor = UIColor.white

    }

    func textFieldDidChange(_ textField: UITextField) {
        if let indexPath = indexPath , let cellType = cellType{
            delegate?.getHumanUpdates(value: textField.text ?? "" , cellType: cellType, indexPath: indexPath)
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if let indexPath = indexPath , let cellType = cellType{
            delegate?.getHumanUpdates(value: textField.text ?? "" , cellType: cellType, indexPath: indexPath)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return diseaseArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let str = diseaseArray[row]
        return str
    }

    //***** TO DO: WHEN CANCEL, DONT PICKUP VALUE
//    func getFieldValue () {
//        textfieldValue.text = String(diseaseArray[row])
//    }
//    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        textfieldValue.text = String(diseaseArray[row])
    
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
