//
//  VerifyMemberVC.swift
//  iGenFamilyTree
//
//  Created by ben on 01/08/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit

struct VerifyMember{
    var email: String
    var patientID: String //family id
    var userID: String
    var patientName: String
    var name: String
    var sendersEmail: String
}


enum verifyMemberRows: Int{
    case personToVerifyEmail = 0
    case patientsEmail
    case patientName
    case personToVerifyName
}

class VerifyMemberVC: UIViewController, UITableViewDelegate, UITableViewDataSource, updateParametersDelegate {

    var currentHuman: Human?
    var memberToVerify: VerifyMember?
    @IBOutlet weak var modalTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let infoCell = UINib(nibName: "InfoCell", bundle: nil)
        self.modalTableView.register(infoCell, forCellReuseIdentifier: CustomCellIdentifiers.infoCellID.rawValue)

        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissVerify(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func callVerfiyEndpoint(_ sender: Any) {
        if let patientID = currentHuman?.patientID, let id = currentHuman?.id {
            
            //You need to set this struct with the values in the gethuman updates function
            let memberToVerify = VerifyMember.init(email: "benjaminsmith1981@gmail.com", //email of person to verify
                                                   patientID: patientID,
                                                   userID: id,
                                                   patientName: "Paul", //name of the patient asking
                                                   name: "Ben", //name of person to verify
                                                   sendersEmail: "pmgeurts@gmail.com") //email of patient asking for verification
            iGenDataService.verifyMember(with: memberToVerify)
            self.presentingViewController?.dismiss(animated: true, completion: nil)

        }

    }
    
    func getHumanUpdates(value: Any, cellType: detailRows, indexPath: IndexPath){
        switch cellType {
        case .nameRow:
            self.memberToVerify?.name = value as! String
            
        default:
            break
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case verifyMemberRows.personToVerifyEmail.rawValue:
            let personToVerifyEmail = self.modalTableView.dequeueReusableCell(withIdentifier: "infoCellID") as! InfoCell

            personToVerifyEmail.titleInfo.text = NSLocalizedString("name", comment: "")
            personToVerifyEmail.textfieldValue.text = ""
            personToVerifyEmail.cellType = .nameRow
            personToVerifyEmail.delegate = self
            return personToVerifyEmail
        case verifyMemberRows.patientName.rawValue:
            let patientNameCell = self.modalTableView.dequeueReusableCell(withIdentifier: "infoCellID") as! InfoCell

            patientNameCell.titleInfo.text = NSLocalizedString("name", comment: "")
            patientNameCell.textfieldValue.text = ""
            patientNameCell.cellType = .nameRow
            patientNameCell.delegate = self
            return patientNameCell

        case verifyMemberRows.personToVerifyEmail.rawValue:
            let personToVerifyEmail = self.modalTableView.dequeueReusableCell(withIdentifier: "infoCellID") as! InfoCell

            personToVerifyEmail.titleInfo.text = NSLocalizedString("name", comment: "")
            personToVerifyEmail.textfieldValue.text = ""
            personToVerifyEmail.cellType = .nameRow
            personToVerifyEmail.delegate = self
            return personToVerifyEmail

        case verifyMemberRows.personToVerifyName.rawValue:
            let personToVerifyName = self.modalTableView.dequeueReusableCell(withIdentifier: "infoCellID") as! InfoCell

            personToVerifyName.titleInfo.text = NSLocalizedString("name", comment: "")
            personToVerifyName.textfieldValue.text = ""
            personToVerifyName.cellType = .nameRow
            personToVerifyName.delegate = self
            return personToVerifyName

        default:
            return UITableViewCell()
        }
    }
}
