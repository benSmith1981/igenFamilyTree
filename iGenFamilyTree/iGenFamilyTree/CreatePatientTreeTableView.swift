//
//  TableViewController.swift
//  iGenFamilyTree
//
//  Created by Achid Farooq on 04-07-17.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit
import IQKeyboardManager

enum QuestionType: Int {
    case brother = 0
    case sister
    case sons
    case daughters
    case brotherMother
    case sisterMother
    case brotherFather
    case sisterFather
    case generateButton
    case gender
    case genderPartner
    
    func selectQuestion() -> String {
        
        switch self {
        case .brother:
            return NSLocalizedString("numberBrothers", comment: "")
        case .sister:
            return NSLocalizedString("numberSisters", comment: "")
        case .sons:
            return NSLocalizedString("numberSons", comment: "")
        case .daughters:
            return NSLocalizedString("numberDaughters", comment: "")
        case .brotherMother:
            return NSLocalizedString("numberBrotherfromMother", comment: "")
        case .sisterMother:
            return NSLocalizedString("numberSistersfromMother", comment: "")
        case .brotherFather:
            return NSLocalizedString("numberBrothersfromFather", comment: "")
        case .sisterFather:
            return NSLocalizedString("numberSistersfromFather", comment: "")
        case .gender:
            return NSLocalizedString("chooseGender", comment: "")
        case .genderPartner:
            return NSLocalizedString("chooseGenderSpouse", comment: "")
        case .generateButton:
            return ""
        }
    }
}

protocol SetNumberOfFamilyMembers {
    func generateTree()
    func sendNumber(number: Int, cellType: QuestionType)
}

struct Answers {
    var brothers: Int = 0
    var sisters: Int = 0
    var sons: Int = 0
    var daughters: Int = 0
    var brothersOfMother: Int = 0
    var sistersOfMother: Int = 0
    var brothersOfFather: Int = 0
    var sistersOfFather: Int = 0
    var patientGender: genderType = .male
    var partnerGender: genderType = .female
}


class GenerateTableViewController: UITableViewController, SetNumberOfFamilyMembers, updateParametersDelegate, UITextFieldDelegate {

    var answers = Answers()
    var familyTreeGenerator = FamilyTreeGenerator.init(familyTree: [:])
    var serverResponse: ServerResponse?

    func generateTree() {
        familyTreeGenerator.generateNewFamilyTree(with: answers)
        self.performSegue(withIdentifier: Segues.familytreeSegue.rawValue, sender: self)
    }
    
    
    func getHumanUpdates(value: Any, cellType: detailRows, indexPath: IndexPath) {
        
        if cellType == .genderRow {
            
            print("gender from form")
            let gender = value as! String
            switch gender {
            case  JsonKeys.male.rawValue:
                if indexPath.section == 0 {
                    answers.patientGender = .male
                } else if indexPath.section == 1 {
                    answers.partnerGender = .male
                }
                print("male from slider cell FORM")
            case  JsonKeys.female.rawValue:
                if indexPath.section == 0 {
                    answers.patientGender = .female
                } else if indexPath.section == 1{
                    answers.partnerGender = .female
                }
                print("female from slider cell FORM")
            default:
                answers.patientGender = .unknown
                print("uunknonwn gender")
            }

        }
    }
    
    
    func sendNumber(number: Int, cellType: QuestionType){
        switch cellType {
        case .brother:
            answers.brothers = number
        case .sister:
            answers.sisters = number
        case .sons:
            answers.sons = number
        case .daughters:
            answers.daughters = number
        case .brotherMother:
            answers.brothersOfMother = number
        case .sisterMother:
            answers.sistersOfMother = number
        case .brotherFather:
            answers.brothersOfFather = number
        case .sisterFather:
            answers.sistersOfFather = number
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tableView.separatorStyle = .singleLineEtched
//        self.tableView.separatorColor = UIColor.black
        
        self.navigationItem.hidesBackButton = true
        
        let nib = UINib(nibName: "CreatePatientTree", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: CustomCellIdentifiers.CreatePatientTreeID.rawValue)
        let generate = UINib(nibName: "GenerateFamilyCellTableViewCell", bundle: nil)
        self.tableView.register(generate, forCellReuseIdentifier: CustomCellIdentifiers.GenerateCellID.rawValue)
        let genderCell = UINib(nibName: "DetailmageSliderCell", bundle: nil)
        self.tableView.register(genderCell, forCellReuseIdentifier: CustomCellIdentifiers.detailImageCellID.rawValue)
        let titleForGenderCells = UINib(nibName: "CreatePatientTreeGender", bundle: nil)
        self.tableView.register(titleForGenderCells, forCellReuseIdentifier: CustomCellIdentifiers.CreatePatientGender.rawValue)

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        NotificationCenter.default.addObserver(self, selector: #selector(GenerateTableViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GenerateTableViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if segue.identifier == segues.familytreeSegue.rawValue {
        let ccData = segue.destination as! CustomCollectionViewController
        ccData.familyTreeGenerator = familyTreeGenerator
        ccData.serverResponse = serverResponse
    }    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0, 1:
            return UITableViewAutomaticDimension
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 9
        default:
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            case 0:
                let genderPatient = tableView.dequeueReusableCell(withIdentifier: CustomCellIdentifiers.detailImageCellID.rawValue, for: indexPath) as! DetailmageSliderCell
                genderPatient.delegate = self
                genderPatient.indexPath = indexPath
                genderPatient.humanGender = answers.patientGender.rawValue

                return genderPatient
            case 1:
                let genderPatientPartner = tableView.dequeueReusableCell(withIdentifier: CustomCellIdentifiers.detailImageCellID.rawValue, for: indexPath) as! DetailmageSliderCell
                genderPatientPartner.delegate = self
                genderPatientPartner.humanGender = answers.partnerGender.rawValue

                genderPatientPartner.indexPath = indexPath

                return genderPatientPartner
            case 2:
                return loadQuestionRows(indexPath: indexPath)
            default:
                return UITableViewCell()
        }
    }

    
    func loadQuestionRows(indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            
        case QuestionType.brother.rawValue:
            let cellBrothers = tableView.dequeueReusableCell(withIdentifier: CustomCellIdentifiers.CreatePatientTreeID.rawValue, for: indexPath) as! CreatePatientTree
            cellBrothers.setNumberDelegate = self
            cellBrothers.questionLabel.text = QuestionType.brother.selectQuestion()
            cellBrothers.awakeFromNib()
            cellBrothers.numberOfMembers.tag = 1
            cellBrothers.layoutSubviews()
            cellBrothers.cellType = .brother
            cellBrothers.numberOfMembers.text = String(answers.brothers)

            return cellBrothers
            
        case QuestionType.sister.rawValue:
            let cellSisters = tableView.dequeueReusableCell(withIdentifier: CustomCellIdentifiers.CreatePatientTreeID.rawValue, for: indexPath) as! CreatePatientTree
            cellSisters.setNumberDelegate = self
            cellSisters.questionLabel.text = QuestionType.sister.selectQuestion()
            cellSisters.cellType = .sister
            cellSisters.numberOfMembers.tag = 2
            cellSisters.layoutSubviews()
            cellSisters.numberOfMembers.text = String(answers.sisters)

            return cellSisters
            
        case QuestionType.sons.rawValue:
            let cellSons = tableView.dequeueReusableCell(withIdentifier: CustomCellIdentifiers.CreatePatientTreeID.rawValue, for: indexPath) as! CreatePatientTree
            cellSons.setNumberDelegate = self
            cellSons.questionLabel.text = QuestionType.sons.selectQuestion()
            cellSons.numberOfMembers.text = String(answers.sons)
            cellSons.numberOfMembers.tag = 3
            cellSons.cellType = .sons
            cellSons.layoutSubviews()
            
            return cellSons
            
        case QuestionType.daughters.rawValue:
            let cellDaughters = tableView.dequeueReusableCell(withIdentifier: CustomCellIdentifiers.CreatePatientTreeID.rawValue, for: indexPath) as! CreatePatientTree
            cellDaughters.setNumberDelegate = self
            cellDaughters.questionLabel.text = QuestionType.daughters.selectQuestion()
            cellDaughters.cellType = .daughters
            cellDaughters.numberOfMembers.tag = 4
            cellDaughters.layoutSubviews()
            cellDaughters.numberOfMembers.text = String(answers.daughters)

            
            return cellDaughters
            
        case QuestionType.brotherMother.rawValue:
            let cellBrotherMother = tableView.dequeueReusableCell(withIdentifier: CustomCellIdentifiers.CreatePatientTreeID.rawValue, for: indexPath) as! CreatePatientTree
            cellBrotherMother.setNumberDelegate = self
            cellBrotherMother.questionLabel.text = QuestionType.brotherMother.selectQuestion()
            cellBrotherMother.cellType = .brotherMother
            cellBrotherMother.numberOfMembers.tag = 5
            cellBrotherMother.layoutSubviews()
            cellBrotherMother.numberOfMembers.text = String(answers.brothersOfMother)

            
            return cellBrotherMother
            
        case QuestionType.sisterMother.rawValue:
            let cellSisterMother = tableView.dequeueReusableCell(withIdentifier: CustomCellIdentifiers.CreatePatientTreeID.rawValue, for: indexPath) as! CreatePatientTree
            cellSisterMother.setNumberDelegate = self
            cellSisterMother.questionLabel.text = QuestionType.sisterMother.selectQuestion()
            cellSisterMother.cellType = .sisterMother
            cellSisterMother.numberOfMembers.tag = 6
            cellSisterMother.layoutSubviews()
            cellSisterMother.numberOfMembers.text = String(answers.sistersOfMother)

            
            return cellSisterMother
            
        case QuestionType.brotherFather.rawValue:
            let cellBrotherFather = tableView.dequeueReusableCell(withIdentifier: CustomCellIdentifiers.CreatePatientTreeID.rawValue, for: indexPath) as! CreatePatientTree
            cellBrotherFather.setNumberDelegate = self
            cellBrotherFather.questionLabel.text = QuestionType.brotherFather.selectQuestion()
            cellBrotherFather.cellType = .brotherFather
            cellBrotherFather.numberOfMembers.tag = 7
            cellBrotherFather.layoutSubviews()
            cellBrotherFather.numberOfMembers.text = String(answers.brothersOfFather)

            
            return cellBrotherFather
            
        case QuestionType.sisterFather.rawValue:
            let cellSisterFather = tableView.dequeueReusableCell(withIdentifier: CustomCellIdentifiers.CreatePatientTreeID.rawValue, for: indexPath) as! CreatePatientTree
            cellSisterFather.setNumberDelegate = self
            cellSisterFather.questionLabel.text = QuestionType.sisterFather.selectQuestion()
            cellSisterFather.cellType = .sisterFather
            cellSisterFather.numberOfMembers.tag = 8
            cellSisterFather.layoutSubviews()
            cellSisterFather.numberOfMembers.text = String(answers.sistersOfFather)

            
            return cellSisterFather
            
        case QuestionType.generateButton.rawValue:
            let generate = tableView.dequeueReusableCell(withIdentifier: "GenerateCellID") as! GenerateFamilyCellTableViewCell
            generate.delegate = self
            generate.layoutSubviews()
            generate.setNeedsLayout()
            
            return generate

            
        default:
            let cellBrothers = tableView.dequeueReusableCell(withIdentifier: CustomCellIdentifiers.CreatePatientTreeID.rawValue, for: indexPath) as! CreatePatientTree
            cellBrothers.setNumberDelegate = self
            cellBrothers.numberOfMembers.text = String(answers.brothers)

            cellBrothers.layoutSubviews()
            return cellBrothers
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let questionGender = tableView.dequeueReusableCell(withIdentifier: "CreatePatientGender") as! CreatePatientTreeGender
            questionGender.questionLabel.text = QuestionType.gender.selectQuestion()
            return questionGender
            
        case 1:
            let questionGenderPartner = tableView.dequeueReusableCell(withIdentifier: "CreatePatientGender") as! CreatePatientTreeGender
            questionGenderPartner.questionLabel.text = QuestionType.genderPartner.selectQuestion()
            return questionGenderPartner
            
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 38
        case 1:
            return 38
        default:
            return 0
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        familyTreeGenerator = FamilyTreeGenerator.init(familyTree: [:])
        
    }
}
