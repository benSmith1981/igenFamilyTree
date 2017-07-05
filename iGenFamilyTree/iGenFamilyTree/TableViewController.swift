//
//  TableViewController.swift
//  iGenFamilyTree
//
//  Created by Achid Farooq on 04-07-17.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var numberOfSiblings:Int = 0
    var numberOfParents:Int = 0
    var numberOfChildren:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "TableViewCell")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }


    @IBAction func generateTree(_ sender: Any) {
        
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
            let cellBrothers = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            cellBrothers.questionLabel.text = QuestionType.brother.selectQuestion()
            cellBrothers.awakeFromNib()
            
            return cellBrothers
            
        case QuestionType.sister.rawValue:
            let cellSisters = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            cellSisters.questionLabel.text = QuestionType.sister.selectQuestion()

            return cellSisters
            
        case QuestionType.sons.rawValue:
            let cellSons = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            cellSons.questionLabel.text = QuestionType.sons.selectQuestion()
            
            return cellSons
            
        case QuestionType.daughters.rawValue:
            let cellDaughters = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            cellDaughters.questionLabel.text = QuestionType.daughters.selectQuestion()
            
            return cellDaughters
            
        case QuestionType.brotherMother.rawValue:
            let cellBrotherMother = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            cellBrotherMother.questionLabel.text = QuestionType.brotherMother.selectQuestion()
            
            return cellBrotherMother
        
        case QuestionType.sisterMother.rawValue:
            let cellSisterMother = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            cellSisterMother.questionLabel.text = QuestionType.sisterMother.selectQuestion()
            
            return cellSisterMother
            
        case QuestionType.brotherFather.rawValue:
            let cellBrotherFather = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            cellBrotherFather.questionLabel.text = QuestionType.brotherFather.selectQuestion()
            
            return cellBrotherFather
            
        case QuestionType.sisterFather.rawValue:
            let cellSisterFather = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            cellSisterFather.questionLabel.text = QuestionType.sisterFather.selectQuestion()
            
            return cellSisterFather
        
        default:
            let cellBrothers = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
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