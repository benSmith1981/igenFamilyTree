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
        modalTableView.layer.masksToBounds = false
        //modalTableView.layer.shadowOffset = CGSize(width: 0, height: 0)
        //modalTableView.layer.shouldRasterize = true
        
        
        let imageCell = UINib(nibName: "DetailmageSliderCell", bundle: nil)
        self.modalTableView.register(imageCell, forCellReuseIdentifier: "detailImageCellID")
        
        let infoCell = UINib(nibName: "InfoCell", bundle: nil)
        self.modalTableView.register(infoCell, forCellReuseIdentifier: "infoCellID")
        
        
        //ONLY NEEDED FOR ... ?
        //self.modalTableView.delegate = self
        //ONLY NEEDED FOR COREDATA?
        //self.modalTableView.dataSource = self
        
        
        
        
        /*
        let plotCell = UINib(nibName: "PlotCell", bundle: nil)
        let imdbCell = UINib(nibName: "imdbCell", bundle:nil)
        let defaultCell = UINib(nibName: "DefaultDetailCell", bundle:nil)
        */
        
        /*
        self.myTableView.register(imdbCell, forCellReuseIdentifier: "imdbCellID")
        self.myTableView.register(plotCell, forCellReuseIdentifier: "plotCellID")
        self.myTableView.register(defaultCell, forCellReuseIdentifier: "defaultCell")
        */
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
