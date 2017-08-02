//
//  ChooserViewController.swift
//  iGenFamilyTree
//
//  Created by Ton on 2017-07-05.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit
import SVProgressHUD

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
        
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ChooserViewController.LoginObserver),
                                               name:  NSNotification.Name(rawValue: NotificationIDs.loginNotificationID.rawValue ),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ChooserViewController.RegisterObserver),
                                               name:  NSNotification.Name(rawValue: NotificationIDs.registerNotificationID.rawValue ),
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        SVProgressHUD.dismiss()
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
            alertMessage(serverResponse as! String)
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
            alertMessage(serverResponse as! String)
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
            alertMessage("Username not a valid e-mail address")
            return
        }
        guard validPassword(passwordTextField.text) else {
            alertMessage("Password not filled in")
            return
        }
        let login = Login.init(username: usernameTextField.text!, password: passwordTextField.text!, PatientID: "", id: "")
        SVProgressHUD.show()
        iGenDataService.login(login)
        
    }
    
    @IBAction func RegisterButton(_ sender: UIButton) {
        guard validUsername(usernameTextField.text) else {
            alertMessage("Username not a valid e-mail address")
            return
        }
        guard validPassword(passwordTextField.text) else {
            alertMessage("Password not filled in")
            return
        }
        let login = Login.init(username: usernameTextField.text!, password: passwordTextField.text!, PatientID: "", id: "")
        SVProgressHUD.show()
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
    
    func validPassword(_ password: String?) -> Bool {
        if  password == nil {
            return false
        } else if password == "" {
            return false
        } else {
            return true
        }
    }
    
    func alertMessage(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (_) in
            self.passwordTextField.text = ""}))
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
