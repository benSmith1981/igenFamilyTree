//
//  HumanModalViewController.swift
//  iGenFamilyTree
//
//  Created by Paul Geurts on 14/07/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
/// A dictionary of parameters to apply to a `URLRequest`.
public typealias Parameters = [String: Any]

enum detailRows: Int {
    //case headerRow = 0
    case genderRow = 0
    case nameRow
    case dobRow
    case disease1Row
    case disease2Row
    case disease3Row
    case disease4Row
    case disease5Row
    case disease6Row
    
    func positionAsInteger() -> Int {
        switch self {
        case .genderRow:
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
        case .disease4Row:
            return 6
        case .disease5Row:
            return 7
        case .disease6Row:
            return 8
        }
    }
}

protocol updateParametersDelegate: class {
    func getHumanUpdates(value: Any, cellType: detailRows)
    func addDisease()
    func removeDisease(indexPath:IndexPath)
}

class HumanModalViewController: UIViewController, UIViewControllerTransitioningDelegate, updateParametersDelegate  {

    // Objects to pass through:
    var humanDetails: FamilyTreeGenerator?
    var indexPathForPerson: IndexPath?
    var currentHuman: Human?
    var editingHuman: Human?
    var currentDiseases: Disease?

    @IBOutlet weak var modelViewTitle: UILabel!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var modalTableView: UITableView!
    @IBOutlet weak var footerBG: UIView!
    @IBOutlet weak var headerBG: UIView!
    
    @IBAction func addDiseaseRow(_ sender: Any) {
        if let currentDiseases = currentDiseases {
            currentDiseases.diseaseList.append(0)
            self.modalTableView.reloadData()
        }
    }
    
    @IBAction func dismissPopover(_ sender: Any) {
        closeView()
    }
    
    @IBAction func saveEditHuman(_ sender: Any) {
        
        let humanUpdate: Parameters = [
            "name": self.editingHuman?.name,
            "dob": self.editingHuman?.dob, //"1981",
            "gender": self.editingHuman?.gender //"male"
            
            //***************fill in rest of parameters
        ]
        
        
        if let item = indexPathForPerson?.item,
            let section = indexPathForPerson?.section,
            let cellContent = humanDetails?.model?.cell?[section][item]{
            currentHuman = editingHuman
            humanDetails?.familyTree[cellContent.getID()] = currentHuman
            
        }
        
        if let humanID = self.currentHuman?.id {
            Alamofire.request("https://fierce-gorge-29081.herokuapp.com/api/edithuman?id=\(humanID)",
                method: .post,
                parameters: humanUpdate,
                encoding: JSONEncoding.default).responseJSON { (response) in
                    switch response.result {
                    case .success(let jsonData):
                        print("success \(jsonData)")
                        
                    case .failure(let error):
                        print("error \(error)")
                    }
            }
        }
        
        //post to endpoint on alamofire
        //close pop-up
        
        
        
        closeView()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        
        self.modelViewTitle.text = NSLocalizedString("modalViewTitle", comment: "")
        
        modalTableView.frame = CGRect(x: modalTableView.frame.origin.x, y: modalTableView.frame.origin.y, width: modalTableView.frame.size.width, height: modalTableView.contentSize.height)
        modalTableView.allowsSelection = false
        
        let rectShapeTop = CAShapeLayer()
        rectShapeTop.bounds = self.headerBG.frame
        rectShapeTop.position = self.headerBG.center
        rectShapeTop.path = UIBezierPath(roundedRect: self.headerBG.bounds, byRoundingCorners: [.topLeft, .topRight ], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        
        let rectShapeBottom = CAShapeLayer()
        rectShapeBottom.bounds = self.footerBG.frame
        rectShapeBottom.position = self.footerBG.center
        rectShapeBottom.path = UIBezierPath(roundedRect: self.footerBG.bounds, byRoundingCorners: [.bottomLeft, .bottomRight ], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        
        self.headerBG.layer.mask = rectShapeTop
        self.footerBG.layer.mask = rectShapeBottom
        
        if let item = indexPathForPerson?.item,
            let section = indexPathForPerson?.section,
            let cellContent = humanDetails?.model?.cell?[section][item],
            let currentHuman = humanDetails?.familyTree[cellContent.getID()]{
                self.currentHuman = currentHuman
                //copy the editing human...
                self.editingHuman = self.currentHuman
        }
        
        if let item = indexPathForPerson?.item,
            let section = indexPathForPerson?.section,
            let cellContent = humanDetails?.model?.cell?[section][item],
            let currentDiseases = humanDetails?.diseases[cellContent.getID()]{
                self.currentDiseases = currentDiseases
        }
        
        // Do any additional setup after loading the view.
        modalTableView.rowHeight = UITableViewAutomaticDimension
        modalTableView.estimatedRowHeight = 36
        modalTableView.layer.shadowRadius = 5
        modalTableView.layer.masksToBounds = true
        
        let imageCell = UINib(nibName: "DetailmageSliderCell", bundle: nil)
        self.modalTableView.register(imageCell, forCellReuseIdentifier: "detailImageCellID")
        
        let infoCell = UINib(nibName: "InfoCell", bundle: nil)
        self.modalTableView.register(infoCell, forCellReuseIdentifier: "infoCellID")

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
    
    func getHumanUpdates(value: Any, cellType: detailRows){
        switch cellType {
        case .nameRow:
            self.editingHuman?.name = value as! String
        case .genderRow :
            self.editingHuman?.gender = value as! String
            modalTableView.reloadRows(at: [IndexPath.init(row: detailRows.nameRow.rawValue,
                                                          section: DetailViewSections.staticSections)],
                                                            with: .fade)
        case .dobRow:
            self.editingHuman?.dob = value as? String
        default:
            break
        }
    }
    
    func addDisease() {
        if let currentDiseases = currentDiseases {
            currentDiseases.diseaseList.append(0)
            self.modalTableView.reloadData()
            
            //modalTableView.reloadRows(at: [IndexPath(2,1)], with: .fade)
            //modalTableView.reloadRows(at: [IndexPath.init(row: currentDiseases.diseaseList.count,
               //                                           section: DetailViewSections.dynamicSection)],
                 //                     with: .fade)
        }
    }
    
    func removeDisease(indexPath:IndexPath) {
        self.modalTableView.beginUpdates()
        self.currentDiseases?.diseaseList.remove(at: indexPath.row)

        self.modalTableView.deleteRows(at: [indexPath], with: .fade)
        self.modalTableView.endUpdates()
    }
}
