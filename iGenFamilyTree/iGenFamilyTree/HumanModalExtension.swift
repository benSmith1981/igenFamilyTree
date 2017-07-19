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
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 4
        } else if section == 1 {
            return numberOfDiseasesToShow()
        } else if section == 2{
            return 1
        } else {
            return 0
        }
    }

    func numberOfDiseasesToShow() -> Int{
        if let showDisease = self.currentHuman?.showDiseaseInfo,
            let diseaseList = self.currentDiseases?.diseaseList{
            return diseaseList.count
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //enums for each case (e.g. 0, 1, 2, ...)
        switch indexPath.section {
        
        case 0:
            return loadSection1(indexPath: indexPath, tableView: tableView)
        case 1:
            return loadSection2(indexPath: indexPath, tableView: tableView)
        case 2:
            let inviteCell = tableView.dequeueReusableCell(withIdentifier: "inviteCellID", for: indexPath) as! InviteCell
            return inviteCell
        default :
            return UITableViewCell()
        }
        
    }
    func loadSection2(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell{
        switch indexPath.row {
        case 0:
            
            let firstDiseaseCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            firstDiseaseCell.titleInfo.text = "Disease(s):"
            if let diseaseOne = currentDiseases?.diseaseList[0] {
                firstDiseaseCell.titleValue.text = "\(String(describing: diseaseOne))"
            }

//            if let section = indexPathForPerson?.section,
//                let item = indexPathForPerson?.item,
//                let cellContent = humanDetails?.model?.cell?[section][item],
//                let currentHuman = humanDetails?.familyTree[cellContent.getID()],
//                let currentDiseases = humanDetails?.diseases[cellContent.getID()]{
//                
//                if currentHuman.showDiseaseInfo {
//                    
//                }
//                
//                if let _ = self.humanDetails?.diseases {
//                }
//
//                
//            }
            
            return firstDiseaseCell
            
        case 1:
            
            let secondDiseaseCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            secondDiseaseCell.titleInfo.text = ""
            if let secondDisease = currentDiseases?.diseaseList[1] {
                secondDiseaseCell.titleValue.text = String(describing: secondDisease)
            }
//            if let section = indexPathForPerson?.section,
//                let item = indexPathForPerson?.item,
//                let cellContent = humanDetails?.model?.cell?[section][item],
//                let currentDiseases = humanDetails?.diseases[cellContent.getID()]{
//
//                
//            }
            
            return secondDiseaseCell
            
        case 2:
            
            let thirdDiseaseCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            thirdDiseaseCell.titleInfo.text = ""
            if let thirdDisease = currentDiseases?.diseaseList[2] {
                thirdDiseaseCell.titleValue.text = String(describing: thirdDisease)
            }
//            if let section = indexPathForPerson?.section,
//                let item = indexPathForPerson?.item,
//                let cellContent = humanDetails?.model?.cell?[section][item] ,
//                let currentDiseases = humanDetails?.diseases[cellContent.getID()]{
//
//                
//            }
            
            return thirdDiseaseCell
            
        default:
            
            let inviteCell = tableView.dequeueReusableCell(withIdentifier: "inviteCellID", for: indexPath) as! InviteCell
            
            return inviteCell
            
            
        }
    }

    func loadSection1(indexPath: IndexPath, tableView: UITableView)  -> UITableViewCell{
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
//            
//            if let section = indexPathForPerson?.section,
//                let item = indexPathForPerson?.item,
//                let cellContent = humanDetails?.model?.cell?[section][item] {
//                let currentHuman = humanDetails?.familyTree[cellContent.getID()]
//                imageCell.humanGender = currentHuman?.gender
//            }
            imageCell.humanGender = self.currentHuman?.gender
            
            return imageCell
            
        case detailRows.nameRow.rawValue:
            
            let nameCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            nameCell.titleInfo.text = "Name:"
            
//            if let section = indexPathForPerson?.section,
//                let item = indexPathForPerson?.item,
//                let cellContent = humanDetails?.model?.cell?[section][item] {
//                let currentHuman = humanDetails?.familyTree[cellContent.getID()]
//                nameCell.titleValue.text = currentHuman?.name
//            }
            nameCell.titleValue.text = self.currentHuman?.name

            return nameCell
            
            
        case detailRows.dobRow.rawValue:
            
            let dateOfBirthCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            dateOfBirthCell.titleInfo.text = "Date of Birth:"
            
//            if let section = indexPathForPerson?.section,
//                let item = indexPathForPerson?.item,
//                let cellContent = humanDetails?.model?.cell?[section][item] {
//                let currentHuman = humanDetails?.familyTree[cellContent.getID()]
//                dateOfBirthCell.titleValue.text = currentHuman?.dob
//            }
            dateOfBirthCell.titleValue.text = self.currentHuman?.dob

            return dateOfBirthCell
        default:
            return UITableViewCell()
        }
    }

}

