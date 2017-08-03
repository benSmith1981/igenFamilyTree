//
//  CanViewDiseasesCell.swift
//  iGenFamilyTree
//
//  Created by ben on 03/08/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit

class CanViewDiseasesCell: UITableViewCell {

    var indexPath: IndexPath?
    var cellType: detailRows?
    weak var delegate: updateParametersDelegate?
    @IBOutlet weak var showDiseaseSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func viewDiseasesSwitch(_ sender: Any) {
        if showDiseaseSwitch.isOn {
            delegate?.getHumanUpdates(value: true, cellType: .diseaseSwitch, indexPath: indexPath!)
        } else {
            delegate?.getHumanUpdates(value: false, cellType: .diseaseSwitch, indexPath: indexPath!)
        }

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
