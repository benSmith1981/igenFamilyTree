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
    //case headerRow = 0
    case imageSliderRow = 0
    case nameRow = 1
    case dobRow = 2
    case disease1Row = 4
    case disease2Row = 5
    case disease3Row = 6
    case inviteRow = 7
    
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
        case .inviteRow:
            return 6
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
    var currentHuman: Human?
    var currentDiseases: Disease?

    @IBOutlet var containerView: UIView!

    @IBOutlet weak var modalTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        modalTableView.frame = CGRect(x: modalTableView.frame.origin.x, y: modalTableView.frame.origin.y, width: modalTableView.frame.size.width, height: modalTableView.contentSize.height)
        
        modalTableView.backgroundColor = UIColor.clear
        
        if let item = indexPathForPerson?.item,
            let section = indexPathForPerson?.section,
            let cellContent = humanDetails?.model?.cell?[section][item],
            let currentHuman = humanDetails?.familyTree[cellContent.getID()]{
                self.currentHuman = currentHuman
        }
        
        if let item = indexPathForPerson?.item,
            let section = indexPathForPerson?.section,
            let cellContent = humanDetails?.model?.cell?[section][item],
            let currentDiseases = humanDetails?.diseases[cellContent.getID()]{
                self.currentDiseases = currentDiseases
        }
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
        
        let emptyCell = UINib(nibName: "emptyTableViewCell", bundle: nil)
        self.modalTableView.register(inviteCell, forCellReuseIdentifier: "emptyTableViewCellID")
  
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLayoutSubviews() {
        
        modalTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func closeView()
    {
        self.presentingViewController?.dismiss(animated: true, completion: nil)

    }
}
