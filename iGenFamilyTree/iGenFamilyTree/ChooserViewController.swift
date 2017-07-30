//
//  ChooserViewController.swift
//  iGenFamilyTree
//
//  Created by Ton on 2017-07-05.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit

struct Login{
    var username: String?
    var password: String?
    var familyTreeID: String? //patient id
    var id: String?
}

class ChooserViewController: UIViewController {
    
    @IBOutlet weak var choosePatientID: UITextField!
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!

    var familyJsonToLoad: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func LoginObserverDisease(notification: NSNotification) {
        let diseaseDict = notification.userInfo as! [ID : Disease]
        // there is always exactly 1 disease notified
        print("notify observer disease \(diseaseDict)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.familytreeSegue.rawValue {
            iGenDataService.parseiGenData(jsonName:familyJsonToLoad!)
        }

    }
    
    @IBAction func Login(_ sender: UIButton) {
        familyJsonToLoad = "687FAB70-F4A8-4E32-A257-6BB98624B8E1"
        self.performSegue(withIdentifier: Segues.familytreeSegue.rawValue, sender: self)
    }
    
    @IBAction func Register(_ sender: UIButton) {
        familyJsonToLoad = "iGen"
        self.performSegue(withIdentifier: Segues.familytreeSegue.rawValue, sender: self)
    }
    
    
    @IBAction func buttonNieuwePatient(_ sender: UIButton) {
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
