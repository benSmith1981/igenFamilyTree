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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return DetailViewSections.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == DetailViewSections.staticSections {
            return DetailViewSections.numberOfStaticSections
        } else if section == DetailViewSections.dynamicSection {
            return numberOfDiseasesToShow()
        } else {
            return DetailViewSections.noSection
        }
    }

    func numberOfDiseasesToShow() -> Int{
        if let showDisease = self.currentHuman?.showDiseaseInfo,
            let diseaseList = self.currentDiseases?.diseaseList{
            return diseaseList.count
        } else {
            return DetailViewSections.noDisease
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //enums for each case (e.g. 0, 1, 2, ...)
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
            imageCell.delegate = self
            imageCell.awakeFromNib()
            imageCell.separatorInset.left = view.frame.width
            imageCell.humanGender = self.currentHuman?.gender
            imageCell.cellType = .genderRow
            
            return imageCell
            
        case detailRows.nameRow.rawValue:
            let nameCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            nameCell.addRowBut.alpha = 0.0
            nameCell.removeRowBut.alpha = 0.0
            nameCell.addRowBut.isUserInteractionEnabled = false
            nameCell.removeRowBut.isUserInteractionEnabled = false
            
            nameCell.titleInfo.text = NSLocalizedString("name", comment: "")
            nameCell.textfieldValue.text = self.currentHuman?.name
            nameCell.cellType = .nameRow
            nameCell.delegate = self
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
            dateOfBirthCell.textfieldValue.text = self.currentHuman?.dob
            dateOfBirthCell.textfieldValue.placeholder = NSLocalizedString("placeholderDateOfBirth", comment: "")
                
            dateOfBirthCell.cellType = .dobRow
            dateOfBirthCell.delegate = self
            return dateOfBirthCell
            
        default:
            return UITableViewCell()
        }
    }
    
    func loadDynamicSection(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell{
        switch indexPath.row {
        case DetailViewSections.firstDiseaseRow:
            
            let firstDiseaseCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            firstDiseaseCell.indexPath = indexPath
            firstDiseaseCell.titleInfo.text = NSLocalizedString("diseases", comment: "")
            firstDiseaseCell.cellType = .disease1Row
            firstDiseaseCell.delegate = self
            if let diseaseOne = currentDiseases?.diseaseList[0] {
                firstDiseaseCell.textfieldValue.text = "\(String(describing: diseaseOne))"
            }
            
            return firstDiseaseCell
            
        case DetailViewSections.secondDiseaseRow:
            
            let secondDiseaseCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            secondDiseaseCell.indexPath = indexPath

            secondDiseaseCell.titleInfo.text = NSLocalizedString("diseases", comment: "")
            secondDiseaseCell.cellType = .disease2Row
            secondDiseaseCell.delegate = self
            if let secondDisease = currentDiseases?.diseaseList[1] {
                secondDiseaseCell.textfieldValue.text = String(describing: secondDisease)
            }
            
            return secondDiseaseCell
            
        case DetailViewSections.thirdDiseaseRow:
            
            let thirdDiseaseCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            thirdDiseaseCell.indexPath = indexPath

            thirdDiseaseCell.titleInfo.text = NSLocalizedString("diseases", comment: "")
            thirdDiseaseCell.cellType = .disease3Row
            thirdDiseaseCell.delegate = self
            if let thirdDisease = currentDiseases?.diseaseList[2] {
                thirdDiseaseCell.textfieldValue.text = String(describing: thirdDisease)
            }
            
            return thirdDiseaseCell
            
        case DetailViewSections.fourthDiseaseRow:
            
            let fourthDiseaseCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            fourthDiseaseCell.indexPath = indexPath

            fourthDiseaseCell.titleInfo.text = NSLocalizedString("diseases", comment: "")
            fourthDiseaseCell.cellType = .disease4Row
            fourthDiseaseCell.delegate = self
            if let fourthDisease = currentDiseases?.diseaseList[3] {
                fourthDiseaseCell.textfieldValue.text = String(describing: fourthDisease)
            }
            
            return fourthDiseaseCell
            
        case DetailViewSections.fifthDiseaseRow:
            
            let fifthDiseaseCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            fifthDiseaseCell.indexPath = indexPath

            fifthDiseaseCell.titleInfo.text = NSLocalizedString("diseases", comment: "")
            fifthDiseaseCell.cellType = .disease4Row
            fifthDiseaseCell.delegate = self
            if let fifthDisease = currentDiseases?.diseaseList[4] {
                fifthDiseaseCell.textfieldValue.text = String(describing: fifthDisease)
            }
            
            return fifthDiseaseCell
            
        default:
            
            return UITableViewCell()
            
        }
    }
    
        
}

