//
//  PickerTableCellTableViewCell.swift
//  iGenFamilyTree
//
//  Created by Paul Geurts on 31/07/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit

class PickerTableCellTableViewCell: UIView,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBAction func dismissPicker(_ sender: Any) {
            
    }
    
    @IBOutlet weak var pickerView: UIPickerView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //do soiething
    }
    
}
