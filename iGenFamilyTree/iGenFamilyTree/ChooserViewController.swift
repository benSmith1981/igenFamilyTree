//
//  ChooserViewController.swift
//  iGenFamilyTree
//
//  Created by Ton on 2017-07-05.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit
import IQKeyboardManager

struct Login {
    var username: String
    var password: String
    var PatientID: ID
    var id: ID
}

class ChooserViewController: UIViewController {
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var serverResponse: ServerResponse?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.shared().disabledToolbarClasses.add(ChooserViewController.self)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ChooserViewController.LoginObserver),
                                               name:  NSNotification.Name(rawValue: NotificationIDs.loginNotificationID.rawValue ),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ChooserViewController.RegisterObserver),
                                               name:  NSNotification.Name(rawValue: NotificationIDs.registerNotificationID.rawValue ),
                                               object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func LoginObserver(notification: NSNotification) {
        let loginDict = notification.userInfo as! [String : Any]
        print("notify observer Login \(loginDict)")
        serverResponse = loginDict["response"] as? ServerResponse
        if serverResponse != nil {
            self.performSegue(withIdentifier: Segues.familytreeSegue.rawValue, sender: self)
        } else {
            let serverResponse = loginDict["message"]
            let alert = UIAlertController(title: "Alert", message: serverResponse as? String, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            passwordTextField.text = ""
        }
    }
    
    func RegisterObserver(notification: NSNotification) {
        let registerDict = notification.userInfo as! [String : Any]
        print("notify observer Register \(registerDict)")
        serverResponse = registerDict["response"] as? ServerResponse
        if serverResponse != nil {
            self.performSegue(withIdentifier: Segues.createFamilytreeSegue.rawValue, sender: self)
        } else {
            let serverResponse = registerDict["message"]
            let alert = UIAlertController(title: "Alert", message: serverResponse as? String, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.familytreeSegue.rawValue {
            let destinationVC = segue.destination as! CustomCollectionViewController
            destinationVC.serverResponse = serverResponse
        } else if segue.identifier == Segues.createFamilytreeSegue.rawValue {
            let destinationVC = segue.destination as! GenerateTableViewController
            destinationVC.serverResponse = serverResponse
            
        }
    }
    
    @IBAction func LoginButton(_ sender: UIButton) {
        guard validUsername(usernameTextField.text) else {
            usernameNotValid()
            return
        }
        guard validPassword(passwordTextField.text) else {
            passwordNotValid()
            return
        }
        let login = Login.init(username: usernameTextField.text!, password: passwordTextField.text!, PatientID: "", id: "")
        iGenDataService.login(login)
        
    }
    
    @IBAction func RegisterButton(_ sender: UIButton) {
        guard validUsername(usernameTextField.text) else {
            usernameNotValid()
            return
        }
        guard validPassword(passwordTextField.text) else {
            passwordNotValid()
            return
        }
        let login = Login.init(username: usernameTextField.text!, password: passwordTextField.text!, PatientID: "", id: "")
        iGenDataService.register(login)
    }
    
    
    func validUsername(_ username: String?) -> Bool {
        if  username == nil {
            return false
        } else if username == "" {
            return false
        } else if username!.isValidEmail()  {
            return true
        } else {
            return false
        }
    }
    
    func usernameNotValid() {
        let alert = UIAlertController(title: "Alert", message: "Username not a valid e-mail address", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func validPassword(_ password: String?) -> Bool {
        if  password == nil {
            return false
        } else if password == "" {
            return false
        } else {
            return true
        }
    }
    
    func passwordNotValid() {
        let alert = UIAlertController(title: "Alert", message: "Password not filled in", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
