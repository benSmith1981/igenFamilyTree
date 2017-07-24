//
//  TableViewController.swift
//  iGenFamilyTree
//
//  Created by Achid Farooq on 04-07-17.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit
import Eureka

enum QuestionType: Int {
    case brother = 0
    case sister = 1
    case sons = 2
    case daughters = 3
    case brotherMother = 4
    case sisterMother = 5
    case brotherFather = 6
    case sisterFather = 7
    
    
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
        }
    }
}

protocol SetNumberOfFamilyMembers {
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

    
    mutating func reset() {
        self = Answers()
    }
}

struct selectGender {
    var genderMale = String()
    var genderFemale = String()
}



class CreatePatientTreeTableView: FormViewController, UITextFieldDelegate {
    var answers = Answers()
    var selectgender = selectGender()
    var familyTreeGenerator = FamilyTreeGenerator.init(familyTree: [:])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        form +++ Section(NSLocalizedString("fillinform", comment: ""))
            <<< IntRow(){ row in
                row.tag = "tagbrother"
                row.title = NSLocalizedString("numberBrothers", comment: "")
                row.placeholder = NSLocalizedString("enternumber", comment: "")
                row.value = self.answers.brothers
                }.onChange {
                    if $0.value != nil {
                        self.answers.brothers = $0.value!
                    }
                    else {
                        print("Amount of brother is zero!")
                    }}
            <<< IntRow(){ row in
                row.tag = "tagsister"
                row.title = NSLocalizedString("numberSisters", comment: "")
                row.placeholder = NSLocalizedString("enternumber", comment: "")
                row.value = self.answers.sisters
                }.onChange {
                    if $0.value != nil {
                        self.answers.sisters = $0.value!}
                    else {
                        print("Amount of sisters is zero!")
                    }}
            <<< IntRow(){ row in
                row.tag = "tagsons"
                row.title = NSLocalizedString("numberSons", comment: "")
                row.placeholder = NSLocalizedString("enternumber", comment: "")
                }.onChange {
                    if $0.value != nil {
                        self.answers.sons = $0.value!}
                    else {
                        print("Amount of sons is zero!")
                    }}
            <<< IntRow(){ row in
                row.tag = "tagdaughters"
                row.title = NSLocalizedString("numberDaughters", comment: "")
                row.placeholder = NSLocalizedString("enternumber", comment: "")
                }.onChange {
                    if $0.value != nil {
                        self.answers.daughters = $0.value!}
                    else {
                        print("Amount of daughters is zero!")
                    }}
            <<< IntRow(){ row in
                row.tag = "tagbrothermother"
                row.title = NSLocalizedString("numberBrotherfromMother", comment: "")
                row.placeholder = NSLocalizedString("enternumber", comment: "")
                }.onChange {
                    if $0.value != nil {
                        self.answers.brothersOfMother = $0.value!}
                    else {
                        print("Amount of brothersOfMother is zero!")
                    }}
            <<< IntRow(){ row in
                row.tag = "tagsistermother"
                row.title = NSLocalizedString("numberSistersfromMother", comment: "")
                row.placeholder = NSLocalizedString("enternumber", comment: "")
                }.onChange {
                    if $0.value != nil {
                        self.answers.sistersOfMother = $0.value!}
                    else {
                        print("Amount of sistersOfMother is zero!")
                    }}
            <<< IntRow(){ row in
                row.tag = "tagbrotherfather"
                row.title = NSLocalizedString("numberBrothersfromFather", comment: "")
                row.placeholder = NSLocalizedString("enternumber", comment: "")
                }.onChange {
                    if $0.value != nil {
                        self.answers.brothersOfFather = $0.value!}
                    else {
                        print("Amount of brothersOfFather is zero!")
                    }}
            <<< IntRow(){ row in
                row.tag = "tagsisterfather"
                row.title = NSLocalizedString("numberSistersfromFather", comment: "")
                row.placeholder = NSLocalizedString("enternumber", comment: "")
                }.onChange {
                    if $0.value != nil {
                        self.answers.sistersOfFather = $0.value!}
                    else {
                        print("Amount of sistersOfFather is zero!")
                    }}
        form +++ Section("Please fill in your gender")
            <<< ActionSheetRow<String>() {
                $0.tag = "whatgendermale"
                $0.title = NSLocalizedString("whatgender", comment: "")
                $0.selectorTitle = NSLocalizedString("pickgender", comment: "")
                $0.options = ["Male","Female"]
                $0.value = "Male"    // initially selected
                }.onChange {
                    if $0.value == "Male"{
                        self.selectgender.genderMale = JsonKeys.male.rawValue}
                    else {
                        self.selectgender.genderMale = JsonKeys.female.rawValue}
            }
            <<< ActionSheetRow<String>() {
                $0.tag = "whatgenderfemale"
                $0.title = NSLocalizedString("genderspouse", comment: "")
                $0.selectorTitle = NSLocalizedString("pickgender", comment: "")
                $0.options = ["Male","Female"]
                $0.value = "Female"    // initially selected
                }.onChange {
                    if $0.value == "Female"{
                        self.selectgender.genderFemale = JsonKeys.female.rawValue
                    }
                    else {
                        self.selectgender.genderFemale = JsonKeys.male.rawValue
                    }
            }
            <<< ButtonRow() {
                $0.title = NSLocalizedString("CreateTree", comment: "")
                $0.onCellSelection(self.buttonTapped)
        }

    }
    
    func setFamilyVariables(){
        let valuesDictionary = form.values()
        print(valuesDictionary)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        familyTreeGenerator.familyTree = [:]
    }
    
    func buttonTapped(cell: ButtonCellOf<String>, row: ButtonRow) {
        familyTreeGenerator.generateNewFamilyTree(with: answers)
        familyTreeGenerator.printFamilyTree(familyTreeGenerator.familyTree)
        
        
        self.performSegue(withIdentifier: Segues.familytreeSegue.rawValue, sender: self)
        print("Generate tree segue button tapped!")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ccData = segue.destination as! CustomCollectionViewController
        ccData.familyTreeGenerator = familyTreeGenerator
    }
    
    

    
}
