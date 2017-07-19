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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //enums for each case (e.g. 0, 1, 2, ...)
        switch indexPath.row {
        
        case detailRows.headerRow.rawValue:
            
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "headerCellID", for: indexPath) as! HeaderCell
            headerCell.delegate = self
            headerCell.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
            
            return headerCell
            
//        case detailRows.imageSliderRow.rawValue:
//            
//            let imageCell = tableView.dequeueReusableCell(withIdentifier: "detailImageCellID", for: indexPath) as! DetailmageSliderCell
//            
//            imageCell.awakeFromNib()
//            //imageCell.siteDetail = siteDetailObject
//            imageCell.separatorInset.left = view.frame.width
//            
//            return imageCell

        case detailRows.nameRow.rawValue:
            
            let nameCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            nameCell.titleInfo.text = "Name"
            
            if let section = indexPathForPerson?.section,
                let item = indexPathForPerson?.item,
                let cellContent = humanDetails?.model?.cell?[section][item] {
                    let currentHuman = humanDetails?.familyTree[cellContent.getID()]
                    nameCell.titleValue.text = currentHuman?.name
            }
            
            /*
            if let cellContent = familyTreeGenerator?.model?.cell?[indexPath.section][indexPath.item] {
                let currentHuman = familyTreeGenerator?.familyTree[cellContent.getID()]
                print(currentHuman?.name)
                cell.bgImg.image = cellContent.switchBG()
                cell.genderImg.image = cellContent.showGender()
                cell.patientName.text = currentHuman?.name
                */
            
            return nameCell
            
            
        case detailRows.dobRow.rawValue:
            
            let dateOfBirthCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            dateOfBirthCell.titleInfo.text = "Date of Birth"
            
            if let section = indexPathForPerson?.section,
                let item = indexPathForPerson?.item,
                let cellContent = humanDetails?.model?.cell?[section][item] {
                let currentHuman = humanDetails?.familyTree[cellContent.getID()]
                dateOfBirthCell.titleValue.text = currentHuman?.dob
            }
            
            return dateOfBirthCell
        
        case detailRows.disease1Row.rawValue:
            
            let firstDiseaseCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            firstDiseaseCell.titleInfo.text = "Disease 1"
            
            return firstDiseaseCell
            
        case detailRows.disease2Row.rawValue:
            
            let secondDiseaseCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            secondDiseaseCell.titleInfo.text = "Disease 2"
            
            return secondDiseaseCell
            
        case detailRows.disease3Row.rawValue:
            
            let thirdDiseaseCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            thirdDiseaseCell.titleInfo.text = "Disease 3"
            
            return thirdDiseaseCell
            
        default:
            
            let inviteCell = tableView.dequeueReusableCell(withIdentifier: "inviteCellID", for: indexPath) as! InviteCell
            
            return inviteCell
            
            
        }
        
    }

}

