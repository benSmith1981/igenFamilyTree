//
//  HumanModalExtension.swift
//  iGenFamilyTree
//
//  Created by Paul Geurts on 17/07/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation
import UIKit

extension HumanModalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return DetailViewSections.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == DetailViewSections.staticSections {
            return DetailViewSections.numberOfStaticRows
        } else if section == DetailViewSections.dynamicSection {
            return numberOfDiseasesToShow()
        } else {
            return DetailViewSections.noSection
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        guard indexPath.section != 0 || indexPath.row !=  detailRows.diseaseSwitch.rawValue else {
//            return UITableViewAutomaticDimension
//        }
//        
//        if let loggedInID = UserDefaults.standard.value(forKey:"userid") as? String,
//            let currentViewedHumanID = currentHuman?.id {
//            if currentViewedHumanID == loggedInID {
//                return UITableViewAutomaticDimension
//            } else {
//                return 0
//            }
//        }
//        return UITableViewAutomaticDimension
//    }

    func numberOfDiseasesToShow() -> Int{
        if let showDisease = self.editingHuman?.showDiseaseInfo,
            let diseaseList = self.editingDiseases?.diseaseList{
            return diseaseList.count
        } else {
            return DetailViewSections.noDisease
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        
        case DetailViewSections.staticSections:
            return loadStaticSection(indexPath: indexPath, tableView: tableView)
        case DetailViewSections.dynamicSection:
            return loadDynamicSection(indexPath: indexPath, tableView: tableView)
        default :
            return UITableViewCell()
        }
    }

    func loadStaticSection(indexPath: IndexPath, tableView: UITableView)  -> UITableViewCell{
        switch indexPath.row {
            
        case detailRows.genderRow.rawValue:
            
            let imageCell = tableView.dequeueReusableCell(withIdentifier: "detailImageCellID", for: indexPath) as! DetailmageSliderCell
            imageCell.isUserInteractionEnabled = false
            imageCell.delegate = self
            imageCell.indexPath = indexPath
            imageCell.awakeFromNib()
            imageCell.separatorInset.left = view.frame.width
            imageCell.humanGender = self.editingHuman?.gender
            imageCell.cellType = .genderRow
            
            return imageCell
            
        case detailRows.nameRow.rawValue:
            let nameCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            nameCell.addRowBut.alpha = 0.0
            nameCell.removeRowBut.alpha = 0.0
            nameCell.addRowBut.isUserInteractionEnabled = false
            nameCell.removeRowBut.isUserInteractionEnabled = false
            
            nameCell.titleInfo.text = NSLocalizedString("name", comment: "")
            nameCell.textfieldValue.text = self.editingHuman?.name
            nameCell.cellType = .nameRow
            nameCell.delegate = self
            nameCell.indexPath = indexPath
            nameCell.textfieldValue.textAlignment = .center
            nameCell.textfieldValue.keyboardType = .alphabet
            
            if self.editingHuman?.gender == JsonKeys.male.rawValue {
                nameCell.textfieldValue.placeholder = NSLocalizedString("placeholderNameMale", comment: "")
                
            } else {
                nameCell.textfieldValue.placeholder = NSLocalizedString("placeholderNameFemale", comment: "")
            }
            
            return nameCell
            
        case detailRows.dobRow.rawValue:
            let dateOfBirthCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            dateOfBirthCell.addRowBut.alpha = 0.0
            dateOfBirthCell.removeRowBut.alpha = 0.0
            dateOfBirthCell.addRowBut.isUserInteractionEnabled = false
            dateOfBirthCell.removeRowBut.isUserInteractionEnabled = false
            
            dateOfBirthCell.titleInfo.text = NSLocalizedString("dateOfBirth", comment: "")
            dateOfBirthCell.textfieldValue.text = self.editingHuman?.dob
            dateOfBirthCell.textfieldValue.placeholder = NSLocalizedString("placeholderDateOfBirth", comment: "")
            dateOfBirthCell.textfieldValue.textAlignment = .center
            dateOfBirthCell.textfieldValue.keyboardType = .numberPad
            dateOfBirthCell.indexPath = indexPath
            dateOfBirthCell.cellType = .dobRow
            dateOfBirthCell.delegate = self
            return dateOfBirthCell
        case detailRows.diseaseSwitch.rawValue:
            var diseaseSwitchCell = tableView.dequeueReusableCell(withIdentifier: CustomCellIdentifiers.CanViewDiseasesCellID.rawValue, for: indexPath) as! CanViewDiseasesCell
            if let showDiseases = self.editingHuman?.showDiseaseInfo {
                diseaseSwitchCell.showDiseaseSwitch.setOn(showDiseases, animated: true)
            }
            
            let height = getDiseaseSwitchCellHeight()
            var frame = diseaseSwitchCell.frame
            frame.size.height = height
            diseaseSwitchCell.frame = frame

            if height == 0{
                diseaseSwitchCell.alpha = 0
                diseaseSwitchCell.diseaseLabel.isHidden = true
                diseaseSwitchCell.showDiseaseSwitch.isHidden = true
            } else{
                diseaseSwitchCell.alpha = 1
                diseaseSwitchCell.diseaseLabel.isHidden = false
                diseaseSwitchCell.showDiseaseSwitch.isHidden = false
            }
            print("disease swithc cell height \(height)")
            diseaseSwitchCell.indexPath = indexPath
            diseaseSwitchCell.cellType = .diseaseSwitch
            diseaseSwitchCell.delegate = self
            return diseaseSwitchCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == detailRows.diseaseSwitch.rawValue{
            return getDiseaseSwitchCellHeight()
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    func getDiseaseSwitchCellHeight() -> CGFloat{
        if let loggedInID = UserDefaults.standard.value(forKey:"userid") as? String,
            let currentViewedHumanID = currentHuman?.id{
            if loggedInID != currentViewedHumanID{
                return 0
            } else {
                return UITableViewAutomaticDimension
            }
            
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    //***** TO DO: FIX THAT YOU CAN ADD ANY DISEASE, NOT ONLY BOTTOM ONE
    func loadDynamicSection(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell{
        switch indexPath.row {
        case DetailViewSections.firstDiseaseRow:
            
            let firstDiseaseCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            firstDiseaseCell.addRowBut.alpha = 1.0
            firstDiseaseCell.removeRowBut.alpha = 1.0
            firstDiseaseCell.indexPath = indexPath
            firstDiseaseCell.titleInfo.text = NSLocalizedString("diseases", comment: "")
            firstDiseaseCell.textfieldValue.placeholder = NSLocalizedString("placeholderDisease", comment: "")
            firstDiseaseCell.textfieldValue.textAlignment = .center
            firstDiseaseCell.cellType = .disease1Row
            firstDiseaseCell.delegate = self
            if let diseaseOne = editingDiseases?.diseaseList[0] {
                firstDiseaseCell.textfieldValue.text = "\(String(describing: diseaseOne))"
            }
            
            pickerView[0].delegate = firstDiseaseCell.self
            pickerView[0].backgroundColor = UIColor.white
            firstDiseaseCell.textfieldValue.inputView = pickerView[0]
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            firstDiseaseCell.textfieldValue.inputAccessoryView = toolBar
            

            return firstDiseaseCell
            
        case DetailViewSections.secondDiseaseRow:
            
            let secondDiseaseCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            secondDiseaseCell.addRowBut.alpha = 1.0
            secondDiseaseCell.removeRowBut.alpha = 1.0
            secondDiseaseCell.indexPath = indexPath

            secondDiseaseCell.titleInfo.text = NSLocalizedString("diseases", comment: "")
            secondDiseaseCell.textfieldValue.placeholder = NSLocalizedString("placeholderDisease", comment: "")
            secondDiseaseCell.textfieldValue.textAlignment = .center
            secondDiseaseCell.cellType = .disease2Row
            secondDiseaseCell.delegate = self
            if let secondDisease = editingDiseases?.diseaseList[1] {
                secondDiseaseCell.textfieldValue.text = String(describing: secondDisease)
            }
            
            pickerView[1].delegate = secondDiseaseCell.self
            pickerView[1].backgroundColor = UIColor.white
            secondDiseaseCell.textfieldValue.inputView = pickerView[1]
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            secondDiseaseCell.textfieldValue.inputAccessoryView = toolBar
            //pickerDim.alpha = 1.0
            
            return secondDiseaseCell
            
        case DetailViewSections.thirdDiseaseRow:
            
            let thirdDiseaseCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            thirdDiseaseCell.addRowBut.alpha = 1.0
            thirdDiseaseCell.removeRowBut.alpha = 1.0
            thirdDiseaseCell.indexPath = indexPath

            thirdDiseaseCell.titleInfo.text = NSLocalizedString("diseases", comment: "")
            thirdDiseaseCell.textfieldValue.placeholder = NSLocalizedString("placeholderDisease", comment: "")
            thirdDiseaseCell.textfieldValue.textAlignment = .center
            thirdDiseaseCell.cellType = .disease3Row
            thirdDiseaseCell.delegate = self
            if let thirdDisease = editingDiseases?.diseaseList[2] {
                thirdDiseaseCell.textfieldValue.text = String(describing: thirdDisease)
            }
            
            pickerView[2].delegate = thirdDiseaseCell.self
            pickerView[2].backgroundColor = UIColor.white
            thirdDiseaseCell.textfieldValue.inputView = pickerView[2]
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            thirdDiseaseCell.textfieldValue.inputAccessoryView = toolBar
            
            return thirdDiseaseCell
            
        case DetailViewSections.fourthDiseaseRow:
            
            let fourthDiseaseCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            fourthDiseaseCell.addRowBut.alpha = 1.0
            fourthDiseaseCell.removeRowBut.alpha = 1.0
            fourthDiseaseCell.indexPath = indexPath

            fourthDiseaseCell.titleInfo.text = NSLocalizedString("diseases", comment: "")
            fourthDiseaseCell.textfieldValue.placeholder = NSLocalizedString("placeholderDisease", comment: "")
            fourthDiseaseCell.textfieldValue.textAlignment = .center
            fourthDiseaseCell.cellType = .disease4Row
            fourthDiseaseCell.delegate = self
            if let fourthDisease = editingDiseases?.diseaseList[3] {
                fourthDiseaseCell.textfieldValue.text = String(describing: fourthDisease)
            }
            
            pickerView[3].delegate = fourthDiseaseCell.self
            pickerView[3].backgroundColor = UIColor.white
            fourthDiseaseCell.textfieldValue.inputView = pickerView[3]
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            fourthDiseaseCell.textfieldValue.inputAccessoryView = toolBar
            
            return fourthDiseaseCell
            
        case DetailViewSections.fifthDiseaseRow:
            
            let fifthDiseaseCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            fifthDiseaseCell.addRowBut.alpha = 1.0
            fifthDiseaseCell.removeRowBut.alpha = 1.0
            fifthDiseaseCell.indexPath = indexPath

            fifthDiseaseCell.titleInfo.text = NSLocalizedString("diseases", comment: "")
            fifthDiseaseCell.textfieldValue.placeholder = NSLocalizedString("placeholderDisease", comment: "")
            fifthDiseaseCell.textfieldValue.textAlignment = .center
            fifthDiseaseCell.cellType = .disease4Row
            fifthDiseaseCell.delegate = self
            if let fifthDisease = editingDiseases?.diseaseList[4] {
                fifthDiseaseCell.textfieldValue.text = String(describing: fifthDisease)
            }
            
            pickerView[4].delegate = fifthDiseaseCell.self
            pickerView[4].backgroundColor = UIColor.white
            fifthDiseaseCell.textfieldValue.inputView = pickerView[4]
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            fifthDiseaseCell.textfieldValue.inputAccessoryView = toolBar
            
            
            return fifthDiseaseCell
            
        default:
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
        
}

