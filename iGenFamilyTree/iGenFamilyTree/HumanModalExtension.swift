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
        } else if section == DetailViewSections.verifyWithFamilySection{
            return DetailViewSections.numberOfVerifyFamilySections
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
        case DetailViewSections.verifyWithFamilySection:
            let inviteCell = tableView.dequeueReusableCell(withIdentifier: "inviteCellID", for: indexPath) as! InviteCell
            return inviteCell
        default :
            return UITableViewCell()
        }
        
    }
    func loadDynamicSection(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell{
        switch indexPath.row {
        case DetailViewSections.firstDiseaseRow:
            
            let firstDiseaseCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            firstDiseaseCell.titleInfo.text = "Disease(s):"
            if let diseaseOne = currentDiseases?.diseaseList[0] {
                firstDiseaseCell.titleValue.text = "\(String(describing: diseaseOne))"
            }
            
            return firstDiseaseCell
            
        case DetailViewSections.secondDiseaseRow:
            
            let secondDiseaseCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            secondDiseaseCell.titleInfo.text = ""
            if let secondDisease = currentDiseases?.diseaseList[1] {
                secondDiseaseCell.titleValue.text = String(describing: secondDisease)
            }
            
            return secondDiseaseCell
            
        case DetailViewSections.thirdDiseaseRow:
            
            let thirdDiseaseCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            thirdDiseaseCell.titleInfo.text = ""
            if let thirdDisease = currentDiseases?.diseaseList[2] {
                thirdDiseaseCell.titleValue.text = String(describing: thirdDisease)
            }
            
            return thirdDiseaseCell
            
        default:
            
            let inviteCell = tableView.dequeueReusableCell(withIdentifier: "inviteCellID", for: indexPath) as! InviteCell
            
            return inviteCell
            
        }
    }

    func loadStaticSection(indexPath: IndexPath, tableView: UITableView)  -> UITableViewCell{
        switch indexPath.row {
        case detailRows.headerRow.rawValue:
            
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "headerCellID", for: indexPath) as! HeaderCell
            headerCell.delegate = self
            headerCell.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
            
            return headerCell
            
        case detailRows.imageSliderRow.rawValue:
            
            let imageCell = tableView.dequeueReusableCell(withIdentifier: "detailImageCellID", for: indexPath) as! DetailmageSliderCell
            
            imageCell.awakeFromNib()
            imageCell.separatorInset.left = view.frame.width
            imageCell.humanGender = self.currentHuman?.gender
            
            return imageCell
            
        case detailRows.nameRow.rawValue:
            let nameCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            nameCell.titleInfo.text = "Name:"
            nameCell.titleValue.text = self.currentHuman?.name

            return nameCell
            
        case detailRows.dobRow.rawValue:
            let dateOfBirthCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell

            dateOfBirthCell.titleInfo.text = "Date of Birth:"
            dateOfBirthCell.titleValue.text = self.currentHuman?.dob

            return dateOfBirthCell
            
        default:
            return UITableViewCell()
        }
    }

}

