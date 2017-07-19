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
    case headerRow = 0
    case imageSliderRow = 1
    case nameRow = 2
    case dobRow = 3
    case disease1Row = 4
    case disease2Row = 5
    case disease3Row = 6
    case inviteRow = 7
    
    func positionAsInteger() -> Int {
        switch self {
        case .headerRow:
            return 0
        case .imageSliderRow:
            return 1
        case .nameRow:
            return 2
        case .dobRow:
            return 3
        case .disease1Row:
            return 4
        case .disease2Row:
            return 5
        case .disease3Row:
            return 6
        case .inviteRow:
            return 7
        }
    }
}

protocol closeDetails {
    func closeView()
}
class HumanModalViewController: UIViewController, closeDetails,UIViewControllerTransitioningDelegate  {

    // Objects to pass through:
    var humanDetails: FamilyTreeGenerator?
    var indexPathForPerson: IndexPath?
    @IBOutlet var containerView: UIView!

    @IBOutlet weak var modalTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        modalTableView.rowHeight = UITableViewAutomaticDimension
        modalTableView.estimatedRowHeight = 40
        
        modalTableView.layer.cornerRadius = 10
        modalTableView.layer.shadowRadius = 5
        modalTableView.layer.masksToBounds = true
        
//        view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        
        //Need to make two layers for cell and shadow to enable both rounded corners AND shadows
        //modalTableView.layer.shadowColor = UIColor.black.cgColor
        //modalTableView.layer.shadowOpacity = 0.15
        //modalTableView.layer.shadowOffset = CGSize(width: 0, height: 0)
        //modalTableView.layer.shouldRasterize = true
        
        let headerCell = UINib(nibName: "HeaderCell", bundle: nil)
        self.modalTableView.register(headerCell, forCellReuseIdentifier: "headerCellID")
        
        let imageCell = UINib(nibName: "DetailmageSliderCell", bundle: nil)
        self.modalTableView.register(imageCell, forCellReuseIdentifier: "detailImageCellID")
        
        let infoCell = UINib(nibName: "InfoCell", bundle: nil)
        self.modalTableView.register(infoCell, forCellReuseIdentifier: "infoCellID")
        
        let inviteCell = UINib(nibName: "InviteCell", bundle: nil)
        self.modalTableView.register(inviteCell, forCellReuseIdentifier: "inviteCellID")
  
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func closeView()
    {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
//        self.dismiss(animated: true, completion: nil)
//        presentingViewController?.dismiss(animated: true, completion: nil)

    }
}
