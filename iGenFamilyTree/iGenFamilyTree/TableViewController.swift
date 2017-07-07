//
//  TableViewController.swift
//  iGenFamilyTree
//
//  Created by Achid Farooq on 04-07-17.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit

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
    let brothers = 2
    let sisters = 0
    let sons = 1
    let daughters = 1
    let brothersOfMother = 3
    let sistersOfMother = 1
    let brothersOfFather = 0
    let sistersOfFather = 1
}

class TableViewController: UITableViewController, SetNumberOfFamilyMembers {
    let answers = Answers()
    var familyTreeGenerator = FamilyTreeGenerator.init(familyTree: [:])
    
    var numberOfBrothers: Int = 0
    var numberOfSisters: Int = 0
    var numberOfSons: Int = 0
    var numberOfDaughters: Int = 0
    var numberOfBrotherMother: Int = 0
    var numberOfSisterMother: Int = 0
    var numberOfBrotherFather: Int = 0
    var numberOfSisterFather: Int = 0
    
    func sendNumber(number: Int, cellType: QuestionType){
        switch cellType {
        case .brother:
            numberOfBrothers = number
        case .sister:
            numberOfSisters = number
        case .sons:
            numberOfSons = number
        case .daughters:
            numberOfDaughters = number
        case .brotherMother:
            numberOfBrotherMother = number
        case .sisterMother:
            numberOfSisterMother = number
        case .brotherFather:
            numberOfBrotherFather = number
        case .sisterFather:
            numberOfSisterFather = number
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        
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
//        if segue.identifier == segues.familytreeSegue.rawValue {
            let ccData = segue.destination as! CustomCollectionViewController
            ccData.familyTreeGenerator = familyTreeGenerator
//        }
    }
    
    
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
            let cellBrothers = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! CreatePatientTree
            cellBrothers.questionLabel.text = QuestionType.brother.selectQuestion()
            cellBrothers.awakeFromNib()
            cellBrothers.cellType = .brother
            cellBrothers.setNumberDelegate = self
            return cellBrothers
            
        case QuestionType.sister.rawValue:
            let cellSisters = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! CreatePatientTree
            cellSisters.questionLabel.text = QuestionType.sister.selectQuestion()
            cellSisters.cellType = .sister
            cellSisters.setNumberDelegate = self
            
            return cellSisters
            
        case QuestionType.sons.rawValue:
            let cellSons = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! CreatePatientTree
            cellSons.questionLabel.text = QuestionType.sons.selectQuestion()
            cellSons.cellType = .sons
            cellSons.setNumberDelegate = self
            
            return cellSons
            
        case QuestionType.daughters.rawValue:
            let cellDaughters = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! CreatePatientTree
            cellDaughters.questionLabel.text = QuestionType.daughters.selectQuestion()
            cellDaughters.cellType = .daughters
            cellDaughters.setNumberDelegate = self
            
            return cellDaughters
            
        case QuestionType.brotherMother.rawValue:
            let cellBrotherMother = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! CreatePatientTree
            cellBrotherMother.questionLabel.text = QuestionType.brotherMother.selectQuestion()
            cellBrotherMother.cellType = .brotherMother
            cellBrotherMother.setNumberDelegate = self
            
            return cellBrotherMother
            
        case QuestionType.sisterMother.rawValue:
            let cellSisterMother = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! CreatePatientTree
            cellSisterMother.questionLabel.text = QuestionType.sisterMother.selectQuestion()
            cellSisterMother.cellType = .sisterMother
            cellSisterMother.setNumberDelegate = self
            
            return cellSisterMother
            
        case QuestionType.brotherFather.rawValue:
            let cellBrotherFather = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! CreatePatientTree
            cellBrotherFather.questionLabel.text = QuestionType.brotherFather.selectQuestion()
            cellBrotherFather.cellType = .brotherFather
            cellBrotherFather.setNumberDelegate = self
            
            return cellBrotherFather
            
        case QuestionType.sisterFather.rawValue:
            let cellSisterFather = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! CreatePatientTree
            cellSisterFather.questionLabel.text = QuestionType.sisterFather.selectQuestion()
            cellSisterFather.cellType = .sisterFather
            cellSisterFather.setNumberDelegate = self
            
            return cellSisterFather
            
        default:
            let cellBrothers = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! CreatePatientTree
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
