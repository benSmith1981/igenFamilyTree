//
//  ChooserViewController.swift
//  iGenFamilyTree
//
//  Created by Ton on 2017-07-05.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit

class ChooserViewController: UIViewController {

    var familyJsonToLoad: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segues.familytreeSegue.rawValue {
            iGenDataService.parseiGenData(jsonName:familyJsonToLoad!)
        }

    }
    
    @IBAction func buttonBen(_ sender: UIButton) {
        familyJsonToLoad = "smith"
        self.performSegue(withIdentifier: segues.familytreeSegue.rawValue, sender: self)
    }

    @IBAction func buttonPaul(_ sender: UIButton) {
        familyJsonToLoad = "Paul"
        self.performSegue(withIdentifier: segues.familytreeSegue.rawValue, sender: self)
    }
    
    @IBAction func buttonAchid(_ sender: UIButton) {
        familyJsonToLoad = "iGen"
        self.performSegue(withIdentifier: segues.familytreeSegue.rawValue, sender: self)
    }
    
    @IBAction func buttonTon(_ sender: UIButton) {
        familyJsonToLoad = "iGen"
        self.performSegue(withIdentifier: segues.familytreeSegue.rawValue, sender: self)
    }
    
    @IBAction func buttonNieuwePatient(_ sender: UIButton) {
//        self.performSegue(withIdentifier: segues.createFamilyTreeSegue.rawValue, sender: self)

        //go to achids view
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
