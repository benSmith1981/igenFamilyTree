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
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //enums for each case (e.g. 0, 1, 2, ...)
        switch indexPath.row {
        case detailRows.imageSliderRow.rawValue:
            
            let imageCell = tableView.dequeueReusableCell(withIdentifier: "detailImageCellID", for: indexPath) as! DetailmageSliderCell
            
            imageCell.awakeFromNib()
            //imageCell.siteDetail = siteDetailObject
            imageCell.separatorInset.left = view.frame.width
            
            return imageCell

            
            
        case detailRows.nameRow.rawValue:
            
            let nameCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            nameCell.textLabel?.text = "Name"
            
            return nameCell
            
            
        case detailRows.dobRow.rawValue:
            
            let dateOfBirthCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            dateOfBirthCell.textLabel?.text = "Date of Birth"
            
            return dateOfBirthCell
            
            
        default:
            
            let infoCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            infoCell.textLabel?.text = "Default cell"
            
            return infoCell
            
            
        }
        
    }

}

