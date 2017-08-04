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
        let message =  self.showDiseaseSwitch.isOn ? NSLocalizedString("showdiseasesmessageOn", comment: "") : NSLocalizedString("showdiseasesmessageOff", comment: "")
        
        let alert = UIAlertController(title: NSLocalizedString("verifyalert", comment: ""), message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("diseaseresponseNo", comment: ""), style: UIAlertActionStyle.default, handler: { (action) in
            self.showDiseaseSwitch.setOn(!self.showDiseaseSwitch.isOn, animated: true)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("diseaseresponseYes", comment: ""), style: UIAlertActionStyle.default, handler: { (action) in
            self.delegate?.getHumanUpdates(value: self.showDiseaseSwitch.isOn, cellType: .diseaseSwitch, indexPath: self.indexPath!)
        }))
        delegate?.showAlertMessage(alert: alert)

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
