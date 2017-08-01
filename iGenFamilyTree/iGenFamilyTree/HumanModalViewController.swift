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
    func getHumanUpdates(value: Any, cellType: detailRows, indexPath:IndexPath)
    func addDisease()
    func removeDisease(indexPath:IndexPath)
    func showPicker()
    func hidePicker()
}
extension updateParametersDelegate {
    func showPicker() {}
    func hidePicker(){}
    func addDisease() {}
    func removeDisease(indexPath:IndexPath) {}
}

class HumanModalViewController: UIViewController, UIViewControllerTransitioningDelegate, updateParametersDelegate  {
    
    // Objects to pass through:
    var humanDetails: FamilyTreeGenerator?
    weak var delegate: reloadAfterEdit?
    var indexPathForPerson: IndexPath?
    var currentHuman: Human?
    var editingHuman: Human?
    var currentDiseases: Disease?
    var editingDiseases: Disease?
    var diseaseArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    @IBOutlet weak var pickerDisease: UIView!

    
    @IBOutlet weak var modelViewTitle: UILabel!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var modalTableView: UITableView!
    @IBOutlet weak var footerBG: UIView!
    @IBOutlet weak var headerBG: UIView!
    
    @IBOutlet weak var pickerTrailingToBottomContraint: NSLayoutConstraint!
    //@IBOutlet weak var pickerheightconstraint: NSLayoutConstraint!
    
    
    @IBAction func verifyMember(_ sender: Any) {
//        self.modalTableView.selectRow(at: IndexPath.init(row: 0, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.none)
        self.performSegue(withIdentifier: "modifySegue", sender: self)

    }
    @IBAction func addDiseaseRow(_ sender: Any) {
        if let currentDiseases = currentDiseases {
            currentDiseases.diseaseList.append("")
            self.modalTableView.reloadData()
        }
    }
    
    
    
//    @IBAction func dismissPIcker(_ sender: UITapGestureRecognizer) {
//        self.hidePicker()
//    }
    @IBAction func dismissPopover(_ sender: Any) {
        closeView()
    }
    
    @IBAction func saveEditHuman(_ sender: Any) {
        
        // ***** MAKE DELETE CURRENT DISEASE FUNCTION
        saveChangedHumanAndDiseases()
        closeView()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        pickerDisease.dataSource = self
//        pickerDisease.delegate = self
        
        self.hideKeyboardWhenTappedAround()
        
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
            let cellContent = humanDetails?.model?.cell?[section][item] {
            
            if let currentDiseases = humanDetails?.diseases[cellContent.getID()]{
                self.currentDiseases = currentDiseases
                self.editingDiseases = self.currentDiseases
            } else {
                self.editingDiseases = Disease.init(id: cellContent.getID(), editInfoID: "", editInfoTimestamp: "", editInfoField: "")
                self.editingDiseases?.diseaseList.append("")
            }
            
        }
        
        // Do any additional setup after loading the view.
        modalTableView.rowHeight = UITableViewAutomaticDimension
        modalTableView.estimatedRowHeight = 36
        modalTableView.layer.shadowRadius = 5
        modalTableView.layer.masksToBounds = true
        
        let imageCell = UINib(nibName: "DetailmageSliderCell", bundle: nil)
        self.modalTableView.register(imageCell, forCellReuseIdentifier: CustomCellIdentifiers.detailImageCellID.rawValue)
        
        let infoCell = UINib(nibName: "InfoCell", bundle: nil)
        self.modalTableView.register(infoCell, forCellReuseIdentifier: CustomCellIdentifiers.infoCellID.rawValue)

        let pickerCell = UINib(nibName: "PickerTableCellTableViewCell", bundle: nil)
        self.modalTableView.register(pickerCell, forCellReuseIdentifier: "diseasePickerID")
        
        
        
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
        delegate?.reloadCell()
    }
    
    func getHumanUpdates(value: Any, cellType: detailRows, indexPath: IndexPath){
        //animate the picker
        

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
        case .disease1Row:
            self.editingDiseases?.diseaseList[0] = value as! String
        case .disease2Row:
            self.editingDiseases?.diseaseList[1] = value as! String
        case .disease3Row:
            self.editingDiseases?.diseaseList[2] = value as! String
        case .disease4Row:
            self.editingDiseases?.diseaseList[3] = value as! String
        case .disease5Row:
            self.editingDiseases?.diseaseList[4] = value as! String
        default:
            break
        }
    }
    
    func showPicker(){
    
        
        self.pickerTrailingToBottomContraint.constant = 0
        
        UIView.animate(withDuration: 0.4,
                       //options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        
            self.pickerDisease.alpha = 1
            self.view.layoutIfNeeded()
            
        }) { (success) in
            //
            print(self.pickerDisease.frame)
        }
    }
    
    func hidePicker(){
        
        self.pickerTrailingToBottomContraint.constant = -200
        
        UIView.animate(withDuration: 0.4, animations: {
            self.pickerDisease.alpha = 0
            self.view.layoutIfNeeded()
            
        }) { (success) in
            //
        }
    }
    func addDisease() {
        if let editingDiseases = editingDiseases {
            
            editingDiseases.diseaseList.append("")
            self.modalTableView.reloadData()
        }
    }
    
    func removeDisease(indexPath:IndexPath) {
        
        self.modalTableView.beginUpdates()
        self.editingDiseases?.diseaseList.remove(at: indexPath.row)
        self.modalTableView.deleteRows(at: [indexPath], with: .fade)
        self.modalTableView.reloadData()
        self.modalTableView.endUpdates()
    }
    
    func saveChangedHumanAndDiseases(){
        if let item = indexPathForPerson?.item,
            let section = indexPathForPerson?.section,
            let cellContent = humanDetails?.model?.cell?[section][item]{
            
            currentHuman = editingHuman
            humanDetails?.familyTree[cellContent.getID()] = currentHuman
            iGenDataService.saveHuman(currentHuman!)
            
            if (editingDiseases?.diseaseList.count)! > 0 && editingDiseases?.diseaseList[0] != "" {
                //save diseases if they got changed
                currentDiseases = editingDiseases
                humanDetails?.diseases[cellContent.getID()] = currentDiseases
                iGenDataService.saveDisease(currentDiseases!)
            } else if currentDiseases != nil {
                humanDetails?.diseases[cellContent.getID()] = nil
                currentDiseases = nil
            } else {
                editingDiseases = nil
            }
            
        }
    }
}
