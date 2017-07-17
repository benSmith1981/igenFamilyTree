//
//  HumanModalViewController.swift
//  iGenFamilyTree
//
//  Created by Paul Geurts on 14/07/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit
import CoreData

enum detailRows: Int {
    case imageSliderRow = 0
    case nameRow = 1
    case dobRow = 2
    case disease1Row = 3
    case disease2Row = 4
    case disease3Row = 5
    
    func positionAsInteger() -> Int {
        switch self {
        case .imageSliderRow:
            return 0
        case .nameRow:
            return 1
        case .dobRow:
            return 2
        case .disease1Row:
            return 3
        case .disease2Row:
            return 4
        case .disease3Row:
            return 5
        }
    }
}

class HumanModalViewController: UIViewController {

    // Objects to pass through:
    
    
    @IBOutlet weak var modalTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        modalTableView.rowHeight = UITableViewAutomaticDimension
        modalTableView.estimatedRowHeight = 150
        modalTableView.layer.cornerRadius = 10
        modalTableView.layer.shadowRadius = 5
        
        modalTableView.layer.shadowColor = UIColor.black.cgColor
        modalTableView.layer.shadowOpacity = 0.15
        modalTableView.layer.masksToBounds = true
        //modalTableView.layer.shadowOffset = CGSize(width: 0, height: 0)
        //modalTableView.layer.shouldRasterize = true
        
        
        let imageCell = UINib(nibName: "DetailmageSliderCell", bundle: nil)
        self.modalTableView.register(imageCell, forCellReuseIdentifier: "detailImageCellID")
        
        let infoCell = UINib(nibName: "InfoCell", bundle: nil)
        self.modalTableView.register(infoCell, forCellReuseIdentifier: "infoCellID")
        
        
        //ONLY NEEDED FOR ... ?
        //self.modalTableView.delegate = self
        //self.modalTableView.dataSource = self
        
    }
    @IBAction func didTapImageView(_ tap: UITapGestureRecognizer) {
        //selectedImage = tap.view as? UIImageView
        
        //let index = tap.view!.tag
        //let selectedHerb = herbs[index]
        
        //present details view controller
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func dismissView(_ sender: Any) {
                self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
