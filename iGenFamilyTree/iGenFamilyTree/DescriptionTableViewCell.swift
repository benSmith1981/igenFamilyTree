//
//  DescriptionTableViewCell.swift
//  FestivalParkApp
//
//  Created by Christophe Delaporte on 02/03/2017.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell, UITextViewDelegate {
    weak var delegate: updateParametersDelegate?
    var cellType: detailRows?
    var indexPath: IndexPath?
    @IBOutlet weak var DescriptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        DescriptionTextView.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        // Initialization code
    }

    func textViewDidChange(_ textView: UITextView) {
        if let indexPath = indexPath , let cellType = cellType{
            delegate?.getHumanUpdates(value: DescriptionTextView.text ?? "" , cellType: cellType, indexPath: indexPath)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
