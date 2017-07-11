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
}



class TableViewController: UITableViewController, SetNumberOfFamilyMembers {
    var answers = Answers()
    var familyTreeGenerator = FamilyTreeGenerator.init(familyTree: [:])
    
    
    
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
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        let nib = UINib(nibName: "CreatePatientTree", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: tableCellIDs.CreatePatientTreeID.rawValue)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    @IBAction func generateTree(_ sender: UIBarButtonItem) {
        // create empty Humans
        // create all relationships for every human
        
        familyTreeGenerator.generateNewFamilyTree(with: answers)
        printCurrent(familyTree: familyTreeGenerator.familyTree)
        
        self.performSegue(withIdentifier: segues.familytreeSegue.rawValue, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let ccData = segue.destination as! CustomCollectionViewController
            ccData.familyTreeGenerator = familyTreeGenerator
        }
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case QuestionType.brother.rawValue:
            let cellBrothers = tableView.dequeueReusableCell(withIdentifier: tableCellIDs.CreatePatientTreeID.rawValue, for: indexPath) as! CreatePatientTree
            cellBrothers.questionLabel.text = QuestionType.brother.selectQuestion()
            cellBrothers.awakeFromNib()
            cellBrothers.cellType = .brother
            cellBrothers.setNumberDelegate = self
            return cellBrothers
            
        case QuestionType.sister.rawValue:
            let cellSisters = tableView.dequeueReusableCell(withIdentifier: tableCellIDs.CreatePatientTreeID.rawValue, for: indexPath) as! CreatePatientTree
            cellSisters.questionLabel.text = QuestionType.sister.selectQuestion()
            cellSisters.cellType = .sister
            cellSisters.setNumberDelegate = self
            
            return cellSisters
            
        case QuestionType.sons.rawValue:
            let cellSons = tableView.dequeueReusableCell(withIdentifier: tableCellIDs.CreatePatientTreeID.rawValue, for: indexPath) as! CreatePatientTree
            cellSons.questionLabel.text = QuestionType.sons.selectQuestion()
            cellSons.cellType = .sons
            cellSons.setNumberDelegate = self
            
            return cellSons
            
        case QuestionType.daughters.rawValue:
            let cellDaughters = tableView.dequeueReusableCell(withIdentifier: tableCellIDs.CreatePatientTreeID.rawValue, for: indexPath) as! CreatePatientTree
            cellDaughters.questionLabel.text = QuestionType.daughters.selectQuestion()
            cellDaughters.cellType = .daughters
            cellDaughters.setNumberDelegate = self
            
            return cellDaughters
            
        case QuestionType.brotherMother.rawValue:
            let cellBrotherMother = tableView.dequeueReusableCell(withIdentifier: tableCellIDs.CreatePatientTreeID.rawValue, for: indexPath) as! CreatePatientTree
            cellBrotherMother.questionLabel.text = QuestionType.brotherMother.selectQuestion()
            cellBrotherMother.cellType = .brotherMother
            cellBrotherMother.setNumberDelegate = self
            
            return cellBrotherMother
            
        case QuestionType.sisterMother.rawValue:
            let cellSisterMother = tableView.dequeueReusableCell(withIdentifier: tableCellIDs.CreatePatientTreeID.rawValue, for: indexPath) as! CreatePatientTree
            cellSisterMother.questionLabel.text = QuestionType.sisterMother.selectQuestion()
            cellSisterMother.cellType = .sisterMother
            cellSisterMother.setNumberDelegate = self
            
            return cellSisterMother
            
        case QuestionType.brotherFather.rawValue:
            let cellBrotherFather = tableView.dequeueReusableCell(withIdentifier: tableCellIDs.CreatePatientTreeID.rawValue, for: indexPath) as! CreatePatientTree
            cellBrotherFather.questionLabel.text = QuestionType.brotherFather.selectQuestion()
            cellBrotherFather.cellType = .brotherFather
            cellBrotherFather.setNumberDelegate = self
            
            return cellBrotherFather
            
        case QuestionType.sisterFather.rawValue:
            let cellSisterFather = tableView.dequeueReusableCell(withIdentifier: tableCellIDs.CreatePatientTreeID.rawValue, for: indexPath) as! CreatePatientTree
            cellSisterFather.questionLabel.text = QuestionType.sisterFather.selectQuestion()
            cellSisterFather.cellType = .sisterFather
            cellSisterFather.setNumberDelegate = self
            
            return cellSisterFather
            
        default:
            let cellBrothers = tableView.dequeueReusableCell(withIdentifier: tableCellIDs.CreatePatientTreeID.rawValue, for: indexPath) as! CreatePatientTree
            cellBrothers.setNumberDelegate = self
            return cellBrothers
        }
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
