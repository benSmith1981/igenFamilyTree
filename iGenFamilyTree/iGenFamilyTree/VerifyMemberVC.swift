//
//  VerifyMemberVC.swift
//  iGenFamilyTree
//
//  Created by ben on 01/08/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit

struct VerifyMember{
    var verifyEmail: String
    var patientID: String //family id
    var userID: String
    var patientName: String
    var verifyName: String
    var patientEmail: String
    var emailText: String
    var code: Int

}


enum verifyMemberRows: Int{
    case personToVerifyName = 0
    case personToVerifyEmail
    case patientName
    case patientsEmail
    case emailText

}

class VerifyMemberVC: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource, updateParametersDelegate {

    var currentHuman: Human?
    var memberToVerify: VerifyMember!
    @IBOutlet weak var modalTableView: UITableView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var footerBG: UIView!
    @IBOutlet weak var headerBG: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        memberToVerify = VerifyMember.init(verifyEmail: "", //email of person to verify
                                               patientID: currentHuman!.patientID,
                                               userID: currentHuman!.id,
                                               patientName: "", //name of the patient asking
                                               verifyName: "", //name of person to verify
                                               patientEmail: "",
                                               emailText:"",
                                               code: self.randomNumberWith(digits: 6)) //email of patient asking for
        let infoCell = UINib(nibName: "InfoCell", bundle: nil)
        self.modalTableView.register(infoCell, forCellReuseIdentifier: CustomCellIdentifiers.infoCellID.rawValue)
        
        let descriptionTableViewNib = UINib(nibName: "DescriptionTableViewCell", bundle:  nil)
        self.modalTableView.register(descriptionTableViewNib, forCellReuseIdentifier: CustomCellIdentifiers.descriptionTableViewCellID.rawValue)
        
        // Do any additional setup after loading the view.
        modalTableView.rowHeight = UITableViewAutomaticDimension
        modalTableView.estimatedRowHeight = 36
        modalTableView.layer.shadowRadius = 5
        modalTableView.layer.masksToBounds = true
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(VerifyMemberVC.verifyObserver),
                                               name:  NSNotification.Name(rawValue: NotificationIDs.verifyNotificationID.rawValue),
                                               object: nil)
        // Do any additional setup after loading the view.
        
        let rectShapeTop = CAShapeLayer()
        rectShapeTop.bounds = self.headerBG.frame
        rectShapeTop.position = self.headerBG.center
        rectShapeTop.path = UIBezierPath(roundedRect: self.headerBG.bounds, byRoundingCorners: [.topLeft, .topRight ], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        
        let rectShapeBottom = CAShapeLayer()
        rectShapeBottom.bounds = self.footerBG.frame
        rectShapeBottom.position = self.footerBG.center
        rectShapeBottom.path = UIBezierPath(roundedRect: self.footerBG.bounds, byRoundingCorners: [.bottomLeft, .bottomRight ], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        
        self.headerBG.layer.mask = rectShapeTop
        self.footerBG.layer.mask = rectShapeBottom
    }

    override func viewDidLayoutSubviews() {
        modalTableView.reloadData()
        super.updateViewConstraints()
        self.widthConstraint?.constant = self.view.frame.width - (leadingConstraint.constant + trailingConstraint.constant)
        
        self.heightConstraint?.constant = self.view.frame.height - (topConstraint.constant + bottomConstraint.constant)
    }
    
    func verifyObserver(notification: NSNotification) {
        let verifyDict = notification.userInfo as! [String : Any]
        if let success = verifyDict["success"] as? Bool, let message = verifyDict["message"] as? String {
            if success {
                showAlertMessage(message: message, success: success)
            } else {
                showAlertMessage(message: message, success: success)
            }
        }
    }
    
    func showAlertMessage(message: String, success: Bool){
        let alert = UIAlertController(title: NSLocalizedString("verifyalert", comment: ""), message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            if success{
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissVerify(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func callVerfiyEndpoint(_ sender: Any) {
        //You need to set this struct with the values in the gethuman updates function verification
        iGenDataService.verifyMember(with: self.memberToVerify)
    }
    
    func getHumanUpdates(value: Any, cellType: detailRows, indexPath: IndexPath){
        switch cellType {
        case .verifyName:
            self.memberToVerify?.verifyName = value as! String
        case .verifyEmail:
            self.memberToVerify?.verifyEmail = value as! String
        case .patientName:
            self.memberToVerify?.patientName = value as! String
        case .patientEmail:
            self.memberToVerify?.patientEmail = value as! String
        case .emailText:
            self.memberToVerify?.emailText = value as! String
        default:
            break
        }
        //Reload the email text
        self.modalTableView.reloadRows(at: [IndexPath.init(row: 4, section: 0)], with: .none)

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == verifyMemberRows.emailText.rawValue {
            return UITableViewAutomaticDimension
        }
        return 34
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case verifyMemberRows.personToVerifyName.rawValue:
            let personToVerifyNameCell = self.modalTableView.dequeueReusableCell(withIdentifier: CustomCellIdentifiers.infoCellID.rawValue) as! InfoCell
            
            personToVerifyNameCell.addRowBut.alpha = 0.0
            personToVerifyNameCell.removeRowBut.alpha = 0.0
            personToVerifyNameCell.addRowBut.isUserInteractionEnabled = false
            personToVerifyNameCell.removeRowBut.isUserInteractionEnabled = false
            
            personToVerifyNameCell.titleInfo.text = NSLocalizedString("verifyName", comment: "")
            personToVerifyNameCell.textfieldValue.text = ""
            
            personToVerifyNameCell.cellType = .verifyName
            personToVerifyNameCell.delegate = self
            personToVerifyNameCell.indexPath = indexPath
            return personToVerifyNameCell
        case verifyMemberRows.personToVerifyEmail.rawValue:
            let personToVerifyEmail = self.modalTableView.dequeueReusableCell(withIdentifier: CustomCellIdentifiers.infoCellID.rawValue) as! InfoCell
            personToVerifyEmail.addRowBut.alpha = 0.0
            personToVerifyEmail.removeRowBut.alpha = 0.0
            personToVerifyEmail.addRowBut.isUserInteractionEnabled = false
            personToVerifyEmail.removeRowBut.isUserInteractionEnabled = false
            
            personToVerifyEmail.titleInfo.text = NSLocalizedString("verifyEmail", comment: "")
            personToVerifyEmail.textfieldValue.text = ""
            
            personToVerifyEmail.cellType = .verifyEmail
            personToVerifyEmail.delegate = self
            personToVerifyEmail.indexPath = indexPath
            
            return personToVerifyEmail
        case verifyMemberRows.patientName.rawValue:
            let patientName = self.modalTableView.dequeueReusableCell(withIdentifier: CustomCellIdentifiers.infoCellID.rawValue) as! InfoCell
            
            patientName.addRowBut.alpha = 0.0
            patientName.removeRowBut.alpha = 0.0
            patientName.addRowBut.isUserInteractionEnabled = false
            patientName.removeRowBut.isUserInteractionEnabled = false
            
            patientName.titleInfo.text = NSLocalizedString("patientName", comment: "")
            patientName.textfieldValue.text = ""
            
            patientName.cellType = .patientName
            patientName.delegate = self
            patientName.indexPath = indexPath

            return patientName
        case verifyMemberRows.patientsEmail.rawValue:
            let patientEmail = self.modalTableView.dequeueReusableCell(withIdentifier: CustomCellIdentifiers.infoCellID.rawValue) as! InfoCell
            
            patientEmail.addRowBut.alpha = 0.0
            patientEmail.removeRowBut.alpha = 0.0
            patientEmail.addRowBut.isUserInteractionEnabled = false
            patientEmail.removeRowBut.isUserInteractionEnabled = false
            
            patientEmail.titleInfo.text = NSLocalizedString("patientEmail", comment: "")
            patientEmail.textfieldValue.text = ""
            
            patientEmail.cellType = .patientEmail
            patientEmail.delegate = self
            patientEmail.indexPath = indexPath

            return patientEmail
        case verifyMemberRows.emailText.rawValue:
            let descriptionCell = self.modalTableView.dequeueReusableCell(withIdentifier: CustomCellIdentifiers.descriptionTableViewCellID.rawValue) as! DescriptionTableViewCell

            descriptionCell.DescriptionTextView.delegate = self
            descriptionCell.cellType = .emailText
            descriptionCell.delegate = self
            descriptionCell.indexPath = indexPath
            
            //test encode html
            let patientName  = memberToVerify?.patientName ?? ""
            let verifyemail = memberToVerify?.verifyEmail ?? ""
            let verifyname = memberToVerify?.verifyName ?? ""
            let code = memberToVerify?.code ?? 0

            let localiseText = String(format: NSLocalizedString("emailText", comment: ""), verifyname, verifyemail, "XXXXXX", patientName)

            let str = localiseText.replacingOccurrences(of: "<[^]>]+>", with: "", options: .regularExpression, range: nil)
            self.memberToVerify?.emailText = String(format: NSLocalizedString("emailText", comment: ""), verifyname, verifyemail, "\(code)", patientName)
            descriptionCell.DescriptionTextView.text = str
            return descriptionCell
        default:
            return UITableViewCell()
        }
    }
    
    func randomNumberWith(digits:Int) -> Int {
        let min = Int(pow(Double(10), Double(digits-1))) - 1
        let max = Int(pow(Double(10), Double(digits))) - 1
        return Int(Range(uncheckedBounds: (lower: min, upper: max)))
    }
    
}

extension Int {
    init(_ range: Range<Int> ) {
        let delta = range.lowerBound < 0 ? abs(range.lowerBound) : 0
        let min = UInt32(range.lowerBound + delta)
        let max = UInt32(range.upperBound   + delta)
        self.init(Int(min + arc4random_uniform(max - min)) - delta)
    }
}

extension UIViewController {
    class func loadFromNib<T: UIViewController>() -> T {
        return T(nibName: String(describing: self), bundle: nil)
    }
}
