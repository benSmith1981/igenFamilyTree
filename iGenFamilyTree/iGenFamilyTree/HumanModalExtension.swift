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
            
            /*
            if let urlString = detailMovieObject?.poster {
                let url = URL(string: urlString)
                cell.fullImage.kf.setImage(with: url)
            }
            
            if let ratings = self.detailMovieObject?.imdbRating {
                cell.votes.text = "\(ratings)"
            }
            
            if let urlString = detailMovieObject?.poster {
                let url = URL(string: urlString)
                cell.profileMovie.kf.setImage(with: url)
            }
            
            //cell.isUserInteractionEnabled = false
            cell.imdbIco.image = #imageLiteral(resourceName: "imdb-2-icon")
            */
            
            
        case detailRows.nameRow.rawValue:
            
            let imageCell = tableView.dequeueReusableCell(withIdentifier: "detailImageCellID", for: indexPath) as! DetailmageSliderCell
            
            imageCell.awakeFromNib()
            //imageCell.siteDetail = siteDetailObject
            imageCell.separatorInset.left = view.frame.width
            
            return imageCell
            /*
            let cell = tableView.dequeueReusableCell(withIdentifier: "plotCellID", for: indexPath) as! PlotCell
            cell.moviePlot.text = self.detailMovieObject?.plot
            */
            
            
            
        case detailRows.dobRow.rawValue:
            
            let imageCell = tableView.dequeueReusableCell(withIdentifier: "detailImageCellID", for: indexPath) as! DetailmageSliderCell
            
            imageCell.awakeFromNib()
            //imageCell.siteDetail = siteDetailObject
            imageCell.separatorInset.left = view.frame.width
            
            return imageCell
            
            /*
            let cell = tableView.dequeueReusableCell(withIdentifier: "imdbCellID", for: indexPath) as! imdbCell
            
            if let votes = self.detailMovieObject?.imdbVotes {
                cell.imdbVotes.text = "IMDb Votes: \(votes)"
            }
            */
            
            
            
        default:
            
            
            
            let infoCell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            infoCell.textLabel?.text = "Poep"
            
            //imageCell.awakeFromNib()
            //imageCell.siteDetail = siteDetailObject
            //imageCell.separatorInset.left = view.frame.width
            
            return infoCell
            
            /*
            let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath) as! DefaultDetailCell
            //cell.moviePlot.text = ""
            // cell.contentView.backgroundColor = UIColor(red: 245/256, green: 245/256, blue: 245/256, alpha: 0.66)
            */
            
            
        }
        
    }

}

