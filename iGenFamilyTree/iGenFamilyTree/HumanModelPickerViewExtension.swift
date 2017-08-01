//
//  HumanModelPickerViewExtension.swift
//  iGenFamilyTree
//
//  Created by Paul Geurts on 31/07/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation
import UIKit
extension HumanModalViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.diseaseArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //do soiething
        
    }
    
}
