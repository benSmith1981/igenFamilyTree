//
//  ChooserViewController.swift
//  iGenFamilyTree
//
//  Created by Ton on 2017-07-05.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit

struct Login{
    var username: String
    var password: String
    var familyTreeID: String //patient id
    var id: String
}

class ChooserViewController: UIViewController {
    
    @IBOutlet weak var choosePatientID: UITextField!
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!

    var familyJsonToLoad: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ChooserViewController.LoginObserver),
                                               name:  NSNotification.Name(rawValue: NotificationIDs.loginNotificationID.rawValue ),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ChooserViewController.RegisterObserver),
                                               name:  NSNotification.Name(rawValue: NotificationIDs.registerNotificationID.rawValue ),
                                               object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func LoginObserver(notification: NSNotification) {
        let loginDict = notification.userInfo as! [String : Any]
        print("notify observer disease \(loginDict)")
        let responseServer = loginDict["response"] as! ServerResponse
        let response = responseServer.response
        let message = responseServer.message
        
        //get userID, family tree if success response is true
        if response{
            let userID = responseServer.userID
            let familyTree = responseServer.familyTree
            familyJsonToLoad = responseServer.patientID

            self.performSegue(withIdentifier: Segues.familytreeSegue.rawValue, sender: self)

        }else { //show a response message 
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    func RegisterObserver(notification: NSNotification) {
        let registerDict = notification.userInfo as! [String : Any]
        print("Register \(registerDict)")
        let responseServer = registerDict["response"] as! ServerResponse
        let response = responseServer.response
        let message = responseServer.message
        //at this point the user does not have a familyID or an ID...
        // YOU NEED TO: create the tree, then update their record using the updateThePatientID function in igen Service
        let username = responseServer.loginDetails["username"]
        let password = responseServer.loginDetails["password"]

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.familytreeSegue.rawValue {
            iGenDataService.parseiGenData(jsonName:familyJsonToLoad!)
        }

    }
    
    @IBAction func LoginButton(_ sender: UIButton) {
        if let  username = usernameTextField.text,
            let password = passwordTextfield.text{
            var login = Login.init(username: username, password: password, familyTreeID: "", id: "")
            iGenDataService.login(login)
        }
    }
    
    @IBAction func RegisterButton(_ sender: UIButton) {
        if let  username = usernameTextField.text,
            let password = passwordTextfield.text{
            var login = Login.init(username: username, password: password, familyTreeID: "", id: "")
            iGenDataService.register(login)
        }
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
