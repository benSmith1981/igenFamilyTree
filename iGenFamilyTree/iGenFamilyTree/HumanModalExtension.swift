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
        //case DetailViewSections.verifyWithFamilySection:
          //  let inviteCell = tableView.dequeueReusableCell(withIdentifier: "inviteCellID", for: indexPath) as! InviteCell
            //return inviteCell
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
                firstDiseaseCell.textfieldValue.text = "\(String(describing: diseaseOne))"
            }
            
            return firstDiseaseCell
            
        case DetailViewSections.secondDiseaseRow:
            
            let secondDiseaseCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            secondDiseaseCell.titleInfo.text = ""
            if let secondDisease = currentDiseases?.diseaseList[1] {
                secondDiseaseCell.textfieldValue.text = String(describing: secondDisease)
            }
            
            return secondDiseaseCell
            
//        case DetailViewSections.thirdDiseaseRow:
//            
//            let thirdDiseaseCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
//            
//            thirdDiseaseCell.titleInfo.text = ""
//            if let thirdDisease = currentDiseases?.diseaseList[2] {
//                thirdDiseaseCell.textfieldValue.text = String(describing: thirdDisease)
//            }
//            
//            return thirdDiseaseCell
//            
        default:
            
            let thirdDiseaseCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            thirdDiseaseCell.titleInfo.text = ""
            if let thirdDisease = currentDiseases?.diseaseList[2] {
                thirdDiseaseCell.textfieldValue.text = String(describing: thirdDisease)
            }
            
            return thirdDiseaseCell
            
        }
    }

    func loadStaticSection(indexPath: IndexPath, tableView: UITableView)  -> UITableViewCell{
        switch indexPath.row {
            
        case detailRows.imageSliderRow.rawValue:
            
            let imageCell = tableView.dequeueReusableCell(withIdentifier: "detailImageCellID", for: indexPath) as! DetailmageSliderCell
            
            imageCell.awakeFromNib()
            imageCell.separatorInset.left = view.frame.width
            imageCell.humanGender = self.currentHuman?.gender
            
            return imageCell
            
        case detailRows.nameRow.rawValue:
            let nameCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            nameCell.titleInfo.text = "Name:"
            nameCell.textfieldValue.text = self.currentHuman?.name
            
            if self.currentHuman?.gender == JsonKeys.male.rawValue {
                nameCell.textfieldValue.placeholder = "e.g. John Doe"
            } else {
                nameCell.textfieldValue.placeholder = "e.g. Jane Doe"
            }

            return nameCell
            
        case detailRows.dobRow.rawValue:
            let dateOfBirthCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell

            dateOfBirthCell.titleInfo.text = "Date of Birth:"
            dateOfBirthCell.textfieldValue.text = self.currentHuman?.dob
            dateOfBirthCell.textfieldValue.placeholder = "YYYY"

            return dateOfBirthCell
            
        default:
            return UITableViewCell()
        }
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerCell = tableView.dequeueReusableCell(withIdentifier: "headerCellID") as! HeaderCell
//        headerCell.delegate = self
//        headerCell.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
//        
//        if section == 0 {
//            return headerCell
//        } else {
//            return nil
//        }
    
        /* switch (section) {
        case 0:
            return headerCell
        //return sectionHeaderView
        case 1:
            return nil
        //return sectionHeaderView
        case 2:
            return nil
        //return sectionHeaderView
        default:
            return nil
        }*/
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0 {
//            return 36
//        } else {
//            return 0
//        }
//    }
    
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footerCell = tableView.dequeueReusableCell(withIdentifier: "footerCellID") as! FooterCell
//        
//        if section == 2 {
//            return footerCell
//        } else {
//            return nil
//        }
//    }
    
    //myTblView.tableFooterView = customView
    
    //func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //    if section == 2 {
    //        return 36
    //    } else {
    //        return 0
    //    }
    //}
    
}

